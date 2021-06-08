Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E8C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42D061263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHG7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:59:48 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:51073 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHG7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:59:47 -0400
Received: by mail-pj1-f41.google.com with SMTP id g4so1859245pjk.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaGN4sZ5ljGJc/j4POFfRuBBuEx1mNzmkjpW1CsjreE=;
        b=jnRynPnVBRuP17+qHT8Acvxgbiy+KcqxYsEwGCjbKxYI+7W66b1fIwSOYAwf8+DL1Z
         hqccJQ7l9z/8u3NMBvtGUNYumVL9wztrR+/U/0Ucm/X3vuqHjT3OHIsvEwZ9mE1PNxeV
         fDDzCkKj8kqP5fZTiHyTqSdE6uSVXBm4FCXZi9fIwgnxke2trLCDCbap++IWxI0R/mTP
         8WezGCpO8SOJcew/thDasFsR+qDuioj+IMs6XNkto7ffi9PhOiiCuzuYzgIXDakTtrx2
         OZPrVnlR3P7bwOQuSoQawEnVDN6Ct5KW9CipheaYbewf9V5zzTxbNs3IJSMynN66vQXj
         W6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaGN4sZ5ljGJc/j4POFfRuBBuEx1mNzmkjpW1CsjreE=;
        b=FQoewifXsi1igE8y/XpOaOVG0uflVAug7eai3wy3KPQoUl2n5ysN469m/xam4e0z7J
         tV8yxcDPvvgrSWpc3yghxelqckQoMp8j6J5sybUb8gvouK9wajyZ64Twq48x2kS5tp5b
         CIq7Mu01uswvVQ9uRb3+GwPMC12hIIc7Wa0tYYHte9HJfqIBcEkZ88aAuIquoIOyW3I8
         xplska1PgkacEGCKHyls5eNJimqndEp41upI/VAfeo6vE3If+35Gv0xOnNMKwwSfL/3i
         diwNEsCxTELzfq3927Gs2chvGieEqNZCXecWq2ke0LNXkGe2UDj/GJsdWJU3ZdNnm7aM
         qTgw==
X-Gm-Message-State: AOAM532100gAIGzWI8gr7+apPYidZVcd2TncsdhCHjnkM5vmRdJyuzMy
        LqEB3lbcQai4GlOuzSTi4fDn/E79rtLTag==
X-Google-Smtp-Source: ABdhPJzFgl0VHsrfNQJsm4WjVOIFXJcxar3nnSpbcxro/dordbRP0qZzLKrKzIUPD0/L7AEj6ayT3Q==
X-Received: by 2002:a17:902:e812:b029:112:3047:272a with SMTP id u18-20020a170902e812b02901123047272amr9848341plg.67.1623135399439;
        Mon, 07 Jun 2021 23:56:39 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id d127sm9735760pfc.50.2021.06.07.23.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:56:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <ttaylorr@github.com>,
        Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5] t: use user-specified utf-8 locale for testing svn
Date:   Tue,  8 Jun 2021 13:56:28 +0700
Message-Id: <20210608065628.23767-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210602114646.17463-1-congdanhqx@gmail.com>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some test-cases, UTF-8 locale is required. To find such locale,
we're using the first available UTF-8 locale that returned by
"locale -a".

However, the locale(1) utility is unavailable on some systems,
e.g. Linux with musl libc.

However, without "locale -a", we can't guess provided UTF-8 locale.

Add a Makefile knob GIT_TEST_UTF8_LOCALE and activate it for
linux-musl in our CI system.

Rename t/lib-git-svn.sh:prepare_a_utf8_locale to prepare_utf8_locale,
since we no longer prepare the variable named "a_utf8_locale",
but set up a fallback value for GIT_TEST_UTF8_LOCALE instead.
The fallback will be LC_ALL, LANG environment variable,
or the first UTF-8 locale from output of "locale -a", in that order.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 New in v5: fix a regression when LC_ALL or LANG set to something that not
 ends with utf-8, e.g. "C", "locale -a" will be ignored completely.

 Thanks to Peff's comment, I didn't notice this regression earlier.

Range-diff against v4:
1:  6036f670d9 ! 1:  6675de6866 t: use user-specified utf-8 locale for testing svn
    @@ t/lib-git-svn.sh: start_svnserve () {
     -}')
     -	if test -n "$a_utf8_locale"
     +prepare_utf8_locale () {
    -+	if test -n "$GIT_TEST_UTF8_LOCALE"
    -+	then
    -+		: test_set_prereq UTF8
    -+	elif test -n "${LC_ALL:-$LANG}"
    ++	if test -z "$GIT_TEST_UTF8_LOCALE"
     +	then
     +		case "${LC_ALL:-$LANG}" in
     +		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
     +			GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
     +			;;
    ++		*)
    ++			GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
    ++				p
    ++				q
    ++			}')
    ++			;;
     +		esac
    -+	else
    -+		GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
    -+		p
    -+		q
    -+	}')
     +	fi
     +	if test -n "$GIT_TEST_UTF8_LOCALE"
      	then

 Makefile                                 |  7 +++++++
 ci/lib.sh                                |  1 +
 t/lib-git-svn.sh                         | 22 ++++++++++++++++------
 t/t9100-git-svn-basic.sh                 | 14 +++-----------
 t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
 t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
 6 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..502e0c9a81 100644
--- a/Makefile
+++ b/Makefile
@@ -398,6 +398,10 @@ all::
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
+# Define GIT_TEST_UTF8_LOCALE to preferred utf-8 locale for testing.
+# If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
+# locale returned by "locale -a".
+#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -2801,6 +2805,9 @@ ifdef GIT_TEST_CMP
 endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
+endif
+ifdef GIT_TEST_UTF8_LOCALE
+	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
diff --git a/ci/lib.sh b/ci/lib.sh
index d848c036c5..476c3f369f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -229,6 +229,7 @@ linux-musl)
 	CC=gcc
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
+	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 esac
 
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 547eb3c31a..2fde2353fd 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -121,12 +121,22 @@ start_svnserve () {
 		 --listen-host 127.0.0.1 &
 }
 
-prepare_a_utf8_locale () {
-	a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
-	p
-	q
-}')
-	if test -n "$a_utf8_locale"
+prepare_utf8_locale () {
+	if test -z "$GIT_TEST_UTF8_LOCALE"
+	then
+		case "${LC_ALL:-$LANG}" in
+		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
+			GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
+			;;
+		*)
+			GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
+				p
+				q
+			}')
+			;;
+		esac
+	fi
+	if test -n "$GIT_TEST_UTF8_LOCALE"
 	then
 		test_set_prereq UTF8
 	else
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 1d3fdcc997..d5563ec35f 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -4,21 +4,13 @@
 #
 
 test_description='git svn basic tests'
-GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
 
-case "$GIT_SVN_LC_ALL" in
-*.UTF-8)
-	test_set_prereq UTF8
-	;;
-*)
-	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
-	;;
-esac
+prepare_utf8_locale
 
 test_expect_success 'git svn --version works anywhere' '
 	nongit git svn --version
@@ -187,8 +179,8 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 	test ! -h "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
 
-name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
-LC_ALL="$GIT_SVN_LC_ALL"
+name="commit with UTF-8 message: locale: $GIT_TEST_UTF8_LOCALE"
+LC_ALL="$GIT_TEST_UTF8_LOCALE"
 export LC_ALL
 # This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
 test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9b44a44bc1..743fbe1fe4 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,9 +93,9 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
 # > ... All of the above characters, except for the backslash, are converted
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
-prepare_a_utf8_locale
+prepare_utf8_locale
 test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 new file on dcommit' '
-	LC_ALL=$a_utf8_locale &&
+	LC_ALL=$GIT_TEST_UTF8_LOCALE &&
 	export LC_ALL &&
 	neq=$(printf "\201\202") &&
 	git config svn.pathnameencoding cp932 &&
@@ -107,7 +107,7 @@ test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 new
 
 # See the comment on the above test for setting of LC_ALL.
 test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 rename on dcommit' '
-	LC_ALL=$a_utf8_locale &&
+	LC_ALL=$GIT_TEST_UTF8_LOCALE &&
 	export LC_ALL &&
 	inf=$(printf "\201\207") &&
 	git config svn.pathnameencoding cp932 &&
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 2c213ae654..01e1e8a8f7 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -14,12 +14,12 @@ compare_git_head_with () {
 	test_cmp current "$1"
 }
 
-prepare_a_utf8_locale
+prepare_utf8_locale
 
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL="$a_utf8_locale" svn log $(git svn info --url) | perl -w -e '
+	LC_ALL="$GIT_TEST_UTF8_LOCALE" svn log $(git svn info --url) | perl -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
-- 
2.32.0.278.gd42b80f139

