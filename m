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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B2C433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CF664E37
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBOPvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBOPqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:46:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C6C061224
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w4so6586748wmi.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toGR4zr9GZcRkSLLYq4McLxBArMZZgzCln2topxgbx4=;
        b=KDq4Tk8avl1GYc9ay6f4YMNwygaw2KRWa3luUcFbh+NJ4FfFp5lYxZuCVvxkeFDur0
         B+4QsNA8IRaQpOQAjXHvJ7yyx646LttgptVCvsgD5iAOB9zqfPMbfJyh/Wk3D5ppz+ma
         Inys/B1fq3pOiix48LXTzRcTceGecHGtD9ovwPr+WoTNKYk0efzpgQHtF/YK0jHKPoGJ
         DlqYN6LBLzgKYTA8FndNaOmbhIkCuuLHMK9n2SlbmNyvcNxdtGrg/6TamXjXoYnwo+5G
         9GR+XjruFOMJ7pUadF4SR+1Rb4P5OkicJj8zot1NJVpepQ4ThWMsHfzwzkDMQkCrqEfe
         +dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toGR4zr9GZcRkSLLYq4McLxBArMZZgzCln2topxgbx4=;
        b=DJlw6LRBdfA/LppjH/X5H61lv5w6fHgWSx0809HK0vrJSGSIL69S5vhBKNKiRk0zyt
         9e+hHzXkg4Szz/GLLzceBOiXUCLP775Cz1yHnlt59w1eOpY6U7rF3cczPCUmjEIJ2eA1
         eUBEUXkUL/UxkpsagTy/0qmW7m90SgxU1FNjKhivjuokX8HNbOjHFfy27P1GZwZza9l+
         EBWWtrXm7vG9T6dZMzmce4v771QWa59QiB9+GYqxO6Z36Vztpy7lcUquX2UpX9NyYr9H
         oPFUmyJu+qvjzDQVbMYXWhU7f602AkEX39Ac60o+/lUliGNKi7QtAFy6nLXOSeQxB3mG
         KlOw==
X-Gm-Message-State: AOAM531ejNAR4O0QOXxF495y2Wl2RUPkihFGAe4XRiZ0arIWBNofFO+Y
        g/eEiSL2pNBPQ/uI/tf044eQcX14qW5sgQ==
X-Google-Smtp-Source: ABdhPJwfiRGAhshmq/NB5z8mPRYqPtScq19EkRCFgygHqCCrfsYZ4EexqxOLT2A+9UI6V9Yn5ZBuDg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr14858806wmp.91.1613403897855;
        Mon, 15 Feb 2021 07:44:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/27] userdiff tests: move custom patterns into one test file
Date:   Mon, 15 Feb 2021 16:44:14 +0100
Message-Id: <20210215154427.32693-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
 t/t4018/custom.sh        | 79 ++++++++++++++++++++++++++++++++++++++++
 t/t4018/custom1.sh       | 27 --------------
 t/t4018/custom2.sh       | 18 ---------
 t/t4018/custom3.sh       | 27 --------------
 5 files changed, 80 insertions(+), 87 deletions(-)
 create mode 100755 t/t4018/custom.sh
 delete mode 100755 t/t4018/custom1.sh
 delete mode 100755 t/t4018/custom2.sh
 delete mode 100755 t/t4018/custom3.sh

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4cb0b7ba2b..d80a2ad4a4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -11,18 +11,6 @@ test_expect_success 'setup' '
 	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
 	test -n "$builtin_drivers" &&
 
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
@@ -30,9 +18,7 @@ test_expect_success 'setup' '
 
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
index 0000000000..59d855c01c
--- /dev/null
+++ b/t/t4018/custom.sh
@@ -0,0 +1,79 @@
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

