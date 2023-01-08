Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1752C46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 01:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjAHB2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 20:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHB2A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 20:28:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823A33D6B
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 17:27:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so3708811pjf.0
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvbnFrzmrltUwd8mp1hRgQkdn2Po7+YXgLWNxLko1bw=;
        b=C3zIn6wtsZlMcFoQtoKNP4FXMD6tG7TIQORNNlWuCCviLnncQBWKD0vWnC9O0s/Uj4
         5orqXcAcWlCMRrepmitPkPOCDzsY7PNZ1bZS+l/+iDarlGZ889jNqeGBxQBOIFKIwpj8
         1e6K7qPAoXFhjuugmlIdos32FQpn7K+XK1+l/8HeSQ13+ksvHFNs/RlgQbTvTta2nbkg
         3oHiWQPFbOBsZaFujFzSiqUadpAoycysYHEvioEWaMSCIZ8KT4ZvPiF2Vu4QzHBcytVl
         SJXpv1sMVvBnIzPpbAFEDsFSnW4NGxgX5ytltZHIr+lgXTl3LR28fCRZGZCAEU6GaI+D
         R5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvbnFrzmrltUwd8mp1hRgQkdn2Po7+YXgLWNxLko1bw=;
        b=3WuoIDDjc/s1mznjU99m5iKLhQLZjCVagstBdWtW1VIug+3cHKKwNcVlGUxXEjZwwu
         80hXfiUyLfhm+pJeZCnF+AvCZkOrpGC7cKKsx23XL8zKohIXwm/cy5LTb/GJXOAfAB0q
         Vze+9MMDEXpRJaMPF2+nWJZASxsrXG+HNMB7el/YQlYA9M9AYEYQB9bAkRm4ny3JWQQ2
         NSdmZjaqYBSv0s4JPgBBv6Jis8l0+Ez92tIuYrC5z5PoJYY5a77Qv/OpJZycAwNRi2e3
         zH3u2uakAOsh8IxxgYOSti2XQbpgQjC9+dRDoULbqg8n511juyRPfiFDdlhGiOAYcLG6
         4PaQ==
X-Gm-Message-State: AFqh2kpx4PZNwE6FMg5YUitg5V6niieguLDGOlePVJrfHiWOSa5XAPft
        75HXW6CjwNNGPYCrSvZA6mU=
X-Google-Smtp-Source: AMrXdXuDofl3OgPbhP0eZry/m4H2sBGWAxa9GZKwoYX7zDtY5J0751gO/XmOULrk7Hz1a6T13VpE1A==
X-Received: by 2002:a17:902:cf41:b0:192:82d4:f9b2 with SMTP id e1-20020a170902cf4100b0019282d4f9b2mr47260139plg.7.1673141278829;
        Sat, 07 Jan 2023 17:27:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b00189b2b8dbedsm3304756plh.228.2023.01.07.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 17:27:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
        <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
        <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
        <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
        <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
        <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
        <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
        <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
Date:   Sun, 08 Jan 2023 10:27:58 +0900
In-Reply-To: <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 8 Jan 2023 01:42:04 +0100")
Message-ID: <xmqqpmbp24td.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> diff --git a/Makefile b/Makefile
> index db447d0738..46e30be673 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,6 +289,10 @@ include shared.mak
>  # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
>  # feature.
>  #
> +# Define USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS if your C library provides
> +# the flag REG_ENHANCED and you'd like to use it to enable enhanced basic
> +# regular expressions.
> +#

I wondered if we should mention macOS somewhere in the description
to help those users that may be affeced, but it seems that looking
for "REG_ENHANCED BSD" with a search engine finds pages that
indicate this is available on BSD's in general?

> @@ -2037,6 +2041,11 @@ endif
>  ifdef NO_REGEX
>  	COMPAT_CFLAGS += -Icompat/regex
>  	COMPAT_OBJS += compat/regex/regex.o
> +else
> +ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
> +	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
> +	COMPAT_OBJS += compat/regcomp_enhanced.o
> +endif

OK.

> diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
> new file mode 100644
> index 0000000000..84193ce53b
> --- /dev/null
> +++ b/compat/regcomp_enhanced.c
> @@ -0,0 +1,9 @@
> +#include "../git-compat-util.h"
> +#undef regcomp
> +int git_regcomp(regex_t *preg, const char *pattern, int cflags)
> +{
> +	if (!(cflags & REG_EXTENDED))
> +		cflags |= REG_ENHANCED;
> +	return regcomp(preg, pattern, cflags);
> +}

OK.  I like the "we only want to affect BRE" bit, that is carefully
done.

> diff --git a/config.mak.uname b/config.mak.uname
> index d63629fe80..7d25995265 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -147,6 +147,7 @@ ifeq ($(uname_S),Darwin)
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
>  	CSPRNG_METHOD = arc4random
> +	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease

OK.  This would give macOS folks who have already been using the
enhanced mode (without us asking) with their older libraries the
behaviour they are more familiar with.  Good.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 76e4b11131..1efa834089 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1338,6 +1338,11 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
>  }
>
> +#ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
> +int git_regcomp(regex_t *preg, const char *pattern, int cflags);
> +#define regcomp git_regcomp
> +#endif

OK.
