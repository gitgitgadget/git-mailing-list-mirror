Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4BC47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5902B613D6
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhFBLs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhFBLs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:48:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C6C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:47:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so2027231pgn.4
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNK7Q1RkjsN+JkpI5ZjeABG0AsmwYd7tXYSebHQQCq8=;
        b=guVsl1FG07eyhJmiefjKXenZfwjnQCBjaK3YbPf5ygJpW0ujO1nwjQuxVFIAg21yFT
         B5n/EyeoVxDsuAbGMWHeIF7ANx7CIdylqo+jWx3JO4+UiUEj2dBrP/dOmzUGkF7DSV3I
         UTtw1zAmegERlU8u5ZiNypXtTQtBfqdip9YN2r4eC1k3r1LPpWY24m7yKXSRieui6owU
         /3uAodUnB/aJxMaAG8zPxWhgERt/bTwByQ47PYyP3Msbqm6dto7UGFsFhGJYDpPr/SLN
         oziAnlFbTLjFzsTmjo7RIu8QOe7Q+M6634jRDLXsLQQWcAPEuscarZs/PhoSF8kYs/Mj
         dSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNK7Q1RkjsN+JkpI5ZjeABG0AsmwYd7tXYSebHQQCq8=;
        b=F221JUAXviNdRKiZA7AxYRJ7O9O7kCLFws6BlWO0pnrFl/QsNActpTPeopEmUN1frB
         rwMcDShoQ6Urzg49VDtQR3ed+WHjwZz7roCcsJ9o++4lPaHRMIN/iPuAm9kAzBIyrTwR
         3b8c/hGZRW1I/RfG9yuQYX2rWiHTIXLqUpuBN1CqS09C8pW54Hr/gCqPMg7WsjD5y02T
         VKxZVfrlbHmcdxT8QM0vQbJ+XLFxn9y/eP4UAMZ7cTPjdPFD6sfLwwIYuMFh8gB0AGJ8
         oiYSvvQRGY9Z+23/skWqU92IYFyCaw1CrZvmNu2yJuV0AzfjWueqGAegi7c1icikK+ax
         Uj+g==
X-Gm-Message-State: AOAM530kEKTPU2bLMqxc9QxHFENjQAL0JQcPB8sxZkQjBIUaaUdYPFcp
        VD4/pqZzxigf6SnfMrFgCLhjL85sA5itag==
X-Google-Smtp-Source: ABdhPJzHhZYtvEM2HLYXt26DVQb/QXb1TZ6ozjD7noijF1+vzmkAFnPQXv8sNpyxMrCrVI1Y95W5fQ==
X-Received: by 2002:a05:6a00:1c4d:b029:2e9:c839:d2d with SMTP id s13-20020a056a001c4db02902e9c8390d2dmr16201677pfw.5.1622634434046;
        Wed, 02 Jun 2021 04:47:14 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id b124sm16017289pfa.27.2021.06.02.04.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:47:13 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] t: use user-specific utf-8 locale for testing
Date:   Wed,  2 Jun 2021 18:46:46 +0700
Message-Id: <20210602114646.17463-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2.1.gd85b21334f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some test-cases, utf-8 locale is required. To find such locale,
we're using the first available UTF-8 locale that returned by
"locale -a".

Despite being required by POSIX, locale(1) is unavailable in some
systems, e.g. Linux with musl libc.  Some of those systems support
utf-8 locale out of the box.

However, without "locale -a", we can't guess provided UTF-8 locale.

Let's give users of those systems an option to have better test
coverage.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile                                 |  6 ++++++
 t/lib-git-svn.sh                         | 15 +++++++++------
 t/t9100-git-svn-basic.sh                 | 14 +++-----------
 t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
 t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
 5 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..4b2c24e5ea 100644
--- a/Makefile
+++ b/Makefile
@@ -398,6 +398,9 @@ all::
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
+# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing.
+# If it isn't set, use the first utf-8 locale returned by "locale -a".
+#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -2801,6 +2804,9 @@ ifdef GIT_TEST_CMP
 endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
+endif
+ifdef GIT_TEST_UTF8_LOCALE
+	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 547eb3c31a..df319593f7 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -121,12 +121,15 @@ start_svnserve () {
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
+		GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
+		p
+		q
+	}')
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
2.32.0.rc2.1.gd85b21334f

