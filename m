Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD8B202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 00:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdGMAob (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 20:44:31 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34079 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdGMAoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 20:44:30 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so20765787pfq.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XzKgfYAA6I8dRCvWC4k0QW9cDlFaCQJUM4vCKCgb4Ys=;
        b=IbHiG32QLb6DeMvbCan3/AQa47VOwF8Zd6AVwknOLu4eyCTQiPJZq4WbTmGOOlzLXM
         QrLRhTngZrvhazlZCSYlVZH057R2I9NhDOh1nSIznXs/4gOJ5nTjRWxzEttZs8gWGKfG
         ZvIoYSWJQW73ZIsBImc/wpVnQBr4bPKaEeonHnI/vlNIAdYmcQqF/kNCwAqmn453JNKy
         trBaeoDz6M8rj0ALmv8T+Q4vfTwpAUGlCQ5YtjsqYvAsezKGd3FSVfQF6AnSFlAzKtcw
         O3ajRj4Wqd7PI5UuJE0naqvBNLxVX+gyNhIS70fqtSLISOHOE4xIPJZRoM7Crp6mIJZQ
         0FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XzKgfYAA6I8dRCvWC4k0QW9cDlFaCQJUM4vCKCgb4Ys=;
        b=LsgvloLJfdCirT/iFTzgoNuN47sCIYLDrZpECVK2bR/3EJdohmxP86SQikFZRrbFfW
         uQ6W/dz5Fe8uqfX53+aRYHP7SCql6CFA7yF8R1UEt76BVG2xKrp5T5BwMsVo0IexfUGY
         ONJph9vYmd6WAFdc52Z+K15d7t1q+r+f2hp9TsWv+HF7XAdcy5idjYqtwFAn4wKWwcMf
         Bt4CBQ0eEFm2pGgJkYajD/v5EUxDBV5UtEgvVJ9xlGP2zUr8rtfZMtFzwWGqHxh66TY8
         aCjRmJbbv77LsYYrDKgSeK13qBTB3d/qvzKXTBku8/ebRLjmVzpX2FbkS9eSdejVeC2g
         +bVg==
X-Gm-Message-State: AIVw113oToDEK8bwKOxk6zwkNtoFvXXXNUxONkP33RC17wCWjbv43ihx
        VZOkjWkyGhVVaJxF6BfaHg==
X-Received: by 10.84.169.36 with SMTP id g33mr7234032plb.52.1499906669079;
        Wed, 12 Jul 2017 17:44:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68de:f6b3:e0e6:2d13])
        by smtp.gmail.com with ESMTPSA id a125sm6457474pgc.37.2017.07.12.17.44.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 17:44:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] commit: convert lookup_commit_graft to struct object_id
Date:   Wed, 12 Jul 2017 17:44:14 -0700
Message-Id: <20170713004415.5051-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.3.650.g5ebc568d5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch, commit.h doesn't contain the string 'sha1' any more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Before diving into the "RFC object store" series further, I want to get
rid of the final sha1s in {commit,tag}.{c,h}.

 commit.c  | 6 +++---
 commit.h  | 2 +-
 fsck.c    | 2 +-
 shallow.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index cbfd689939..e0888cf0f7 100644
--- a/commit.c
+++ b/commit.c
@@ -199,11 +199,11 @@ static void prepare_commit_graft(void)
 	commit_graft_prepared = 1;
 }
 
-struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
+struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft();
-	pos = commit_graft_pos(sha1);
+	pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return NULL;
 	return commit_graft[pos];
@@ -335,7 +335,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(item->object.oid.hash);
+	graft = lookup_commit_graft(&item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
diff --git a/commit.h b/commit.h
index 4127c298cb..6d857f06c1 100644
--- a/commit.h
+++ b/commit.h
@@ -249,7 +249,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
-struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
+struct commit_graft *lookup_commit_graft(const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
diff --git a/fsck.c b/fsck.c
index b4204d772b..2d2d2e9432 100644
--- a/fsck.c
+++ b/fsck.c
@@ -736,7 +736,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		buffer += 41;
 		parent_line_count++;
 	}
-	graft = lookup_commit_graft(commit->object.oid.hash);
+	graft = lookup_commit_graft(&commit->object.oid);
 	parent_count = commit_list_count(commit->parents);
 	if (graft) {
 		if (graft->nr_parent == -1 && !parent_count)
diff --git a/shallow.c b/shallow.c
index 54359d5490..f5591e56da 100644
--- a/shallow.c
+++ b/shallow.c
@@ -107,7 +107,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
 		    (is_repository_shallow() && !commit->parents &&
-		     (graft = lookup_commit_graft(commit->object.oid.hash)) != NULL &&
+		     (graft = lookup_commit_graft(&commit->object.oid)) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
 			commit->object.flags |= shallow_flag;
@@ -398,7 +398,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	for (i = 0; i < sa->nr; i++) {
 		if (has_object_file(sa->oid + i)) {
 			struct commit_graft *graft;
-			graft = lookup_commit_graft(sa->oid[i].hash);
+			graft = lookup_commit_graft(&sa->oid[i]);
 			if (graft && graft->nr_parent < 0)
 				continue;
 			info->ours[info->nr_ours++] = i;
-- 
2.13.3.650.g5ebc568d5d

