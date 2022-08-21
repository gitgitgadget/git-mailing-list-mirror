Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30264C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiHUOCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiHUOBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953823160
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso6422681wma.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ykoe4wu5z/sMjr2ids4DeW1vF7vBKq2AwINGMxJmPMA=;
        b=XyBay0f4MBqcVCYVHSqVD5C7TjUUPWzYGfVWmL/bFq5U9rWiTK8nq5nbwUMeLkyCAw
         mLBVpVRsvppxnEJnR7+qrqs87iBaI+HooWw8w0iu/2yPV+t+ySKR3JDgLmZgCZ4Pq0ha
         L6iNMLCcKHSqU9LtR9x0olS+D2jcNns/sNUl/LmcHV6DxU0DA5o7qC+mJyQiBKruC87J
         k6tT3PkRaT+R1RYDbC1MN3D7bQ4oYol5yhE7FmKoDtsUAMfIR/mUdTvf4XI5xexc61vv
         tMPBBanihxGFGS/xgiS9sjcbpRK3Ta7fnGe0xn+CvvPR67PkcPasL2DSVsCWZgFgBHny
         16gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ykoe4wu5z/sMjr2ids4DeW1vF7vBKq2AwINGMxJmPMA=;
        b=ZOn2SoRJ377pH+9uHSR39NO+gL2tYebwknMbKZpmaqxz2BkXxb2MGIfCVXpXUhhxKg
         F0eCWCg0S190ZD31SPJV1GbTRokZ8NxyKtkBEL26fwBYA0JRjmEpoo/qp6uuGGWRsNLw
         8yFxGwIouj4zO3nrgg4dXkqweEjWzySjpoCDWUzojtvGzUFwt9l3QNipe8/g0Hx6t33x
         xFxfh50ao7jXI686enS1/eyvxO+XyTFPb+VDvXJo7OeoFFzcrnrnVvNuA8Io6tbk0aWh
         zJXPjwJunkJDA/OM9pWAkjc48TIPt9D0Q8/70Rtp/5ybdLTaI8XWYJlR2PtdO3e13s2E
         TTvA==
X-Gm-Message-State: ACgBeo36edekeMfhM2wifcQJ8vRqS050NrTx113ByrYgQWSMEOKSePjw
        H+qDQ5hOb2MOICkpW5BWobTYpEdmyInxMdCP
X-Google-Smtp-Source: AA6agR7GhNxRh9GU+dbHns/ADZgFo810vRY39wS23HpteXA0pS4+LpPX+Ecr+wutHQyNQYjs303fQg==
X-Received: by 2002:a05:600c:348e:b0:3a5:fbcf:4c1a with SMTP id a14-20020a05600c348e00b003a5fbcf4c1amr12775912wmq.171.1661090479505;
        Sun, 21 Aug 2022 07:01:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/17] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Sun, 21 Aug 2022 15:59:39 +0200
Message-Id: <patch-v6-15.17-f3cf49dd029-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
 t/t7419-submodule-set-branch.sh    | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e75d7fa2e10..dbbe412b24e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1880,7 +1880,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1918,6 +1918,7 @@ struct update_data {
 
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
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 3b925c302fc..96e98423214 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -9,6 +9,7 @@ This test verifies that the set-branch subcommand of git-submodule is working
 as expected.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
-- 
2.37.2.1279.g64dec4e13cf

