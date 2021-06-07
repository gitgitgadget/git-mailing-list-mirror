Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790DC4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A768613D4
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFGBK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGBK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 21:10:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF3C061766
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 18:08:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u18so11847914pfk.11
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZ/MVSIyGjzoRpHYl+CmAFkl6jIhxHw2dH0L7FgYzg4=;
        b=hKOVeWh6t2kRw6srz5g20tlAUt99vMtS7EcUXhXH4iJTUPqHLMCnpVxz6xqSNA0XMG
         Qio7FtXesZCVSbSyfvU2k+SUX0KTpXDk5KUXJzRARHSu2bYkn/f8XXLDzjPV2vQKAOYw
         u+x9Qs9KWJG2/SFQzFBS977gfJDMXMJcxIiXFUwLYU2447TiJ0W1Xznj7ragZcKP12O6
         K3pJsydLKbxGA3Fu+uwoXoxIGHVvV8CVB/c0ls9qcz/ZXNmdL+IdJbfZRe1O2xqyc4Qo
         qTyfuQ4r6F++Jb5ciiA7Zj7EnT08Pl+VVyZOj23sCIBD7IlbKLK0lcZV4vQhvjZEBJEc
         xaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZ/MVSIyGjzoRpHYl+CmAFkl6jIhxHw2dH0L7FgYzg4=;
        b=NGaSxYSeMiFSIexRcu/AOWPIufkRiapn+Uzb0/U5tqZtyj0+9WQ+SrDsIRCPy745Dr
         7UMfGkoou5Ll+Gq4UpDvC1yL0I11jMUu3+Xw0/JuandMjxDCfHcm3Mu5CsbkgEKtKJ7K
         jE5uQEVzdEhz1WO82REoZydT1Mvjz9tuNK7GGxHc3GYQzNqZotvPmrObgUI5AVhYFHuE
         gzoF3/zAyw3qg0JlUtYp3mdy8DvFzLmn5rw5vVukMvmD8XYnfs4VRlCfmP2oyRG8OHlE
         S9VEmNLbxwDf6pEQoLB/Z4R65XA6lvtF5/82bflWnG8a+FNmjIUomxlpH6zXjv77L9uJ
         u4/A==
X-Gm-Message-State: AOAM530pNixsJHc/Vdzk3Nl+hrJ9EcVnj+5WC5AI6WpiZoQ5CRyUIi5r
        qTVec78U9wUFrlHfC4PeESGNx8Q52pETJQ==
X-Google-Smtp-Source: ABdhPJzIK+7Zqn3Si5a7kcY3/4zYBa3KjUI8w69fhvQIAqGPyngPLGzYSF8qS0IWYeaOblhiI3wkAw==
X-Received: by 2002:a63:7e11:: with SMTP id z17mr15535899pgc.9.1623028130831;
        Sun, 06 Jun 2021 18:08:50 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id v6sm6668247pfi.46.2021.06.06.18.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 18:08:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <ttaylorr@github.com>,
        Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] t: use user-specified utf-8 locale for testing svn
Date:   Mon,  7 Jun 2021 08:08:44 +0700
Message-Id: <20210607010844.24587-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.5.gf3d78db977
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

Junio C. Hamano wrote:

> That certainly is better than "user-specific", but a lot worse than
> "user-specified".  "pre-defined" leaves it open to question "who
> defines it?", and it is a reasonable interpretation that the locale
> may be hardcoded in the makefile, but that is not what this patch
> does.  Saying "user-specified" would not have such a problem.

Ahh, I scanned your comment too fast. Sorry for the noise.

Thanks for the quick turn-around.

Range-diff against v3:
1:  064cfc0fe3 ! 1:  6036f670d9 t: use pre-defined utf-8 locale for testing svn
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    t: use pre-defined utf-8 locale for testing svn
    +    t: use user-specified utf-8 locale for testing svn
     
         In some test-cases, UTF-8 locale is required. To find such locale,
         we're using the first available UTF-8 locale that returned by

 Makefile                                 |  7 +++++++
 ci/lib.sh                                |  1 +
 t/lib-git-svn.sh                         | 24 ++++++++++++++++++------
 t/t9100-git-svn-basic.sh                 | 14 +++-----------
 t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
 t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
 6 files changed, 34 insertions(+), 22 deletions(-)

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
index 547eb3c31a..83efc17661 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -121,12 +121,24 @@ start_svnserve () {
 		 --listen-host 127.0.0.1 &
 }
 
-prepare_a_utf8_locale () {
-	a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
-	p
-	q
-}')
-	if test -n "$a_utf8_locale"
+prepare_utf8_locale () {
+	if test -n "$GIT_TEST_UTF8_LOCALE"
+	then
+		: test_set_prereq UTF8
+	elif test -n "${LC_ALL:-$LANG}"
+	then
+		case "${LC_ALL:-$LANG}" in
+		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
+			GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
+			;;
+		esac
+	else
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
2.32.0.rc3.5.gf3d78db977

