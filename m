Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F3C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1722E246A1
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WDWxqqaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406747AbgBNQcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:32:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406854AbgBNQcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 11:32:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BA77B5EE8;
        Fri, 14 Feb 2020 11:31:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Wz1xUVAPBtSNJNySsZ3VZBZuUU=; b=WDWxqq
        aZEGS7ph9TKLRJgdbvQ8HdHDPR4cjk0xAyoLNbOn92p0JKm9DncrC+mdFSBzA5MF
        nbUavakyY1p4KIlDK8efqwWfjLVfUT4jVrZnmLdh0XFFFY3czmAaAL1OlwODH4pC
        GYR3jF/3Tnqe3Nk+kumAuyuyLUq56rxCH8YAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aCjZq/ozOYiShfBXLuOKkaHUEUjRH5l3
        JPL8u7J6D8dEWcrk5dyLzXKlb/DlpbWCyJEc1nEISDnmsyn6RE4+Iux2INdu3fTU
        1Xu/hoaXWkhyEg/UU3rdKI7lwasaYXBT37bKOFpddvNuqwT2XHklgp4tvpI6yCjB
        2tO7+p+wD4c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44DD4B5EE7;
        Fri, 14 Feb 2020 11:31:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B758B5EE6;
        Fri, 14 Feb 2020 11:31:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: How to force configure script to use curl ?
References: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
        <20200214061714.GA605125@coredump.intra.peff.net>
Date:   Fri, 14 Feb 2020 08:31:52 -0800
In-Reply-To: <20200214061714.GA605125@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Feb 2020 01:17:14 -0500")
Message-ID: <xmqqh7ztp1tz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82D5FE12-4F47-11EA-989A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But our use of autoconf is not very extensive, and in fact most
> developers do not use it at all. If you know you want curl, you're
> better off just overriding it explicitly with the Makefile knob:
>
>   make NO_CURL=
>
> or:
>
>   echo NO_CURL= >>config.mak
>   make
>
> Either of those will override the NO_CURL setting done by the configure
> script (you can see the full list of knobs set by configure in
> config.mak.autogen).

Heh, I didn't even know that things were expected to work if you
further tweak ./configure generated settings.  

You are correct to point out that our use of autoconf is merely is
an afterthought ;-), and the list of knobs near the top of Makefile
is more authoritative and fresh than what configure.in knows about.

Thanks.

