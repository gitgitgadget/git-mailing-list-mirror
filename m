Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177331F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936005AbeFMXG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:29 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:55355 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeFMXG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:27 -0400
Received: by mail-ua0-f202.google.com with SMTP id n13-v6so1335985uaj.22
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=w1jXl6FI4O382/o7a5LD6/tkLQRmEzahn4wYpMJPYYU=;
        b=oIiWQPs/QtJ3OyWeRtoU2xtvqiviiwKMjBjpIoTcn9gbUQYaVJoecFZwiHM7DiDnN5
         eKRiFJ4SpRxihuQe9E3rhCHOzrASljAWSueJuNK1oUmuUBtK7qN41wFaeNMOG8tTU7ad
         nDNJxs8JERlsr2QReq/Ez/580xq+8kyQMPSIi+Ss5flBX+y/z+9Qq+bsvhOQH4VWMCQk
         t9dVVtdFYuB6vIQcWQkngoPbMfRugyydXSN0aj12DvbX6QkkUYlziufaIn6MVQQTklUi
         +v3qwTb2n1O9nb60/ljRad8NjaiJRk7AGYRl186Kh8tnkRNntJTTcuzxkSD/74raJEV3
         7AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=w1jXl6FI4O382/o7a5LD6/tkLQRmEzahn4wYpMJPYYU=;
        b=QGRTjpkgE4xRL7DUylMSYxBKqTl+ubhjUb1ULGf2ANMujsvp5l25Dv/iGiXFRqecnd
         bmUoA2PvgNuhmUD9qCWXROc8EmEQ+wwm6MPl7kv1vcsjKoaJXtqkVQVYDqTcDLI87naG
         0UMZ/MEClg5s5jViB3xrQrq51J4aZaAFlPq5VSZzHLwq2ABKftuABpe/kuYZeuu1v6QI
         wGLPYLgfawZsC26SC6FdPcdFJffIXLfQA5gVOyT4b0GSH9bCBqtngBqB51Hm60yeqypP
         LccRc1d4TqZ05pwKW+PykUNoz0vRc1P4WhHHqC2VSsc6o0CNJ2B0nF6H8oEigiY0hgRP
         rIjw==
X-Gm-Message-State: APt69E0OEGyYIedPcYO+JiaTPKly75/Yt100bdkrAWRyvxNS55stSn7k
        CdkTpcsir13Wx24RLIDAlwH/gJr/lECMoUvGaG/hRVnFznFOg5SB1GBTCcEGE76BYVibcX/GqG+
        okLMqNGMiVJvHDdPZgdgU7y+zPfkxXnK7NhEIjQ9uW4d48N9JHixbrqCp6kKO
X-Google-Smtp-Source: ADUXVKIyiU73RWOkCmnvG+zM9cge3XkVf1bj2hXUyYt2NF+8pgWXadMuurWnMTYFrf+j61/jCdwRcOwuZQTq
MIME-Version: 1.0
X-Received: by 2002:a1f:cd2:: with SMTP id 201-v6mr73281vkm.15.1528931186358;
 Wed, 13 Jun 2018 16:06:26 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:13 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-23-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 22/31] commit.c: allow parse_commit_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 4b10e7173b5..fe3b6ff216f 100644
--- a/commit.c
+++ b/commit.c
@@ -335,7 +335,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -355,11 +355,11 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(the_repository, &parent);
+	item->tree = lookup_tree(r, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(the_repository, &item->object.oid);
+	graft = lookup_commit_graft(r, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -374,7 +374,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(the_repository, &parent);
+		new_parent = lookup_commit(r, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -382,7 +382,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(the_repository,
+			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
 				continue;
diff --git a/commit.h b/commit.h
index d4561587851..66aabb80068 100644
--- a/commit.h
+++ b/commit.h
@@ -71,8 +71,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
-- 
2.18.0.rc1.244.gcf134e6275-goog

