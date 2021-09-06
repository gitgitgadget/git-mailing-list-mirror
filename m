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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA3AC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0856061039
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhIFEkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhIFEkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:40:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93CC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:39:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so4007540wmi.0
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZghqnjUMTOJqieudxaed7aADlrHH4VJ7f9c2Txe4F3Y=;
        b=FRpU8IpYUMS0j1Cv3Bm8klyQRHfcyblacAK0G6UnAh4KLOI4IZv+CjYucEW69DcJcC
         Py4eya8YaoKpEPiud7jOoQX+ppTVflxiX8BzDWYbOWprbCs8yN5F9Aaiy8p09TkAmXWu
         DSnx0K2nAiFVtCkMihhD40PH515u0Wc0k+VVtzkd2vZV5pQ4i+Lak/abUUWCOYmZyL9F
         TIkTB9ItKurQMLV8miLND2Gaj265FS7NgPYLFoiRykEy8ag//wejh8QCDc/Wz33fDPcK
         rRjd8MbyShSpRgufKR94YqfDpee7fj5+7sZmvAkJm0+B7GbrUeECYfrXf1PQ8/SxW0yN
         JlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZghqnjUMTOJqieudxaed7aADlrHH4VJ7f9c2Txe4F3Y=;
        b=EreCbbWxnDvQoh4ocMofD8vXVJEP4b268gPb7G3cBhosCUJG8aFphiG+X/wJSOQkGf
         ibnHi55peT4l0v/MnMJmnhDQG4PKKMe0PwC95HKs3MueyackcOtp+nEVh7Nxgm78Bfs+
         UPTDFSCMpmu8ZoYPlaPh/BT0H9S+KzYFKLLGhd2pXadxpUBQRcd5zEIFs09ZQ7okY1iD
         SPCtJOnp1bViX6dVlEnV7Gmr8sAjFe82xHB+88XLkAamHBmayVfVZVxiw5h85I2S3GwU
         1n6kRoD539qoMcrRoGLemcpVUIhSlFXgLewYFhckdBCoWVxMnf1ZRHZQXJCdS3oI88D2
         ybLA==
X-Gm-Message-State: AOAM533w2jWWp2ORg2Z2v8OLIP4y5nFdwqCafpFIQEKaVTMbiXUijvJ0
        RcORKzhRx2JN09QIIjL4h5GuEs9teCw=
X-Google-Smtp-Source: ABdhPJwHGemHBLl20gwr77L+fMkv4rtDjJV3ufl+i2LpFSEqrvGqa4CWdaF8v3m8Wp946rsLr5p1Qg==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr9589180wmc.114.1630903143207;
        Sun, 05 Sep 2021 21:39:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm6328041wmb.7.2021.09.05.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:39:02 -0700 (PDT)
Message-Id: <a231d560e68898dfe072a1701376f3f96e3b02b6.1630903140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
References: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
        <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:38:59 +0000
Subject: [PATCH v5 2/3] test-lib-functions: optionally keep HOME, TERM and
 SHELL in 'test_pause'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The 'test_pause' function, which is designed to help interactive
debugging and exploration of tests, currently inherits the value of HOME
and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
also invokes the shell defined by TEST_SHELL_PATH, which defaults to
/bin/sh (through SHELL_PATH).

Changing the value of HOME means that any customization configured in a
developers' shell startup files and any Git aliases defined in their
global Git configuration file are not available in the shell invoked by
'test_pause'.

Changing the value of TERM to 'dumb' means that colored output
is disabled for all commands in that shell.

Using /bin/sh as the shell invoked by 'test_pause' is not ideal since
some platforms (i.e. Debian and derivatives) use Dash as /bin/sh, and
this shell is usually compiled without readline support, which makes for
a poor interactive command line experience.

To make the interactive command line experience in the shell invoked by
'test_pause' more pleasant, save the values of HOME and TERM in
USER_HOME and USER_TERM before changing them in test-lib.sh, and add
options to 'test_pause' to optionally use these variables to invoke the
shell. Also add an option to invoke SHELL instead of TEST_SHELL_PATH, so
that developer's interactive shell is used.

We use options instead of changing the behaviour unconditionally since
these three variables can slightly change command behaviour. Moreover,
using the original HOME means commands could overwrite files in a user's
home directory. Be explicit about these caveats in the new 'Usage'
section in test-lib-functions.sh.

Finally, add '[options]' to the test_pause synopsys in t/README, and
mention that the full list of helper functions and their options can be
found in test-lib-functions.sh.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/README                |  5 +++--
 t/test-lib-functions.sh | 47 ++++++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh           |  6 ++++--
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/t/README b/t/README
index 9e701223020..cc8be6e67ad 100644
--- a/t/README
+++ b/t/README
@@ -753,7 +753,8 @@ Test harness library
 --------------------
 
 There are a handful helper functions defined in the test harness
-library for your script to use.
+library for your script to use. Some of them are listed below;
+see test-lib-functions.sh for the full list and their options.
 
  - test_expect_success [<prereq>] <message> <script>
 
@@ -989,7 +990,7 @@ library for your script to use.
 	EOF
 
 
- - test_pause
+ - test_pause [options]
 
 	This command is useful for writing and debugging tests and must be
 	removed before submitting. It halts the execution of the test and
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1884177e293..5bed34e47e0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -137,9 +137,54 @@ test_tick () {
 # Stop execution and start a shell. This is useful for debugging tests.
 #
 # Be sure to remove all invocations of this command before submitting.
+# WARNING: the shell invoked by this helper does not have the same environment
+# as the one running the tests (shell variables and functions are not
+# available, and the options below further modify the environment). As such,
+# commands copied from a test script might behave differently than when
+# running the test.
+#
+# Usage: test_pause [options]
+#   -t
+#	Use your original TERM instead of test-lib.sh's "dumb".
+#	This usually restores color output in the invoked shell.
+#   -s
+#	Invoke $SHELL instead of $TEST_SHELL_PATH.
+#   -h
+#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
+#	This allows you to use your regular shell environment and Git aliases.
+#	CAUTION: running commands copied from a test script into the paused shell
+#	might result in files in your HOME being overwritten.
+#   -a
+#	Shortcut for -t -s -h
 
 test_pause () {
-	"$TEST_SHELL_PATH" <&6 >&5 2>&7
+	PAUSE_TERM=$TERM &&
+	PAUSE_SHELL=$TEST_SHELL_PATH &&
+	PAUSE_HOME=$HOME &&
+	while test $# != 0
+	do
+		case "$1" in
+		-t)
+			PAUSE_TERM="$USER_TERM"
+			;;
+		-s)
+			PAUSE_SHELL="$SHELL"
+			;;
+		-h)
+			PAUSE_HOME="$USER_HOME"
+			;;
+		-a)
+			PAUSE_TERM="$USER_TERM"
+			PAUSE_SHELL="$SHELL"
+			PAUSE_HOME="$USER_HOME"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+	TERM="$PAUSE_TERM" HOME="$PAUSE_HOME" "$PAUSE_SHELL" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..132618991e2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -585,8 +585,9 @@ else
 	}
 fi
 
+USER_TERM="$TERM"
 TERM=dumb
-export TERM
+export TERM USER_TERM
 
 error () {
 	say_color error "error: $*"
@@ -1380,9 +1381,10 @@ then
 fi
 
 # Last-minute variable setup
+USER_HOME="$HOME"
 HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
-export HOME GNUPGHOME
+export HOME GNUPGHOME USER_HOME
 
 # Test repository
 rm -fr "$TRASH_DIRECTORY" || {
-- 
gitgitgadget

