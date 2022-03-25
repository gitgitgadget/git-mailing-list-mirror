Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BDFC4332F
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiCYRaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbiCYR34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B334192A9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so11186167ljr.9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EXIwRJq7h/kj2WetiHGBxPZsMepCOcwJay29fFJg9A=;
        b=XghFNw06aXrl2ALAhjybusGj+JKEw5cVyc5iv42yf0/9V048Cy2IuqZYZjyMKApbAS
         DazaA4TffQBDBiz6IhXF0aRb0LrFUL0NyTN4Od7B06fauc0LhwUg8TvyYHnD7Ei17t2i
         hiD3Uay6YzVWFBCt+p0IaBRM921Q/Vhnl1oiYYC0J9NDbGILnAurEjVbvVB/LUdVFtrR
         5LXci1Txsu6I9t2nvwvQI9xzKspESeXd7cf6u4eY89rMFZyyIf99Kiqbu6ND25Hvkd9X
         7SKHSNnWd4HXRyOtIYhvdHaCXPSocYo5N8GY4plnCSYOb+8cZD3wrv92IFmTMtFMcphv
         ahNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EXIwRJq7h/kj2WetiHGBxPZsMepCOcwJay29fFJg9A=;
        b=DMao+9Ot4wO9XL/GDEK43vluPiQocQvF7L0IC9jljNQlAT7h6N29hexSbfAF1r2LDJ
         de8hcCdNJ/Y17ghZuikXeE8pRzXOPfvXNhV3+6RXxVr4KThtOekW18o1RyZQ6khGP16x
         Lvqg9Y17gcdlCxjGMGQpboobRaIn2tpQOHeOJZEWKNugFtvDtvPyRGIHJiRqHwOQLlYb
         pDemvS+XU2EN+HyQxFbcj3chrKactKaNQ4820znPQ20axMx+xn/TCybopT7+Ondb2iy3
         /83iAn6Q0A1nOvIqGah+/QcTlBlH++8Gtip1iu3ATrkTITITbBil98aBI2qKyrb89AvA
         gLkg==
X-Gm-Message-State: AOAM533+V+yLkWb9BasThPqcaQQvmqPWpvZ+WNvZuXVLrXDc2hT8NkeJ
        djqzA01d24oukCfp14Jc7bEWSs6cvItxvQ==
X-Google-Smtp-Source: ABdhPJw+mFd62PqusoeMd8exP3fd3KNBfj1q/tFAeic33mL5A02SzAMPhBz0HzhNBOQBU2IcNK9XyA==
X-Received: by 2002:adf:db92:0:b0:205:9c92:f1e3 with SMTP id u18-20020adfdb92000000b002059c92f1e3mr6002439wri.515.1648228780311;
        Fri, 25 Mar 2022 10:19:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/27] revisions API users: use release_revisions() in submodule.c edge case
Date:   Fri, 25 Mar 2022 18:18:33 +0100
Message-Id: <patch-v3-09.27-5f5c0d26395-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() on the the "struct rev_info" in
show_submodule_diff_summary() where we'd otherwise need to do the
equivalent of pre-initializing the "struct rev_info" with "{ 0 }" if
we were going to add it to the cleanup being performed in the "out"
part of the function, let's instead introduce an "out_no_rev" for the
reasons discussed in the preceding commit.

Doing so for the "goto" on "(!left || !right || !sub)" added in
8e6df65015f (submodule: refactor show_submodule_summary with helper
function, 2016-08-31) would have been straightforward, as in the
preceding commit.

But for the case of prepare_submodule_diff_summary() failing it's less
straightforward. Reading the pre-image we could simply retain the
"goto out" if it fails, because we can see that the first thing it
does is call repo_init_revisions().

But having a hard reliance on that would be a bit nasty, as we'd
potentially introduce a segfault if the function did some other
initialization first, and early aborted if that failed.

Let's just fold that helper function away into
show_submodule_diff_summary() itself, which was its only user. Now
following the flow of initialization is more obvious, and it's
immediately clear that the "goto out" if prepare_revision_walk()
returns non-zero is safe.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0510cb193b6..1dd61476307 100644
--- a/submodule.c
+++ b/submodule.c
@@ -477,28 +477,6 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	 */
 }
 
-static int prepare_submodule_diff_summary(struct repository *r, struct rev_info *rev,
-					  const char *path,
-					  struct commit *left, struct commit *right,
-					  struct commit_list *merge_bases)
-{
-	struct commit_list *list;
-
-	repo_init_revisions(r, rev, NULL);
-	setup_revisions(0, NULL, rev, NULL);
-	rev->left_right = 1;
-	rev->first_parent_only = 1;
-	left->object.flags |= SYMMETRIC_LEFT;
-	add_pending_object(rev, &left->object, path);
-	add_pending_object(rev, &right->object, path);
-	for (list = merge_bases; list; list = list->next) {
-		list->item->object.flags |= UNINTERESTING;
-		add_pending_object(rev, &list->item->object,
-			oid_to_hex(&list->item->object.oid));
-	}
-	return prepare_revision_walk(rev);
-}
-
 static void print_submodule_diff_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
@@ -642,6 +620,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct repository *sub;
+	struct commit_list *list;
 
 	sub = open_submodule(path);
 	show_submodule_header(o, path, one, two, dirty_submodule,
@@ -653,10 +632,22 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	 * all the information the user needs.
 	 */
 	if (!left || !right || !sub)
-		goto out;
+		goto out_no_rev;
 
+	repo_init_revisions(sub, &rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.left_right = 1;
+	rev.first_parent_only = 1;
+	left->object.flags |= SYMMETRIC_LEFT;
+	add_pending_object(&rev, &left->object, path);
+	add_pending_object(&rev, &right->object, path);
+	for (list = merge_bases; list; list = list->next) {
+		list->item->object.flags |= UNINTERESTING;
+		add_pending_object(&rev, &list->item->object,
+			oid_to_hex(&list->item->object.oid));
+	}
 	/* Treat revision walker failure the same as missing commits */
-	if (prepare_submodule_diff_summary(sub, &rev, path, left, right, merge_bases)) {
+	if (prepare_revision_walk(&rev)) {
 		diff_emit_submodule_error(o, "(revision walker failed)\n");
 		goto out;
 	}
@@ -664,6 +655,8 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
+	release_revisions(&rev);
+out_no_rev:
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
-- 
2.35.1.1509.ge4eeb5bd39e

