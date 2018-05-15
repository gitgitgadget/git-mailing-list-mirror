Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5285C1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEOXmt (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:49 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:33673 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOXmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:47 -0400
Received: by mail-pl0-f53.google.com with SMTP id n10-v6so972728plp.0
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zPEG/QDoNyvIt2iGKeKPAnxckJVB4X7vuiYjrEWCTu0=;
        b=YQSwAJga5G7/OxIxRJKT71zeKzPes1IyqdU8i9+BvO2JBvEY0uARlHqKZv1K4pupD0
         NBHGXWBuXdzlOiPlgSEiFohGSl4EmhQJ6gWRl5JYuEw4i97FqABqyTvhQuso7+CBYjpD
         94cfQhZ5u2m2Q5RvIVPUPgniqniGWuNU2AhcRwgzAbymHOuyvvP5KTk4Ha7TNtXwDW1Q
         h2Qk+SSstf+jr2Km6gDBvpVDUAUS61LqpNXJr9ByAQlrc+shvPe4Oj5Gg9+lWIoeJxmG
         xb3SndjASji+kPFewL8FyWURS4z2+IE8BTdoQXE4Xl9Q1OAqPz1x3pC+FXVOTw4gruPb
         GTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zPEG/QDoNyvIt2iGKeKPAnxckJVB4X7vuiYjrEWCTu0=;
        b=C/y/Sdhnw4G2ikGHfcn9+XEdUyK5vur58hofaAPy4rcoeBNANxJ/NH0BGauOufuPM2
         4eWGBfemsGUdUUTPvw79GdE4Sll/yqdLnGMy+ibg6Ve/iWjV4sPdyOs0UlmndnBHi5ro
         y8ROs7VrN9PoWLV+utYjig6hwL8P4zzA1n9LVclw/AF0beviWIHHqMFKH4JC3OHd7HOF
         EAVfKoeyNEdfZRq5n1h9l2AV7s26lWDL7aEuAfkS1q+mNiJarumslTK07/thrye4g4h6
         X/nbcCboegpM5eLD/1klO33FNBUUs9d8Ne7qIgocMf7VPTHzMpWmEG6B1tq9TmO2+ugo
         R5lw==
X-Gm-Message-State: ALKqPwdikpX9OKmhSAtiNZF+DkzpZUtIwkCdfWtlfFkDY8jS3hxM6FwD
        qnhB+c3GtAMd2QT0DEyloyeNTJPhOjM=
X-Google-Smtp-Source: AB8JxZp8BhvhuDah9r1CdYhCvpgyHE3LmXGqiYQRqD1Jxtm5DAB7MWRR4sekqbko/cKpPuqVfWww5g==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr16714139pla.125.1526427766226;
        Tue, 15 May 2018 16:42:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a23-v6sm1317572pfi.176.2018.05.15.16.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/19] commit: add repository argument to lookup_commit_graft
Date:   Tue, 15 May 2018 16:42:21 -0700
Message-Id: <20180515234233.143708-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
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

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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

