Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C433E1
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F522070C
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNK0askc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgGFR3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgGFR3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 13:29:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76160C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 10:29:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so42051063wrv.9
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyTlcIZrqnt9n2tJMBRxxLrLOE+DS937uvg1AYaoXds=;
        b=HNK0askceTS4f4jQSgRccSeYI/BEMQw5RwLDY6BWxWuGnmDcr+iviGRrE/ZgehGwEJ
         HMILdnDSo7ADBksjvIJ1Hs/ww3S3cdJrv3hbaJ4IdzWUbDfOlLAl10luomxvsO3dgD+D
         ktQXnfMGsdmL5Nk78cuyMfMk4v4PmSZyfpdTMTq1ba+A0rIWqXhk9e+nnuc1DQmx+9Nf
         HNA2WBDfB2dkIEeQ640l08xqekqbDLPJ+UgEfadct3ducnj+UB1+vKYcmHbTu117hkyq
         0crynV+LpV0Nc7xJ4i4gnR2BIiMsbngk6HHBCioFxV2GrEvhTnSc6e/s0Xhg7bvQ8FyS
         2tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyTlcIZrqnt9n2tJMBRxxLrLOE+DS937uvg1AYaoXds=;
        b=s1CebKnRJihy5fS+peKQJn6scGoya7Ew16yzXyxVEjZitmuH1dTxuKmzQ3ErJKZC2b
         iVh7vNXsgH5Ocn/uMU35I9ThDQQ2xpO9We3K4A7r2bDYYZDn6W7OPV5dRsJTPu1Ep6xd
         kLERlpXd7u8RhNJ0emXVSxQBdGm3Pj0Tb12bhGGPu89rOWxS4l9bRyaoMjoRX8bihzis
         A8WdGcK1OMxgyGNxIsMD9jqu1VzFqRSARabPVxqpK0iTHYFMTENo95SnIX21gwqiuS9u
         LrFSA6lmhDft25O2vk64M206r8Gr7NXRAhg+aXp/MNHGTy22X2UlCkEgaBM385NSh4yp
         Cijw==
X-Gm-Message-State: AOAM533A6mQdkGXJkmJWi3ZZxwG6BFjl95Scowof4UyCdQc6nJMKY3bF
        wmbGAHGFdo2s3e2uv60q2slfM4kt
X-Google-Smtp-Source: ABdhPJyeNbPpKYUtHN3BMyaPOYiRi4+8aMD3PqGo+rOjiJTe64h6ddoNqrXvNHOq4d4Ruv2COPtCEg==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr49621149wrc.122.1594056576023;
        Mon, 06 Jul 2020 10:29:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm27073558wre.6.2020.07.06.10.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:29:35 -0700 (PDT)
Message-Id: <470821dc6d4b72c6414b3458883277ad36952892.1594056572.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.git.1594056572.gitgitgadget@gmail.com>
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 17:29:32 +0000
Subject: [PATCH 2/2] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is consistent with the definition of REF_TYPE_PSEUDOREF
(uppercase in the root ref namespace).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a2fd42364f..265767a234 100644
--- a/refs.c
+++ b/refs.c
@@ -676,10 +676,9 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/worktree/") ||
-		starts_with(refname, "refs/bisect/") ||
-		starts_with(refname, "refs/rewritten/");
+	return starts_with(refname, "refs/worktree/") ||
+	       starts_with(refname, "refs/bisect/") ||
+	       starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
-- 
gitgitgadget
