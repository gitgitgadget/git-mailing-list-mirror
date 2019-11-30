Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57113C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206632075A
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSK7bJM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK3V57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:57:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57326 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3V56 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 16:57:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E06E37BEB;
        Sat, 30 Nov 2019 16:57:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gLLvaNvtELyYY0QiwXIjl6MFQRo=; b=qSK7bJ
        M046K0NyGN1JTsSZ8gsJ6LtpVFAjoRQbBQemNNSXecP2/+i9PwkVR/Qh5ONTtVwP
        hYRY0xIDFFnmJqeLMQ1uafsYdGxoLJHvLcIUgXw0zErKco+Ney2uWvoH8ZzZF1wO
        /UVveIvQZnMskG2Ec2H1ne47kIL/fyQdiJaUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y5jO6Et3NBLdOJGYgJEwm2LOGv4BzB4p
        4+YGdBKsAG3e5+Xt8xNdu4iSHNG4VDhxll2mEGlKkbLIq8GVVbO9ByWe76L8/gdC
        UvBd77xYFkY2F9XSazDF+KUCOnEkoZLDPyP40IM91p3VJUYVsVwqxMxi3vojKwqo
        yFbEZgCY/6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46A6237BEA;
        Sat, 30 Nov 2019 16:57:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB0AF37BE9;
        Sat, 30 Nov 2019 16:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: prefer check_signature() for GPG verification
References: <20191127174821.5830-1-hji@dyntopia.com>
        <20191127174821.5830-2-hji@dyntopia.com>
Date:   Sat, 30 Nov 2019 13:57:54 -0800
In-Reply-To: <20191127174821.5830-2-hji@dyntopia.com> (Hans Jerry Illikainen's
        message of "Wed, 27 Nov 2019 17:48:21 +0000")
Message-ID: <xmqqo8wt10yl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76DC44C0-13BC-11EA-BA92-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> This commit refactors the use of verify_signed_buffer() outside of
> gpg-interface.c to use check_signature() instead.  It also turns
> verify_signed_buffer() into a file-local function since it's now only
> invoked internally by check_signature().
>
> There were previously two globally scoped functions used in different
> parts of Git to perform GPG signature verification:
> verify_signed_buffer() and check_signature().  Now only
> check_signature() is used.

OK.  I wondered why the former does not get removed, but if the
latter uses it as its implementation detail, then it is expected
that it has to remain.  So check_signature() allows it to make a
minimum sanity check, but it does its own verification based on the
status output, and both have to pass for a signature to be valid?
Which makes sense to me.

> Now all operations that does signature verification share a single entry
> point to gpg-interface.c.  This makes it easier to propagate changed or
> additional functionality in GPG signature verification to all parts of
> Git, without having odd edge-cases that don't perform the same degree of
> verification.

Makes sense.
