Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiG1QbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiG1Qap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217748EA8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1302283wmm.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VmJMl0+v4ZZLPGOvQA/fP7vWGTJKtcZpXq54VGdb8Lw=;
        b=BbaWoA7XDoQAl27P3YHKQoSO/8l1PGPp2nlNL5UtU5xZY281G9S6A5Kxf01W2cioIP
         bNUswE3fmYTNkACGg74NY5ZS7QClmNJu5J3pCnDry/3g0Yxy/ar29G3NQkXTrench5To
         eixZsC0ML92ziUH/7QsHewvObzUAgn4D1p3750tp5jgNRZ6KMdfUyRJzsf03mgYCmagi
         zuUesc5TaUmrG6qgoDpNrRGFVTGxdu/28bBX6lNLls794jBnmUSgdVkJtuB6HAJ1CJdN
         TCpy1rNLLH6ZP3hH9aW+F/tu/tgTrWmmynqnuttnc1DXVKK3b+oISE3RKocOH0cChTlu
         u4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VmJMl0+v4ZZLPGOvQA/fP7vWGTJKtcZpXq54VGdb8Lw=;
        b=6BRa0bMeDVQHZTmiZPzqJAfRX7O0TER7y0JQp94IXg9ZjpXJVbbDOda2wazrgYHPv2
         Khj3h/C1lN+f9kRwhlzjRnNOFeeqwC8a/jtFwqa+W9h9ShxhoYJmrcO/18OE7kSGb9+2
         LjKi9JALsUOEX8TsmbKGivtLaMvi5VGTZwUBBgbsoGRv/1Po++sqBEDhcJ6M5DJ5qxfv
         uDLs5L4XxZRTwwBjlZKqgD3EVeNj/Mk9xpGDkFYM3arA0YMwp0yThFONkaVYFLDFqB0K
         4oTXSzxU3OhLjwB6OZlwIxJ+wElCUocevrKeQh2b6reujYP/c0igq6qhb7yl4SnhZJ1r
         vkKQ==
X-Gm-Message-State: AJIora/SQkjCcwgdrHMIsI7eb7GLc97IaaonINHWvz9TEWAHXdchWmcr
        jnHM5ygdpx3tzdQujc0hvDTI//kmW+XKAQ==
X-Google-Smtp-Source: AGRyM1sQ8c1wyitrGqTxXBBo0knto6kdtouXLCpvPA16rtYD1BdcuLKenUOjl43P3oVycgW0LX47QQ==
X-Received: by 2002:a7b:cb4e:0:b0:3a2:f3b0:4233 with SMTP id v14-20020a7bcb4e000000b003a2f3b04233mr156724wmj.50.1659025833403;
        Thu, 28 Jul 2022 09:30:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/17] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Thu, 28 Jul 2022 18:30:09 +0200
Message-Id: <patch-v4-15.17-230e5f8ad14-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
index b51b60d5c77..2e39750fb06 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1856,7 +1856,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1894,6 +1894,7 @@ struct update_data {
 
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
2.37.1.1197.g7ed548b7807

