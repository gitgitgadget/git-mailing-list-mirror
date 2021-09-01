Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92260C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720E660200
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhIANcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbhIANcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:32:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B50C0613D9
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:31:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m2so1933728wmm.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cm8pZ9Fk7ZioC6j3NFEsg2wMeo+xZMkXXYHQC2E0/eA=;
        b=E8UFg4LDaDm6dUkCLSc0aw0vqnHlAKK0HlBKT6sE2mwbjwnqWXrbWh822eYhyvgHiM
         Y33bdow7XmFcj1fz78hw1JgKD7Whszb2uBqBrpVGytwGFreLxXFsMrXcXy4z+/UXI6dE
         gE3khMiSaLEQtuIBC/JnRKWj9ZKBYNdGJ5UHUc9YK5xTsg1X1W7TIjRuQMU1/gKK5jFO
         jFVuBVq2NFdjcmqSijrdVY1kDs2fFdb9/fPdVYov9vUooeYmUUdsWcXQp+/bkNqtG2RP
         jeI+SkwSGUwmv9TQrFGtZPH7bZGLcPGusD8p4uKChkcpk0KER9fa6EVA3nYr/mPyr3XJ
         UEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cm8pZ9Fk7ZioC6j3NFEsg2wMeo+xZMkXXYHQC2E0/eA=;
        b=O6rDupppyMtcAF8ToVzzz1deOrAiNsRAoKwyzJ8g7xQFJRnYN0/6otCJnuf469tY4l
         cQkm8IsAU2ZsE3tDc+LvSNoxgINo0SrsIIrJbHssxonjjT7RRpQ7XhDd7W/JxHNOank7
         kpeE7mJmHJIqq0f5rMKZo2NWzbuUxib2tzni3G7tFH0a263wYHsaLlL2+rkIjVTsvnk5
         BhtPpaEAhi149szgBjl84HKYw+CNuC/64ajJd30/SbL1SUW4FNltwhWn2gnoSxVaZA4c
         UYfSeZD1nh6tK1yC10sxKdhnHW2pHThfiAU9Gb2GM0aWeeRKYDNyaoXbzUDy2BWu4MJ+
         8Yxg==
X-Gm-Message-State: AOAM532vGhrVQtYXHnLytcAyBM6qxLJb06S8iKu4qP4SIgSPCoefpoZv
        BfvpcCsnlG1iZ+27YhDc5lCn4HN6GFk=
X-Google-Smtp-Source: ABdhPJwuWJyIUpWaFUkSmgETpNqPxNM+1fBIjVocJjexGFLsPIF8L9jdKX0aIQb3zPCGXmvVMF6m2Q==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr9929538wmh.32.1630503105378;
        Wed, 01 Sep 2021 06:31:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d24sm5315720wmb.35.2021.09.01.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:31:45 -0700 (PDT)
Message-Id: <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:31:41 +0000
Subject: [PATCH v3 2/3] test-lib-functions: optionally keep HOME, TERM and
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
these three variables can break test reproducibility. Moreover, using the
original HOME means tests could overwrite files in a user's home
directory. Be explicit about these caveats in the new 'Usage' section in
test-lib-functions.sh.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 44 ++++++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh           |  6 ++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1884177e293..4b667dc7e76 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -137,9 +137,51 @@ test_tick () {
 # Stop execution and start a shell. This is useful for debugging tests.
 #
 # Be sure to remove all invocations of this command before submitting.
+#
+# Usage: test_pause [options]
+#   -t
+#	Use your original TERM instead of test-lib.sh's "dumb".
+#	This usually restores color output in the invoked shell.
+#	WARNING: this can break test reproducibility.
+#   -s
+#	Invoke $SHELL instead of $TEST_SHELL_PATH
+#	WARNING: this can break test reproducibility.
+#   -h
+#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
+#	This allows you to use your regular shell environment and Git aliases.
+#	WARNING: this can break test reproducibility.
+#	CAUTION: this can overwrite files in your HOME.
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

