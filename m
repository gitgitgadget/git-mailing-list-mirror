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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF1C43381
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6226D6528C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCIGZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCIGYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC4C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b18so13922587wrn.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AUKeDKPuqxhv/6Lfxp0d9Im1h1wJr9EUYccuGbNuGZg=;
        b=QTvXDAt7JfT3+TuuaSF4qx6DMa8xnJ9QgEQt/OKi6x8xiZlp38n6Gki+EgPcjBE2jd
         SLfnrEvSfFnjW7dHgE5c6FlBO/l/gk2Tu7SupLbPXfgEoFgo06N3gn1Z0yhP84LzbUjL
         50vRtrEWlZk7fUSCS6q6+bwLVGhDJD+fjoUvOSkBgg9FsxPGGH+0DK2PW3d7ct9FCGMz
         Wxj9t6M+hLr7/L97zkT8G1rePrJLDnXXBn8ZT6Rr6ZXyuIgZMB1xEYU5LSjgnoRn2KcM
         /Izga3skVDFkP10tPGhmwRT7OjMveeEBmtSKYdfa7DUy8ZkJBI0hbX2gxtZBErdda/dp
         f59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AUKeDKPuqxhv/6Lfxp0d9Im1h1wJr9EUYccuGbNuGZg=;
        b=lapFxSW8G4P6TJKEHVo9BeraqGk6zKHcHVf5pry9IF/LT93BgqFhZ6/yWh/4+IsqLa
         r5XsarZkCJ0/5e6WxGh/HuL51KPfUPSuZimz5EODs6Wfk+qScytrKAUM42CzCrKpbtvN
         Ay5BHljXt2tMtmLVVoFwoyMQdRfd9tynmLDFFiYQH5tR6gKcqOHeNsQUhM3/wnpbVeI5
         969ztO7v+pB3I4Rr8Ykp0DHLT4vZuHArCHaKiyl2NxkSi0uTLy0h875JdWemsjbkH8N7
         mo9LriiVROkluPw81KPNN9THBbADvmKEtF64t7uCOm/vPB3cMO84g6VXEiuqDYIRfLsH
         rZSQ==
X-Gm-Message-State: AOAM5336CmS9WktEiyJADOhBTOACGQE/e3IlSLhgVZaKA4NBlKivtaLp
        t76scAhXUHXh5MLnSnCg5x9MFLg4fdg=
X-Google-Smtp-Source: ABdhPJyo9Rh9yQUJ100TZTrWAYPBQc+jrKXfWGm+hX7oD2lMDGnPdXD4ud9AldeQPvTQKQHRfxg35g==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr26048378wrd.424.1615271090597;
        Mon, 08 Mar 2021 22:24:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm2266198wmp.30.2021.03.08.22.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:50 -0800 (PST)
Message-Id: <e21eea71e70733a035031bd4e97957b08bc6b22a.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:40 +0000
Subject: [PATCH v2 05/10] merge-ort: support subtree shifting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index db46f496cb82..cfd956a3f435 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3416,6 +3416,23 @@ void merge_finalize(struct merge_options *opt,
 
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
@@ -3543,6 +3560,13 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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

