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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14551C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A3464E6B
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhBLNbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhBLNbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660BC06178A
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so4321375wrd.6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtDCRKKbwNMRV/B4X3PoS5tfVS9BpPT1sOOWmlpf9pk=;
        b=TN1L7/ic3cve8DQDzl9j7xumg8OpFkB9N72BKrFn8l/ShGvAnhFRNS1304ydTo14gO
         aB0fbzSgoLkJ3eOF+Zkeg9y94CSbaogj4Qgy7PNgXIbIllC+vFvzJWxr8mYDkiubGox+
         WdU1c/nz+Hcu4TwvPBCNBHU8F81TvMMAjwo6kabpikxVkzxbF8yH8Ti442H3KPPQuTiz
         d58yqmzc83sOo9r7zogISGYZBHB/8iLrkMyY6+rBCjWo+bYiHJKbPw+CmZTD76sWZSEB
         TtwSZzDSM93bIMQG4nE5qZWP17Q5buCGLH0EQwRftXJSau77D2BDk/E4lYrVKiQBQv3H
         VR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtDCRKKbwNMRV/B4X3PoS5tfVS9BpPT1sOOWmlpf9pk=;
        b=K6TsuJ0sXGqselb+YAmgL0+9trDDxV8iXwqxzrYWL5K5bJo9+JhSZwsnki+hsyHRcX
         hAEJnIcrEU8976EDwtGEIUaRvMFhvkICUUUNkaSqeJFFd3/oP3xIWIGU9CEutEEuRc7E
         +YeOy3gw2M/UUVKAT48inx6f310eHLKinRDP7rGlgEE+/PEW/4yELEqdROwjTj49yPkx
         R7QgK5uJZ79Dv15n+7FEakw4xNOzgleaP0X0NtLzUW09rdmTd7T3OkUB5YjZczVqxN30
         FTb1Z0IErpGpQjF5swfKIS8F9zL14ofhnyQzv/hThn8hFLgQp8inzKcIGCemYfbdnq4c
         4FGQ==
X-Gm-Message-State: AOAM530kQ91qX13cfdIbrff1wUf23EKWeisjEfYmh+Cyytn3TM30MNjB
        q5GOTb1wRoa+nlX4glhYES39dwB/AwN3wg==
X-Google-Smtp-Source: ABdhPJx3i6usxAp+tQU1c/DkgD8bQI4JfsHE1rJ3OGw6RZNU4/kv+0s/X6Uf60muRXlLtxMcXCI5Wg==
X-Received: by 2002:adf:decb:: with SMTP id i11mr3357666wrn.78.1613136597472;
        Fri, 12 Feb 2021 05:29:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] test-lib-functions: move test_set_index_version() to its user
Date:   Fri, 12 Feb 2021 14:29:34 +0100
Message-Id: <20210212132942.17325-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the test_set_index_version() function to its only user. This
function has only been used in one place since its addition in
5d9fc888b48 (test-lib: allow setting the index format version,
2014-02-23). Let's have that test script define it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 5 +++++
 t/test-lib-functions.sh               | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 7e2e7dd4ae5..30666fc70d2 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -9,6 +9,11 @@ test_description='skip-worktree bit test'
 
 sane_unset GIT_TEST_SPLIT_INDEX
 
+test_set_index_version () {
+    GIT_INDEX_VERSION="$1"
+    export GIT_INDEX_VERSION
+}
+
 test_set_index_version 3
 
 cat >expect.full <<EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4b7e09db63a..82ad0b91743 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -32,11 +32,6 @@ test_set_editor () {
 	export EDITOR
 }
 
-test_set_index_version () {
-    GIT_INDEX_VERSION="$1"
-    export GIT_INDEX_VERSION
-}
-
 test_decode_color () {
 	awk '
 		function name(n) {
-- 
2.30.0.284.gd98b1dd5eaa7

