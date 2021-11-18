Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EBC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5388C6128C
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbhKRHNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:13:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55738 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243609AbhKRHMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:12:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 846FD174724;
        Thu, 18 Nov 2021 02:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fO9OyE5mE00XjuoNexzNj62orpk8em3J8NSC7M
        ytZaU=; b=l4YnW18JrbM+2wdGWkskh7y9tC74Rx9P7ETT2fvsLpseL7kOPACYhf
        GBUBu+WLMoZ6UHr3TZ86efUSpjuopWKab1m01GOCXGSpUby0dsErA2JViaiNGgCi
        OkZ5oeD2hVJZUp6UvOw2lBVSgoo1SAPNBvDVszZ52Ce0zEfExSJvg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D93A174723;
        Thu, 18 Nov 2021 02:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF0B4174722;
        Thu, 18 Nov 2021 02:09:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
In-Reply-To: <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com> (Phillip Wood's
        message of "Wed, 17 Nov 2021 11:03:58 +0000")
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
        <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
        <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 17 Nov 2021 23:09:08 -0800
Message-ID: <xmqq1r3eym7f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D395166-483E-11EC-A975-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I like the idea of using a specific test balloon for the features that
> we want to use but wont this one break the build for anyone doing
> 'make DEVELOPER=1' because -Wdeclaration-after-statement will error
> out.

I think you are missing '?' at the end of the sentence, but the
answer is "no, at least not for me".

    # pardon my "make" wrapper; it is to pass DEVELOPER=1 etc. to
    # the underlying "make" command.
    $ Meta/Make V=1 revision.o
    cc -o revision.o -c -MF ./.depend/revision.o.d -MQ revision.o -MMD -MP  -Werror -Wall -pedantic -Wpedantic -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -fno-common -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  revision.c
    $ cc --version
    cc (Debian 10.3.0-11) 10.3.0
    Copyright (C) 2020 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


It would be quite sad if we had to allow decl-after-stmt, only to
allow

	stmt;
	for (type var = init; ...; ...) {
		...;
	}

because it should merely be a short-hand for

	stmt;
	{
	    type var;
	    for (var = init; ...; ...) {
		...;
	    }
	}

that does not need to allow decl-after-stmt.

Different compilers may behave differently, so it might be an issue
for somebody else, but I am hoping any reasonable compiler would
behave sensibly.

Thanks for raising a potential issue, as others can try it out in
their environment and see if their compilers behave well.



