Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D039C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FB6113C
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhDHUmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhDHUlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0953C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g20so3723653qkk.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZLa4mTWDPJPdVgUASdSPKkYYnPcQU6HiJPkJWeDCDE=;
        b=cFvtjoFHeWjc3o09ZZLB2lRf7aHz2MBgeZh+VG67KEmMgRBO4fARue5cAvmegkmQnp
         Q8ALExSeK7ZfMTfdtHY4VTLHSku+RWAz+b2L20zLnJfwh9cHXXSbS6M2Ot1FkoGFSThj
         OvFrm1y1A9ipv23egCtX8CqzO8JaQ6pPqd628NWwFM92p4uRNfSAR/iw5uay02xIBDiC
         B4QS5f3O0CfgbMXt5WbvljCJJwC0CUgl1kkv+RQDKqG15oCl5ts8L04IINGYkMTOMf0y
         LnehKXgv8LcmyM7en+kpRSH8SodvyWHrieaXVJbWt1wUsxM/JpfRE0Sjc1kTKcRyaUPP
         dhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZLa4mTWDPJPdVgUASdSPKkYYnPcQU6HiJPkJWeDCDE=;
        b=Ze8ieZJX6MvUPs6hHI8BFvUF7IXBKk0/KFrsZGyQwIp194t7vHM+cJitYZ86TVWYQC
         jIHnSEsXIDe41KSdYlP0iGqYaD97FLwgzOPYKmjo498gfh86+3bUC7LDvQy3MjQQ46XR
         paxznlzMFvljHCKVurnYyn1710goswj/pBLuL9FPe0t4B60rkRui7dA/nMgZ6dKip4Xy
         KjkPjutwLSP91L1KpzTe+Gj8IP2s38dkeu8oRWTgcBDQpHJnlFuZgBpOKq9+aIOvX9OR
         FtyMN16+WaSjvJWSgQ3bWbXst1pjF3RUWLnWMX1uilkbHQgotU7Bo3ppODyQckEZdbjb
         +8Yw==
X-Gm-Message-State: AOAM531ijM7WM1qsRMlm4IHs30i4DNXN9j3rqWn4DPQWOUM6Zi6SyATM
        QjP7iALJMweynaLe5UtmNKRbQWqJMJj8dQ==
X-Google-Smtp-Source: ABdhPJxC+3XxUtJvMVtSaSnypfW/gdIbRC62RO6naEy1QL27tdCAp8HjK3gnPaZO9cleW3deDq4hog==
X-Received: by 2002:a05:620a:e1a:: with SMTP id y26mr10666550qkm.280.1617914502808;
        Thu, 08 Apr 2021 13:41:42 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 4/7] pathspec: allow to ignore SKIP_WORKTREE entries on index matching
Date:   Thu,  8 Apr 2021 17:41:25 -0300
Message-Id: <a6e98b17eb5f4770367cf336832d92c5017e0af7.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new enum parameter to `add_pathspec_matches_against_index()` and
`find_pathspecs_matching_against_index()`, allowing callers to specify
whether these function should attempt to match SKIP_WORKTREE entries or
not. This will be used in a future patch to make `git add` display a
warning when it is asked to update SKIP_WORKTREE entries.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c          |  6 ++++--
 builtin/check-ignore.c |  3 ++-
 pathspec.c             | 10 +++++++---
 pathspec.h             | 10 ++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5fec21a792..050cb8af30 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -177,7 +177,8 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen,
+					   PS_HEED_SKIP_WORKTREE);
 	return seen;
 }
 
@@ -578,7 +579,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+			seen = find_pathspecs_matching_against_index(&pathspec,
+					&the_index, PS_HEED_SKIP_WORKTREE);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3c652748d5..0f4480a11b 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -100,7 +100,8 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index,
+						     PS_HEED_SKIP_WORKTREE);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
diff --git a/pathspec.c b/pathspec.c
index 18b3be362a..8b05575110 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -21,7 +21,8 @@
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen)
+					char *seen,
+					enum ps_skip_worktree_action sw_action)
 {
 	int num_unmatched = 0, i;
 
@@ -38,6 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
+		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
+			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
 }
@@ -51,10 +54,11 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * given pathspecs achieves against all items in the index.
  */
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate)
+					    const struct index_state *istate,
+					    enum ps_skip_worktree_action sw_action)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, istate, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen, sw_action);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..0feb8e9f67 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -149,11 +149,17 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 		return strcmp(s1, s2);
 }
 
+enum ps_skip_worktree_action {
+  PS_HEED_SKIP_WORKTREE = 0,
+  PS_IGNORE_SKIP_WORKTREE = 1
+};
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen);
+					char *seen,
+					enum ps_skip_worktree_action sw_action);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate);
+					    const struct index_state *istate,
+					    enum ps_skip_worktree_action sw_action);
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
-- 
2.30.1

