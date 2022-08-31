Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BDECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiHaXQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiHaXPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1725C48
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m16so20097330wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oeZNjQ57DkDPQMEZahF9BONdvx2gWqe1N4RLb4YPUfU=;
        b=M2BNKDPorQG8YhP7hgEcVIxea7SN0VvdWMZ+9WCR/QJOg/dcncNGczMS2gu9Ig3p51
         7C5kEsJhxzNQzpCSAOt/zTQps2LX/nMSLVhNsKlZq2/MlNviWsv1SZpqQENqNpU4uOJs
         YozkCBQWjn5ZdIL+oqk7yoWUxpNLfswTWnm8A/1bTd5GFyMOw2FPFci+TyPJ0YhBkz39
         48zMwgqxJqdyNYrazdXe/Cv1hgxTGs8K6FTWLoKHV7sQFWbJNSnQESlDT0YrlFqNzb1q
         t1HGO57TMa8hx/xvXjwj+DY43cjC6X0sEL5gGlX9s1+tp30md4Yxa/nflyEjY1l98lhb
         LdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oeZNjQ57DkDPQMEZahF9BONdvx2gWqe1N4RLb4YPUfU=;
        b=TKBtJbNh6iF3GvKBA1QC3XKxDOwsw9CL1NPrlFBPmCLLYp1Q2aX2ixmyy27Wrlj7zz
         /yxEaR71Fi20l8fiy1xlof2EN1LFnf9HYVv1/N1AcnGeMhIj6VVBOxIv4YpmS8m5MaSI
         8eYnI8VQiADFb11EmWRBSCrqjoyMIoEwDyzqVRN/fJD0N9qY9zet/l6ozzrFbDD/wPcX
         mXxGUZtZ3Y3cwY5Sb09qEFlQpCZGCnlhXMh9j8HE0/iJLydc08GgntX2BwWAqu4Q1bKp
         X1iOu66LThd30mvDamWjNF9HtjHVrFm0bmrsFmGiR8V2107j1IvrxHoLl39jthsAE4RS
         Mc5g==
X-Gm-Message-State: ACgBeo1ZAezFgekUg66ymZaHvVypkCEqN4hnBH+Xzu1Dj6jxYr7XMEcr
        xDui7U63Jf70ZLNL0SVdy+2QxJBsoLTW2w==
X-Google-Smtp-Source: AA6agR5iJ9eLIeylF9ax/G9qQ4nHdJDymYCy+JuIXrO7ABnoFROCkrISGvX3Ke81f5qbYZrqUUBrDA==
X-Received: by 2002:a05:6000:1f18:b0:226:eacb:2d77 with SMTP id bv24-20020a0560001f1800b00226eacb2d77mr3294728wrb.0.1661987699447;
        Wed, 31 Aug 2022 16:14:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 15/17] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Thu,  1 Sep 2022 01:14:22 +0200
Message-Id: <patch-v7-15.17-bfafd31746e-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index 23c9e28deaa..94ebd8ea38e 100644
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
2.37.3.1420.g76f8a3d556c

