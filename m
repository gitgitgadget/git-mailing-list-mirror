Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB0C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4856611EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhIJPnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:43:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F70C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:41:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t19so5063545ejr.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3ajuD2+mbwh46HeOXY94t9hNBDwJkWtHB5fytupKYzc=;
        b=JzvSfzN8oeqig6skkT0ESUUBASz+zbwPZeP9SznUTg8EhuM7GuXl/VAZA+Ix7Y05SU
         WDG+W2uCA7otmO8wUlgqKSP/oXnSxCVWmvw2vi2mc+aPMf2FV6ssBh8xO9JmaeL5nEtJ
         T9GOjkrcdS1AouU7P8ciAzVXPJH8JVIfz1VXZEjhkSnEFK6TuiP2RqwrtETUwceKzomu
         qA0jbqkxjZ7R5WbuJ8GEhhlAcdZh6wVVUTETA0rWtl5bF534DnoZsur10DFwTkRWchz0
         BoRMjQhwYmTLbAEWGMzguBz2zoJCUe+ZELBr3e83oz7k2i2BgKuZfG108iKCtkzplS/h
         WDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3ajuD2+mbwh46HeOXY94t9hNBDwJkWtHB5fytupKYzc=;
        b=qp5/GV0+z4OHBbkKaOjuIm0PP7P3h0udvQj4l8/1S+A9WY8xF3KzXzC4PwkIncUH1z
         S+m1zS9UIPI0D9dc+4wVhPKj7FRsYPP7h+KWDEpiY3qf9rHGveoZ1A74lbPySawiMUVV
         G2Mp5306+DxICbbMKQhcBmup1H/yRbPEJ4yZzhUOUppc2rgCo4CJcDbRCMAEtg/9hDH9
         PtASyURWvED/Bzd78N73eXx/OcN3sMqM1T+1lCqQGlWxyKKnG5hvQycp76T2LiTtqJk7
         Ze9ln1mBjHGjCRqslNESIkqSd3xO7uHOiRVZKOfB34QL2gvfB7/M1JKW1HeTPZDQxBss
         8tiw==
X-Gm-Message-State: AOAM531KGsiWS3N3txTd95mj32cFPHCrhpf7lY/2qfjFLtqd+59rDYPb
        XJlliDXlnI8SBJgsSD7rPXM=
X-Google-Smtp-Source: ABdhPJxmY0Xjtd7LWBOLjVOfiw5Pa70mCwoh3whN6n8sNCUXnP63scvo0sXlEohhvzHJ3LghTMCMDg==
X-Received: by 2002:a17:906:3983:: with SMTP id h3mr10041031eje.249.1631288518462;
        Fri, 10 Sep 2021 08:41:58 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t1sm2914924edq.31.2021.09.10.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:41:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/3] gettext: remove optional non-standard parens in
 N_() definition
Date:   Fri, 10 Sep 2021 17:39:57 +0200
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-2-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210903170232.57646-2-carenas@gmail.com>
Message-ID: <87h7escu9m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Remove the USE_PARENS_AROUND_GETTEXT_N compile-time option which was
> meant to catch an inadvertent mistake which is too obscure to
> maintain this facility.
>
> The backstory of how USE_PARENS_AROUND_GETTEXT_N came about is: When I
> added the N_() macro in 65784830366 (i18n: add no-op _() and N_()
> wrappers, 2011-02-22) it was defined as:
>
>     #define N_(msgid) (msgid)
>
> This is non-standard C, as was noticed and fixed in 642f85faab2 (i18n:
> avoid parenthesized string as array initializer, 2011-04-07).
> I.e. this needed to be defined as:
>
>     #define N_(msgid) msgid
>
> Then in e62cd35a3e8 (i18n: log: mark parseopt strings for translation,
> 2012-08-20) when "builtin_log_usage" was marked for translation the
> string concatenation for passing to usage() added in 1c370ea4e51
> (Show usage string for 'git log -h', 'git show -h' and 'git diff -h',
> 2009-08-06) was faithfully preserved:
>
> -       "git log [<options>] [<since>..<until>] [[--] <path>...]\n"
> -       "   or: git show [options] <object>...",
> +       N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
> +       N_("   or: git show [options] <object>..."),
>
> This was then fixed to be the expected array of usage strings in
> e66dc0cc4b1 (log.c: fix translation markings, 2015-01-06) rather than
> a string with multiple "\n"-delimited usage strings, and finally in
> 290c8e7a3fe (gettext.h: add parentheses around N_ expansion if
> supported, 2015-01-11) USE_PARENS_AROUND_GETTEXT_N was added to ensure
> this mistake didn't happen again.
>
> I think that even if this was a N_()-specific issue this
> USE_PARENS_AROUND_GETTEXT_N facility wouldn't be worth it, the issue
> would be too rare to worry about.
>
> But I also think that 290c8e7a3fe which introduced
> USE_PARENS_AROUND_GETTEXT_N misattributed the problem. The issue
> wasn't with the N_() macro added in e62cd35a3e8, but that before the
> N_() macro existed in the codebase the initial migration to
> parse_options() in 1c370ea4e51 continued passsing in a "\n"-delimited
> string, when the new API it was migrating to supported and expected
> the passing of an array.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile          | 20 +-------------------
>  config.mak.dev    |  2 --
>  gettext.h         | 24 ------------------------
>  git-compat-util.h |  4 ----
>  4 files changed, 1 insertion(+), 49 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9573190f1d..4e94073c2a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -409,15 +409,6 @@ all::
>  # Define NEEDS_LIBRT if your platform requires linking with librt (glibc=
 version
>  # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
>  #
> -# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
> -# compiles the following initialization:
> -#
> -#   static const char s[] =3D ("FOO");
> -#
> -# and define it to "no" if you need to remove the parentheses () around =
the
> -# constant.  The default is "auto", which means to use parentheses if yo=
ur
> -# compiler is detected to support it.
> -#
>  # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl fu=
nction.
>  #
>  # Define HAVE_GETDELIM if your system has the getdelim() function.
> @@ -497,8 +488,7 @@ all::
>  #
>  #    pedantic:
>  #
> -#        Enable -pedantic compilation. This also disables
> -#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
> +#        Enable -pedantic compilation.
>=20=20
>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1347,14 +1337,6 @@ ifneq (,$(SOCKLEN_T))
>  	BASIC_CFLAGS +=3D -Dsocklen_t=3D$(SOCKLEN_T)
>  endif
>=20=20
> -ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
> -	BASIC_CFLAGS +=3D -DUSE_PARENS_AROUND_GETTEXT_N=3D1
> -else
> -ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
> -	BASIC_CFLAGS +=3D -DUSE_PARENS_AROUND_GETTEXT_N=3D0
> -endif
> -endif
> -
>  ifeq ($(uname_S),Darwin)
>  	ifndef NO_FINK
>  		ifeq ($(shell test -d /sw/lib && echo y),y)
> diff --git a/config.mak.dev b/config.mak.dev
> index 022fb58218..41d6345bc0 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -4,8 +4,6 @@ SPARSE_FLAGS +=3D -Wsparse-error
>  endif
>  ifneq ($(filter pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -pedantic
> -# don't warn for each N_ use
> -DEVELOPER_CFLAGS +=3D -DUSE_PARENS_AROUND_GETTEXT_N=3D0
>  endif
>  DEVELOPER_CFLAGS +=3D -Wall
>  DEVELOPER_CFLAGS +=3D -Wdeclaration-after-statement
> diff --git a/gettext.h b/gettext.h
> index c8b34fd612..d209911ebb 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -55,31 +55,7 @@ const char *Q_(const char *msgid, const char *plu, uns=
igned long n)
>  }
>=20=20
>  /* Mark msgid for translation but do not translate it. */
> -#if !USE_PARENS_AROUND_GETTEXT_N
>  #define N_(msgid) msgid
> -#else
> -/*
> - * Strictly speaking, this will lead to invalid C when
> - * used this way:
> - *	static const char s[] =3D N_("FOO");
> - * which will expand to
> - *	static const char s[] =3D ("FOO");
> - * and in valid C, the initializer on the right hand side must
> - * be without the parentheses.  But many compilers do accept it
> - * as a language extension and it will allow us to catch mistakes
> - * like:
> - *	static const char *msgs[] =3D {
> - *		N_("one")
> - *		N_("two"),
> - *		N_("three"),
> - *		NULL
> - *	};
> - * (notice the missing comma on one of the lines) by forcing
> - * a compilation error, because parenthesised ("one") ("two")
> - * will not get silently turned into ("onetwo").
> - */
> -#define N_(msgid) (msgid)
> -#endif
>=20=20
>  const char *get_preferred_languages(void);
>  int is_utf8_locale(void);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b46605300a..ddc65ff61d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1253,10 +1253,6 @@ int warn_on_fopen_errors(const char *path);
>   */
>  int open_nofollow(const char *path, int flags);
>=20=20
> -#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
> -#define USE_PARENS_AROUND_GETTEXT_N 1
> -#endif
> -
>  #ifndef SHELL_PATH
>  # define SHELL_PATH "/bin/sh"
>  #endif

A note & cross-link: I've submitted a v2 of another series where we'll
effectively duplicate the check being removed here, see
https://lore.kernel.org/git/cover-v2-0.6-00000000000-20210910T153146Z-avara=
b@gmail.com/

Well, it's not a general N_() multi-line checker like the proposed
https://lore.kernel.org/git/20210901091941.34886-4-carenas@gmail.com/
and this USE_PARENS_AROUND_GETTEXT_N, but we added
USE_PARENS_AROUND_GETTEXT_N to begin with for these usage strings. The
bad usage of that usage API (phew!, that's a mouthful) will be caught by
that usage CAPI being stricter now.
