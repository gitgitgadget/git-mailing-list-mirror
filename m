Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E1C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiHWV0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiHWV0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 17:26:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233089819
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 14:26:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay12so7821378wmb.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=qTUWv6d/aFKMFyYuRhrkgbraZnV5iQcmY3nbJzg5HJk=;
        b=dlPWJSOzog4lwxjdQjXebb9Rkb9mVMfFsHokmleJeJA5aUgTbT1RTEtlInolBnVcWB
         EHM3CvS/TxffhZKgQS/xWQ+r4cZ1bOnvf4WDGByK2bz6GwqETDZcSCVhFR9WkM2U4SOh
         FuF/U8IbEeaaGiWHWL56TgP80Lue6eumxwvWz6w/nXO1dHMWQvWRf4JdD05a7bgUBvS3
         Lj04Z6Eam9OxqntcgDS1KpVFm1VSeTTGsKw2rO84QzDGB90VjN21vDv9kyGrFDrRQinx
         D2dzeiVYgEf1J/AflqQUeHDqif41ScpNDqMTPRowxWYPUkFXsGWfeLd/67+Mln9JN/N/
         bLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=qTUWv6d/aFKMFyYuRhrkgbraZnV5iQcmY3nbJzg5HJk=;
        b=yXibBftr9Ua+gZL/XYvNfQqzVP8iRMfhgmEXKtDRx6nwXJDBx2qDHp3El9hpkqQqKu
         7msCdR3VV0n36/xP3eo4tFuwixWjnXo1AfimpXuQFikdyRt/VFlQQrezHI9ibBI/zoTE
         1Ud39si4RnOsMRPDD64bVltMoO0+z039eQLEGp85vitAno1scKlXYo2g+SeWJ1NIrYRL
         u+TUcsdpGlGh5CJ6f8pSa3ScOy2KomzyhZRgeUIDYsZ1wOZv8XK4uqZRDRpggGaSxTU3
         s31bT8Nps/IUXgoy1yBf1wjJneEXHXrQV0p6pya9xrCN3u0Xoy6Va/3yUrvsq+HKpAQO
         p+ZA==
X-Gm-Message-State: ACgBeo2Drwc+Fq02+kh8mya8URNGUjUhujekYUO8Gfome6vcBAW+LACV
        SlTKhX+2/CiJMyUdQdjdRzze+Rdt35I=
X-Google-Smtp-Source: AA6agR7vGy/FntX4H8iPnSezOO3aLjBhBQXJROFueVsFiQ5P2VB7rcwjxT6vfAEyIepJwSA4JB0SmQ==
X-Received: by 2002:a05:600c:4152:b0:3a6:48c0:509c with SMTP id h18-20020a05600c415200b003a648c0509cmr3379768wmm.24.1661289991734;
        Tue, 23 Aug 2022 14:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d564a000000b00225307f43fbsm14908133wrw.44.2022.08.23.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 14:26:31 -0700 (PDT)
Message-Id: <pull.1313.v2.git.git.1661289990205.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
References: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
From:   "Diomidis Spinellis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 21:26:30 +0000
Subject: [PATCH v2] grep: fix multibyte regex handling under macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Diomidis Spinellis <dds@aueb.gr>,
        Diomidis Spinellis <dds@aueb.gr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Diomidis Spinellis <dds@aueb.gr>

The 2013 commit 29de20504e9 fixed t0070-fundamental.sh under Darwin
(macOS) by adopting Git's regex library.  However, this library is
compiled with NO_MBSUPPORT, which causes git-grep to work incorrectly
on multibyte (e.g. UTF-8) files.  Current macOS versions pass
t0070-fundamental.sh with the native macOS regex library, which
also supports multibyte characters.

Adjust the Makefile to use the native regex library, and call
setlocale(3) to set CTYPE according to the user's preference.  The
setlocale(3) call is required on all platforms, but in platforms
supporting gettext(3), setlocale(3) is called as a side-effect of
initializing gettext(3).

To avoid running the new tests on platforms still using the
compatibility library, which is compiled without multibyte
support, store the corresponding NO_REGEX setting in the
GIT-BUILD-OPTIONS file.  This makes it available to the test
scripts.  In addition, adjust the test-tool regex command to
work with multibyte regexes to further test a platform's
support for them.

Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
---
    grep: fix multibyte regex handling under macOS
    
    The 2013 commit 29de20504e9 fixed t0070-fundamental.sh under Darwin
    (macOS) by adopting Git's regex library. However, this library is
    compiled with NO_MBSUPPORT, which causes git-grep to work incorrectly on
    multibyte (e.g. UTF-8) files. Current macOS versions pass
    t0070-fundamental.sh with the native macOS regex library, which also
    supports multibyte characters.
    
    Adjust the Makefile to use the native regex library, and call
    setlocale(3) to set CTYPE according to the user's preference. The
    setlocale(3) call is required on all platforms, but in platforms
    supporting gettext(3), setlocale(3) is called as a side-effect of
    initializing gettext(3).
    
    To avoid running the new tests on platforms still using the
    compatibility library, which is compiled without multibyte support,
    store the corresponding NO_REGEX setting in the GIT-BUILD-OPTIONS file.
    This makes it available to the test scripts. In addition, adjust the
    test-tool regex command to work with multibyte regexes to further test a
    platform's support for them.
    
    Signed-off-by: Diomidis Spinellis dds@aueb.gr

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1313%2Fdspinellis%2Ffix-macos-mb-grep-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1313/dspinellis/fix-macos-mb-grep-v2
Pull-Request: https://github.com/git/git/pull/1313

Range-diff vs v1:

 1:  d29b93537f4 ! 1:  1d390b493c1 grep: fix multibyte regex handling under macOS
     @@ t/t7818-grep-multibyte.sh (new)
      +. ./test-lib.sh
      +
      +# Multibyte regex search is only supported with a native regex library
     -+# that supports them.
     -+# (The included library is compiled with NO_MBSUPPORT) and only if it
     ++# that supports it.
     ++# (The supplied compatibility library is compiled with NO_MBSUPPORT.)
      +test -z "$NO_REGEX" &&
      +  LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
      +  test_set_prereq MB_REGEX


 Makefile                  |  2 +-
 grep.c                    |  6 +++++-
 t/helper/test-regex.c     |  2 ++
 t/t7818-grep-multibyte.sh | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100755 t/t7818-grep-multibyte.sh

diff --git a/Makefile b/Makefile
index 04d0fd1fe60..d1a98257150 100644
--- a/Makefile
+++ b/Makefile
@@ -1427,7 +1427,6 @@ ifeq ($(uname_S),Darwin)
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
-	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
 
@@ -2970,6 +2969,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
+	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
diff --git a/grep.c b/grep.c
index 82eb7da1022..c31657c3da3 100644
--- a/grep.c
+++ b/grep.c
@@ -10,6 +10,8 @@
 #include "quote.h"
 #include "help.h"
 
+#include <locale.h>
+
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
 				 struct index_state *istate);
@@ -707,8 +709,10 @@ static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y
 void compile_grep_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
-	struct grep_expr *header_expr = prep_header_patterns(opt);
+	struct grep_expr *header_expr;
 
+	setlocale(LC_CTYPE, "");
+	header_expr = prep_header_patterns(opt);
 	for (p = opt->pattern_list; p; p = p->next) {
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index d6f28ca8d14..ae4d7854abd 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "gettext.h"
+#include <locale.h>
 
 struct reg_flag {
 	const char *name;
@@ -85,6 +86,7 @@ int cmd__regex(int argc, const char **argv)
 	}
 	git_setup_gettext();
 
+	setlocale(LC_CTYPE, "");
 	ret = regcomp(&r, pat, flags);
 	if (ret) {
 		if (silent)
diff --git a/t/t7818-grep-multibyte.sh b/t/t7818-grep-multibyte.sh
new file mode 100755
index 00000000000..6cffcb33e26
--- /dev/null
+++ b/t/t7818-grep-multibyte.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='grep multibyte characters'
+
+. ./test-lib.sh
+
+# Multibyte regex search is only supported with a native regex library
+# that supports it.
+# (The supplied compatibility library is compiled with NO_MBSUPPORT.)
+test -z "$NO_REGEX" &&
+  LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
+  test_set_prereq MB_REGEX
+
+if ! test_have_prereq MB_REGEX
+then
+  skip_all='multibyte grep tests; Git compiled with NO_REGEX, NO_MBSUPPORT'
+  test_done
+fi
+
+test_expect_success 'setup' '
+	test_write_lines "¿" >file &&
+	git add file &&
+	LC_ALL="en_US.UTF-8" &&
+	export LC_ALL
+'
+test_expect_success 'grep exactly one char in single-char multibyte file' '
+	git grep "^.$"
+'
+
+test_expect_code 1 'grep two chars in single-char multibyte file' '
+	git grep ".."
+'
+
+test_done

base-commit: ad60dddad72dfb8367bd695028b5b8dc6c33661b
-- 
gitgitgadget
