Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiDLUoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDLUoM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 16:44:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26154B0A71
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:38:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso2558417pjj.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+ir/G4NpzfQQvvEOlLWLqTnQ6goY48Yu/xVLe7RWgY=;
        b=It/8qvDsiIcza5BvNt0DMfNAhQKxWtW28IZfuMbbScEftv4m7UKMEgEzPD/Owcplzo
         Tjaq7MXV598LoShly6yYqeKIZMITogPQMLso1kOTf4/hxS63fguqgg4b5RPGJe8rGX3v
         I5Hdj9Ootl9y2owyoq7RBuP0YL3P4WAqZR6KJ+7GHW9MWW/vz7CflzqeRqUNjUxReiy8
         AQ9VM8EWs4+QR1v2H+2akTV+Kg4detALAj6c0sx2MbvchtZFzyjCunjt//PxBaLGB8ME
         /vbFEGmI2EIqjJx/LvIpBOTFRVGN8wrKX0batSbwJuuvE60T9nIWbOjPLBCtVp0eHFnt
         6gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+ir/G4NpzfQQvvEOlLWLqTnQ6goY48Yu/xVLe7RWgY=;
        b=nKb+bqyd7Mz4mimhMGv8N3XwYyv4/62bdAjK46eg0I5L0LgNJP/r12yl7BoGASccuw
         xSXVu93ZRjwIW85Se5KyVsiTluXmfPWNe2/B/W/6S6sfTJpNlvmE0+r/WTehicdXAEG8
         veBqyP1hIhPMR6++8xHZJOgADWve7XBqB4UcT8kkhuSwoBWYSrTyvao+JgETkToNNr/M
         SUOWORR1K8BlqhlbhIlScbxa6wCS3lxA5jCdN9XrIXM0voC5+qgInbsvCCqMlNzOUci4
         NDRVsrFVyzHEZt5kbULVxydd85Tn7spIIt22ZyN7rM8mxijg8YOS3KKV/dgyMyVRtTMU
         f9xQ==
X-Gm-Message-State: AOAM532DHQs/wZqfRRElW7j5305uTZZrhKAPqMxReXI4+xu9BqEpYvDC
        9e5oF2D4q1mo/VtUK8JkpYcGmULuV6JELguY
X-Google-Smtp-Source: ABdhPJwN1+lJistX3MwoZ+9qrShPOjphjaQNjvl/ZF5EWCawS2EP+k4PBxRltsKPDl41JV/eNB6sxg==
X-Received: by 2002:a17:90b:3508:b0:1cb:8e7d:a63 with SMTP id ls8-20020a17090b350800b001cb8e7d0a63mr6941077pjb.183.1649795853570;
        Tue, 12 Apr 2022 13:37:33 -0700 (PDT)
Received: from HB2.. ([2409:4043:4c88:e096:3c28:bfd2:5de6:8af8])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm40467300pfh.84.2022.04.12.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:37:33 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        larsxschneider@gmail.com, newren@gmail.com,
        siddharthasthana31@gmail.com
Subject: [GSoC] [PATCH v2] t1011: replace test -f with test_path_is_file
Date:   Wed, 13 Apr 2022 02:07:22 +0530
Message-Id: <20220412203722.10484-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <xmqq1qy3igif.fsf@gitster.g>
References: <xmqq1qy3igif.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_file() instead of 'test -f' for better debugging
information.

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
2.35.2

