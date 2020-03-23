Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9041C54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9162320753
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MFgmWmLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgCWTZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:25:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56668 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgCWTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 15:25:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02252B8534;
        Mon, 23 Mar 2020 15:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l4QlB+igqoZSIOISjYUkOnlirII=; b=MFgmWm
        Lk2M8rIU0chqyeo6sPq+NP12m5f/WUI2tgTZsktb2Ty4beoQZXdY0foNkdFNszMd
        u15H9w07qKazmBl6SX7gPJ90XPnInl5tLLFeHzealAPtjioaidN63XUd5It6QjnX
        ASUDgxr/nK6H7OHKTyeY1BUQqeqaeOTKAo8o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fSkqtoK0sO66ivtDDiMVPa9pelm0XUby
        nm7RbDbZvnkEs5G5HjVBvSp1oTI1sLnz7pE/ENOuCV1HpJ5Vsqo0kpNzsfd5HsS7
        qY3rD+s/pR1ZsP904pqaVBoVHu2Ymx9SKFsnAeTCGX5cNXNaYXTkFndd4m4ZFB3q
        nAGttBzblbc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBFA7B8533;
        Mon, 23 Mar 2020 15:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 381FCB8532;
        Mon, 23 Mar 2020 15:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #07; Sun, 22)
References: <xmqqh7yf7u6q.fsf@gitster.c.googlers.com>
        <20200323191602.GC93624@syl.local>
Date:   Mon, 23 Mar 2020 12:25:21 -0700
In-Reply-To: <20200323191602.GC93624@syl.local> (Taylor Blau's message of
        "Mon, 23 Mar 2020 13:16:02 -0600")
Message-ID: <xmqq4kue6fha.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AA7A554-6D3C-11EA-BCCC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I noticed that this has been cooking in 'next' for a few weeks now. Is
> there anything you're looking for specifically before graduating this to
> master?

Yeah, I saw some mention about "--input=none does not mean there is
no input" confusion in a separate discussion in the past few days
[*1*], which may make us reconsider the proposed UI by this series,
and it is a good time to do so when we rewind/rebuild 'next' after
a release (i.e. "now").


[Reference]

*1* https://lore.kernel.org/git/20200322110424.GC2224@szeder.dev/
