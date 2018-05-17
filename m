Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD0D1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEQWwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:22 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:44083 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeEQWwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:20 -0400
Received: by mail-pg0-f47.google.com with SMTP id c22-v6so1772388pgn.11
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=irb6+GHAp/Z2FeMLjWO95WYO/UPrbN0TxvjHGPs+9Xg=;
        b=GcbiKJYlLPgPpVcKFxPXcJWkZCQQR+CYS/lY8jdNlFzsX/6ZmqPM2+tWlSWCg+9VJP
         Ka/weDX3NvO3n1X+Bzqth2lgFJVvjhy2a97Wo0on0F9TMtd+TlYkQ4t565ImW9nqks5t
         vJmz5CV20t4uXKM3F3ypTBSc6A90rkVjPsYMzgJ0nj7q9n865issPc1nYJlUWO3c35BG
         HgQCmQrNHkhRNwIaE9yf9PtZlj5ES8bUQ0DhZi4SL9k6QYQ+JAH3+VnhdaHObHeBS4FX
         8S8byny0vjvNYaofpJ5azlDceUSMxG7n8C8b+ud337B4gDoNejrCpfila25k3TPUyiaI
         2ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=irb6+GHAp/Z2FeMLjWO95WYO/UPrbN0TxvjHGPs+9Xg=;
        b=kjI6qW1UuAOHuR6Oz01XHSOY3l5paN0Fq0Q/mObpBdDYbPKDBbYlXpu71jtTswLr74
         Qg2A6EPoYtrS5iLvdQV8QLzPOwryQYp99dN++zbAdzKbR4E9FEnGw9AKHzfCNIx+E0yh
         nCU66ubV3seVd6szkytX/DZb8O1vzD21k4EX3uXxo+Sn9/V22zPI8IRpd135UcsDskcH
         3Af0YOk/iG+Df1IMhIgGvzo+MZ++Q/GBpnqqgsbld48j7TXXrc7wA21Dm24gv5LDLEkV
         +ONHS5yH3oZdatzK41tRq/a2F8SDmB1RLeMm2KK7O4CNlxCnv6KHdzb1PpiGwqCInC0L
         y4iw==
X-Gm-Message-State: ALKqPwcVQ/MbJqxZzNp9zPjTY7qfi9tJVD0PK5ymljA8dyyL0v2PJfqG
        4cwBUq+Y8NQlke5yxt+60CGzTQ==
X-Google-Smtp-Source: AB8JxZqJn8jEBRWK0g/KnDjy2Ke68YGeOuMbbtvpVDV1NkYbFYblFidqnogRMEZ00EwtPH3+aqzzjQ==
X-Received: by 2002:a62:dfcd:: with SMTP id d74-v6mr6899517pfl.114.1526597539147;
        Thu, 17 May 2018 15:52:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s88-v6sm13124101pfe.43.2018.05.17.15.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/19] commit: add repository argument to lookup_commit_graft
Date:   Thu, 17 May 2018 15:51:42 -0700
Message-Id: <20180517225154.9200-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of lookup_commit_graft to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c  | 4 ++--
 commit.h  | 3 ++-
 fsck.c    | 2 +-
 shallow.c | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index a0400b93a1e..c832133f055 100644
--- a/commit.c
+++ b/commit.c
@@ -212,7 +212,7 @@ static void prepare_commit_graft_the_repository(void)
 	commit_graft_prepared = 1;
 }
 
-struct commit_graft *lookup_commit_graft(const struct object_id *oid)
+struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft(the_repository);
@@ -359,7 +359,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(&item->object.oid);
+	graft = lookup_commit_graft(the_repository, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
diff --git a/commit.h b/commit.h
index 40a5b5e2585..f6746125766 100644
--- a/commit.h
+++ b/commit.h
@@ -176,7 +176,8 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 struct commit_graft *read_graft_line(struct strbuf *line);
 #define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
 int register_commit_graft_the_repository(struct commit_graft *, int);
-struct commit_graft *lookup_commit_graft(const struct object_id *oid);
+#define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
+struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
diff --git a/fsck.c b/fsck.c
index 59b0c7d640e..104c3c0a434 100644
--- a/fsck.c
+++ b/fsck.c
@@ -738,7 +738,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		buffer += 41;
 		parent_line_count++;
 	}
-	graft = lookup_commit_graft(&commit->object.oid);
+	graft = lookup_commit_graft(the_repository, &commit->object.oid);
 	parent_count = commit_list_count(commit->parents);
 	if (graft) {
 		if (graft->nr_parent == -1 && !parent_count)
diff --git a/shallow.c b/shallow.c
index ef802deed41..ca360c700c5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -109,7 +109,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
 		    (is_repository_shallow() && !commit->parents &&
-		     (graft = lookup_commit_graft(&commit->object.oid)) != NULL &&
+		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
 			commit->object.flags |= shallow_flag;
@@ -398,7 +398,8 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	for (i = 0; i < sa->nr; i++) {
 		if (has_object_file(sa->oid + i)) {
 			struct commit_graft *graft;
-			graft = lookup_commit_graft(&sa->oid[i]);
+			graft = lookup_commit_graft(the_repository,
+						    &sa->oid[i]);
 			if (graft && graft->nr_parent < 0)
 				continue;
 			info->ours[info->nr_ours++] = i;
-- 
2.17.0.582.gccdcbd54c44.dirty

