Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E3FC43381
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58F564E56
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBOAyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBOAyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B22C061794
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o24so6468262wmh.5
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gGyw14kAn5AhLjMedvcCwIj8w/YHAPFKx+O/PMlpL4=;
        b=lPnTgj2HE2jlaD5R/NhEfkiooYnFRzBaCfL9LlVDRWPjeMrrhrgaJLmuNY8HUU86xm
         hZdFSCi/P2nRUoEYDe6CbkdeLMQHNYLdhYcsG7ynafbrz3rGZgXYCxTR4kH234sWxr7I
         3qR77QZoaYTlwRqoLlIAfkdU7aJl+kg9lwQpKE1W6rNByN49FI3w1K+A1TuHK7FgwXLV
         RHaW1jX1CzszmFCjzuE6d1asC9+Fhnj+F88EfM5iy6f+HdwVMV009r5BkOyj06GS0Lte
         IBXmxdKN1zx+xR4ZcjbL7PynPaHeqBOex9y6d4RyFVl9lAYiOOHQ9OQgAtY5+RexHGZa
         8W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gGyw14kAn5AhLjMedvcCwIj8w/YHAPFKx+O/PMlpL4=;
        b=t5mgEFtoMcDJoYQDFCE6HXT+mElL2078tBqu5lxAfmRNbJIPw2YlVU6+zxE9AyWKNQ
         Rwod9TwBT7XLJUMO0lk8wYGzK74SAYGskZWfaFBMjfyAV8UIquNs73QJ8FJLx++/Yt1h
         gAPoRcdJVaSW3vQRTlLciBgCKeEq80Gromm00xvuyhjqf6qQJPOC5Y5dX2ginG/0GSEs
         8ZIAqZLB1NMDhmcbaTjCBmwLRxQGJar983cXPd7gxPk/yyOiyU6tHjwOdjjthyfz484f
         cVU3yTI/4FlBXzMHl5yusxTmRUWx57aUE1c32FPEijZOYzR3siX1c8CalCq9d0prEavo
         XbwQ==
X-Gm-Message-State: AOAM530ehhlglng7m3kL346Wv8tLQJ2soyEO35O0kZPbETuC0FgJMnUI
        bybsIZEZbmqwASYWIZ8uCvjxCVtDJ9090g==
X-Google-Smtp-Source: ABdhPJz6MVF/hKdpPgyCbNAQLXwhBUjA41dB9BqC2Q7FtywQdqgCOggb7nAzzh0vwge5TGHm3evzsQ==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr11871177wmc.3.1613350387213;
        Sun, 14 Feb 2021 16:53:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/20] userdiff tests: move custom patterns into one test file
Date:   Mon, 15 Feb 2021 01:52:26 +0100
Message-Id: <20210215005236.11313-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit the test infrastructure got rewritten so
"t/t4018/" are now normal test files which can do things like set
config, so let's make it responsible for setting up and tearing down
the config for its tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 16 +-------
 t/t4018/custom.sh        | 84 ++++++++++++++++++++++++++++++++++++++++
 t/t4018/custom1.sh       | 27 -------------
 t/t4018/custom2.sh       | 18 ---------
 t/t4018/custom3.sh       | 27 -------------
 5 files changed, 85 insertions(+), 87 deletions(-)
 create mode 100755 t/t4018/custom.sh
 delete mode 100755 t/t4018/custom1.sh
 delete mode 100755 t/t4018/custom2.sh
 delete mode 100755 t/t4018/custom3.sh

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 3ff34c13d7..3e4c07e42b 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -12,18 +12,6 @@ test_expect_success 'setup' '
 	test_file_not_empty builtin-drivers &&
 	builtin_drivers=$(cat builtin-drivers) &&
 
-	# a non-trivial custom pattern
-	git config diff.custom1.funcname "!static
-!String
-[^ 	].*s.*" &&
-
-	# a custom pattern which matches to end of line
-	git config diff.custom2.funcname "......Beer\$" &&
-
-	# alternation in pattern
-	git config diff.custom3.funcname "Beer$" &&
-	git config diff.custom3.xfuncname "^[ 	]*((public|static).*)$" &&
-
 	# for regexp compilation tests
 	echo A >A.java &&
 	echo B >B.java
@@ -31,9 +19,7 @@ test_expect_success 'setup' '
 
 diffpatterns="
 	$builtin_drivers
-	custom1
-	custom2
-	custom3
+	custom
 "
 
 for p in $diffpatterns
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
new file mode 100755
index 0000000000..69f1f7339f
--- /dev/null
+++ b/t/t4018/custom.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_expect_success 'custom: setup non-trivial custom' '
+	git config diff.custom.funcname "!static
+!String
+[^ 	].*s.*"
+'
+
+test_diff_funcname 'custom: non-trivial custom pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+int special, RIGHT;
+EOF_HUNK
+public class Beer
+{
+	int special, RIGHT;
+	public static void main(String args[])
+	{
+		String s=" ";
+		for(int x = 99; x > 0; x--)
+		{
+			System.out.print(x + " bottles of beer on the wall "
+				+ x + " bottles of beer\n" // ChangeMe
+				+ "Take one down, pass it around, " + (x - 1)
+				+ " bottles of beer on the wall.\n");
+		}
+		System.out.print("Go to the store, buy some more,\n"
+			+ "99 bottles of beer on the wall.\n");
+	}
+}
+EOF_TEST
+
+test_expect_success 'custom: setup match to end of line' '
+	git config diff.custom.funcname "......Beer\$"
+'
+
+test_diff_funcname 'custom: match to end of line' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT_Beer
+EOF_HUNK
+public class RIGHT_Beer
+{
+	int special;
+	public static void main(String args[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
+EOF_TEST
+
+test_expect_success 'custom: setup alternation in pattern' '
+	git config diff.custom.funcname "Beer$" &&
+	git config diff.custom.xfuncname "^[ 	]*((public|static).*)$"
+'
+
+test_diff_funcname 'custom: alternation in pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+public static void main(String RIGHT[])
+EOF_HUNK
+public class Beer
+{
+	int special;
+	public static void main(String RIGHT[])
+	{
+		String s=" ";
+		for(int x = 99; x > 0; x--)
+		{
+			System.out.print(x + " bottles of beer on the wall "
+				+ x + " bottles of beer\n" // ChangeMe
+				+ "Take one down, pass it around, " + (x - 1)
+				+ " bottles of beer on the wall.\n");
+		}
+		System.out.print("Go to the store, buy some more,\n"
+			+ "99 bottles of beer on the wall.\n");
+	}
+}
+EOF_TEST
+
+test_expect_success 'custom: teardown' '
+	test_unconfig diff.custom.funcname &&
+	test_unconfig diff.custom.xfuncname
+'
diff --git a/t/t4018/custom1.sh b/t/t4018/custom1.sh
deleted file mode 100755
index f8bbccadb4..0000000000
--- a/t/t4018/custom1.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# See ../t4018-diff-funcname.sh's test_diff_funcname()
-#
-
-test_diff_funcname 'custom1: pattern' \
-	8<<\EOF_HUNK 9<<\EOF_TEST
-int special, RIGHT;
-EOF_HUNK
-public class Beer
-{
-	int special, RIGHT;
-	public static void main(String args[])
-	{
-		String s=" ";
-		for(int x = 99; x > 0; x--)
-		{
-			System.out.print(x + " bottles of beer on the wall "
-				+ x + " bottles of beer\n" // ChangeMe
-				+ "Take one down, pass it around, " + (x - 1)
-				+ " bottles of beer on the wall.\n");
-		}
-		System.out.print("Go to the store, buy some more,\n"
-			+ "99 bottles of beer on the wall.\n");
-	}
-}
-EOF_TEST
diff --git a/t/t4018/custom2.sh b/t/t4018/custom2.sh
deleted file mode 100755
index c68421f788..0000000000
--- a/t/t4018/custom2.sh
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-#
-# See ../t4018-diff-funcname.sh's test_diff_funcname()
-#
-
-test_diff_funcname 'custom2: match to end of line' \
-	8<<\EOF_HUNK 9<<\EOF_TEST
-RIGHT_Beer
-EOF_HUNK
-public class RIGHT_Beer
-{
-	int special;
-	public static void main(String args[])
-	{
-		System.out.print("ChangeMe");
-	}
-}
-EOF_TEST
diff --git a/t/t4018/custom3.sh b/t/t4018/custom3.sh
deleted file mode 100755
index 07c5c134ff..0000000000
--- a/t/t4018/custom3.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# See ../t4018-diff-funcname.sh's test_diff_funcname()
-#
-
-test_diff_funcname 'custom3: alternation in pattern' \
-	8<<\EOF_HUNK 9<<\EOF_TEST
-public static void main(String RIGHT[])
-EOF_HUNK
-public class Beer
-{
-	int special;
-	public static void main(String RIGHT[])
-	{
-		String s=" ";
-		for(int x = 99; x > 0; x--)
-		{
-			System.out.print(x + " bottles of beer on the wall "
-				+ x + " bottles of beer\n" // ChangeMe
-				+ "Take one down, pass it around, " + (x - 1)
-				+ " bottles of beer on the wall.\n");
-		}
-		System.out.print("Go to the store, buy some more,\n"
-			+ "99 bottles of beer on the wall.\n");
-	}
-}
-EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

