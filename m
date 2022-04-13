Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiDMUEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiDMUE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEEB7B10B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4664130wme.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFI3cRmC6pe0JsWsXgxWU9gQmpy/VHl2mdKujlQOz30=;
        b=UY28qlR+w6K4RBeocjpBoDJmZP3eTWxo2eG7EhzWWqyqM8BtGuN3Qc+NFeyOfrUsJv
         9xHlvOmfuteJ+ClIm4HwmBRMw5Ao+r6DrBOv4ov65c3HAyUMacnpn7248AgsqPnacrw2
         e+kVoRBWEqVttNGagT4T5ycpbFivt6o6/DfnpxWmVRVSQbrfp0cuHAKkU8n/8ceoDOi3
         nsP0AFYJ4aje7Y6VGBLQUSTNTdoVaZfoUtH+H64O/xMJGcDu7jse2kcDvWhlMZcNmLoo
         lLqYI2u3JG0vltAQAuxDYrOaEbzBRsK8c0BWnIOvC/19d0KV1FbLi59ZFgwffJkFwyji
         v2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFI3cRmC6pe0JsWsXgxWU9gQmpy/VHl2mdKujlQOz30=;
        b=3AhEh9DMjBn4lvEE7SmPDYlzVvF0PfpRlDDPYAJGAfwm6bd1bCxm261ukbPlI/KqAO
         mW5HaY9ruPl/aVpClQD2zpSjwzqI209Fw4ZCKE4j0e5BQJ0vh3IQwEq0vI42GCeaaoiK
         TWX/S5EYTQGbMIzsYW2al34jCNjJmSTEBop0AvMFWhtfhEJg3T0FZK9FYHJrYBAs2n9M
         ghFaohvoJUyXEQxSLAiTbv//33/wFaqIg0+D45Aw4U+ZZc22vvs7jFsiTW43RYCublwX
         Vvdp3nSme4MjdQbne3lKmcq4Ww/N+he0qJb8bgFG1vuuwCyrWstKWUcZimHGfJqP+OGc
         1mdQ==
X-Gm-Message-State: AOAM532DwOP8agzBITiqX8WCqT4YBwfvkpI/TPwr8pj9vxrCBER80+9r
        cFjKI45Zc7J61yNE2aQI83xjyUsUCcuoEg==
X-Google-Smtp-Source: ABdhPJy62hS26ZtqJugFHeS8ra+5b4Kk3cPMgS7phhQkCGpAzm/dpu1KREDadXN5Qe6isxxa/CSFFQ==
X-Received: by 2002:a05:600c:1e85:b0:38c:ef05:ba5d with SMTP id be5-20020a05600c1e8500b0038cef05ba5dmr284192wmb.119.1649880125454;
        Wed, 13 Apr 2022 13:02:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:04 -0700 (PDT)
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
Subject: [PATCH v6 05/27] cocci: add and apply free_commit_list() rules
Date:   Wed, 13 Apr 2022 22:01:34 +0200
Message-Id: <patch-v6-05.27-9eada36dacf-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

