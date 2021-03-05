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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ACDC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBAD6500A
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhCEAzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCEAzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BDC061760
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d11so232377wrj.7
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZzgMfaPXSLniEgS5NzuFkxH1zntUo1RC9iPpEaSe0jk=;
        b=USxzTgDjgu953EDJJpVZSahPRx3Mvyx1Sr3/eCZwPfRn7uM+cObheWeWlsJDnsIal1
         5O0QpELWGyxlCAeFMiMppZXZszKivcaRG6s2NmZzPmNJSdLinY6aRWnFa8a+zgCf0ri5
         UjnZQg6NM0dw/8IvEj5dcH8FNKzlceiisg/4wuKqPwJ+ehKAtJE6khEDXcipWYEJMn6w
         uAWRKcfp9munFF4GTJEhwtpKNjb523L4kivPGs1YYFGVfcbcDSrPzZghPN9IgYDR2MNt
         wYPrN7ncn+CjZ5xmEtBXBAh4VG0gs4P6ZLtnaS7eR8wo2pN+wljjrlTQK7C14fs/oKr3
         re0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZzgMfaPXSLniEgS5NzuFkxH1zntUo1RC9iPpEaSe0jk=;
        b=RHC+p6rpDe2D1CUXkxa1Ne0Dl7Hgl/Ct5x8m97uU4t7OmiFP/mhAvaA/SFH/a8yFCW
         j43KdCdwDvPxP/lGUw1NWiIQNU55h0V43utjcsrTvNXc8Bai2HpUfLI9v+uL2fXsr+uq
         Bmj7xSh5baW7qIPxytpsJpQEl9c8voIma1KtYbkdmoh2ivXiJDlA3jxmZmQYDHemOcTE
         ThpMmLQBBfOC7XjOlB/balFVfzbLGs3FKBHE/DqnncYaa3zH9Ef5iFxoW5Cz2KGkaGL+
         gtM6K8zfhGxx69p/+eTpqhxjmIXV+IZC5vYrzyHylLK2OPJm9bFv076nvbzQCiqiPsQf
         3GUw==
X-Gm-Message-State: AOAM530I0R52driOKG6AVmGhFaUUkylEc1SmXnzTt7FZ5bJQ2WkTQnDn
        eRrn7r4j4bQ4IF0WLQyHc0v7CY+2pyk=
X-Google-Smtp-Source: ABdhPJyinJKJrLciuVrkxQGHvnem3YQAeG0LzaHnBh9kJQYdSoMWsVDUj0JMF6v9iE0wy0tdChZpPQ==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr6769826wrw.235.1614905742631;
        Thu, 04 Mar 2021 16:55:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm1635751wrr.7.2021.03.04.16.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:42 -0800 (PST)
Message-Id: <d04ddabde124c165a1096c1a1d72490b2e399138.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:32 +0000
Subject: [PATCH 06/11] merge-ort: support subtree shifting
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
index c4bd88b9d3db..a998f843a1da 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3417,6 +3417,23 @@ void merge_finalize(struct merge_options *opt,
 
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
@@ -3544,6 +3561,13 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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

