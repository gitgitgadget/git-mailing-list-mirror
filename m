Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6581F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdHOLtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38409 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdHOLtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id y15so457352lfd.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=neEISX2/ovDkcUkHcRm4ZaCxyrRCtFq7Q24iVH5awc4=;
        b=You5I3nSxwcEtaJtZ74Kul4NLL/9dqr2ct67RZFvx+qlkUmD/XrdKrZbcnddxCtROp
         vo/XXSjV7TMlDuA/KgEL3pxV7Y9uSwacjBtoI7WM1AgHar5PLY+pytS/IdCQCvjPyuYD
         V0jwLbgprtL39kXg5TcyKa7L5rJq7OLQZI9CNcjyu4hw4TvCTHAu/fkwUZF8FeAGhwAM
         V1zrMPWkFlmUuL5HcRRltgmT7QWMzt7p7VSlrJsyqhzty7UsNm+krM1lgDZCi0NhxScy
         pLOl26AWi75Kl/raYPcZ5nV9A0heUzXOi4ghq+4Yq4zgNcFm0RtTaxWMRVHmdeZKN3HV
         aK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=neEISX2/ovDkcUkHcRm4ZaCxyrRCtFq7Q24iVH5awc4=;
        b=D+RF4YezekTqx4P/roAwGkY5v72ZEUN9pGfNYNqeY73oUcmR+2TBO3ix31Xq7DxMLc
         DVtCZ/fdDjzP7Mn0oBHcn6+16jzlmY+9/Eh8BR7EywRjZdEK+FypWCHbwXMB8d1ZccUu
         4T40M4ho6jD0+4i2BR7Lw9hZVTXkzIdv3CrhQDBSSAJ7Fki2/7BIqJ/9ugZ5c6JYag1+
         AhGNPgqcf/peeR8EGM92WsJQhsTV/laU8nX1oiYhDe8x1gtmb1Bn/EiU2gKuIWMEa9sP
         Ozc8m8uLvQ70gdtLzuLJ6IwSh/zbbmvUOT++e1EkOSqH++mmnt1TQ9rsNFBcIvABaJIw
         4FzQ==
X-Gm-Message-State: AHYfb5imf4++MQR7tGF+z78IWX9Fqt5lhmHUnamTORdz6g9ASATh45mE
        Mck4xcQ9ZpQCMgJ+GwI=
X-Received: by 10.25.41.137 with SMTP id p131mr9724006lfp.216.1502797778161;
        Tue, 15 Aug 2017 04:49:38 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:37 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 5/5] commit: rewrite read_graft_line
Date:   Tue, 15 Aug 2017 13:49:06 +0200
Message-Id: <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
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
index 6a145f1..75dd45d 100644
--- a/commit.c
+++ b/commit.c
@@ -111,6 +111,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 void free_commit_graft(struct commit_graft *graft)
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
index c1b319f..070d45d 100644
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

