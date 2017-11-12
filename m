Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127DF201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdKLPAy (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:00:54 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:57992
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbdKLPAm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 10:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510498841;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2pufDgKV8d5tcjH8pG/OG1a+gp1n+av9DTI0588Y2RY=;
        b=fOxELIv0XPao75fOOmOu9RUcq7woVAaP1ZgpVcX8NRMfiYRReo78ct0m75rggO6c
        AcBolLdJC0OTzNmlCPCAOFN713aTOEorW6obhXTd8OpZntI2p+yamUZIYTD2dPCyg9w
        yLsAmg6aR6sgJC1zYDfzY5BIf0pZBJl5pPQp3idg=
From:   Soukaina NAIT HMID <nhsoukaina@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fb0bf30cb-b3c720d6-c508-4771-a0f1-8c4b2e84f20f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Subject: [add-default-config 3/5] add same test for new command format with
 --default and --color
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 15:00:40 +0000
X-SES-Outgoing: 2017.11.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>
---
 t/t4026-color2.sh | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100755 t/t4026-color2.sh

diff --git a/t/t4026-color2.sh b/t/t4026-color2.sh
new file mode 100755
index 0000000000000..695ce9dd6f8d4
--- /dev/null
+++ b/t/t4026-color2.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Timo Hirvonen
+#
+
+test_description='Test diff/status color escape codes'
+. ./test-lib.sh
+
+ESC=$(printf '\033')
+color()
+{
+	actual=$(git config --default "$1" --color no.such.slot) &&
+	test "$actual" = "${2:+$ESC}$2"
+}
+
+invalid_color()
+{
+	test_must_fail git config --get-color no.such.slot "$1"
+}
+
+test_expect_success 'reset' '
+	color "reset" "[m"
+'
+
+test_expect_success 'empty color is empty' '
+	color "" ""
+'
+
+test_expect_success 'attribute before color name' '
+	color "bold red" "[1;31m"
+'
+
+test_expect_success 'color name before attribute' '
+	color "red bold" "[1;31m"
+'
+
+test_expect_success 'attr fg bg' '
+	color "ul blue red" "[4;34;41m"
+'
+
+test_expect_success 'fg attr bg' '
+	color "blue ul red" "[4;34;41m"
+'
+
+test_expect_success 'fg bg attr' '
+	color "blue red ul" "[4;34;41m"
+'
+
+test_expect_success 'fg bg attr...' '
+	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
+'
+
+# note that nobold and nodim are the same code (22)
+test_expect_success 'attr negation' '
+	color "nobold nodim noul noblink noreverse" "[22;24;25;27m"
+'
+
+test_expect_success '"no-" variant of negation' '
+	color "no-bold no-blink" "[22;25m"
+'
+
+test_expect_success 'long color specification' '
+	color "254 255 bold dim ul blink reverse" "[1;2;4;5;7;38;5;254;48;5;255m"
+'
+
+test_expect_success 'absurdly long color specification' '
+	color \
+	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
+	   ul noul blink noblink reverse noreverse strike nostrike" \
+	  "[1;2;3;4;5;7;9;22;23;24;25;27;29;38;2;255;255;255;48;2;255;255;255m"
+'
+
+test_expect_success '0-7 are aliases for basic ANSI color names' '
+	color "0 7" "[30;47m"
+'
+
+test_expect_success '256 colors' '
+	color "254 bold 255" "[1;38;5;254;48;5;255m"
+'
+
+test_expect_success '24-bit colors' '
+	color "#ff00ff black" "[38;2;255;0;255;40m"
+'
+
+test_expect_success '"normal" yields no color at all"' '
+	color "normal black" "[40m"
+'
+
+test_expect_success '-1 is a synonym for "normal"' '
+	color "-1 black" "[40m"
+'
+
+test_expect_success 'color too small' '
+	invalid_color "-2"
+'
+
+test_expect_success 'color too big' '
+	invalid_color "256"
+'
+
+test_expect_success 'extra character after color number' '
+	invalid_color "3X"
+'
+
+test_expect_success 'extra character after color name' '
+	invalid_color "redX"
+'
+
+test_expect_success 'extra character after attribute' '
+	invalid_color "dimX"
+'
+
+test_expect_success 'unknown color slots are ignored (diff)' '
+	git config color.diff.nosuchslotwilleverbedefined white &&
+	git diff --color
+'
+
+test_expect_success 'unknown color slots are ignored (branch)' '
+	git config color.branch.nosuchslotwilleverbedefined white &&
+	git branch -a
+'
+
+test_expect_success 'unknown color slots are ignored (status)' '
+	git config color.status.nosuchslotwilleverbedefined white &&
+	{ git status; ret=$?; } &&
+	case $ret in 0|1) : ok ;; *) false ;; esac
+'
+
+test_done

--
https://github.com/git/git/pull/431
