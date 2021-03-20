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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836FAC433E1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4675B61988
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTAEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCTAEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F62C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so8132801wml.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ftj6qMkNmrnsXmtUxcUDofo5ZMdWVt4dfoOIo49gQVo=;
        b=Db3C2AYS2hsGiLS0EefO6Emj/KkHkPWYoFJo6cvxgM4/D/ToH4cCaRWzEb2QwYKirm
         tqi7QLTwjzZ2sBPyK53Xrrkip4yAGxzp1Q0wcsPfCO+1xWGfY3vWJBU3xMYHuCff/hQO
         ZiXZl0RrUFl4HbZtP7oiZtvezimLVHVBHLVqqAekYE3IiUf+P0spxb8q8BFaZA0Pvbmb
         aUcHZvlrtRXdLMQ+jqr5p7NU66iOdSWfHZ+gipab+6xJmhMt4jz4F2OmpEtlywihrXq+
         Fjt8Pmrvs7UfwwPiHtlL7fteI3qrowYLpnTtGm+yjpDjbPmVu3VSmOccNg66Akf2AML8
         9ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ftj6qMkNmrnsXmtUxcUDofo5ZMdWVt4dfoOIo49gQVo=;
        b=Y7+9YAnnAW2Or6epnblb82BmiqU9XrmUbOJt7eM4vvT9WyXE6uC/b9yvpjGIW9g6Z6
         0fvRlxpjj+Lv9+8CUsMu19c+DYj3mig0xfzs12zTE6JaOJ2gThfWqKnSfD8eZ299XJ2b
         dGutEf7lq1V9lvYnsWC9ImmM6GXCt0jmwENhv/IRpapuSbeW9J8mk2Aases/y07KB2YP
         auZm+QtOehKezFEVrH8AucCL1OAcNsOwPohlihvbUcZWlXJgRQ5YE38O//gW/bul7zP2
         bdrb8E2K7DSxAZPRkY4CcpziYtSHRok7DvPOS8Ix8A3XJ6E54FY0iE+g7Ce/IcsQGfnf
         LK1A==
X-Gm-Message-State: AOAM533Qip7ASrxFy0juGY1XxfHhV/JWcR4DdOqrJVUzrTKrTjZG3Ykz
        4UBBBuVFGhKOWQORmjHXtxrg8S3FcLg=
X-Google-Smtp-Source: ABdhPJwSRTGzPg3UsvRTS1apLp0KFHlgICOmib+Oa/LHQYGfyyZIGpEzySrPAVu1xk2OfjBHgfr4yg==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr5271897wmj.54.1616198640815;
        Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm9869223wrt.17.2021.03.19.17.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Message-Id: <41fffcdd3b786c460c3a0652108212d8c361159f.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:48 +0000
Subject: [PATCH v3 05/13] merge-ort: support subtree shifting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive has some simple code to support subtree shifting; copy
it over to merge-ort.  This fixes t6409.12 under
GIT_TEST_MERGE_ALGORITHM=ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index c7083e3769aa..c4fe234d8972 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3551,6 +3551,23 @@ void merge_finalize(struct merge_options *opt,
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
 
+static struct tree *shift_tree_object(struct repository *repo,
+				      struct tree *one, struct tree *two,
+				      const char *subtree_shift)
+{
+	struct object_id shifted;
+
+	if (!*subtree_shift) {
+		shift_tree(repo, &one->object.oid, &two->object.oid, &shifted, 0);
+	} else {
+		shift_tree_by(repo, &one->object.oid, &two->object.oid, &shifted,
+			      subtree_shift);
+	}
+	if (oideq(&two->object.oid, &shifted))
+		return two;
+	return lookup_tree(repo, &shifted);
+}
+
 static inline void set_commit_tree(struct commit *c, struct tree *t)
 {
 	c->maybe_tree = t;
@@ -3680,6 +3697,13 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
+	if (opt->subtree_shift) {
+		side2 = shift_tree_object(opt->repo, side1, side2,
+					  opt->subtree_shift);
+		merge_base = shift_tree_object(opt->repo, side1, merge_base,
+					       opt->subtree_shift);
+	}
+
 	trace2_region_enter("merge", "collect_merge_info", opt->repo);
 	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
 		/*
-- 
gitgitgadget

