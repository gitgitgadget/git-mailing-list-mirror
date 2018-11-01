Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3E21F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKAWtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeKAWtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id r71so12265429qkr.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+Ow6algqNOpaxltSKYqvDdeKyRr7gCkMuSUNcd3kVg=;
        b=UZgI/bteDtSSaIW4jCwA+je6G9zyfnGkHZLOO5t+/bDqVZbWmPpWcvtHwOJNzLgnfZ
         J/NhZMs+HUZWc0kbW+GPFDL5piXB1hdonQFKACPnN4ztqQOXaFLu2aG9YvJ2i15hAvIl
         Q6sj+oUNb5bqCfKBnRz01/2tkbwaDZfrUcdo3Pqnv4E2A0aWTmQXet1jYUs1XQs1pQEr
         p9oUF2bnoQyc04ytgrPeb9+4JDHZxQSW9GvCfWLpVrQv1rZ7zZ5Rq+g28O4FP/vSbgRu
         fGTVuqGkfs25umpKBv9XYOkrdQ7DAnMAeE1JCe6RwJ47/725TqdE6KuWERuImuWNJ+4r
         6oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+Ow6algqNOpaxltSKYqvDdeKyRr7gCkMuSUNcd3kVg=;
        b=TQQ9hw9KPJhs3ZUU+elStqaEaNYREc7gUHfkY98ovbkTSvKmmsZXfnQuL7EPtNWtBa
         65uEuQFbD6YrkM/ipb/X7RG1uFIiJ2wFigFGF2a3gyP7ug0j7q/dA8y6rlib6wU8wAGg
         Sob2H7PRrQk6DEvFV0AbMCKTNaCQCFRRCsqJPqXLHuUrHgr96wjZ2h0STGmjd9TArhlm
         XUejUsjFHKVzEazR5iXXKqr2k1MLAXvAw4I6YFG3ptrK+mqwak9GVxXJVu85+u+A2rDT
         VixyIE+0f+E5zFbsuZaPlfqlcvZYXR9LC3zsa7YCjV3pDMeCF2nFk37EhqI9w6YgUnkp
         FclQ==
X-Gm-Message-State: AGRZ1gJcAh5IKmxC664+w1wB7jmok5OmhWCDsZ3uDQ9TfHpo0NlhnmoP
        wlanx04+e3wisjXNjO5VwWMt5sKk
X-Google-Smtp-Source: AJdET5f3dVrhXNtJonhhLfiOXnkQ4kik3BjEc1UsmDEnRebn60CjU/QSpHWLDv3tNFs5+zoWwoFQVA==
X-Received: by 2002:a37:34f:: with SMTP id 76mr6480126qkd.347.1541079992307;
        Thu, 01 Nov 2018 06:46:32 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:31 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 5/7] commit/revisions: bookkeeping before refactoring
Date:   Thu,  1 Nov 2018 13:46:21 +0000
Message-Id: <20181101134623.84055-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few things that need to move around a little before
making a big refactoring in the topo-order logic:

1. We need access to record_author_date() and
   compare_commits_by_author_date() in revision.c. These are used
   currently by sort_in_topological_order() in commit.c.

2. Moving these methods to commit.h requires adding an author_date_slab
   declaration to commit.h. Consumers will need their own implementation.

3. The add_parents_to_list() method in revision.c performs logic
   around the UNINTERESTING flag and other special cases depending
   on the struct rev_info. Allow this method to ignore a NULL 'list'
   parameter, as we will not be populating the list for our walk.
   Also rename the method to the slightly more generic name
   process_parents() to make clear that this method does more than
   add to a list (and no list is required anymore).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c   |  9 ++++-----
 commit.h   |  7 +++++++
 revision.c | 18 ++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/commit.c b/commit.c
index d0f199e122..a025a0db60 100644
--- a/commit.c
+++ b/commit.c
@@ -655,11 +655,10 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
-/* record author-date for each commit object */
 define_commit_slab(author_date_slab, timestamp_t);
 
-static void record_author_date(struct author_date_slab *author_date,
-			       struct commit *commit)
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit)
 {
 	const char *buffer = get_commit_buffer(commit, NULL);
 	struct ident_split ident;
@@ -684,8 +683,8 @@ static void record_author_date(struct author_date_slab *author_date,
 	unuse_commit_buffer(commit, buffer);
 }
 
-static int compare_commits_by_author_date(const void *a_, const void *b_,
-					  void *cb_data)
+int compare_commits_by_author_date(const void *a_, const void *b_,
+				   void *cb_data)
 {
 	const struct commit *a = a_, *b = b_;
 	struct author_date_slab *author_date = cb_data;
diff --git a/commit.h b/commit.h
index 2b1a734388..ec5b9093ad 100644
--- a/commit.h
+++ b/commit.h
@@ -8,6 +8,7 @@
 #include "gpg-interface.h"
 #include "string-list.h"
 #include "pretty.h"
+#include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
@@ -328,6 +329,12 @@ extern int remove_signature(struct strbuf *buf);
  */
 extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/* record author-date for each commit object */
+struct author_date_slab;
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit);
+
+int compare_commits_by_author_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/revision.c b/revision.c
index 2dcde8a8ac..36458265a0 100644
--- a/revision.c
+++ b/revision.c
@@ -768,8 +768,8 @@ static void commit_list_insert_by_date_cached(struct commit *p, struct commit_li
 		*cache = new_entry;
 }
 
-static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
-		    struct commit_list **list, struct commit_list **cache_ptr)
+static int process_parents(struct rev_info *revs, struct commit *commit,
+			   struct commit_list **list, struct commit_list **cache_ptr)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
@@ -808,7 +808,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -847,7 +848,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1091,7 +1093,7 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
+		if (process_parents(revs, commit, &list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -2913,7 +2915,7 @@ static struct commit *next_topo_commit(struct rev_info *revs)
 
 static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
-	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
 			    oid_to_hex(&commit->object.oid));
@@ -2979,7 +2981,7 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
+			if (process_parents(revs, p, &revs->commits, &cache) < 0)
 				return rewrite_one_error;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
@@ -3312,7 +3314,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				try_to_simplify_commit(revs, commit);
 			else if (revs->topo_walk_info)
 				expand_topo_walk(revs, commit);
-			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
-- 
2.19.1.542.gc4df23f792

