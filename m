Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD552C33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7DE207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfO+g62x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgAGExd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36659 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgAGExc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so41965521qkc.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BH/BhIcjwj3b4Zj09JzrLz89x8UD3qVZ5zGxOg67Xw=;
        b=FfO+g62xJqcLxCMbjA9zJvLCNDaNCFUT0Cb/FDxyY3AekI4RSTqlMEy8v14IOj1f/m
         J4jIyHrAUiTxbHexJchaP8jNd50fym4jb+N5BZRZ4ADtts68vzNOewMrtFL3/baZPPo8
         +0P54xpd2tJ1PFW5KcOw5hosHzqaLh5D85bBjpnBCGUd+VjqHs8dgCEJrDn9a/PyDyFD
         LsMU4H9DoNZZeUnP7Mj9RHt5SylqdnjhD9wDx038wtXFj3py778rZ84zUPXfxmMySARL
         33E2fkwOlK4wzCPIciSCI/qLlhz7rS6mof08tW+gNIzxmpIheQCBDyZn+JETQoPvcAI9
         JsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BH/BhIcjwj3b4Zj09JzrLz89x8UD3qVZ5zGxOg67Xw=;
        b=R4Bv5zDsrFMnR8A1KxrApfX9DUZSzBFuZgjfoqoNLAqpmW7ZkXRtpn/YcxbxIrwDXv
         S6elb7cmA4EYfI3wJiffDLE9tvNJSZ4SDxd+sKI4OxNtt9CTeNM4nNIlFo9nuZytRfXE
         KaN2Pbxng54fQ0eH0IbPfBDxaHNAhw9qF2UovzsLveOxf0W1j9icbeT69FgV0HY1+bLJ
         wKvFaW8umt0KUxMkyoNL+m+8tJjeXG/MQd9Nbzbbft3wCO0HsgdieQ84trVn6v1TkmGy
         XjAIIMRXRwDLV3qqo2VGAxRvCo/LL8qlZVXAr9zvMhaSSVHRpzfn4aQe7r6Gwo78EJeO
         W++A==
X-Gm-Message-State: APjAAAUtG681C6iVDreOlnsh+bdbQadRtGKSBqSD0OD/C8A9fkP+id+X
        Gy2+KFjDOiBPIWXk2u+B2RSs1997
X-Google-Smtp-Source: APXvYqxj2nwbL1GLEyf7j5vNKVJureKsh50aOptvZON1obCVO15qHSEYHRSDBxx88WSonQZkL/oZxw==
X-Received: by 2002:a05:620a:142c:: with SMTP id k12mr86953799qkj.207.1578372811249;
        Mon, 06 Jan 2020 20:53:31 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:30 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/16] t2018: teach do_checkout() to accept `!` arg
Date:   Mon,  6 Jan 2020 23:53:02 -0500
Message-Id: <c43c11b91243b253702204241feb88adb3936ffe.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are running `test_must_fail do_checkout`. However,
`test_must_fail` should only be used on git commands. Teach
do_checkout() to accept `!` as a potential first argument which will
cause the function to expect the "git checkout" to fail.

This increases the granularity of the test as, instead of blindly
checking that do_checkout() failed, we check that only the specific
expected invocation of git fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 7ca55efc6b..687ab6713c 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -4,7 +4,7 @@ test_description='checkout'
 
 . ./test-lib.sh
 
-# Arguments: <branch> <sha> [<checkout options>]
+# Arguments: [!] <branch> <sha> [<checkout options>]
 #
 # Runs "git checkout" to switch to <branch>, testing that
 #
@@ -12,7 +12,16 @@ test_description='checkout'
 #   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
+#
+# If the first argument is `!`, "git checkout" is expected to fail when
+# it is run.
 do_checkout () {
+	should_fail= &&
+	if test "x$1" = "x!"
+	then
+		should_fail=yes &&
+		shift
+	fi &&
 	exp_branch=$1 &&
 	exp_ref="refs/heads/$exp_branch" &&
 
@@ -27,10 +36,14 @@ do_checkout () {
 		opts="$3"
 	fi
 
-	git checkout $opts $exp_branch $exp_sha &&
-
-	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
-	test $exp_sha = $(git rev-parse --verify HEAD)
+	if test -n "$should_fail"
+	then
+		test_must_fail git checkout $opts $exp_branch $exp_sha
+	else
+		git checkout $opts $exp_branch $exp_sha &&
+		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
+		test $exp_sha = $(git rev-parse --verify HEAD)
+	fi
 }
 
 test_dirty_unmergeable () {
@@ -91,7 +104,7 @@ test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
 
 test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
 	setup_dirty_unmergeable &&
-	test_must_fail do_checkout branch2 $HEAD1 &&
+	do_checkout ! branch2 $HEAD1 &&
 	test_dirty_unmergeable
 '
 
@@ -125,7 +138,7 @@ test_expect_success 'checkout -f -b to a new branch with mergeable changes disca
 
 test_expect_success 'checkout -b to an existing branch fails' '
 	test_when_finished git reset --hard HEAD &&
-	test_must_fail do_checkout branch2 $HEAD2
+	do_checkout ! branch2 $HEAD2
 '
 
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
@@ -164,7 +177,7 @@ test_expect_success 'checkout -B to an existing branch with unmergeable changes
 	git checkout branch1 &&
 
 	setup_dirty_unmergeable &&
-	test_must_fail do_checkout branch2 $HEAD1 -B &&
+	do_checkout ! branch2 $HEAD1 -B &&
 	test_dirty_unmergeable
 '
 
-- 
2.25.0.rc1.180.g49a268d3eb

