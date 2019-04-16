Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D3020248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfDPJfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38095 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so10056617plb.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0aQ1uRl1ylWR1LoSCegbTCrprkOD9xY2bCL4Qv1Y6s=;
        b=kjv/IrJCcvETb9rDqxPINhQ7R/aSBFqBdaFDYaTfTGexo2/h6I4Smkb455sl1ekOgW
         XaFKyaq/o9onUP21ECtFbQ0RiP5mgpauzfaYANOxtOHqUCKnfjhf72MpDQQTlvN4zRjA
         lvSjYkbHymEJLxvKx5mycU5hSQjCoype9sFVtLx1V77JMZQFq6TaL8gqDIyxPM0GKFql
         undmLF9EyV6k61gQUN7/pPmYEZhlmHi3qaXbIFHWVj7J9ge3wDisZJe768u9RMTsM7UG
         ZxDY1BDj11to9r72byY92hpta1wrmKlxB8xGix+KOY9fuhxGXkLBJWaaMdfaSE3PDHMY
         XBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0aQ1uRl1ylWR1LoSCegbTCrprkOD9xY2bCL4Qv1Y6s=;
        b=kDPdWsk5C/LUFS1jB3R4SNtCxBeVbkDFBa7Z8LMcOmIpqQFz/ds1xytBpsfPMGMCXO
         k6bOhPZrrx3jnt9vedTI4LrTCzHqvFkZVw7T/QhO3twYIEmMhIMb5Aartuo9DGjFE25K
         G2JHtVPcc3rNlYxobvOVoaqgBskNpn7p+mufqErjldUpuWWfwiyjvqbYYRqIjLYzB/Ga
         7RaZcjxAhUH3poNS4hGafxm3lOM5JJKlY0YME4Arn1okQpAXVPSuxkDbpSShedtW6R7z
         iBEsNGGsSNgwgMUskbRCGBeA5d9hTjrJ+YVLtKhsgxpON1OuRnH/tbmsACRNjU1M2MtD
         E6sg==
X-Gm-Message-State: APjAAAWpBT5nKfDE+3MLh6JH2IZIujg+r7dEISUFwr6y0eiL1JnY+YxA
        2FiVT/r6vweLrYoHpAGLjLU=
X-Google-Smtp-Source: APXvYqyG/XOfPvwwW2XE79KLc9WduUzMHLTkuEPo8yGCBsu4ePAfWVZV+I6wbXiNzyN4Ea6je1adtQ==
X-Received: by 2002:a17:902:7785:: with SMTP id o5mr81482051pll.33.1555407330625;
        Tue, 16 Apr 2019 02:35:30 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id t21sm36399661pfe.22.2019.04.16.02.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 11/34] commit.cocci: refactor code, avoid double rewrite
Date:   Tue, 16 Apr 2019 16:33:18 +0700
Message-Id: <20190416093341.17079-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"maybe" pointer in 'struct commit' is tricky because it can be lazily
initialized to take advantage of commit-graph if available. This makes
it not safe to access directly.

This leads to a rule in commit.cocci to rewrite 'x->maybe_tree' to
'get_commit_tree(x)'. But that rule alone could lead to incorrectly
rewrite assignments, e.g. from

    x->maybe_tree = yes

to

    get_commit_tree(x) = yes

Because of this we have a second rule to revert this effect. Szeder
found out that we could do better by performing the assignment rewrite
rule first, then the remaining is read-only access and handled by the
current first rule.

For this to work, we need to transform "x->maybe_tree = y" to something
that does NOT contain "x->maybe_tree" to avoid the original first
rule. This is where set_commit_tree() comes in.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit-graph.c                  |  9 +++++++--
 commit.c                        |  9 +++++++--
 contrib/coccinelle/commit.cocci | 20 +++++++++++++-------
 merge-recursive.c               |  7 ++++++-
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 47e9be0a3a..155a270457 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -343,6 +343,11 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 static int fill_commit_in_graph(struct repository *r,
 				struct commit *item,
 				struct commit_graph *g, uint32_t pos)
@@ -356,7 +361,7 @@ static int fill_commit_in_graph(struct repository *r,
 	item->object.parsed = 1;
 	item->graph_pos = pos;
 
-	item->maybe_tree = NULL;
+	set_commit_tree(item, NULL);
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
@@ -442,7 +447,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(r, &oid);
+	set_commit_tree(c, lookup_tree(r, &oid));
 
 	return c->maybe_tree;
 }
diff --git a/commit.c b/commit.c
index a5333c7ac6..043ba64f17 100644
--- a/commit.c
+++ b/commit.c
@@ -340,6 +340,11 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 struct tree *get_commit_tree(const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
@@ -358,7 +363,7 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
-	c->maybe_tree = NULL;
+	set_commit_tree(c, NULL);
 	c->index = 0;
 	free_commit_buffer(pool, c);
 	free_commit_list(c->parents);
@@ -406,7 +411,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(r, &parent);
+	set_commit_tree(item, lookup_tree(r, &parent));
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c49aa558f0..663658a127 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -10,19 +10,25 @@ expression c;
 - c->maybe_tree->object.oid.hash
 + get_commit_tree_oid(c)->hash
 
-// These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^set_commit_tree$";
 expression c;
+expression s;
 @@
   f(...) {<...
-- c->maybe_tree
-+ get_commit_tree(c)
+- c->maybe_tree = s
++ set_commit_tree(c, s)
   ...>}
 
+// These excluded functions must access c->maybe_tree direcly.
+// Note that if c->maybe_tree is written somewhere outside of these
+// functions, then the recommended transformation will be bogus with
+// get_commit_tree() on the LHS.
 @@
+identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
 expression c;
-expression s;
 @@
-- get_commit_tree(c) = s
-+ c->maybe_tree = s
+  f(...) {<...
+- c->maybe_tree
++ get_commit_tree(c)
+  ...>}
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..ca4731a719 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -163,6 +163,11 @@ static struct tree *shift_tree_object(struct repository *repo,
 	return lookup_tree(repo, &shifted);
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 static struct commit *make_virtual_commit(struct repository *repo,
 					  struct tree *tree,
 					  const char *comment)
@@ -170,7 +175,7 @@ static struct commit *make_virtual_commit(struct repository *repo,
 	struct commit *commit = alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
-	commit->maybe_tree = tree;
+	set_commit_tree(commit, tree);
 	commit->object.parsed = 1;
 	return commit;
 }
-- 
2.21.0.682.g30d2204636

