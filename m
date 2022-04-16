Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3612C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 13:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiDPOCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiDPOCX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 10:02:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CEEDF07
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:59:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k62so4917838pgd.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGkOyMGN2Nd00s+dDSO+ipbKhh4/j3bAOdlK9lA2yYk=;
        b=PqFl/3vuG5zQmaZhCEAqQyEbqnYwAy6FXCmb1bumuasbfx6IOOCsrk0XHPfU/y3K7s
         p7mCccpl27tpnRzUJpUsn6zgvmY9DGyT8p5yjmE+wcVi/22UdveRBt4Tk4bXrvAv0Ogo
         ME0nz094IBStojYip0KpCUf7NoWL6KEhvpLiW7QmjU/FvxC1H0ch0i/f/1gugnTJYthQ
         P5IQdeC45GGqjDMTaz8waIBvAUSiveZv9FXXsWQThVvENxPN6Hh7c8hdgeN54641IUz5
         qjqSnToh/4nzMstsDIH9TYVXqvttHByxndcctJzc07etK/CJ1GNI1oaVlDZLUqGL0Tvj
         B7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGkOyMGN2Nd00s+dDSO+ipbKhh4/j3bAOdlK9lA2yYk=;
        b=P7LdVc2BX1rkW5TnNdMt3s8Zine/exYUyDD3rPKuRSJuJTEPqkddQEFO/h8oXkWfs3
         7G7Y0OrqxXgE6plJoSjdzwvt//6vxEFKwpy8qswC0l4EDrfouraNH38P0GZbsx5hVJCa
         nf8GQ/9Z4L3LJNj3d2A6Qyn/mELpwLlYF+gb+dI2OIVysRE27eYgm7pWqvgnpX/QVr1y
         2xRGy4fXEQyYbERdJQ50snPViBxVzKjfmzmN4eEzw1zJkUz3moJQUmu/XvK6n3Hg/Dqc
         PJBISeVtF1Oqgqv+mJ6Y79bS17lYolh7oLQOgINQPEc4JgK+rHAcecoc1iJpvaxHUc4V
         L7Dw==
X-Gm-Message-State: AOAM532qd9rLrIXEnJm1Rr9hsRzhyDLgusDnkm5Cry9Qu4v8aTc8LdOq
        Axvqni8pRd2l3NXGt5lQokc=
X-Google-Smtp-Source: ABdhPJwLEvNU+Vypj3Svtmb9dSqgPa2RRhqKDPghEEQy+NMycQeeoIsgDOPHdj6GW4L/WePtKEHHAQ==
X-Received: by 2002:a63:6984:0:b0:398:8db9:7570 with SMTP id e126-20020a636984000000b003988db97570mr2955603pgc.373.1650117589119;
        Sat, 16 Apr 2022 06:59:49 -0700 (PDT)
Received: from HB2.. ([2409:4043:4d8c:dad:5b69:8790:ab20:744f])
        by smtp.gmail.com with ESMTPSA id x129-20020a627c87000000b00506e53ddd4fsm5790863pfc.114.2022.04.16.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 06:59:48 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     siddharthasthana31@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        larsxschneider@gmail.com, newren@gmail.com
Subject: [PATCH v3] t1011: replace test -f with test_path_is* helpers
Date:   Sat, 16 Apr 2022 19:29:32 +0530
Message-Id: <20220416135932.146811-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a1199b2f-c7ad-5d50-e36a-0d47b05c16c4@gmail.com>
References: <a1199b2f-c7ad-5d50-e36a-0d47b05c16c4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace 'test -f' with test_path_is_file for better debugging
information.

Replace '! test -f' with 'test_path_is_missing' helper instead of
'! test_path_is_file'. It is because, in the test, when we write

   ! test -f init.t &&
   ! test -f sub/added

we do not expect init.t or sub/added to exist at all. But when we write

   ! test_path_is_file init.t &&
   ! test_path_is_file sub/added

the test will _complain_ "init.t doesn't exist" when the test runs
successully, while it will be _silent_ when init.t that should not exist
is there. This is complete opposite of what we want to do in the test.
We want to fail loudly when our expectation is not met.

So, replace '! test -f' with 'test_path_is_missing', as we do not expect
foo to exist, rgardless of its type, i.e our expectation is met
if the path did not exist or it is a directory, symlink or a socket.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 46 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index dd957be1b7..63a553d7b3 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -57,8 +57,8 @@ test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
-	test -f init.t &&
-	test -f sub/added
+	test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-checkout and enabled' '
@@ -67,8 +67,8 @@ test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-
 	read_tree_u_must_succeed --no-sparse-checkout -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
-	test -f init.t &&
-	test -f sub/added
+	test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
@@ -85,8 +85,8 @@ test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	S subsub/added
 	EOF
 	test_cmp expected.swt result &&
-	! test -f init.t &&
-	! test -f sub/added
+	test_path_is_missing init.t &&
+	test_path_is_missing sub/added
 '
 
 test_expect_success 'match directories with trailing slash' '
@@ -101,8 +101,8 @@ test_expect_success 'match directories with trailing slash' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t > result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	test_path_is_missing init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'match directories without trailing slash' '
@@ -110,8 +110,8 @@ test_expect_success 'match directories without trailing slash' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	test_path_is_missing init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'match directories with negated patterns' '
@@ -129,9 +129,9 @@ EOF
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-negation result &&
-	test ! -f init.t &&
-	test ! -f sub/added &&
-	test -f sub/addedtoo
+	test_path_is_missing init.t &&
+	test_path_is_missing sub/added &&
+	test_path_is_file sub/addedtoo
 '
 
 test_expect_success 'match directories with negated patterns (2)' '
@@ -150,9 +150,9 @@ EOF
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-negation2 result &&
-	test -f init.t &&
-	test -f sub/added &&
-	test ! -f sub/addedtoo
+	test_path_is_file init.t &&
+	test_path_is_file sub/added &&
+	test_path_is_missing sub/addedtoo
 '
 
 test_expect_success 'match directory pattern' '
@@ -160,8 +160,8 @@ test_expect_success 'match directory pattern' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	test_path_is_missing init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'checkout area changes' '
@@ -176,15 +176,15 @@ test_expect_success 'checkout area changes' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-nosub result &&
-	test -f init.t &&
-	test ! -f sub/added
+	test_path_is_file init.t &&
+	test_path_is_missing sub/added
 '
 
 test_expect_success 'read-tree updates worktree, absent case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	read_tree_u_must_succeed -m -u HEAD^ &&
-	test ! -f init.t
+	test_path_is_missing init.t
 '
 
 test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
@@ -229,7 +229,7 @@ test_expect_success 'read-tree adds to worktree, absent case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	read_tree_u_must_succeed -u -m HEAD^ &&
-	test ! -f sub/added
+	test_path_is_missing sub/added
 '
 
 test_expect_success 'read-tree adds to worktree, dirty case' '
@@ -248,7 +248,7 @@ test_expect_success 'index removal and worktree narrowing at the same time' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout removed &&
 	git ls-files sub/added >result &&
-	test ! -f sub/added &&
+	test_path_is_missing sub/added &&
 	test_must_be_empty result
 '
 
-- 
2.35.3

