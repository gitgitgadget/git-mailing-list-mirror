Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97552C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9B864E77
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhBXEGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhBXEGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02DC06178B
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:31 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r24so543397qtt.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ozh311a+BORhAxJEYW4Xj3uH5cuh9nBKmwS5H6ieBsQ=;
        b=k0lOD8byVCW3nmcfIWaWduSrCc6VkGFmr4nMxgtTlkoegNGvoOXxHjHtHITI9Ueohk
         OMzC3Oa8wCH9nlBbOXqFED7+5veLBljd2ntrabi1LVN9V2vt/on4BfqmCjpMpEZBJiKu
         XPF2KbnjkHqGxCqO/tPjyQkigIagejLVWbPH3J1MHIlcHRCo4sif4bMboGaRGqZARhDA
         yGetybve1fv0ARb1qVRL3vVsn51x30XkCcmQWQm/zGQ/wQ9AmpAow6qas5fqnZeU+qzG
         oo4P+TVMFoQqcWob+Czas+jwRfavIVhCiNRFstB4658/FGyOwAJnhE4MiJzgy/MVfRWX
         h9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ozh311a+BORhAxJEYW4Xj3uH5cuh9nBKmwS5H6ieBsQ=;
        b=e5heSL3rGS+vObBCd/52NcadEdHlXsyFRQMU9tKDzC6ioFTbanrUbFjHQhSIMMFybQ
         VgDOBpN0iSzRxVqRIgj8qKbhenOSVpkHI7K5QgrEb2S7K7O/QIB1eBCYZB4YwJVYrsgZ
         ZvvUP1+6Nz4h+2vos2j37mlc/o+1UIWdPb6Cqba4wLHNuBl5jU7mY0hpWko9Puksp6Ho
         4EhBd5KDSwqFV+m8lrJDucSaegJzBU59xBahmhZXFHgLxjexZGynNo7MtIgQx6bxxnJJ
         BW/Mu+YfKScwufpsmjnwV+nYiizh+GAaMH2qShDmqz9SKBu7LKvXdzhP3H+YyJfwshNV
         lJ/Q==
X-Gm-Message-State: AOAM5336JM+2OomOePz/09/9Ovu1dIKBNP4z59uKUp8Vttr7VtVmarbl
        z2Q8owtOwlZ0tPnRcQXuolj7JEAuIyKxaw==
X-Google-Smtp-Source: ABdhPJxbOrT2ibAfvJ2N3gUtZW180BX9hgMsvrDxTuhOznT0DdEngK56vjnMl+Dm5ZM8iouUFeqJ3g==
X-Received: by 2002:ac8:594e:: with SMTP id 14mr28206481qtz.102.1614139529911;
        Tue, 23 Feb 2021 20:05:29 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:29 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 4/7] pathspec: allow to ignore SKIP_WORKTREE entries on index matching
Date:   Wed, 24 Feb 2021 01:05:09 -0300
Message-Id: <a8a8af22a03f73c572c3d45d9e7dbb0503451fa2.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'ignore_skip_worktree' boolean parameter to both
add_pathspec_matches_against_index() and
find_pathspecs_matching_against_index(). When true, these functions will
not try to match the given pathspec with SKIP_WORKTREE entries. This
will be used in a future patch to make `git add` display a hint
when the pathspec matches only sparse paths.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  2 +-
 pathspec.c             | 10 +++++++---
 pathspec.h             |  5 +++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5fec21a792..e15b25a623 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -177,7 +177,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
 	return seen;
 }
 
@@ -578,7 +578,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3c652748d5..235b7fc905 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -100,7 +100,7 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..e5e6b7458d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -21,7 +21,7 @@
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen)
+					char *seen, int ignore_skip_worktree)
 {
 	int num_unmatched = 0, i;
 
@@ -38,6 +38,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
+		if (ignore_skip_worktree && ce_skip_worktree(ce))
+			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
 }
@@ -51,10 +53,12 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * given pathspecs achieves against all items in the index.
  */
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate)
+					    const struct index_state *istate,
+					    int ignore_skip_worktree)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, istate, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen,
+					   ignore_skip_worktree);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..8202882ecd 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -151,9 +151,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen);
+					char *seen, int ignore_skip_worktree);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate);
+					    const struct index_state *istate,
+					    int ignore_skip_worktree);
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
-- 
2.30.1

