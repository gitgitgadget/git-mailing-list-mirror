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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F02C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A3664F38
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhCQV20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhCQV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z2so3308374wrl.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ftj6qMkNmrnsXmtUxcUDofo5ZMdWVt4dfoOIo49gQVo=;
        b=JihzdWqVjOgCgr3WM/X8ZsSOUu97jZcoqOXyqL7H9qvrmbBfNL4oiShyhkSuX+gbv3
         XztiHUj7e4kLtYRVNsI2nmUq7jUz1HQKkUflUZfvBF/GNsXclsMo9HIMsiHH0otvWmbK
         0CnymyLvfcNgCixEHYGWKLCDpx90GgbyVgNs6G7RBKuKaOPw6CXFCdgLaC18BJJVRXX5
         nYLNzQ7RlxEQE6/76A5uK4nA66E/wWz7FGdv8mUwvyunJLOoRquf2irXuFIkUqber5kH
         m2qzQSMOBDqqdQqN1Tda6rfNxBcl4Sg0RI1bqI/Td/pIRM1f3oPZrwukfuZ/0O0cktGv
         jJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ftj6qMkNmrnsXmtUxcUDofo5ZMdWVt4dfoOIo49gQVo=;
        b=mIf2xe9FK2CEf3od/LuY5rcmWX0hYfbpG9JgBvgQc0WmHJxkbuVgLyzsbASK1HeGlS
         Z7zfJNYc7R1a14ny7cFb/kl2xMDY+NBj11s1fpxRcptqDFvk/MJ8dtS3RoO+hIMjoZ0t
         BRZ6cU2mxqkj5kgHvEXF+bO8tabrYD5cTBvg5G+KyjNZdbagPSrJDPvQwXWMiyucWaaK
         g211XZQX8ZS+weNDHU7g5dcCt8se5djC6mHVa771WZf2OzvY7kCLgh6LOWKzk2k03OG1
         rIaZ1pj72kNRe0gaGJEbNi5EYS7UEqaWse45/X5soAJ6bdxhGDBsJ8657dnw2whtmYF4
         oViA==
X-Gm-Message-State: AOAM533QDQxBs5WpKZGRXecG/QroxmstY3lmWtWZYI4myX8bcJhWDQaA
        i6gXqZnUMUuJWeWj35qXJ8ryXx+ELf0=
X-Google-Smtp-Source: ABdhPJxh0GgPz7AI7ZUqjNDuC6a2q04G97ZAZEpGmMjGMmS7KKPi8pCaKY266fIiZXBOkpFvw+6VDw==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr6112172wrs.43.1616016489762;
        Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm218169wru.46.2021.03.17.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
Message-Id: <41fffcdd3b786c460c3a0652108212d8c361159f.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:57 +0000
Subject: [PATCH v2 05/13] merge-ort: support subtree shifting
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

