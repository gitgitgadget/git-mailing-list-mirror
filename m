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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A17C43381
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B818225AB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbhAKOsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbhAKOsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A6C0617A2
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d26so16661544wrb.12
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mtKDAMTwfYdmN26GVSXZHxCuFdYM8FP0h0Q92Ywb7w=;
        b=W0IwI3+0bBkW55Bvdp3t6mo+eOBUSE3FV6PYHA32Z0vrMdf69CYPL9X8N1djImcR/F
         j6hHwwd+WRpSe39erWYENBC8Lsuf5x6ZtLbQxi/ETCP3FOb1taLAZv7fzJ986OQnZYEk
         42H7Si8khrz+AOASB581ESsO9nKuKyl5igtaHTKHUsqUZ8zNsrNSx9uP242wd310RLgr
         6dwLeSFKsa3yOuzZELuIItlUdbdho2xrHXzHvq6ORup1W75QzDuZ96X7VwxslWJrV742
         QzackwSVezXBvDc98A74Iys30Z6LL6/2itMyBko98T+LDATNh/aWEZ93trbSQmYGNS8T
         cONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mtKDAMTwfYdmN26GVSXZHxCuFdYM8FP0h0Q92Ywb7w=;
        b=fw2a3b/0xITv40IBlZnmCr2tSmzX3UMwW3uGNjSOG50luTpG9XlvH4/VeZB6t+G+EM
         KwmVPOpp67f4YK2s+QOS0JiHMVte9MIQxcD8s7WBVqnNpJTJDltfdKmaKe4kzmeALzU3
         58ie2h+cg7V1gQqmLPyWKANuHpWzgwsmPz2XtldpbJRCC0Rgdtxg8N7eBRuMT6YwMIzf
         jvp1H50z1RL7lpuzHh5Mc2Q1d9wonSVOhP7cJSz8vVZtV/lbvZHbjeKQfqHyDqVgdFMh
         Yti5UGcNpH7vMkRi3ijC750bwFCI2I1sRdsS1l6ab2PDO+5WXx0P/XkLSkqLQI8e9Gyd
         m+Cg==
X-Gm-Message-State: AOAM530mxA9ImzUumNvs0G/XyEz+6iGEwYptvYFybBp5DQUHoijELx1B
        FwBhvF14k89EiQSN5eKowwJoEN5dEYJ9hw==
X-Google-Smtp-Source: ABdhPJzS+d7Ye1Drb9xlYHM61jDADvjAciM2SqNE7vbBXSG7B26DWGvedS/wXfYSo5vn5oL20xWHFQ==
X-Received: by 2002:adf:aad3:: with SMTP id i19mr16434109wrc.119.1610376468388;
        Mon, 11 Jan 2021 06:47:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] tests: remove support for GIT_TEST_GETTEXT_POISON
Date:   Mon, 11 Jan 2021 15:47:36 +0100
Message-Id: <20210111144740.6092-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the ability to inject "poison" gettext() messages via the
GIT_TEST_GETTEXT_POISON special test setup.

I initially added this as a compile-time option in bb946bba761 (i18n:
add GETTEXT_POISON to simulate unfriendly translator, 2011-02-22), and
most recently modified to be toggleable at runtime in
6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option, 2018-11-08)..

The reason for its removal is that the trade-off of maintaining it
v.s. what it's getting us has long since flipped. When gettext was
integrated in 5e9637c6297 (i18n: add infrastructure for translating
Git with gettext, 2011-11-18) there was understandable concern on the
Git ML that in marking messages for translation en-masse we'd
inadvertently mark plumbing messages. The GETTEXT_POISON facility was
a way to smoke those out via our test suite.

Nowadays however we're done (or almost entirely done) with any marking
of messages for translation. New messages are usually marked by their
authors, who'll know whether it makes sense to translate them or
not. If not any errors in marking the messages are much more likely to
be spotted in review than in the the initial deluge of i18n patches in
the 2011-2012 era.

So let's just remove this. This leaves the test suite in a state where
we still have a lot of test_i18n, C_LOCALE_OUTPUT
etc. uses. Subsequent commits will remove those too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/MyFirstContribution.txt |  2 +-
 config.c                              |  9 -------
 gettext.c                             | 10 -------
 gettext.h                             |  7 +----
 git-sh-i18n.sh                        | 22 +--------------
 po/README                             | 34 ++++++++++++-----------
 t/README                              |  6 -----
 t/lib-gettext.sh                      |  2 +-
 t/t0017-env-helper.sh                 |  8 +++---
 t/t0205-gettext-poison.sh             | 39 ---------------------------
 t/test-lib-functions.sh               | 23 +++++-----------
 t/test-lib.sh                         | 23 +++-------------
 12 files changed, 38 insertions(+), 147 deletions(-)
 delete mode 100755 t/t0205-gettext-poison.sh

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 7c9a037cc2..af0a9da62e 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -664,7 +664,7 @@ mention the right animal somewhere:
 ----
 test_expect_success 'runs correctly with no args and good output' '
 	git psuh >actual &&
-	test_i18ngrep Pony actual
+	grep Pony actual
 '
 ----
 
diff --git a/config.c b/config.c
index 1137bd73af..a8dec9a247 100644
--- a/config.c
+++ b/config.c
@@ -996,15 +996,6 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
-		/*
-		 * We explicitly *don't* use _() here since it would
-		 * cause an infinite loop with _() needing to call
-		 * use_gettext_poison(). This is why marked up
-		 * translations with N_() above.
-		 */
-		die(bad_numeric, value, name, error_type);
-
 	if (!(cf && cf->name))
 		die(_(bad_numeric), value, name, _(error_type));
 
diff --git a/gettext.c b/gettext.c
index 35d2c1218d..308c4b3129 100644
--- a/gettext.c
+++ b/gettext.c
@@ -65,14 +65,6 @@ const char *get_preferred_languages(void)
 	return NULL;
 }
 
-int use_gettext_poison(void)
-{
-	static int poison_requested = -1;
-	if (poison_requested == -1)
-		poison_requested = git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
-	return poison_requested;
-}
-
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
 {
@@ -181,8 +173,6 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
-	use_gettext_poison(); /* getenv() reentrancy paranoia */
-
 	if (!is_directory(podir)) {
 		free(p);
 		return;
diff --git a/gettext.h b/gettext.h
index bee52eb113..c8b34fd612 100644
--- a/gettext.h
+++ b/gettext.h
@@ -28,15 +28,12 @@
 
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
-int use_gettext_poison(void);
-
 #ifndef NO_GETTEXT
 void git_setup_gettext(void);
 int gettext_width(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
-	use_gettext_poison(); /* getenv() reentrancy paranoia */
 }
 static inline int gettext_width(const char *s)
 {
@@ -48,14 +45,12 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
 		return "";
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	return gettext(msgid);
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
-	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
 	return ngettext(msgid, plu, n);
 }
 
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 8eef60b43f..e3d9f4836d 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,12 +17,7 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_TEST_GETTEXT_POISON" &&
-	    git env--helper --type=bool --default=0 --exit-code \
-		GIT_TEST_GETTEXT_POISON
-then
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
-elif test -n "@@USE_GETTEXT_SCHEME@@"
+if test -n "@@USE_GETTEXT_SCHEME@@"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
 elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
@@ -63,21 +58,6 @@ gettext_without_eval_gettext)
 		)
 	}
 	;;
-poison)
-	# Emit garbage so that tests that incorrectly rely on translatable
-	# strings will fail.
-	gettext () {
-		printf "%s" "# GETTEXT POISON #"
-	}
-
-	eval_gettext () {
-		printf "%s" "# GETTEXT POISON #"
-	}
-
-	eval_ngettext () {
-		printf "%s" "# GETTEXT POISON #"
-	}
-	;;
 *)
 	gettext () {
 		printf "%s" "$1"
diff --git a/po/README b/po/README
index 07595d369b..b9b6c9cb24 100644
--- a/po/README
+++ b/po/README
@@ -284,23 +284,27 @@ Perl:
 Testing marked strings
 ----------------------
 
-Even if you've correctly marked porcelain strings for translation
-something in the test suite might still depend on the US English
-version of the strings, e.g. to grep some error message or other
-output.
+Git's tests are run under LANG=C LC_ALL=C. So the tests do not need be
+changed to account for translations as they're added.
 
-To smoke out issues like these, Git tested with a translation mode that
-emits gibberish on every call to gettext. To use it run the test suite
-with it, e.g.:
+Testing whether marked strings are used by plumbing
+---------------------------------------------------
 
-    cd t && GIT_TEST_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh
+It may be useful to use the test suite to smoke out any strings that
+shouldn't be translated, because they are used by plumbing or
+otherwise part of machine-readable output.
 
-If tests break with it you should inspect them manually and see if
-what you're translating is sane, i.e. that you're not translating
+This is most useful in cases where e.g. library function might return
+a string like _("tree"), and the developer marking strings for
+translation wishes to check that they're not inadvertently translating
 plumbing output.
 
-If not you should replace calls to grep with test_i18ngrep, or
-test_cmp calls with test_i18ncmp. If that's not enough you can skip
-the whole test by making it depend on the C_LOCALE_OUTPUT
-prerequisite. See existing test files with this prerequisite for
-examples.
+There used to be a GIT_TEST_GETTEXT_POISON=true test mode to replace
+translated strings with gibberish to facilitate this. Maintaining it
+and annotating tests appropriately was considered too high of a burden
+for its usefulness.
+
+It's still possible to do a one-off test of where a string might be
+used in the tests by simply replacing the "some hardcoded string" with
+something like "POISON ME" locally and running the tests, before
+finally converting it to _("some hardcoded string").
diff --git a/t/README b/t/README
index c730a70770..9a9dded033 100644
--- a/t/README
+++ b/t/README
@@ -358,12 +358,6 @@ whether this mode is active, and e.g. skip some tests that are hard to
 refactor to deal with it. The "SYMLINKS" prerequisite is currently
 excluded as so much relies on it, but this might change in the future.
 
-GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
-translation into gibberish if true. Used for spotting those tests that
-need to be marked with a C_LOCALE_OUTPUT prerequisite when adding more
-strings for translation. See "Testing marked strings" in po/README for
-details.
-
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 2139b427ca..cc6bb2cdea 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -17,7 +17,7 @@ else
 	. "$GIT_BUILD_DIR"/git-sh-i18n
 fi
 
-if test_have_prereq GETTEXT && test_have_prereq C_LOCALE_OUTPUT
+if test_have_prereq GETTEXT
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
 	is_IS_locale=$(locale -a 2>/dev/null |
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index c1ecf6aeac..4a159f99e4 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -86,14 +86,14 @@ test_expect_success 'env--helper reads config thanks to trace2' '
 	git config -f home/cycle include.path .gitconfig &&
 
 	test_must_fail \
-		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=false \
+		env HOME="$(pwd)/home" \
 		git config -l 2>err &&
 	grep "exceeded maximum include depth" err &&
 
 	test_must_fail \
-		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=true \
-		git -C cycle env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON 2>err &&
-	grep "# GETTEXT POISON #" err
+		env HOME="$(pwd)/home" GIT_TEST_ENV_HELPER=true \
+		git -C cycle env--helper --type=bool --default=0 --exit-code GIT_TEST_ENV_HELPER 2>err &&
+	grep "exceeded maximum include depth" err
 '
 
 test_done
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
deleted file mode 100755
index f9fa16ad83..0000000000
--- a/t/t0205-gettext-poison.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 Ævar Arnfjörð Bjarmason
-#
-
-test_description='Gettext Shell poison'
-
-GIT_TEST_GETTEXT_POISON=true
-export GIT_TEST_GETTEXT_POISON
-. ./lib-gettext.sh
-
-test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
-    test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
-'
-
-test_expect_success 'gettext: our gettext() fallback has poison semantics' '
-    printf "# GETTEXT POISON #" >expect &&
-    gettext "test" >actual &&
-    test_cmp expect actual &&
-    printf "# GETTEXT POISON #" >expect &&
-    gettext "test more words" >actual &&
-    test_cmp expect actual
-'
-
-test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semantics' '
-    printf "# GETTEXT POISON #" >expect &&
-    eval_gettext "test" >actual &&
-    test_cmp expect actual &&
-    printf "# GETTEXT POISON #" >expect &&
-    eval_gettext "test more words" >actual &&
-    test_cmp expect actual
-'
-
-test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
-	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
-	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
-"
-
-test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a..c7b1d857c4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -988,19 +988,16 @@ test_cmp_bin () {
 	cmp "$@"
 }
 
-# Use this instead of test_cmp to compare files that contain expected and
-# actual output from git commands that can be translated.  When running
-# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
-# results.
+# Wrapper for test_cmp which used to be used for
+# GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
+# in-flight changes. Should not be used and will be removed soon.
 test_i18ncmp () {
-	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
+	test_cmp "$@"
 }
 
-# Use this instead of "grep expected-string actual" to see if the
-# output from a git command that can be translated either contains an
-# expected string, or does not contain an unwanted one.  When running
-# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
-# results.
+# Wrapper for grep which used to be used for
+# GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
+# in-flight changes. Should not be used and will be removed soon.
 test_i18ngrep () {
 	eval "last_arg=\${$#}"
 
@@ -1013,12 +1010,6 @@ test_i18ngrep () {
 		BUG "too few parameters to test_i18ngrep"
 	fi
 
-	if test_have_prereq !C_LOCALE_OUTPUT
-	then
-		# pretend success
-		return 0
-	fi
-
 	if test "x!" = "x$1"
 	then
 		shift
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9fa7c1d0f6..c1ff5db2c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -404,15 +404,6 @@ TZ=UTC
 export LANG LC_ALL PAGER TZ
 EDITOR=:
 
-# GIT_TEST_GETTEXT_POISON should not influence git commands executed
-# during initialization of test-lib and the test repo. Back it up,
-# unset and then restore after initialization is finished.
-if test -n "$GIT_TEST_GETTEXT_POISON"
-then
-	GIT_TEST_GETTEXT_POISON_ORIG=$GIT_TEST_GETTEXT_POISON
-	unset GIT_TEST_GETTEXT_POISON
-fi
-
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
@@ -1529,16 +1520,10 @@ test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
-then
-	GIT_TEST_GETTEXT_POISON=$GIT_TEST_GETTEXT_POISON_ORIG
-	export GIT_TEST_GETTEXT_POISON
-	unset GIT_TEST_GETTEXT_POISON_ORIG
-fi
-
-test_lazy_prereq C_LOCALE_OUTPUT '
-	! test_bool_env GIT_TEST_GETTEXT_POISON false
-'
+# Used to be used for GIT_TEST_GETTEXT_POISON=false. Only here as a
+# shim for other in-flight changes. Should not be used and will be
+# removed soon.
+test_set_prereq C_LOCALE_OUTPUT
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.29.2.222.g5d2a92d10f8

