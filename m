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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8334C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBBA60FBF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhIFEVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhIFEVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:21:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7DC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:20:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so7710112wrr.9
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZghqnjUMTOJqieudxaed7aADlrHH4VJ7f9c2Txe4F3Y=;
        b=KH3NkYGGf1I1RnCVNjTOj9bRroenBUa0r3NGNZI76I2BpiuNKNSfgBWxaQKI2ujFpi
         vbTdV5cSwzFi8NhNzOA0ulZr9zzDg/mjsJ08AD0/jJYHceotRUa/17QErUpXXCaS3dLV
         tDAbD06gTktt2gi59rFWw5VfJ8VzYihpDQmthBoJJn53aeqg7o1p4Hol9XwczURHwYEW
         rI/SEDwdvCQpfsdHnTtb+ewcVbozlGPl86XEvxOZHVl7gEFjQQ/NEiwwm8IZGIT/+OsH
         aYwbgESpAcZ2h49U8GFVgSL2YykAlzcZSG1Ol4NIBjOQlvK6IAVWyvtuOuGlMiwbHkeN
         h3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZghqnjUMTOJqieudxaed7aADlrHH4VJ7f9c2Txe4F3Y=;
        b=lsgufDts1Dwzl47wF7xWTQoLserAlJz+L6rD5ikRpmORsJrqDnhOHVWa6OMVJ54INv
         zwjQuIvJm/kCWhbiekpUgtLcLQMOfT1cgVv/7NuYi38jc/mOrWk29arEOEl5iicPw8d1
         Sa1T+YYlr2/DORNXzqRvAZdIOrQBFwT0nE9mgGPE8PYa+DZeMSQrugi/sTu8BCB8MoFS
         6hg6IOBYKv5ihM0fL6WnMNJkSq3WYkkk1sg2z5CZYkYEMTcvaoIy9D2ZR50NHFdj3iTv
         NtPsSet7i+QdItI11EvJ7KOnriePmgUZfxu953i9CKaK7WT9dtXFRTXSD8JACJqfRUuC
         EAPA==
X-Gm-Message-State: AOAM5325ExfVOpcws+OksWe0qE6H/i6M2pZ6/Z1WyjRALqQvP+SbKudp
        LqE/aV3b4RSEFzEPTuqcIl/Ms7FrnZ0=
X-Google-Smtp-Source: ABdhPJwPZnF5jHNLIGAmoup2rmiUvVgWVXIn192BJ/zNu50scNAvNKio/+KTOS1qrCxaEG42hCNrsw==
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr11193102wrn.327.1630902009280;
        Sun, 05 Sep 2021 21:20:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm6670143wrh.97.2021.09.05.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:20:08 -0700 (PDT)
Message-Id: <a231d560e68898dfe072a1701376f3f96e3b02b6.1630902006.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
References: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:20:05 +0000
Subject: [PATCH v4 2/3] test-lib-functions: optionally keep HOME, TERM and
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

