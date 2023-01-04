Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9BBC4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 06:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjADGNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 01:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjADGNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 01:13:31 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A21582F
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 22:13:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn22so34903423plb.13
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/45Zv3hJuSeCsrWwqJvRnMDVHx8RweXGfH0qUKRi6U=;
        b=Y1hgYAhJJId+r8XILByhZqSmBtb5bHrSrcduptAABrHJyJmFaupcEbBk0nICqMnsbY
         8RDfH8rhlrZurCOn0xCdIZT3SuFxBUgFMO3Mh/pGgCMs1JMzJJEgrjWqtBKdYyqmDOfn
         79yEqzipEyE7+gJk2AWlchYxVW4F1uHJcFmL7EVJWWz0Y/VxV2r/eN5q0wBXjVIW84GJ
         jYuJdp47d5ItHv0fE4ezUlaUwS7ZsM8ruwsDVfHvyD3Wn9hZtTp4wpsvc+dHS/pGJD1N
         KOPKGZTfpC3UhDmx3cAZjCe6FF7gvmOottbYJ/xhJhTiaW//Lxl8VoiSrX0IuIdhVtD2
         PuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/45Zv3hJuSeCsrWwqJvRnMDVHx8RweXGfH0qUKRi6U=;
        b=gyPb9hQf0iWyPDib6buZfvubrHmhIod+5evBAMVxRMleTW7WnG2FJtNgXjt30owA4+
         ku5acqY96T0gcLM1MNsRdGjrShEJ/yQG7nZsASbqolT7C+az7QjSlxrCylxOoeFUPwFB
         xBETTmiL5B92PJbk73eqEE2Yblq1b6iVJCIpZpbkGG57016OoJxuLrH+qty0pWxJVjSk
         8xx6oPQiOR4Eu0L9cSK60KVvQ6JqipZHi68ryRpchozvvDFgSTBl2nr+NsSMNCOlt5Jb
         KQeh9ACEx4hxqCwL+xGg0Ta7uPC5TFl42Ci5R8MxtnPO5dIVuaSwC6drrWvlfOS/hRq+
         /Log==
X-Gm-Message-State: AFqh2kojpOEOO5grF3glrzp4t71pKHcpHQXsZPcMrEFpGDajXE2UOHB9
        DNavgjTMPRWuKQNQGX0zazY=
X-Google-Smtp-Source: AMrXdXscgzGSMftF2RNavcG/y6MMrC1ycgy/WpJ4KB7zFZab5wP4cp1kDWyZgmtBr7Mlzc6Kog38lQ==
X-Received: by 2002:a17:903:2283:b0:192:8b51:a9f5 with SMTP id b3-20020a170903228300b001928b51a9f5mr45317600plh.68.1672812810123;
        Tue, 03 Jan 2023 22:13:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b001868981a18esm23283633plh.6.2023.01.03.22.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:13:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
        <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
        <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
        <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
Date:   Wed, 04 Jan 2023 15:13:29 +0900
In-Reply-To: <343a891e-d737-0ace-26a9-3839d3bd5583@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 3 Jan 2023 21:52:27 +0100")
Message-ID: <xmqq8riivncm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>    "For enhanced basic REs, ‘+’, ‘?’ and ‘|’ remain regular characters,
>     but ‘\+’, ‘\?’ and ‘\|’ have the same special meaning as the
>     unescaped characters do for extended REs, i.e., one or more
>     matches, zero or one matches and alteration, respectively."
>
> So apparently Apple chose a middle ground between basic and extended
> regular expressions for its grep and git grep.

Sounds like GNU extension to me.

> So GNU grep apparently made the same choice as Apple, probably far
> earlier.

Yup.

> Based on that I suggest:
> ...
>
> It would be simpler to use REG_ENHANCED everywhere it is defined instead
> of adding a Makefile setting, but it's a non-standard extension and
> might mean something else on other platforms.

OK.  Very conservative and good.

> Reported-by: Marco Nenciarini <marco.nenciarini@enterprisedb.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Makefile         | 8 ++++++++
>  config.mak.uname | 1 +
>  grep.c           | 4 ++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index db447d0738..15e7edc9d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,6 +289,10 @@ include shared.mak
>  # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
>  # feature.
>  #
> +# Define GIT_GREP_USES_REG_ENHANCED if your C library provides the flag
> +# REG_ENHANCED to enable enhanced basic regular expressions and you'd
> +# like to use it in git grep.
> +#
>  # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
>  # user.
>  #
> @@ -2037,6 +2041,10 @@ endif
>  ifdef NO_REGEX
>  	COMPAT_CFLAGS += -Icompat/regex
>  	COMPAT_OBJS += compat/regex/regex.o
> +else
> +ifdef GIT_GREP_USES_REG_ENHANCED
> +	COMPAT_CFLAGS += -DGIT_GREP_USES_REG_ENHANCED
> +endif
>  endif
>  ifdef NATIVE_CRLF
>  	BASIC_CFLAGS += -DNATIVE_CRLF
> diff --git a/config.mak.uname b/config.mak.uname
> index d63629fe80..14c145ae42 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -147,6 +147,7 @@ ifeq ($(uname_S),Darwin)
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
>  	CSPRNG_METHOD = arc4random
> +	GIT_GREP_USES_REG_ENHANCED = YesPlease
>
>  	# Workaround for `gettext` being keg-only and not even being linked via
>  	# `brew link --force gettext`, should be obsolete as of
> diff --git a/grep.c b/grep.c
> index 06eed69493..a8430daaba 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -502,6 +502,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  		regflags |= REG_ICASE;
>  	if (opt->pattern_type_option == GREP_PATTERN_TYPE_ERE)
>  		regflags |= REG_EXTENDED;
> +#if defined(GIT_GREP_USES_REG_ENHANCED) && defined(REG_ENHANCED)
> +	else
> +		regflags |= REG_ENHANCED;
> +#endif
>  	err = regcomp(&p->regexp, p->pattern, regflags);
>  	if (err) {
>  		char errbuf[1024];
> --
> 2.39.0
