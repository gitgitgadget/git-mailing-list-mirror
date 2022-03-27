Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2D1C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiC0I7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiC0I7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 04:59:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA01409D
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 01:58:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m30so16278473wrb.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=FAJqFv0/tDEnzg2hGZh+OljkZABBw5rGN4Fy9fpqK80=;
        b=TmEAXc0gsZ4YmVUxbYrLnptelCQPumttzv9dRC9+26z84jOGbSIgc6jm5X53jy/fBC
         BypH94ariZ6T6VEIXtSkv48bc47jnQ4OELSr7ngVGZGAaw+YekJ7dt73DI02AjXFU7Lg
         +MSUjCwA+wxdjwq6mIYr1iaIEy/jW8yVkwV3xjPBp+Cwe89H+eleYXcAEJta6BmyH8gb
         vvQqP4eUXvIjpHF01UVo1nL7BjVsu+TXODLzOP5mPPJG4oUhLgcFO/RXoAdpY5w0MkuQ
         b4ct9ApU6Vy0WnC3XjP70xb4zkqCnQ84317qsFPOZA4SGY6Sn/xEMfWjItDJG80HjJmo
         H9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FAJqFv0/tDEnzg2hGZh+OljkZABBw5rGN4Fy9fpqK80=;
        b=NbOxfKwFIy+VxYehb+IIcx/zgHcbeHSlXq39puhXVDmY/024v2CojW6XQGvPGoqoan
         0CvJoq6b5niaRWoS+98c4eHVBctqwLwg70MzsAUt5MSyTmK99wxZbc9Y/yzTcvfaNY3Z
         sFz2IfV4T+dJjF/wJlnFw7+RDouDlnj6PjTqHk7mBqxsZGyW+EPxCYTvGjYD778YMOMI
         PaWYrcPMUkS1qvUn820g+smeCuNa0zWN4Bu5kGbRPYUmTZmeZjIdJcGmHlj8TMsMbpGu
         OgcNFpNLaaOREoCAsRo4FtaxfTE3yVYb+JgEjrAPr0cqNTS+H1Zcxesdd3p05JPxLbaC
         WrPA==
X-Gm-Message-State: AOAM532hSqX621QMs7qNnloss4qkVqnB21wJnXEJ6bEU8XcsJU8RMOEg
        17S3CvkCx97ZVE7K/wrhN/mh+rFPY68=
X-Google-Smtp-Source: ABdhPJxyHUvKKY7y12Mr3cPep7yu3mf4AlLlDvAQg6DZ0gNvjr9mAB2EYiHYxtiIEpAwaEV8Y+Nlcw==
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id e7-20020adffc47000000b00203dda14311mr16750476wrs.301.1648371491277;
        Sun, 27 Mar 2022 01:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm9033406wma.48.2022.03.27.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 01:58:10 -0700 (PDT)
Message-Id: <pull.1189.git.1648371489398.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 27 Mar 2022 08:58:09 +0000
Subject: [PATCH] set LC_TIME even if locale dir is not present
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Since Commit aa1462c (introduce "format" date-mode, 2015-06-25) git log can
pass user specified format strings directly to strftime(). One special
format string we explicitly mention in our documentation is %c, which
depends on the system locale. To accommodate for %c we added a call to
setlocale() in git_setup_gettext().

In Commit cc5e1bf (gettext: avoid initialization if the locale dir is not
present, 2018-04-21) we added an early exit to git_setup_gettext() in case
no textdomain directory is present. This early exit is so early, that we
don't even set the locale for %c in that case, despite strftime() not
needing the textdomain directory at all.

This leads to a subtle bug where `git log --date=format:%c` will use C
locale instead of the system locale on systems without a valid textdomain
directory.

This fixes https://github.com/git-for-windows/git/issues/2959

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
    [RFC] set LC_TIME even if locale dir is not present
    
    This is a small bug fix with a large and unwieldy regression test. The
    whole prepare_time_locale() bit and and the Makefile change is obviously
    based on prepare_utf8_locale(), but I'm not really happy with it. I'm
    not even sure how to fully put the issues I have with the test in words.
    
     * I feel like it's not really testing anything on builds without
       gettext, but adding a GETTEXT prerequisite to a test that something
       works without gettext is very counter intuitive.
    
     * I'm also not exactly happy about how I choose a locale, but can't
       think of a better way. It's a reasonable assumption that C locale
       uses a US date format on most, if not all supported systems, but I
       have no good way to make sure that the selected locale actually
       formats dates differently. Defining a custom locale would solve this,
       but seems like a convoluted way to go about things.
    
     * I'm not entirely happy with testing the output of git log
       -format=date:%c against the output of the exact same command. I've
       tried a version of the test based on date(1) and got it working with
       the GNU version, but looking at the BSD version for our OS X based CI
       builds and the POSIX spec for that command, they share barely more
       than their name.
    
    So, looking at the points above, I expect this to take a few re-rolls to
    get into a reasonable shape.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1189%2Frimrul%2Fdate-format-without-gettext-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1189/rimrul/date-format-without-gettext-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1189

 Makefile                      |  7 +++++++
 gettext.c                     |  3 ++-
 t/t4205-log-pretty-formats.sh | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8aba291d7f..ddca29b550b 100644
--- a/Makefile
+++ b/Makefile
@@ -410,6 +410,10 @@ include shared.mak
 # If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
 # locale returned by "locale -a".
 #
+# Define GIT_TEST_TIME_LOCALE to preferred non-us locale for testing.
+# If it isn't set, fallback to $LC_ALL, $LANG or use the first non-us
+# locale returned by "locale -a".
+#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -2862,6 +2866,9 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 ifdef GIT_TEST_UTF8_LOCALE
 	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
+endif
+ifdef GIT_TEST_TIME_LOCALE
+	@echo GIT_TEST_TIME_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_TIME_LOCALE)))'\' >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
diff --git a/gettext.c b/gettext.c
index bb5ba1fe7cc..2b614c2b8c6 100644
--- a/gettext.c
+++ b/gettext.c
@@ -107,6 +107,8 @@ void git_setup_gettext(void)
 	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
 	char *p = NULL;
 
+	setlocale(LC_TIME, "");
+
 	if (!podir)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
@@ -117,7 +119,6 @@ void git_setup_gettext(void)
 
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
-	setlocale(LC_TIME, "");
 	init_gettext_charset("git");
 	textdomain("git");
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928a..01a1e61ecea 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -25,6 +25,29 @@ commit_msg () {
 	fi
 }
 
+prepare_time_locale () {
+	if test -z "$GIT_TEST_TIME_LOCALE"
+	then
+		case "${LC_ALL:-$LANG}" in
+		C | C.* | POSIX | POSIX.* | en_US | en_US.* )
+			GIT_TEST_TIME_LOCALE=$(locale -a | sed -n '/^\(C\|POSIX\|en_US\)/I !{
+				p
+				q
+			}')
+			;;
+		*)
+			GIT_TEST_TIME_LOCALE="${LC_ALL:-$LANG}"
+			;;
+		esac
+	fi
+	if test -n "$GIT_TEST_TIME_LOCALE"
+	then
+		test_set_prereq TIME_LOCALE
+	else
+		say "# No non-us locale available, some tests are skipped"
+	fi
+}
+
 test_expect_success 'set up basic repos' '
 	>foo &&
 	>bar &&
@@ -544,6 +567,14 @@ test_expect_success '--date=human %ad%cd is the same as %ah%ch' '
 	test_cmp expected actual
 '
 
+prepare_time_locale
+test_expect_success TIME_LOCALE '--date=format:%c does not need gettext' '
+	rm -fr no-such-dir &&
+	LC_ALL=$GIT_TEST_TIME_LOCALE git log --date=format:%c HEAD^1..HEAD >expected &&
+	GIT_TEXTDOMAINDIR=no-such-dir LC_ALL=$GIT_TEST_TIME_LOCALE git log --date=format:%c HEAD^1..HEAD >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&

base-commit: abf474a5dd901f28013c52155411a48fd4c09922
-- 
gitgitgadget
