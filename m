Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B0C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2BE2311A
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vfdxu519"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWVjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:39:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61486 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgIWVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 17:39:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91C8FD8E4B;
        Wed, 23 Sep 2020 17:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VY18q9GskyejliDtJoqDfGcnd2Y=; b=vfdxu5
        19rk481ZyjYYmYwGLydUs8E37spAEykD87Ta41GcBzv5dg34j9ru1GYMr7Xdf0K8
        3TYuSv4ArBEODoYF/SpfUtoEgNGizsXnzLHjexb5jmg69BKG4wcBXKdF9cculAEy
        GXB1CdgxBgtSht2ZSXT7RPZDUopgoHDNiKxLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RM1hMowR4cLRyFG0VrE617Cq2uTukxo5
        05xT2SjLm0eCZngOJiuK80zR0OAMuLdkYWx843MxvwZE3n6fqLly8NrRbkg1ua3z
        vUEwj8lox+IeL7odHoP1UeGiebvvoPZAfuww9sKYEiSuL6R0dWarnFIbwYLtEUSt
        ngS59qftEZQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AA90D8E4A;
        Wed, 23 Sep 2020 17:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D10ECD8E48;
        Wed, 23 Sep 2020 17:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Sep 2020 14:39:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 23 Sep 2020 23:05:20 +0200
        (CEST)")
Message-ID: <xmqqa6xgi363.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3222FCFC-FDE5-11EA-837F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Christian,
> ...
> -- snipsnap --
> From f673cea53e046774847be918f4023430e56bf6cb Mon Sep 17 00:00:00 2001
> From: Christian Couder <christian.couder@gmail.com>
> Date: Wed, 23 Sep 2020 19:09:15 +0200
> Subject: [PATCH] bisect: don't use invalid oid as rev when starting
> ...
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 93e855271b9..d11d4c9bbb5 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c

Unfortunately this does not apply to the broken commit or 'master'
or anywhere else, it seems (no such blob as 93e855271b9 found at the
path).

It is better to make it applicable at least to 'master'.  Making it
also apply to 'maint' is optional, I would say, as the bug it fixes
is not so critical.

Thanks.

