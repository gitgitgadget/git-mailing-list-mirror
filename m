Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D54AC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354496AbiDBKvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354475AbiDBKvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2171403EB
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b24so5658678edu.10
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLGYQg3ylXDMwVJtYaP9VqtGSTKZZVpzngu+i3xfZWQ=;
        b=AoxRkUkggPg3xZb9WThuemgwUyE1hrm+Etpqcb9y31hJa85ij0l1xSk85jP4JLHu0r
         ZmaxNrgTempErm01Bs7NQYEFyaUPP7QsTIdhI3Yb1DFZEi1MfelIYOAWMf/xd3tiOBTW
         mW72CEKPnNCyT4ZvXiwF+QdSWFtKYSRKe9B9W1TlDfVsGV4UbKfyB4MCxsykXeIR0/P/
         VMZQdFMwiS2gGwgXuqfV9GSmwDyeoDxxIoybeaGKQK4bnwq230Gs0EKxGGFPEAbcC/jB
         ZpEAEP+xFMD6U9El42dSfUehRwbl3Yp1lmyJtOJMBYFQllVJW5Ykswtnyijk06cEofxR
         ubww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLGYQg3ylXDMwVJtYaP9VqtGSTKZZVpzngu+i3xfZWQ=;
        b=T6m/C2xrbnx1FxF5lfylvURhKoYBPyOa7JNcQO5Um0zSosEoI3LGl11a2IWhloX51Q
         1ajpCjYxtPuk60cpAGUyDwF1Pq5kXlBCareuiFk+/PT4FUkA/MaHoMIPsi5jflWdCWXV
         OxH5YciaN48XdtOZpW1p3qcCfcPK1iOBFKX1FARrMx6DW0hzWlMy3ZJuE2HROmhOgMc7
         8KzS/5fbCk7AufCpq8AC9qx3tgZt7d+hx160xW6uepKfTi80PEtuFstmmU1mvJAkASE+
         +ZN9R82Wzk5mV40VpHjKL1A7TNLQJvbyp0R4RrvhxBJz3rbt04vNG9k+T4mM4JSBexaL
         Oq8w==
X-Gm-Message-State: AOAM531zqdnKKs/xfzSRGy62+L5o8LyG2zxfC2vtXZs3YbOiHPMR+P4w
        1PNg9IY2hyZ0sFOhI+1z5kzBXYeBpnzhtQ==
X-Google-Smtp-Source: ABdhPJyW4Enhsjwx0G9AgOZ023xZ8xxl/bF5u+j3mV4kaxbSetq2wW2cxkUE50QCKujLcAqhXpbmeA==
X-Received: by 2002:a05:6402:5243:b0:419:4ce2:cb5c with SMTP id t3-20020a056402524300b004194ce2cb5cmr24946152edd.151.1648896589774;
        Sat, 02 Apr 2022 03:49:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/27] cocci: add and apply free_commit_list() rules
Date:   Sat,  2 Apr 2022 12:49:19 +0200
Message-Id: <patch-v5-05.27-c38db28f920-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and apply coccinelle rules to remove "if (E)" before
"free_commit_list(E)", the function can accept NULL, and further
change cases where "E = NULL" followed to also be unconditionally.

The code changes in this commit were entirely made by the coccinelle
rule being added here, and applied with:

    make contrib/coccinelle/free.cocci.patch
    patch -p1 <contrib/coccinelle/free.cocci.patch

The only manual intervention here is that the the relevant code in
commit.c has been manually re-indented.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rev-list.c            |  6 ++----
 commit.c                      | 19 ++++++++-----------
 contrib/coccinelle/free.cocci | 27 +++++++++++++++++++++++++++
 revision.c                    | 17 ++++++-----------
 submodule.c                   |  6 ++----
 5 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 572da1472e5..07c0ad11d8d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -213,10 +213,8 @@ static void show_commit(struct commit *commit, void *data)
 
 static void finish_commit(struct commit *commit)
 {
-	if (commit->parents) {
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
-	}
+	free_commit_list(commit->parents);
+	commit->parents = NULL;
 	free_commit_buffer(the_repository->parsed_objects,
 			   commit);
 }
diff --git a/commit.c b/commit.c
index 59b6c3e4552..9628716bf2f 100644
--- a/commit.c
+++ b/commit.c
@@ -407,17 +407,14 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 
 	if (item->object.parsed)
 		return 0;
-
-	if (item->parents) {
-		/*
-		 * Presumably this is leftover from an earlier failed parse;
-		 * clear it out in preparation for us re-parsing (we'll hit the
-		 * same error, but that's good, since it lets our caller know
-		 * the result cannot be trusted.
-		 */
-		free_commit_list(item->parents);
-		item->parents = NULL;
-	}
+	/*
+	 * Presumably this is leftover from an earlier failed parse;
+	 * clear it out in preparation for us re-parsing (we'll hit the
+	 * same error, but that's good, since it lets our caller know
+	 * the result cannot be trusted.
+	 */
+	free_commit_list(item->parents);
+	item->parents = NULL;
 
 	tail += size;
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df96..6fb9eb6e883 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -2,13 +2,21 @@
 expression E;
 @@
 - if (E)
+(
   free(E);
+|
+  free_commit_list(E);
+)
 
 @@
 expression E;
 @@
 - if (!E)
+(
   free(E);
+|
+  free_commit_list(E);
+)
 
 @@
 expression E;
@@ -16,3 +24,22 @@ expression E;
 - free(E);
 + FREE_AND_NULL(E);
 - E = NULL;
+
+@@
+expression E;
+@@
+- if (E)
+- {
+  free_commit_list(E);
+  E = NULL;
+- }
+
+@@
+expression E;
+statement S;
+@@
+- if (E) {
++ if (E)
+  S
+  free_commit_list(E);
+- }
diff --git a/revision.c b/revision.c
index 7d435f80480..4963ba7def8 100644
--- a/revision.c
+++ b/revision.c
@@ -1456,10 +1456,9 @@ static int limit_list(struct rev_info *revs)
 	if (revs->left_only || revs->right_only)
 		limit_left_right(newlist, revs);
 
-	if (bottom) {
+	if (bottom)
 		limit_to_ancestry(bottom, newlist);
-		free_commit_list(bottom);
-	}
+	free_commit_list(bottom);
 
 	/*
 	 * Check if any commits have become TREESAME by some of their parents
@@ -4080,10 +4079,8 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * boundary commits anyway.  (This is what the code has always
 	 * done.)
 	 */
-	if (revs->commits) {
-		free_commit_list(revs->commits);
-		revs->commits = NULL;
-	}
+	free_commit_list(revs->commits);
+	revs->commits = NULL;
 
 	/*
 	 * Put all of the actual boundary commits from revs->boundary_commits
@@ -4220,10 +4217,8 @@ struct commit *get_revision(struct rev_info *revs)
 		graph_update(revs->graph, c);
 	if (!c) {
 		free_saved_parents(revs);
-		if (revs->previous_parents) {
-			free_commit_list(revs->previous_parents);
-			revs->previous_parents = NULL;
-		}
+		free_commit_list(revs->previous_parents);
+		revs->previous_parents = NULL;
 	}
 	return c;
 }
diff --git a/submodule.c b/submodule.c
index 86c8f0f89db..9b715b4a5cb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -645,8 +645,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
-	if (merge_bases)
-		free_commit_list(merge_bases);
+	free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
 	if (sub) {
@@ -735,8 +734,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 
 done:
 	strbuf_release(&sb);
-	if (merge_bases)
-		free_commit_list(merge_bases);
+	free_commit_list(merge_bases);
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
-- 
2.35.1.1585.gd85f8dcb745

