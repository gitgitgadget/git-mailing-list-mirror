Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B91C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjC1OAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjC1N75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB63C667
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so4048454wms.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi9k8ZLjAcBF+cXO42OWKevb5t874fQ2nMdPuvd7wAc=;
        b=qtOO5N2ZdPq/LLIPzRJiklqHKfDiJR9aWx9omXJ/KHwzIdotj4r9VAlUQy4NXRs2SJ
         +hG+lrO5bxMYqb7SnF45eeeme+SP83xynpgnSv0lHGa1mpkUHvAxuC04soc9pO5UMUy7
         7asPlHE3zlfZFPtHAqDjCwwCj+/XiUl6NLlQ2+HTTz4iCnpCRlDDvovuUo36ZxIFiyjX
         IntRWopPth451B8VXhRJmLqDDV2U0E/57KeGfwpR1JzwHSBytQKdVc/Pu/rzo7PzD+xM
         XydsDMljL3jCEHCUxG+ToGE0fASQSk8IMPPlfkeUoBufvK4V/0wzLx5yLuJbLY+Gm05B
         Ecog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi9k8ZLjAcBF+cXO42OWKevb5t874fQ2nMdPuvd7wAc=;
        b=kTjmfxb63/dKlLEI1j9WdOcklG79y0Uh9Sj6lgJva/RqRTVibw0XXJSFf9ihGu90ds
         DEvvMqJzuctT5XZlNB9oFK6TLPBegb6F/ssNVFdCFJob8K//UQlwKKNxAJ3XS7CY7M/n
         g9s8iLRvd2HQddNkn3dtadWosqh2Ip7sGP7nw3QaDnoBpmMywi+bU16P6egJ67u8SxdM
         8JB1aY3HnmYSKk2vqQFngVT2sSYuUhrEQF3LPrxzB27d1F/7aEi7doroqKc0i/iyXb6d
         GGJYroA+i+KChmzeCyXG7ZJM9A4Xqe4XjtWuxKYbR3FAxWvLufJlvDaxuCbfidXxtcB6
         pBlg==
X-Gm-Message-State: AO0yUKUfuaRie71GU1766po7sdlEpGh3lb455VbnSRRFiNlD8rF3ER6v
        ZT9Z6VsOwTtJ9gQwrFZdc0dWlAiM7lh0JA==
X-Google-Smtp-Source: AK7set91maXWw3covquSaHORdgL7wR1s5A/ukg4d73lE8Srtwq+w2Xfl1E1nyRRiZEZqKUMFUK8dBQ==
X-Received: by 2002:a05:600c:21d8:b0:3ee:5d1d:6c2d with SMTP id x24-20020a05600c21d800b003ee5d1d6c2dmr11585025wmj.35.1680011962180;
        Tue, 28 Mar 2023 06:59:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/17] cocci: apply the "rerere.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:55 +0200
Message-Id: <patch-v2-14.17-3d59dfe4186-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"rerere.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c                                 | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 rerere.h                                        | 3 ---
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 60052ec9d7b..b60c82f7af2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -602,7 +602,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		rerere(0);
+		repo_rerere(the_repository, 0);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index b20a3e70845..1d1ac7d4fc5 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -109,6 +109,10 @@
 |
 - dwim_ref
 + repo_dwim_ref
+// rerere.h
+|
+- rerere
++ repo_rerere
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 8bf30798a04..1190a3312bd 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// rerere.h
-- rerere
-+ repo_rerere
 // revision.h
-|
 - init_revisions
 + repo_init_revisions
 )
diff --git a/rerere.h b/rerere.h
index c32d79c3bd8..876c316321e 100644
--- a/rerere.h
+++ b/rerere.h
@@ -24,9 +24,6 @@ struct rerere_id {
 };
 
 int setup_rerere(struct repository *,struct string_list *, int);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define rerere(flags) repo_rerere(the_repository, flags)
-#endif
 int repo_rerere(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
-- 
2.40.0.rc1.1034.g5867a1b10c5

