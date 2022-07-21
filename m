Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C2C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGUTPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiGUTO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6078E4D9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so3634890wrc.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4h2siDrQDNXEtig58zecJxF3gBab2/L/AEPMJKpXKQ=;
        b=P5HPUGLIAikFh5Grg8NjMorqkHHyOSifM7UnLM3NIaKVxu3KSKnDqOEaUyS16Fnblq
         TE/c0gqBOH7be2HRdwui2LCvJ19rsXGysuLvDCT/QeZml8E4n6sEne9dJZl+zvksYKmF
         FEpLtRtf//nuD8ZSNM7Uv3cTKOWkoELHOCdyX/u6R/M2VdQiVLFTtRqlEO50vUKHg8XA
         bi8e6yIWmlgEYjYuOEyEXMIy9fqxo7JmTvNGHnZzCQbMEeFzb8d7zfMNSpp67BLHDm2D
         h9BfwvzwduBEA8pWjJ4lhDnfmhE4sXGPYM00a1eMPQunmr+137dFK3papGwyJkpqjGJY
         f1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4h2siDrQDNXEtig58zecJxF3gBab2/L/AEPMJKpXKQ=;
        b=F7/5zQsWqNvkgaobYPob75YpXiPNpikvEBHKmDnFoZHMgwh6hIHUXrl+zdKVJ7Y2CJ
         i28VsUBCsTbq4K+jwXfNiO+kVEwWlUltxAO5BX8O68jw48RDqSSiVYXOXdzqdxxQHR5d
         cgqUH7THZcPYhBrzc0Rws7CTecK2tP9ksDmghy35YzPWWhCA8FLldlWfMoYsBCiCh+DN
         MmT3JgIkp/zi2U4RDqD71gPyt9ETMmoX5qOJV6ZMpgmV5wyzIxjqz2pnD1+2siVOUzbd
         CS0zzR8Z/y9/24DpP9hFCtePPiBKVpznjW6xdLwbEUsKR/cRBirWmqM70zKO29KWBgg5
         ePlA==
X-Gm-Message-State: AJIora+aJzm7pdrYAQbUEN4/mroBS6qdjvDh43iY4TXo/S/tCf3yPl7H
        pSr1TmzqCcJAb+7eTb/1+qHHeb2yaIPPdA==
X-Google-Smtp-Source: AGRyM1t79E9qyKTQ42dISvgi9w+sHHZGrptQLaPFmI2EhWMiJxm774NuBWEet98QZb6GgUXy3peUPQ==
X-Received: by 2002:a05:6000:1d86:b0:21d:6433:1455 with SMTP id bk6-20020a0560001d8600b0021d64331455mr36337529wrb.514.1658430855746;
        Thu, 21 Jul 2022 12:14:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/26] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Thu, 21 Jul 2022 21:13:16 +0200
Message-Id: <patch-v3-20.26-b8d47fc7d70-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index 4decbdcdc5c..378f85e37fa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1954,7 +1954,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1992,6 +1992,7 @@ struct update_data {
 
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
2.37.1.1095.g0bd6f54ba8a

