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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62EC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EB422B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgLOS32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgLOS3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35242C061282
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:13 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so137517wmb.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lTMgcVB6vgszaz4Tdvquin0z9C4VpWH2bLbPz0t6/YU=;
        b=pZC0afmh6Jz8fgGmCwHSQfq2nPfs0+AVqBlq1jHS8AlQOyq6CXeTUd2Y6T5dSITtGo
         Q+3lOtjSio1/QBZal7BE7CGyENIWZ+tSofuvJWVuTZYwa3zRrL54rsXZzuUqTi1FRUNy
         1OR1SG7l/lkYwIzjVrnq1ekbVHvHDpj0E6dcJXfhvdCsFZXx9DLwarZxZz2lsdOr6ZEf
         jBm5NRaWnax1E+g5KuubIHT3W5rn0rhueFydly3CEf8nSKyi7rRWKDKIeLCt+fVqzwqn
         slj5LcoadXmNtrnYtXPPr0YLWHwmOyyw54Qxta09y1t6zPJkeoO94Fcctj+FJkTgzbVX
         dKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lTMgcVB6vgszaz4Tdvquin0z9C4VpWH2bLbPz0t6/YU=;
        b=dJXFEGL80s5dNTzLTY9Hv5uhWwQ9+V99G0A7MjES5hi4NQfs36C5FLohsgTgIAuPOr
         er2HB4FaEBuo2WJt/f7KOofWQCX94rVMgm2jdGwWrL+rjj+hMdXbqvLelMvprrRntKza
         4hY75rvo7a4xfjtKmKIB44dpyDFQFUAadmgyID85O1N+PoLIWHLU/JESGIliTDa35n7p
         cWAkqo4BavPb7L508MOj+hZYPmX36jrxf2g2XIPdPMzOYO8nYsPSn3biwT4h9TpzxOY5
         4NeEV5fYL4ezl1tgmE/+zrC+nfQubNRvB+iHPGexk50CCSfoU6KexJn8V4WrYdojqJhQ
         C5qA==
X-Gm-Message-State: AOAM5334A7PXMVRj7by8ZSHPMPuLBSLGPF1couDGLDlh1YK1GBskk8BC
        e9XwwsAUVeUGnNtqHp6LNMw6o182URg=
X-Google-Smtp-Source: ABdhPJwMhIRvBYjxCCRwDUgrKlQpGFyW+f3+uXgQTiqGiLUwipVk5tKxlLv0YjuON/YA+jKGYQLcxw==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr203490wmb.70.1608056891792;
        Tue, 15 Dec 2020 10:28:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm28508589wrv.44.2020.12.15.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:11 -0800 (PST)
Message-Id: <9382dc4d50b3cf675d607cf5d39be08542d8147e.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:27:59 +0000
Subject: [PATCH v3 04/11] merge-ort: implement compare_pairs() and
 collect_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 66f84d39b43..10550c542b8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -652,7 +652,10 @@ static int process_renames(struct merge_options *opt,
 
 static int compare_pairs(const void *a_, const void *b_)
 {
-	die("Not yet implemented.");
+	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
+	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
+
+	return strcmp(a->one->path, b->one->path);
 }
 
 /* Call diffcore_rename() to compute which files have changed on given side */
@@ -698,7 +701,35 @@ static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index)
 {
-	die("Not yet implemented.");
+	int i, clean = 1;
+	struct diff_queue_struct *side_pairs;
+	struct rename_info *renames = &opt->priv->renames;
+
+	side_pairs = &renames->pairs[side_index];
+
+	for (i = 0; i < side_pairs->nr; ++i) {
+		struct diff_filepair *p = side_pairs->queue[i];
+
+		if (p->status != 'R') {
+			diff_free_filepair(p);
+			continue;
+		}
+
+		/*
+		 * p->score comes back from diffcore_rename_extended() with
+		 * the similarity of the renamed file.  The similarity is
+		 * was used to determine that the two files were related
+		 * and are a rename, which we have already used, but beyond
+		 * that we have no use for the similarity.  So p->score is
+		 * now irrelevant.  However, process_renames() will need to
+		 * know which side of the merge this rename was associated
+		 * with, so overwrite p->score with that value.
+		 */
+		p->score = side_index;
+		result->queue[result->nr++] = p;
+	}
+
+	return clean;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
gitgitgadget

