Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A288201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756640AbdEKWEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:48 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34414 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756393AbdEKWEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:46 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so20140315pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLqkxbD9R7hDFbmz51dlMq7Mdq6XjuRkzrxOk8DxXVY=;
        b=m5d1zLumnu9z3n42CJjfpK9DXgqBaPLPfFQG+MM7zTv9/ejyE0sprRsILFsm8GJW1c
         RTlm+BxYRiCp/K4pK5xLlw4qv8X29suMPwZlyEWgMNuKEs/aQttEe15gjl+JJZo/XRrG
         HqpgWCkLE8yskA+EytZ61Run4GMwP5oz/fBdJfDYikvE88ydrbe+vfvv/eEkP7SkUB51
         JtXteX/2h9+TV94CBQfEWwGVYQWCzs0Vis99KHzdHfqPCkneLb5E7b45jtBXcE1VqnTC
         XKnq1milXKpSYtwjYAUdxe267LFXUrFLQuS//O2k4aCGyvoDlSwre2Dv26sphkKOMZ8g
         ZxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rLqkxbD9R7hDFbmz51dlMq7Mdq6XjuRkzrxOk8DxXVY=;
        b=RwM8pIkXwTQ2nG8txp5zFCbAZu6+QE83NaGTXtZqcq0m3H1X5y5DOs2S1xsWsBImBK
         YBX+Wrqp26JaPrIVA91aLq/2600eUKwIRTIZJi1HVxrL/cHNUrpKkVzvbt9KdXXkjMmH
         MeSVi7x6mLEoOH5WFzV5SR2w96B1YoPhvBHQj1ssE+Rtr6U9ZqBexLmAy4pn7SkNJKru
         v2hWdZypolx1jtXU3DwIoynL1mC3LVSfHlUEvyGI+coxsSftQSTf04eEOiPIJflxmU/W
         JI4Q1H+4NVQE4GIzDj1MLUlQlLc0o3uhgwcHqQxwqui93FGM5QlDkjXGc7EEZkoMrQyP
         cR1w==
X-Gm-Message-State: AODbwcDQlvZaKs/7hB8Z/kEQtliS8cs6MCqdmZ1tCCsSG5J8cBedtnPc
        VO5Ru16H0j7zc7zj
X-Received: by 10.98.16.28 with SMTP id y28mr721898pfi.163.1494540279942;
        Thu, 11 May 2017 15:04:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 6/6] pathspec: convert find_pathspecs_matching_against_index to take an index
Date:   Thu, 11 May 2017 15:04:27 -0700
Message-Id: <20170511220427.192627-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511220427.192627-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert find_pathspecs_matching_against_index to take an index
parameter.

In addition mark pathspec.c with NO_THE_INDEX_COMPATIBILITY_MACROS now
that it doesn't use any cache macros or reference 'the_index'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  2 +-
 pathspec.c             | 11 +++++++----
 pathspec.h             |  7 +++++--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 86770d6af..0365a5209 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -136,7 +136,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen);
 	return seen;
 }
 
@@ -418,7 +418,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec);
+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 91040a4b0..7629018a5 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -98,7 +98,7 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		exclude = NULL;
diff --git a/pathspec.c b/pathspec.c
index 1e5df2316..828405021 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
@@ -17,6 +18,7 @@
  * to use find_pathspecs_matching_against_index() instead.
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
+					const struct index_state *istate,
 					char *seen)
 {
 	int num_unmatched = 0, i;
@@ -32,8 +34,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		ce_path_match(ce, pathspec, seen);
 	}
 }
@@ -46,10 +48,11 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * nature of the "closest" (i.e. most specific) matches which each of the
  * given pathspecs achieves against all items in the index.
  */
-char *find_pathspecs_matching_against_index(const struct pathspec *pathspec)
+char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
+					    const struct index_state *istate)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index 6671b9577..60e650040 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -96,7 +96,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 		return strcmp(s1, s2);
 }
 
-extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
-extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
+extern void add_pathspec_matches_against_index(const struct pathspec *pathspec,
+					       const struct index_state *istate,
+					       char *seen);
+extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
+						   const struct index_state *istate);
 
 #endif /* PATHSPEC_H */
-- 
2.13.0.rc2.291.g57267f2277-goog

