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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA50C433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CA66103C
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhIFEkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhIFEkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:40:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B1C061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:39:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so7768792wrn.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=nM4aaP8pkz0FH4bfit6iJAJdj/G5Ya05UiNpb3kibMY=;
        b=PJAMLEqsMsCtAlT5vFwRk7VO5HJmEhhgbqS1MQqNixVMI2Rdjg7eUs6BiOipTAzobk
         hqrXm3A3zvLu9SdhU5sJIikb/yZS19dms2b/WplHdDml2l4658eHAdIe1Y9FK+kPcS+t
         0ZB5AEZMRgqIWwybnMMz3Y5ud0ds5d0ga4EQYUd0ectWHD/CrbAfJKqt9gvrKNH0lkHq
         /qbW2p31sWtq+NW4rhU2EQQOGsllzScJ9uqlc90+rU8t1ZxNuHlzP159D5e/mRJWO+4W
         ep6DIDlBwbENhMRkJaeKsvOG8F9ie46q2Lz5uidWF3Z2735kMqQpqirUmKHHV5avL1Py
         hRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=nM4aaP8pkz0FH4bfit6iJAJdj/G5Ya05UiNpb3kibMY=;
        b=uXf/mf3jYkvpwyyRwbgTm23RfUGCcfFKS/sSVJzT/H8kd/6H/8VBscWNJDlnhc0x/U
         lenF6HE8KDrUUU4jR1aO3NfOi+dG7NSxRMlM/l79rCLZjZuN5F1ZUb0cRJJ42zxu/yjn
         brKP7n2pOZZGqrQSHjJxZTCLWVuA5zLObvc7HxFRA4YMWCVo8+9QUiAWuMHYjFqisTjL
         cf2a0TlvymGrjDTnW+Huzq4Y6bGBWYrk7SNeAjDE54M+onRdE39pa7ebH7eavdBE4cM0
         M2kMqJUu9UHVKPNu1skY0P894BRrmpKWZrFghwX2oCZx8Dq03VmHgQ4UYakURYcsPhIA
         /7lw==
X-Gm-Message-State: AOAM532lDxdePSih0EQyJdyDlqWQSn1i6sSDhvW+lXR81owtGaPBi80X
        cqxU/Hja54jKj2K/L9OcsIgU4fkyH0c=
X-Google-Smtp-Source: ABdhPJzszu/o5ZlB/DyZrLd7e1lapyYgJbfcp/AO4M3Iy7N2W7k+di9fBIkDpdjJawaMszlRxbMBGw==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr11152871wru.230.1630903143865;
        Sun, 05 Sep 2021 21:39:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm6578467wrc.31.2021.09.05.21.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:39:03 -0700 (PDT)
Message-Id: <ebf92b6b2c379ed007ec66e97dc4ad7aecb7ad81.1630903140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
References: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
        <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:39:00 +0000
Subject: [PATCH v5 3/3] test-lib-functions: keep user's debugger config files
 and TERM in 'debug'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

The 'debug' function in test-lib-functions.sh is used to invoke a
debugger at a specific line in a test. It inherits the value of HOME and
TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb.

Changing the value of HOME means that any customization configured in a
developers' debugger configuration file (like $HOME/.gdbinit or
$HOME/.lldbinit) are not available in the debugger invoked by
'test_pause'.

Changing the value of TERM to 'dumb' means that colored output
is disabled in the debugger.

To make the debugging experience with 'debug' more pleasant, leverage
the variable USER_HOME, added in the previous commit, to copy a
developer's ~/.gdbinit and ~/.lldbinit to the test HOME. We do not set
HOME to USER_HOME as in 'test_pause' to avoid user configuration in
$USER_HOME/.gitconfig from interfering with the command being debugged.

Also, add a flag to launch the debugger with the original value of
TERM, and add the same warning as for 'test_pause'.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/README                |  6 +++--
 t/test-lib-functions.sh | 60 +++++++++++++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index cc8be6e67ad..e924bd81e2d 100644
--- a/t/README
+++ b/t/README
@@ -800,10 +800,12 @@ see test-lib-functions.sh for the full list and their options.
    argument.  This is primarily meant for use during the
    development of a new test script.
 
- - debug <git-command>
+ - debug [options] <git-command>
 
    Run a git command inside a debugger. This is primarily meant for
-   use when debugging a failing test script.
+   use when debugging a failing test script. With '-t', use your
+   original TERM instead of test-lib.sh's "dumb", so that your
+   debugger interface has colors.
 
  - test_done
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5bed34e47e0..eef2262a360 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -190,25 +190,57 @@ test_pause () {
 # Wrap git with a debugger. Adding this to a command can make it easier
 # to understand what is going on in a failing test.
 #
+# Usage: debug [options] <git command>
+#   -d <debugger>
+#   --debugger=<debugger>
+#	Use <debugger> instead of GDB
+#   -t
+#	Use your original TERM instead of test-lib.sh's "dumb".
+#	This usually restores color output in the debugger.
+#	WARNING: the command being debugged might behave differently than when
+#	running the test.
+#
 # Examples:
 #     debug git checkout master
 #     debug --debugger=nemiver git $ARGS
 #     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
 debug () {
-	case "$1" in
-	-d)
-		GIT_DEBUGGER="$2" &&
-		shift 2
-		;;
-	--debugger=*)
-		GIT_DEBUGGER="${1#*=}" &&
-		shift 1
-		;;
-	*)
-		GIT_DEBUGGER=1
-		;;
-	esac &&
-	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
+	GIT_DEBUGGER=1 &&
+	DEBUG_TERM=$TERM &&
+	while test $# != 0
+	do
+		case "$1" in
+		-t)
+			DEBUG_TERM="$USER_TERM"
+			;;
+		-d)
+			GIT_DEBUGGER="$2" &&
+			shift
+			;;
+		--debugger=*)
+			GIT_DEBUGGER="${1#*=}"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+
+	dotfiles=".gdbinit .lldbinit"
+
+	for dotfile in $dotfiles
+	do
+		dotfile="$USER_HOME/$dotfile" &&
+		test -f "$dotfile" && cp "$dotfile" "$HOME" || :
+	done &&
+
+	TERM="$DEBUG_TERM" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7 &&
+
+	for dotfile in $dotfiles
+	do
+		rm -f "$HOME/$dotfile"
+	done
 }
 
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
-- 
gitgitgadget
