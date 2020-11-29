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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A10C64E7D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23982080C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGp+m9Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgK2Hor (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Hor (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4530C061A04
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so10804833wrg.7
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l+uEjOkxm94slzmtCXqPDLGdmMBiPqyT9ZMyOAakzC0=;
        b=XGp+m9AuoBl5PGPYvEqeqMMrNkG90Hmia0azXd3in1uQVDBU2fzjIrwoPHkfw3Yvaa
         K3+UBTpw7ZPWe+4E5KhFjqjxS1lBCsZniFBHfTES7Jv/XsS/LNjuKqmT9FJz9cusqC32
         5ecGmN07J52VTfSowGATRbTjBFZx6lEQgXGZNuvH/U0foAar/QoKddqX+t7B6OHkAUFR
         QsFUL6z3eIMvnS9+PewG8LumLqaxBnedGN839EhkkDjAexkZs/qbI/WcJ1H1+rX4Qw1/
         xR6jYYlE0DeUHJ0ndWfM7jR2ez4bAUv9lOJ4HAOdouFiPrQ+2I+rkgGi6lV3TYHGo1zv
         xhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l+uEjOkxm94slzmtCXqPDLGdmMBiPqyT9ZMyOAakzC0=;
        b=t6NrP5UwCykFw1Syl+keLvUMbFdVpjRwYnvIwelYPAMNw13wGGp12HvucTM7S9aP/3
         RI6kNVYxUM4+OmGdtxp2oT0MBpXzcYj/j6iIp1Jojn6W6bKx+7zu1EDx2YZioUwGT/3q
         OlhytOpqIFoZgt0zAvzfHT/FmNXZcucjpbPAXIC5i5wrm9PMEEL79IaVy7M+oCLr6aYM
         IAhuTfF1C089RqUECrQO8sm+UiM+jaoDvAz2rf2vW7EE6fH3Sym6fUb2DLiIg4lva11+
         GgG8DVbZbJSpLkaXx0BNi88Kvid9M7jtNFqdZAxwiN5VWODgSiOVAs2f0EFm6J8dl0Fj
         y7/g==
X-Gm-Message-State: AOAM533sxjYaICMLZo8wGd4UU1Bkjw39loKKdUendJMGi8uHg+lL0MFH
        /XdopyA2FVCUZD/Nhl63o1qA6t+mcUQ=
X-Google-Smtp-Source: ABdhPJz026q+F/ImwLRDPGnOfdBsdfmgMOaLIJgQ2yZGdPtF2cvSwVH0cwm+ogbed5tCaebcwx406w==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr21839836wru.352.1606635809383;
        Sat, 28 Nov 2020 23:43:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21sm23976059wra.40.2020.11.28.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:28 -0800 (PST)
Message-Id: <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:08 +0000
Subject: [PATCH 05/20] merge-ort: add an err() function similar to one from
 merge-recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Various places in merge-recursive used an err() function when it hit
some kind of unrecoverable error.  That code was from the reusable bits
of merge-recursive.c that we liked, such as merge_3way, writing object
files to the object store, reading blobs from the object store, etc.  So
create a similar function to allow us to port that code over, and use it
for when we detect problems returned from collect_merge_info()'s
traverse_trees() call, which we will be adding next.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d737762700..baf31bcc28 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -158,11 +158,28 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int err(struct merge_options *opt, const char *err, ...)
+{
+	va_list params;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, "error: ");
+	va_start(params, err);
+	strbuf_vaddf(&sb, err, params);
+	va_end(params);
+
+	error("%s", sb.buf);
+	strbuf_release(&sb);
+
+	return -1;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
+	/* TODO: Implement this using traverse_trees() */
 	die("Not yet implemented.");
 }
 
@@ -265,7 +282,15 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
-	collect_merge_info(opt, merge_base, side1, side2);
+	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
+		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
+		    oid_to_hex(&merge_base->object.oid),
+		    oid_to_hex(&side1->object.oid),
+		    oid_to_hex(&side2->object.oid));
+		result->clean = -1;
+		return;
+	}
+
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
 	process_entries(opt, &working_tree_oid);
-- 
gitgitgadget

