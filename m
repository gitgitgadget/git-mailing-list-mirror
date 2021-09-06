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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FAC433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFE260FBF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhIFEV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhIFEVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:21:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5ABC061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:20:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i6so7740578wrv.2
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Vm174qB5w3hwQ39LKmWrmIQHHk+2s7x0hbJOX4B9a5U=;
        b=fdV32n03t9Veq0UsmX6hP8M9l7uglD/uASG5VFYMfzgBXGyTnkV3nYCHMEbaLT265M
         0jLC4QDX0FxMuMhvCSnWTiI6rsFzee5FdtKjBzvkP3bSH/DGpU3vYNDEF7u/y7YWT2vf
         41+ss+nTU4sSou/GjhtFknm9CHJefz4K1sgheYtThCzhhRyOov+nOpTvBLnb0tccwZPu
         V/+Ht03ZgykM7f4YwskILnxb6ze9lzdYChm6gmmRi9BQa9ZZrooBCPWsSCkauaXuUD+I
         eSpnHqcD3MFw51ZkAj+hxTyl9YT2DTDyDIAmD6CHLa32elUF8q9hq1ThJHcxV6iIMOBW
         SuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Vm174qB5w3hwQ39LKmWrmIQHHk+2s7x0hbJOX4B9a5U=;
        b=p/cCh8T+dj8U3Mg891hLUfCrLdtMNTXYThwOCmjcb8+zidWHm+A5wj46iWfqON3vVV
         FEO2XEZRLg2W8acYPT7+oApbM9XAPkzT8krmDi90c1CQ7nbsX7iDfnxWB7xCRKOdRX1C
         53myIgGd6BizEmeILIcSkH2wM89haHSP5lqZ2yncquHMqs0PHcFL6iJnLN2/ABJcs9Po
         a3tL18cnufv20uWfjGaVl7h1CI44VE4FQvXIIUH+VMc2viIe8t5fHLIDJYh44lfS8zAI
         TLvbzzvBmqbh8P0ft4zJmdDuh1zl65Q1G4zPtuU10Wq4v8ZIT2axwxUhC9XClIwaPLdN
         x3qQ==
X-Gm-Message-State: AOAM532BdJKtBLnKy1ole3oQBmjTZPMAcdjrz3zmNZckxOSMB6wP24Lw
        hCzDVRow3ItJpzSQuAWEFfQIL2TY1TE=
X-Google-Smtp-Source: ABdhPJwPfNhqNWfyDglyaj2xhfqqUgS+8zabs15iV/Rypsk+vBpZzE5/gvNMzKwY6aMdfkx5lcoazw==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr10695916wrs.218.1630902009894;
        Sun, 05 Sep 2021 21:20:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm6062666wmi.13.2021.09.05.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:20:09 -0700 (PDT)
Message-Id: <a8b12788fa46f0096b6bcc6731fa9e3bfb3d5bb4.1630902006.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
References: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:20:06 +0000
Subject: [PATCH v4 3/3] test-lib-functions: keep user's debugger config files
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

Note that we use a while loop and a heredoc to protect against
$USER_HOME containing spaces.

Also, add a flag to launch the debugger with the original value of
TERM, and add the same warning as for 'test_pause'.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/README                |  6 ++--
 t/test-lib-functions.sh | 66 ++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 16 deletions(-)

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
index 5bed34e47e0..8cec0e986e1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -190,25 +190,63 @@ test_pause () {
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
+	dotfiles="
+	.gdbinit
+	.lldbinit
+	"
+	while read -r dotfile
+	do
+		dotfile="$USER_HOME/$dotfile" &&
+		test -f "$dotfile" && cp "$dotfile" "$HOME" || :
+	done <<-EOF &&
+	$dotfiles
+	EOF
+
+	TERM="$DEBUG_TERM" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7 &&
+
+	while read -r dotfile
+	do
+		rm -f "$HOME/$dotfile"
+	done <<-EOF
+	$dotfiles
+	EOF
 }
 
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
-- 
gitgitgadget
