Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D59C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiHBPzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiHBPzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEBA3AE6B
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:55:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so7168312wmj.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LfVgofzlzF/lwqZXuZGrJO05xMWJsvMNGS8Sd2gqOrY=;
        b=Z9BJz4IejqvUCRqwacJlmIQywU8mN71tjJibZ5Iz3oFGOYtqtAw25YKUczyEV7ZYnR
         ULp8+amTfZUdr8wR6pXDMmF/6g0tZ8eQuPWtLMGIBA4QOp0P5yE1+eeCpZnHW167b9g0
         PtO/lxpQtRWslS4NHpzgMlc9paxDw7J1FX9Z4tKeuD+xZrWDtmF+w7VPELbb2Vf42TkR
         xhnDOMtAurUOENMEn1q4gb0CkQctdIQSbrVe/cYKLmIj7VnxAc4XjB91PAJlvKVyhrVv
         +RatqglfV7evDhqPYE//akHsmOW0Y7YML83eHD1oFIXwg6rHZudW48PbQL/IXQpJ6Uho
         evzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LfVgofzlzF/lwqZXuZGrJO05xMWJsvMNGS8Sd2gqOrY=;
        b=TGtASnYxhb85xpdL65DQn9MSEv1tEywK9wAu1wWrMjNuv192tm6L5F53MWMAFTH8Rx
         xNNU9gnY/uVXToUq7W+udMnWvBSz+hc00wIJwpc3w08P3YKzB0mXDB4UCXxHb6q6AlZP
         ni0QKAS44xicfqZJCk66dxykDRir6R+ZGWTns8h0B7DQ163ZOF6oJ9bkKGUqZf+ZXN4x
         ysiczNfaSbkdLTN3WMXLOCnCTWaTcLQ7CKBlCPJUkV6OUeNMLEN/LqtjiuQcH//OPV+N
         4n3bYfj90kZZSCj7LzJCPPN4VIRzfFr0fBANMt9V5tNasuJwtJF0G68illKSZnYT811q
         PxjQ==
X-Gm-Message-State: ACgBeo1gV17yfV5t8EyI5h54qkbVqnfupjpmcgIxUfdHMZOfWl7PfchQ
        GcBHs5g9Uopk1J7tdzNsaIPU+JCQtRtpQA==
X-Google-Smtp-Source: AA6agR6Fwzb7iVJeDmbbhuF4QrROCSR28krJzl4tvBTq+PnxW0R6aYjJhVKRJ9uD6FoAWfI/xqUnxg==
X-Received: by 2002:a05:600c:3d0d:b0:3a3:7a1a:326a with SMTP id bh13-20020a05600c3d0d00b003a37a1a326amr66575wmb.127.1659455700106;
        Tue, 02 Aug 2022 08:55:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/17] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Tue,  2 Aug 2022 17:54:39 +0200
Message-Id: <patch-v5-15.17-613d077c4ec-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the update_data_release() function free "displaypath" member when
appropriate. The "displaypath" member is always ours, the "const" on
the "char *" was wrong to begin with.

This leaves a leak of "displaypath" in update_submodule(), which as
we'll see in subsequent commits is harder to deal with than this
trivial fix.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c        | 3 ++-
 t/t2403-worktree-move.sh           | 1 +
 t/t7412-submodule-absorbgitdirs.sh | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0f1846021e6..79eca6c439b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1882,7 +1882,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1920,6 +1920,7 @@ struct update_data {
 
 static void update_data_release(struct update_data *ud)
 {
+	free(ud->displaypath);
 	module_list_release(&ud->list);
 }
 
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index a4e1a178e0a..1168e9f9982 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -2,6 +2,7 @@
 
 test_description='test git worktree move, remove, lock and unlock'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768d..2859695c6d2 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -6,6 +6,7 @@ This test verifies that `git submodue absorbgitdirs` moves a submodules git
 directory into the superproject.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
-- 
2.37.1.1233.ge8b09efaedc

