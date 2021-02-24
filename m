Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FDC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2789F64F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhBXT4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhBXTx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128AC06121F
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w7so2796004wmb.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYqILTozRcLmffUhghiG81a7ez+XYfWlrKIzGlF6CoU=;
        b=iXDs7kR6F0/TaMk2a2lq6GoEkmRqWWCUrJHZPFt0Ty+aaDtsiGwDDPBIQJ3SSQTyO+
         y/fqPI4FqKjuQ9+KcwrD63atlrUyc6y30RpY2vZdopZIrXCA7X1TV1tO8y4XOkzysHFn
         Bp7An9kOhecUh8KuzehQO4uM8h2QOnuVIRPq6zEEEzyAwcDsL/RMt5fqudvdmE3iqQt7
         xehkJp/mY5dcSmAFhJjkjbNAJHd1UBInOmmkEbMaHSogVJiV37GqudXRnJYrvLQ/jifx
         TLW9qu7VzGBgkG4ljtamZ6jrNcgbGugCJleRJ17EdDCTlZdaDtMNJ4W7Lyl5T6lLNxBk
         +6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYqILTozRcLmffUhghiG81a7ez+XYfWlrKIzGlF6CoU=;
        b=t/3X9SirNBXRjqKyEBV5BRFhjyP5wG3z5MUuAnG9tHFGZB0zmCaWMRfGwtCykMJZY8
         i2pjF6rEXPamJ7gwlV6DVNvv+agarz/jtSSvmPiXuZA0Grsa8vSgAnc3+ShVwBr5a3Eo
         VTNxJ/inedQiVHkE0bNZdJzsihLOzzCNZU2QcXB+nKMkJYa1ve475L89fNsbnlbi/lGb
         a7NnHmy0VJKuB1q+3bpqSuomekKNOBgLeEweXKaAwJQwLaksNFcH53Z3Ky34tHj4N0TV
         UECwlUbdITdws8FPJ1Lel6zK8pQqPptVlxBeOeXXbSYs3Fr0fAVJOSoknAeXqyeAU//j
         wsdA==
X-Gm-Message-State: AOAM53202+g8tWaRBR4RInQg8Y4k6eLsORj4xsVuSYbVosr5tw1dotW7
        nmmsyQkjf4xGH61OwwdjFYNNrQ3fmJ2AXw==
X-Google-Smtp-Source: ABdhPJzLnBAcI3gC/33uAwNBQ0Rjl0dhW+ukTRzteUuzVoXrM89Epjz+nZGHLUxugk5BefNgX7sO+A==
X-Received: by 2002:a05:600c:228c:: with SMTP id 12mr5140671wmf.74.1614196326954;
        Wed, 24 Feb 2021 11:52:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:06 -0800 (PST)
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
Subject: [PATCH v3 17/35] userdiff tests: move custom patterns into one test file
Date:   Wed, 24 Feb 2021 20:51:11 +0100
Message-Id: <20210224195129.4004-18-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
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
index 496313fc900..71a7b474cd4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -15,18 +15,6 @@ test_expect_success 'setup' '
 	sort <builtin-drivers >builtin-drivers.sorted &&
 	test_cmp builtin-drivers.sorted builtin-drivers &&
 
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
@@ -34,9 +22,7 @@ test_expect_success 'setup' '
 
 diffpatterns="
 	$(cat builtin-drivers)
-	custom1
-	custom2
-	custom3
+	custom
 "
 
 for p in $diffpatterns
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
new file mode 100755
index 00000000000..59d855c01c5
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
index f8bbccadb47..00000000000
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
index c68421f788e..00000000000
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
index 07c5c134ffe..00000000000
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

