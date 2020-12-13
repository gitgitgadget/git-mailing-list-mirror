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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63475C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDFE22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbgLMIG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393872AbgLMIGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:06:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC065C0611CB
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:44 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w206so7089790wma.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q30DZV4Ul5zUbF1Xb7wjc7z6AvKBgAzBlBhRSeesxD8=;
        b=EgRTK++EToSAKkkIM3mo0C3/5mMKnrcJEvN/Ps0J6i6ZT6jlVsOyttX9JHuKUEohWl
         Z2aBF9VXIzBtWop02rF1qxWDbVVsgJddlfvMjrv849NQfA7lDEvV6WKKwIlBIrVReduI
         uMy5rNh3vF3aKaEVG1xTE+nWcv5zs9+JFisdizFRK6uRb9VViyAAAjblmbWVa9Rs47vK
         at5A5o76j1dgazbpFTzRknwhO+rVs8tEtTy4xe4ulSFnogcMCOWb8Img0mwtTZVpwYft
         eBYKo0pDmuN3Md+oACviP+U5t9vzDuASsN7bIoCbGKtH2kJtmFCVCzvYwl1S/y6Cip+n
         t6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q30DZV4Ul5zUbF1Xb7wjc7z6AvKBgAzBlBhRSeesxD8=;
        b=TqRSMSwbXma64G8/a95/MWNEqG6YvFnt3ZRzy22GYK2IJNOm/2J30De0Yh6mDdCa6w
         VCJTqs4Z+M4lzMFpH5ls9rpLB6G1GDkFD/FgbUSjnuRSGDvmIVM4Sp/bzkDstiqK/wZ7
         au9xNv+LX/8YMVX/LgBqKRC6a/P+/NEwSKzdn6U4xtYCv0YudWgzDtGc+iPQU5sypO4J
         ogReyS/IXNIRyiiMfgOTa210ldt28fRRp0I/Ee1Q3a5RfClBi3whlTDye6pUxMdBU5/G
         aUmiQrK1tTSaJa+AJk1UK2eshFeylLjQHqZk5m4r7sKSamBcGE8f+6jkJIBmvyXZ92vf
         yX0g==
X-Gm-Message-State: AOAM5318iTt7t5Tcfw4bU9Dup+cQpMw8Y4202re0vtLSDUveis+KeX6s
        F4qxfo1W9MCX+8DejNGZTfJ2Ngz3/oA=
X-Google-Smtp-Source: ABdhPJw/ZRhdM6VJP68M0TDtshNaCgWmsUL9UZq0OzriyecQIsrB2onXXruZy5WuHhRXa7ZrZWkFYA==
X-Received: by 2002:a1c:4684:: with SMTP id t126mr21945638wma.165.1607846683408;
        Sun, 13 Dec 2020 00:04:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm19128910wrq.29.2020.12.13.00.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:42 -0800 (PST)
Message-Id: <3198efe31882cac93af2d0625b4872e52697caf4.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:23 +0000
Subject: [PATCH v3 16/20] merge-ort: basic outline for
 merge_switch_to_result()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds a basic implementation for merge_switch_to_result(), though
just in terms of a few new empty functions that will be defined in
subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index a7b0df8cb08..ee7fbe71404 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -971,13 +971,53 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+static int checkout(struct merge_options *opt,
+		    struct tree *prev,
+		    struct tree *next)
+{
+	die("Not yet implemented.");
+}
+
+static int record_conflicted_index_entries(struct merge_options *opt,
+					   struct index_state *index,
+					   struct strmap *paths,
+					   struct strmap *conflicted)
+{
+	if (strmap_empty(conflicted))
+		return 0;
+
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
 			    int update_worktree_and_index,
 			    int display_update_msgs)
 {
-	die("Not yet implemented");
+	assert(opt->priv == NULL);
+	if (result->clean >= 0 && update_worktree_and_index) {
+		struct merge_options_internal *opti = result->priv;
+
+		if (checkout(opt, head, result->tree)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+
+		if (record_conflicted_index_entries(opt, opt->repo->index,
+						    &opti->paths,
+						    &opti->conflicted)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+	}
+
+	if (display_update_msgs) {
+		/* TODO: print out CONFLICT and other informational messages. */
+	}
+
 	merge_finalize(opt, result);
 }
 
-- 
gitgitgadget

