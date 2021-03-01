Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAFC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1186527F
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhCARaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:30:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59534 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbhCARSC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 12:18:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6439113759;
        Mon,  1 Mar 2021 12:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/2awBSR9K5DyLI7JqNkhPaZExs=; b=SBPIC6
        kWbH6oY4bjDr4lho5dQxF4m3irR4WZd1R1REGiqdGUDMDA0Z2acd8jOPAYItiPa1
        Iv0wad+KRdVh4cLCT4TsyGvfmQEc6pVkm9IONHatlXJcnEZIRWCjMGciBkEM4Fgn
        Cp7ycB+7DhiXKl5f2Rl79DtYhUA7V5Xx4dgMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ivUuoqbjo7sfGdZH8tYJtZrKh6JXh9uX
        E60OQShTt7K00tbW+yrNPEpMisazqglm7pwFW51ohHP24KpnJV6kI1rfUY9fDxvH
        TjmSXGLcTeGN6Pxe48Z1xajO0M1K6DWWbGYeGxQ3PD7BtdxAUZDZcf36YMjUy3am
        QHT9ZlZnRvs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEB26113758;
        Mon,  1 Mar 2021 12:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16A9C113756;
        Mon,  1 Mar 2021 12:17:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] config.mak.uname: enable OPEN_RETURNS_EINTR for macOS
 Big Sur
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
        <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
        <xmqqzgzuyqli.fsf@gitster.g>
        <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
        <YDiRywyld/0OTT5U@coredump.intra.peff.net>
        <xmqq8s7ascby.fsf@gitster.g>
        <YDy0C9sRvboGXQ7P@coredump.intra.peff.net>
Date:   Mon, 01 Mar 2021 09:17:13 -0800
In-Reply-To: <YDy0C9sRvboGXQ7P@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 1 Mar 2021 04:29:47 -0500")
Message-ID: <xmqqk0qqssiu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7DB1D3C-7AB1-11EB-A67A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I got another off-list report of the problem. I think we probably want
> to do this on top:
>
> -- >8 --
> Subject: config.mak.uname: enable OPEN_RETURNS_EINTR for macOS Big Sur
>
> We've had mixed reports on whether the latest release of macOS needs
> this Makefile knob set. In most reported cases, there's antivirus
> software running (which one might imagine could cause an open() call to
> be delayed). However, one of the (off-list) reports I've gotten
> indicated that it happened on an otherwise clean install of Big Sur.
>
> Since the symptom is so bad (checkout randomly fails to write several
> fails when the progress meter kicks in), and since the workaround is so
> lightweight (if we don't see EINTR, it's just an extra conditional
> check), let's just turn it on by default.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Apparently Big Sur jumped from macOS 10.x to 11.x. But our "uname -r"
> check gives the "Darwin version", in which it is 20.x (following 19.x
> for the previous version). At least according to some sources I found
> online. :) So that is good, because otherwise all of our uname_R checks
> here would have been broken. I don't have a Big Sur machine handy to
> test with, but I believe this should do what we want.

Thanks.

>  config.mak.uname | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index e22d4b6d67..d204c20a64 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -124,6 +124,9 @@ ifeq ($(uname_S),Darwin)
>  	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
>  		HAVE_GETDELIM = YesPlease
>  	endif
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
> +		OPEN_RETURNS_EINTR = UnfortunatelyYes
> +	endif
>  	NO_MEMMEM = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
>  	HAVE_DEV_TTY = YesPlease
