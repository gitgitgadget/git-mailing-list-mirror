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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0708FC4320E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CB461002
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhH1As3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhH1As1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 20:48:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1190C061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so10348508wmd.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4L5UsfibSptli36PytIpsRTnIvEs40sWKfzuSCFDId4=;
        b=ucpxjxjSe1ajOjt8dfoAZK+u/uBnPA4C7YzRyDoxOhlNiSXV+qSnkd0boBFc5MkdUK
         uSjreoivljTOAQ0khOQE3BJDale11jIvH2RKRGKiW0p18/fr7tczZ3hARW74byu5DLfq
         d0f4wxLOUiGjFQYmovLdnPL9N/u4wG8r+Xz9eXYX9pmoSa7CovTlVpKz9UEdg5DRBP1s
         HD4hRQHvs79M8NJ89hHJAn7/PzuoU2TCsZl31f0LJqvmPWIcto/ibgNABeRWHLOVOI/k
         Dzz7NEZFAqWsSUCbEOTwmEY4Hx4DPzpO6s//knawawZXKjN4H9aovpfphYf1D62MILJo
         2LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4L5UsfibSptli36PytIpsRTnIvEs40sWKfzuSCFDId4=;
        b=E0UxOaxY/Z3b8pBIVc8ilTYVHYoQQgJ8mw7l6pDPNeI5/K/DGq9IT3sMg8IUe2SRR9
         N6vjaO9NfhAOCkLfWdENVsUKIxaVhnIoKgmLC4DOC2snTSaFja6Etu41YMLJvbaNHKzt
         XnhE1WNrVCfvpjJPSL7sf+DTu1dxAcM1Ep8lKwl6o5d4g9VAz5kU+WSZS6nVPSDk9kLB
         8Xe/zSPDfwUlcpSvCWAAshvKIzPVod6bHyMHZh9KHksdazgO3toLp0tphXU8ljHBij81
         tOyEa66ib8xi7M4UBsIfwAmOKZ1VodmoETItZ3fAEgkJG3Ma9sxikjArN/YHCd+8Xn1i
         Ic+Q==
X-Gm-Message-State: AOAM533m1MaU3yeyiBzdZE+PWqyGzzNrVi5SPuW6OQynCZ02HxSYMJqc
        kYUzIhpNQ/7J4wUKXjM0W8eIdIIJSJo=
X-Google-Smtp-Source: ABdhPJxOmFZFVhkYyhWzRyGN6AKdSiZ6s+teeA2EQI9BU3PuIaqRKtwvvuOLDcDwJtX982Hg6KwikA==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr11499105wmc.26.1630111656272;
        Fri, 27 Aug 2021 17:47:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm7009227wmd.3.2021.08.27.17.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:47:35 -0700 (PDT)
Message-Id: <1fac9baec1d5b9d42d925c1e6d0005a396c64164.1630111653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
        <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Aug 2021 00:47:33 +0000
Subject: [PATCH v2 3/3] test-lib-functions: optionally keep HOME and TERM in
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
 t/test-lib-functions.sh | 54 ++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1b775343adc..0f6d30e2b3f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -180,25 +180,51 @@ test_pause () {
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
