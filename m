Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A9C1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdHPR7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:59:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33656 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdHPR7N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:59:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id 71so10784lfs.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k2V0MirxJYU4m+9dtVo/BrmBSMQwoyOn1FiEltBHYNE=;
        b=gjjLVe+veK0c8MKJoSQay/ok1lR8CjYWBSo4g88FniSXQrtVLfK/TyXyQv2LFmAh+e
         1ABdmHzrrtXDl6w2SZz36Z+jSQViyFz6bhxYFkwWOWSbcllBZQ65WEqurNotEvWQFSl2
         gjsoV4PmeUn/F/6f/2zqu+8GiNsRuH+HRFezjNSWsn5zXBEMKXhh36ot5jIIFb7d2lc+
         J8jnI9+GJNbMDqq4l9hb3oXUC2gnPvuX/deTiisrfSRehV3roWujOEkQpMxF2X2CL74+
         92qyvr4FibohDDOztpU//6LRwuet5ix/bmTy5sy1p7SjMzw5gVMriHxE3grv1zJBCVAq
         Zt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=k2V0MirxJYU4m+9dtVo/BrmBSMQwoyOn1FiEltBHYNE=;
        b=tIDq8WSwPG9MGZpSO+5tSQh5htL78sPKTFZU/TL5lZC/4CbqD8if5xSgfXN0kp7UJT
         hntxBGSE59ah6kRCX+12QHbumaR6BOwzaLHmy43T8CvuGSf8SeufztrY77IBhQkuM6nb
         gWrk1maJQLxZ/RW9OI9deyduJxaRpPp9SwbQPLrwYuFm22TpiFMZlT7a4yePkaEAQiQZ
         M/0yKUxo0Urmg3DgDUedR/9J/e7PuiGBzkAWAHx1HP2OmsqvX65yMfYpkm6J7MEMSD02
         7o0dKm8CS9VI0uuRGGQkVzJCVyWFrOwoAqQBr9g0hbbNcjong9KFu2V5dpWcdRt47E7C
         UPMg==
X-Gm-Message-State: AHYfb5jmjIv3xb3wlM+E7dFtsUJkhxt+czvlNNWsqBkUmCHnm9APG9pb
        yrmKtjKM8Ma1YrZ7d6M=
X-Received: by 10.25.233.15 with SMTP id g15mr1007015lfh.161.1502906351413;
        Wed, 16 Aug 2017 10:59:11 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c64sm361245lfc.4.2017.08.16.10.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 10:59:10 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH v2 4/4] commit: rewrite read_graft_line
Date:   Wed, 16 Aug 2017 19:58:25 +0200
Message-Id: <b63b2148b7d79ebe5c57b876c7077a9ac42d2869.1502905085.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <cover.1502905085.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous implementation of read_graft_line used calculations based
on GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ to determine the number of commit
ids in a single graft line.  New implementation does not depend on these
constants, so it adapts to any object_id buffer size.

To make this possible, FLEX_ARRAY of object_id in struct was replaced
by an oid_array.

Code allocating graft now needs to use memset to zero the memory before
use to start with oid_array in a consistent state.

Updates free_graft function implemented in the previous patch to
properly cleanup an oid_array storing parents.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c  | 39 +++++++++++++++++++++------------------
 commit.h  |  2 +-
 shallow.c |  1 +
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index 4d23e72..8bdce36 100644
--- a/commit.c
+++ b/commit.c
@@ -111,6 +111,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 static void free_commit_graft(struct commit_graft *graft)
 {
+	oid_array_clear(&graft->parents);
 	free(graft);
 }
 
@@ -139,35 +140,37 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 	return 0;
 }
 
+static int parse_next_oid_hex(const char *buf, struct object_id *oid, const char **end)
+{
+	while (isspace(buf[0]))
+		buf++;
+	return parse_oid_hex(buf, oid, end);
+}
+
 struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
-	int i, len;
-	char *buf = line->buf;
 	struct commit_graft *graft = NULL;
-	const int entry_size = GIT_SHA1_HEXSZ + 1;
+	struct object_id oid;
+	const char *tail = NULL;
 
 	strbuf_rtrim(line);
-	len = line->len;
-	if (buf[0] == '#' || buf[0] == '\0')
+	if (line->buf[0] == '#' || line->len == 0)
 		return NULL;
-	if ((len + 1) % entry_size)
+	graft = xmalloc(sizeof(*graft));
+	memset(graft, 0, sizeof(*graft));
+	if (parse_oid_hex(line->buf, &graft->oid, &tail))
 		goto bad_graft_data;
-	i = (len + 1) / entry_size - 1;
-	graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
-	graft->nr_parent = i;
-	if (get_oid_hex(buf, &graft->oid))
+	while (!parse_next_oid_hex(tail, &oid, &tail))
+		oid_array_append(&graft->parents, &oid);
+	if (tail[0] != '\0')
 		goto bad_graft_data;
-	for (i = GIT_SHA1_HEXSZ; i < len; i += entry_size) {
-		if (buf[i] != ' ')
-			goto bad_graft_data;
-		if (get_sha1_hex(buf + i + 1, graft->parent[i/entry_size].hash))
-			goto bad_graft_data;
-	}
+	graft->nr_parent = graft->parents.nr;
+
 	return graft;
 
 bad_graft_data:
-	error("bad graft data: %s", buf);
+	error("bad graft data: %s", line->buf);
 	free_commit_graft(graft);
 	return NULL;
 }
@@ -363,7 +366,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(&graft->parent[i]);
+			new_parent = lookup_commit(&graft->parents.oid[i]);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
diff --git a/commit.h b/commit.h
index baecc0a..96ff375 100644
--- a/commit.h
+++ b/commit.h
@@ -243,7 +243,7 @@ void sort_in_topological_order(struct commit_list **, enum rev_sort_order);
 struct commit_graft {
 	struct object_id oid;
 	int nr_parent; /* < 0 if shallow commit */
-	struct object_id parent[FLEX_ARRAY]; /* more */
+	struct oid_array parents;
 };
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
diff --git a/shallow.c b/shallow.c
index f5591e5..892cd90 100644
--- a/shallow.c
+++ b/shallow.c
@@ -33,6 +33,7 @@ int register_shallow(const struct object_id *oid)
 		xmalloc(sizeof(struct commit_graft));
 	struct commit *commit = lookup_commit(oid);
 
+	memset(graft, 0, sizeof(*graft));
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
-- 
2.9.5

