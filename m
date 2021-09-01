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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDCC4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3578960698
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbhIANcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbhIANco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:32:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6DC061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:31:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d26so4654928wrc.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W+Z2c5THaMjlg+aOfSKnIQYLc7aEofJNYVpoumXofpY=;
        b=Gg/fzGEvHhB9yqBb8NI8Nfcbi3q4WecfROePpmuiNcFmrzPwMKmd5t6lm793LSEvMi
         64Au4qYodqs9bQiVQ22cou09k7krNdLnCltj+GekQLxvYNo6ZL1R0yWBBfEOACkE1f3s
         6pRUNv7KoYZuRk39c31DLhrYhGMG+KAAkYBkitA0DVBqBiXZ7+Q5mnSulP2s3PYNEChh
         4PWZ59PekaDGbarFUpE7awJpKweEnsM50mba9OjyV+LAGIir3keedUE0WfM6Db0DgmST
         Xc6ocwW11vDUCmUQKtJoJzd4u8MT18YZ2V4KLODFKjVwwOQVrcCLgN12c9f2dOp8NukY
         eDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W+Z2c5THaMjlg+aOfSKnIQYLc7aEofJNYVpoumXofpY=;
        b=eJLDcQgJbPIDyni7TjsA0n0lro5bICsA+dfM7BBubfC+7wbhC9l5/vgCFjOhamV7tL
         +wkTSNyOEs/5Cgdrs3WT8NNk2imROJ3wj3G8OOCj1IwP1mchRobem/G4/PPwRH6L7N2Q
         9vFmHr5/UZkTp5DY0QwsML1d9y2beE/ky4NMPw8wYwvL5d/EwmgA9eS1fivxWmMLVDvN
         VSgIOkcO9NUp8fqAH83DIARuPTr21TrIZYgxGfVUM/yaTzXZVBUHAKsttx8SyoJZaVa2
         QpDWSxrbEpfWoxqvQJBlDnFlEoR2pZFP9vEuQ740UMBelnRgay+qa/bVe3/QHGEHY+0U
         1HUA==
X-Gm-Message-State: AOAM5331GNdBuEAOmjkbfQzRVPjaSraxUolRSqwnCSV5lGdTtr1YmruO
        rTj8/tGGuDf+XgB8TK/Fv+Y/J25s7KM=
X-Google-Smtp-Source: ABdhPJyobNmRbixH3f2iiYB2bU4fNHpfIeEWOpihmOJUw0ZxcEc8X3Z/5MG+mEg2oPANseFDrsPRsQ==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr38460877wrz.343.1630503106056;
        Wed, 01 Sep 2021 06:31:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26sm22443545wrc.6.2021.09.01.06.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:31:45 -0700 (PDT)
Message-Id: <4e43bd086b5d7768afd2c35b1bab19120fb87ead.1630503102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:31:42 +0000
Subject: [PATCH v3 3/3] test-lib-functions: optionally keep HOME and TERM in
 'debug'
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
the variables USER_HOME and USER_TERM, added in the previous commit, to
optionally set HOME and TERM before invoking the debugger.

Add the same warnings as for 'test_pause' in the "Usage" section.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 60 +++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4b667dc7e76..537fd88e686 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -187,25 +187,57 @@ test_pause () {
 # Wrap git with a debugger. Adding this to a command can make it easier
 # to understand what is going on in a failing test.
 #
+# Usage: debug [options] [git command]
+#   -d <debugger>
+#   --debugger=<debugger>
+#	Use <debugger> instead of GDB
+#   -t
+#	Use your original TERM instead of test-lib.sh's "dumb".
+#	This usually restores color output in the debugger.
+#	WARNING: this can break test reproducibility.
+#   -h
+#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
+#	This allows your debugger to find its config file in your home.
+#	WARNING: this can break test reproducibility.
+#	CAUTION: this can overwrite files in your HOME.
+#   -a
+#	Shortcut for -t -h
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
+	DEBUG_HOME=$HOME &&
+	while test $# != 0
+	do
+		case "$1" in
+		-t)
+			DEBUG_TERM="$USER_TERM"
+			;;
+		-h)
+			DEBUG_HOME="$USER_HOME"
+			;;
+		-a)
+			DEBUG_TERM="$USER_TERM"
+			DEBUG_HOME="$USER_HOME"
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
+	TERM="$DEBUG_TERM" HOME="$DEBUG_HOME" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
 }
 
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
-- 
gitgitgadget
