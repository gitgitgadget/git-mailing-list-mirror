Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B3A20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDFLgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so4764305pfn.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KdpKCBthk7pbFNe/d0GUMNketEGbY/sNj+6gFKzJkY=;
        b=MRiMONm8nk7ctdLin3lpx8flmHg7UUZ5NXFnFpGvj/qJwGkl+l5BY1BU7LTFC7lGDL
         jA4XsGZsG2trydYtTEBUyfjVx7+55vuiUa9HrIgJLESO72aT+p4kJzZ75pZmVslfA8sf
         ofN3BzHcyKSJeaqHVCWEjjqEiTp1Do4q80WfjEatrR3AGPCPQ0ths+frLXNdkQHoME+1
         DbhhR9mqHA2aUxDxUa6rfHJqWN4rCl/Pv3VTjUwWO9vMuPXRs1osfi7m51+y0v28Ch3O
         rKca/i4e8W56fCQIsYvWTNFWhu9cHcxmqZM7B9k9YOhl1N8H72lAZtS7BMlWT4hsmP6T
         j3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KdpKCBthk7pbFNe/d0GUMNketEGbY/sNj+6gFKzJkY=;
        b=oBRClpBrXZkrXEXxi4rONq7NTypfqtjlbuoQJog315kHM7BKcfS7zbmd1FdttHj7AR
         4hsefRZO9f8XaPBuCub+flNMVi+fk2IiADmdbIYeUaPOSQsETlGZU1ifoeW3CX4fNVwk
         tkuGxkyabzV89TdoP7My1i+5lb/zFSiHMCPbEOwI6xu3KFWF4xYXIXhY95zqUV4rDgXA
         dmKFmQzIr0d171YDNwlwjFPh9AoG4P+gbc82spJ4DT9w26aZrJ6nQF7lPzot0zAP6YV1
         ga7wcYc1tX5ZgRLM1fmBGHmU9MZlKWupV8FcQe3oAnJxDUELRgRx9icMGu2zguNlbqq6
         LMdA==
X-Gm-Message-State: APjAAAUvVATJsilDdv/rd67DQoBJU9uQ+oi4HtgEIuzOdD5XMVQotpTo
        vHlM3eww/SEJ9WJnOa+sCjo=
X-Google-Smtp-Source: APXvYqztSzYiDPQsnyYjVZUkBancC7avLA7F1EdA2tkadFwZGK/WVUxAi8UMW7bfQnCtcUFfC3kb0A==
X-Received: by 2002:a63:450f:: with SMTP id s15mr17156940pga.157.1554550573872;
        Sat, 06 Apr 2019 04:36:13 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id y23sm35663911pfn.25.2019.04.06.04.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 11/33] commit.c: add repo_get_commit_tree()
Date:   Sat,  6 Apr 2019 18:34:31 +0700
Message-Id: <20190406113453.5149-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the implicit dependency on the_repository in this function.
It will be used in sha1-name.c functions when they are updated to take
any 'struct repository'. get_commit_tree() remains as a compat wrapper,
to be slowly replaced later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c                        | 5 +++--
 commit.h                        | 5 +++--
 contrib/coccinelle/commit.cocci | 7 ++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..f0a5506f04 100644
--- a/commit.c
+++ b/commit.c
@@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
-struct tree *get_commit_tree(const struct commit *commit)
+struct tree *repo_get_commit_tree(struct repository *r,
+				  const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
@@ -348,7 +349,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return get_commit_tree_in_graph(r, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index 42728c2906..f1aa4c0472 100644
--- a/commit.h
+++ b/commit.h
@@ -32,7 +32,7 @@ struct commit {
 
 	/*
 	 * If the commit is loaded from the commit-graph file, then this
-	 * member may be NULL. Only access it through get_commit_tree()
+	 * member may be NULL. Only access it through repo_get_commit_tree()
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
@@ -143,7 +143,8 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *get_commit_tree(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c49aa558f0..57c8f71479 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -12,17 +12,18 @@ expression c;
 
 // These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
 expression c;
 @@
   f(...) {<...
 - c->maybe_tree
-+ get_commit_tree(c)
++ repo_get_commit_tree(the_repository, c)
   ...>}
 
 @@
 expression c;
+expression r;
 expression s;
 @@
-- get_commit_tree(c) = s
+- repo_get_commit_tree(r, c) = s
 + c->maybe_tree = s
-- 
2.21.0.479.g47ac719cd3

