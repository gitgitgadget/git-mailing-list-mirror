Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCD91F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBFAPY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:15:24 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36329 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFAPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:15:22 -0500
Received: by mail-pg0-f68.google.com with SMTP id x25so160238pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKi4OHqtxkvirSpZ3V7hUoqEIhJpTO+ec1SXZKphl54=;
        b=uW/xRAjroVHvlOPBpkm1bFisY7zF60YqI7LHuE2JKJFe07xp0C8F+Im6glhgA0TDsq
         jO9wetVbHcUKwr/XFUgHeLF5mXwZ7T2Y/0Vc9oorh8+d63xVNC2afJFuDG8ilkUJr/Hc
         M0p70YrVwEk5Z/8W967WAZQeW8eX7BdcNDKI7KQ7Oh+WajMpnC1zC4BQf912rOOuiOOE
         ddIDniCHvhc5fHbAapaWNbeQPtmlykgn5dJxiJ7LZM/8t9VrsD2lqZKKXiVBY869+RdK
         j4Fb24Q4ObZ2IEkZQdGH9aPsGTjzRi3PskZtqxSVFSjepVfQhjcttQITjBR0d3Bmd5HQ
         2r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKi4OHqtxkvirSpZ3V7hUoqEIhJpTO+ec1SXZKphl54=;
        b=fZVg5/Ajy/VFpO4eZT7uOahN6uV556XL46CEujnNDQIZWAosWJFkrdPs+x+Oh7grwP
         JkBSrWTtEVI2gxEuoF7xoLDdV7HthZh3DXwmCJE8Uzd2ieU0t/V2uC4n2jPVJkECBCrP
         XniUznNTxw34tJkzzVLDMbuLjbI4UAwJEvw+c6Ys16KMYv2EKdN5MBtmnZGKkjxoEOIY
         /I0+Wf2DoFI4MGtvk5MQYQVHjxiYqoVC0GYebJVf8hs7FheJ3DSgzwcpR2fhkfPxziLI
         1gES/Tmo/KV13z+K0n+CkW0VpoA1+xar84/rGud8awAaj7vj08sEf5SENjsfkPQWoH3l
         bTVw==
X-Gm-Message-State: APf1xPCD7duGx4rcPXRxMAZIc5o1ZXsXkAY8olvChCwBEng64VuCMifr
        hRFnp11cYn0IgDy7aURjKq3dAmOty6c=
X-Google-Smtp-Source: AH8x226iGvB/nFotETdiRc8egqB+46Zvt3C1ud7ukrc46OPgNyftc7ZCW2NUaCJBkbzTm+Jkhd7eCw==
X-Received: by 10.101.66.6 with SMTP id c6mr423447pgq.213.1517876121701;
        Mon, 05 Feb 2018 16:15:21 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s14sm15061698pgc.36.2018.02.05.16.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:15:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 098/194] object: add repository argument to lookup_commit_graft
Date:   Mon,  5 Feb 2018 15:55:59 -0800
Message-Id: <20180205235735.216710-78-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
 commit.c                               | 4 ++--
 commit.h                               | 3 ++-
 contrib/coccinelle/object_parser.cocci | 7 +++++++
 fsck.c                                 | 2 +-
 shallow.c                              | 5 +++--
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index fbe27cf436..8e42af7565 100644
--- a/commit.c
+++ b/commit.c
@@ -213,7 +213,7 @@ static void prepare_commit_graft_the_repository(void)
 	commit_graft_prepared = 1;
 }
 
-struct commit_graft *lookup_commit_graft(const struct object_id *oid)
+struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft(the_repository);
@@ -349,7 +349,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(&item->object.oid);
+	graft = lookup_commit_graft(the_repository, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
diff --git a/commit.h b/commit.h
index c8c5aafcb1..f791a55379 100644
--- a/commit.h
+++ b/commit.h
@@ -178,7 +178,8 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 struct commit_graft *read_graft_line(struct strbuf *line);
 #define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
 int register_commit_graft_the_repository(struct commit_graft *, int);
-struct commit_graft *lookup_commit_graft(const struct object_id *oid);
+#define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
+struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index fc56a90934..987630f70f 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -98,3 +98,10 @@ expression F;
  register_commit_graft(
 +the_repository,
  E, F)
+
+@@
+expression E;
+@@
+ lookup_commit_graft(
++the_repository,
+ E)
diff --git a/fsck.c b/fsck.c
index 54943b7dee..af0291121d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -739,7 +739,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		buffer += 41;
 		parent_line_count++;
 	}
-	graft = lookup_commit_graft(&commit->object.oid);
+	graft = lookup_commit_graft(the_repository, &commit->object.oid);
 	parent_count = commit_list_count(commit->parents);
 	if (graft) {
 		if (graft->nr_parent == -1 && !parent_count)
diff --git a/shallow.c b/shallow.c
index 925db794fd..004f99d4e2 100644
--- a/shallow.c
+++ b/shallow.c
@@ -111,7 +111,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
 		    (is_repository_shallow() && !commit->parents &&
-		     (graft = lookup_commit_graft(&commit->object.oid)) != NULL &&
+		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
 			commit->object.flags |= shallow_flag;
@@ -400,7 +400,8 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
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
2.15.1.433.g936d1b9894.dirty

