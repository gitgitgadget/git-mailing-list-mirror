Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DAC4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EE760555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbhIHBnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbhIHBnr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F1C0613C1
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so290494wms.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MbU88O7tq8/LF2BlKKzEtM7WyKkge6STN6O1kXeP2X4=;
        b=QAoA2hozMExu4pnkALgP+1Q9R7VMM7hhgc30I4guL2KlB6DVZxidffNwjED3A+I8Ig
         ii3SJaeh1tOpTySb6EE0fILuAD7aXI1tLi8WFmAnkHGjUeyxlda6y+BrYcVKBtuFRH1B
         A2jqo/47h3fDP2Q1E1vEPgThX0sV5Qu4eF4xARzg3pCEHwKahqetQ5m8QNFEui8FkFTT
         YJD/6531xHEcULkxgQeueqZIhbgCR5isXxTG03u1PpnvXq64FkWzAKHe78dVXgC+eDkl
         fnUjqCTlKSH8frX3t7BezgkX4fVgxCwmvhWkcK97qFUi4sWgtK4QnVITS1woAZ09w/6U
         yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MbU88O7tq8/LF2BlKKzEtM7WyKkge6STN6O1kXeP2X4=;
        b=BFEDeiEmz8rehtUeY0fxnokUC8tGBOZgEohfLlOmhuKca5i8HSE1Gny9A9IFEeEdXJ
         aoAkdZO4dIxkFcWEc2//HDL/PQWRrSTGlVSbyO7pymXYPhN9OJg4NVQvy8BF7TBWLG6+
         lMOY/Gaqj1yh0LNvSbnE9pKnTHcm6lGh120zE+nn5+QOkCZEK0SeHfIhDy0xoWWpbOQt
         d9qlzyOfIzGXgsD4BAQ85fmBYSDTd9X+7Ra32JdcqkJnkB++h7bz3zX/BgmbDSEjAzaY
         WdkgGmTXbHSJjaLpLs7HbSIDYxLrTQ8/UPVQrgrZ/ajNe2W02HOpbJnDzhqeYFM5MXUE
         3+yA==
X-Gm-Message-State: AOAM533sKZAo5xw39+l67vnRn+9S4/w6UrvlAqEiGi9OpVvEc3i4dcqI
        WqKy4WREfD/YiIR9eYI+t9Lx/3xy7ug=
X-Google-Smtp-Source: ABdhPJyMkZeJchJV3sTtCNkKpqCHSSDmkAEJ+1uldM33GXuXHnd/CBwj1wpIhP7BCHEfs/nx5fmTIw==
X-Received: by 2002:a05:600c:4fc1:: with SMTP id o1mr1021741wmq.4.1631065358185;
        Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm624782wmh.20.2021.09.07.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:37 -0700 (PDT)
Message-Id: <371716124247cf89069c1344e77c08853a1f76fb.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:29 +0000
Subject: [PATCH v5 5/9] sparse-index: use WRITE_TREE_MISSING_OK
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When updating the cache tree in convert_to_sparse(), the
WRITE_TREE_MISSING_OK flag indicates that trees might be computed that
do not already exist within the object database. This happens in cases
such as 'git add' creating new trees that it wants to store in
anticipation of a following 'git commit'. If this flag is not specified,
then it might trigger a promisor fetch or a failure due to the object
not existing locally.

Use WRITE_TREE_MISSING_OK during convert_to_sparse() to avoid these
possible reasons for the cache_tree_update() to fail.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index d9b07695953..880c5f72338 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -181,8 +181,11 @@ int convert_to_sparse(struct index_state *istate)
 	/*
 	 * Silently return if there is a problem with the cache tree update,
 	 * which might just be due to a conflict state in some entry.
+	 *
+	 * This might create new tree objects, so be sure to use
+	 * WRITE_TREE_MISSING_OK.
 	 */
-	if (cache_tree_update(istate, 0))
+	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
 		return 0;
 
 	remove_fsmonitor(istate);
-- 
gitgitgadget

