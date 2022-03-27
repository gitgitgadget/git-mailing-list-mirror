Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11982C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 11:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiC0LO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0LO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 07:14:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777337BCB
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:12:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bq8so9362046ejb.10
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NoGyazFsoHTD779cmCCjk82pGJdnS7QuVFZL3l6/nw4=;
        b=K2LL0O2cES5PB28LShDsp/QJKnWSJLAaDRwYV+2ml0mwku0iOuWC5eSYd6oZ/xbOao
         70bFGCCg7CxF4IrF3arFiMp7UcaA7sANfP4YicimcN5MYQ6lKADhDmnBHMbEd8IRCrke
         H9hpFzEdH30tXTc52DlFMFNlhWzO15RsL3d77HOW2WsPN4KMYteVJWxa3hLr4Lv4MIL7
         bqxxJaWKS1Jo8ogFNHZDloqcHT10agaTBQiKFK8adFBtFiWyvHChh6mINQLGnxnDe87o
         4kd55c/PFuckLqzKCttaciRxNJae8QfNebHDM7ebOX1aymZTr2VxYRXPqutq/wI+Kgsw
         O2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NoGyazFsoHTD779cmCCjk82pGJdnS7QuVFZL3l6/nw4=;
        b=ViS4Zp25RCpwLkJNgaaJDWzQPhgeKCwyUR3zUVtiMy2FGsiW3JXh0cL7vhTsW8cbCI
         srCNN79OnJH5VkjEiFrtdtaS+6rLBZjx82c02npXjW1Z0XLMPmOY1tvS8S/v9TvtlP8W
         hleO03OvQYmGoi8nv+0W54ncgvGv48h0clHRTO0yCSTgtVwM6KJwlMsUOThqkx1jO6xq
         IVE2I8OdwC8ZtTT/Mv6wQ5m5c6dXEQHcGQ9dS9hbApQU6rO0JFfSAvXt50UnAGGBbbWl
         idDOgGSLl8xY9utKhY77UgG7HzT/YXCGYbbuTqMj9rVplgXHVs/zFQDO+pk1rPpjHAoo
         kZ/A==
X-Gm-Message-State: AOAM530rERZ6h7tqnTub2NqmoRmbSgH9eA4zKaQtgVqtToelPp9Q7uW0
        OXD2DcjMteFauQEptiWvW7M487heeVcdOg==
X-Google-Smtp-Source: ABdhPJwe8SX22UvYY+es19/TMDv0apDgH/2GNDdMq4TFK8tu4Yb+s9mldO82jw635I55SAPt4J22jA==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr22139459ejc.401.1648379565603;
        Sun, 27 Mar 2022 04:12:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b006b0e62bee84sm4448509ejm.115.2022.03.27.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 04:12:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYQpA-002kJS-CO;
        Sun, 27 Mar 2022 13:12:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH] set LC_TIME even if locale dir is not present
Date:   Sun, 27 Mar 2022 12:13:31 +0200
References: <pull.1189.git.1648371489398.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <pull.1189.git.1648371489398.gitgitgadget@gmail.com>
Message-ID: <220327.867d8ffy37.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 27 2022, Matthias A=C3=9Fhauer via GitGitGadget wrote:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> Since Commit aa1462c (introduce "format" date-mode, 2015-06-25) git log c=
an
> pass user specified format strings directly to strftime(). One special
> format string we explicitly mention in our documentation is %c, which
> depends on the system locale. To accommodate for %c we added a call to
> setlocale() in git_setup_gettext().
>
> In Commit cc5e1bf (gettext: avoid initialization if the locale dir is not
> present, 2018-04-21) we added an early exit to git_setup_gettext() in case
> no textdomain directory is present. This early exit is so early, that we
> don't even set the locale for %c in that case, despite strftime() not
> needing the textdomain directory at all.

Thanks for tracking this down. This commit & end-state looks good to me,
I just have comments about the implementation below, i.e. you're doing
more work than you need to, some of this we have test infrastructure
already...

> diff --git a/Makefile b/Makefile
> index e8aba291d7f..ddca29b550b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -410,6 +410,10 @@ include shared.mak
>  # If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
>  # locale returned by "locale -a".
>  #
> +# Define GIT_TEST_TIME_LOCALE to preferred non-us locale for testing.
> +# If it isn't set, fallback to $LC_ALL, $LANG or use the first non-us
> +# locale returned by "locale -a".
> +#
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
>  #
>  # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
> @@ -2862,6 +2866,9 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>  endif
>  ifdef GIT_TEST_UTF8_LOCALE
>  	@echo GIT_TEST_UTF8_LOCALE=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TES=
T_UTF8_LOCALE)))'\' >>$@+
> +endif
> +ifdef GIT_TEST_TIME_LOCALE
> +	@echo GIT_TEST_TIME_LOCALE=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TES=
T_TIME_LOCALE)))'\' >>$@+
>  endif
>  	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' =
>>$@+
>  ifdef GIT_PERF_REPEAT_COUNT

You won't need this, more later...

> diff --git a/gettext.c b/gettext.c
> index bb5ba1fe7cc..2b614c2b8c6 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -107,6 +107,8 @@ void git_setup_gettext(void)
>  	const char *podir =3D getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
>  	char *p =3D NULL;
>=20=20
> +	setlocale(LC_TIME, "");
> +
>  	if (!podir)
>  		podir =3D p =3D system_path(GIT_LOCALE_PATH);
>=20=20
> @@ -117,7 +119,6 @@ void git_setup_gettext(void)
>=20=20
>  	bindtextdomain("git", podir);
>  	setlocale(LC_MESSAGES, "");
> -	setlocale(LC_TIME, "");
>  	init_gettext_charset("git");
>  	textdomain("git");
>=20=20
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index e448ef2928a..01a1e61ecea 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -25,6 +25,29 @@ commit_msg () {
>  	fi
>  }
>=20=20
> +prepare_time_locale () {
> +	if test -z "$GIT_TEST_TIME_LOCALE"
> +	then
> +		case "${LC_ALL:-$LANG}" in
> +		C | C.* | POSIX | POSIX.* | en_US | en_US.* )
> +			GIT_TEST_TIME_LOCALE=3D$(locale -a | sed -n '/^\(C\|POSIX\|en_US\)/I =
!{
> +				p
> +				q
> +			}')
> +			;;
> +		*)
> +			GIT_TEST_TIME_LOCALE=3D"${LC_ALL:-$LANG}"
> +			;;
> +		esac
> +	fi
> +	if test -n "$GIT_TEST_TIME_LOCALE"
> +	then
> +		test_set_prereq TIME_LOCALE
> +	else
> +		say "# No non-us locale available, some tests are skipped"
> +	fi
> +}
> +

And this setup we do already elsewhere.

I think the below would be a good candidate to squash into this. The C
change doesn't change the behavior from your version, but I think it's
good to take the change here about being explicit what we do and don't
seup with/without a podir.

Your prepare_time_locale() is then duplicating lib-gettext.sh, the below
shows a replacement for your test piggy-backing on existing test infra.

I was then worried that we'd introduced a regression in cc5e1bf in
assuming that we didn't need to setlocale(LC_MESSAGES) just because we
didn't have a podir, because the C library might have some, but the
below test passe for me on linux+glibc.

Maybe there's still a regression there, I'm not sure. Perhaps it's also
good to drop that "optimization" on non-Windows platforms?

diff --git a/gettext.c b/gettext.c
index bb5ba1fe7cc..9b46c224230 100644
--- a/gettext.c
+++ b/gettext.c
@@ -102,25 +102,34 @@ static void init_gettext_charset(const char *domain)
 		setlocale(LC_CTYPE, "C");
 }
=20
+static void git_setup_gettext_no_podir(void)
+{
+	setlocale(LC_TIME, "");
+}
+
+static void git_setup_gettext_podir(const char *podir)
+{
+	bindtextdomain("git", podir);
+	setlocale(LC_MESSAGES, "");
+	init_gettext_charset("git");
+	textdomain("git");
+}
+
 void git_setup_gettext(void)
 {
 	const char *podir =3D getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
 	char *p =3D NULL;
=20
+	git_setup_gettext_no_podir();
+
 	if (!podir)
 		podir =3D p =3D system_path(GIT_LOCALE_PATH);
=20
-	if (!is_directory(podir)) {
-		free(p);
-		return;
-	}
-
-	bindtextdomain("git", podir);
-	setlocale(LC_MESSAGES, "");
-	setlocale(LC_TIME, "");
-	init_gettext_charset("git");
-	textdomain("git");
+	if (!is_directory(podir))
+		goto done;
=20
+	git_setup_gettext_podir(podir);
+done:
 	free(p);
 }
=20
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocal=
e-sanity.sh
index 0ce1f22eff6..69facd2f8ed 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -23,4 +23,49 @@ test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-=
1 commit under a UTF-8 l
 	grep -q "iso-utf8-commit" out
 '
=20
+test_expect_success GETTEXT_LOCALE 'the %c date format works even without =
a localedir (LC_TIME)' '
+	test_when_finished "rm -rf empty" &&
+	mkdir empty &&
+	LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" GIT_TEXTDOMAINDIR=3D"$PWD/empty" \
+		git log --pretty=3Dformat:%ad --date=3Dformat:%c HEAD^1..HEAD >actual &&
+
+	# Avoid testing the raw format (it might differ?). But
+	# Thursday is Fimmtudagur in Icelandic, so grepping "fim" is
+	# pretty certain to test that the locale was used.
+	grep -iF fim actual
+'
+
+test_lazy_prereq GETTEXT_HAVE_STRERROR_TRANSLATED '
+	test_have_prereq GETTEXT_LOCALE &&
+	test_have_prereq POSIXPERM &&
+
+	test_when_finished "rm -f file" &&
+	>file &&
+
+	# German is more likely to have a strerror() translation
+	test_must_fail git init file 2>loc-C &&
+	grep "cannot mkdir" loc-C &&
+	test_must_fail env \
+		LANGUAGE=3Dde LC_ALL=3D"de_DE.utf8" \
+		git init file 2>loc-de &&
p+	! grep "cannot mkdir" loc-de
+
+'
+
+test_expect_success GETTEXT_LOCALE,GETTEXT_HAVE_STRERROR_TRANSLATED \
+	'LC_MESSAGES is set up without a localedir (for strerror())' '
+	test_when_finished "rm -f file" &&
+	>file &&
+	test_when_finished "rm -rf no-domain" &&
+	mkdir no-domain &&
+
+	test_must_fail git init file 2>loc-C &&
+	test_must_fail env \
+		LANGUAGE=3Dde LC_ALL=3D"de_DE.utf8" \
+		NO_SET_GIT_TEXTDOMAINDIR=3DStopDoingThatInBinWrappers \
+		GIT_TEXTDOMAINDIR=3D"$PWD/no-domain" \
+		git init file 2>loc-de-no-textdomain &&
+	! test_cmp loc-C loc-de-no-textdomain
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 515b1af7ed4..886d260082d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1428,6 +1428,8 @@ else # normal case, use ../bin-wrappers only unless $=
with_dashes:
 			fi
 			with_dashes=3Dt
 		fi
+		GIT_RUNING_TEST_LIB_SH=3Dt
+		export GIT_RUNING_TEST_LIB_SH
 		PATH=3D"$git_bin_dir:$PATH"
 	fi
 	GIT_EXEC_PATH=3D$GIT_BUILD_DIR
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 95851b85b6b..3089bcad37c 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -15,10 +15,14 @@ else
 	export GIT_TEMPLATE_DIR
 fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/build/lib'"${GITPERLLIB:+:$GITPERLLIB}"
-GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+if test -z "$NO_SET_GIT_TEXTDOMAINDIR"
+then
+	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+	export GIT_TEXTDOMAINDIR
+fi
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
=20
-export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
+export GIT_EXEC_PATH GITPERLLIB PATH
=20
 case "$GIT_DEBUGGER" in
 '')
