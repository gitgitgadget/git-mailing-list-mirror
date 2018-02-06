Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54071F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBFAWx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:53 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35643 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFAWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so175903pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dk45XN6FkOhu9t1FuJkRILlDlvO9ehl3eSE8DEdSGq8=;
        b=Dm6Xu9BF2ta+dwaaSuFhBv76XQiiMOuxxTsmy9myE7d0J7kaZhE1pA+urjAtO99Pik
         n/PwkqEyUxlAURP373iSaQ1eS9JDSDaujB5Y9gEp9YPWIccVZisCRz3G0md/scEP8uLO
         ITGrAJBa2k6hbZgcaTI7/6WRHF7hUkmswmViumaE7GZWpmeZYTt9NR1OcNoAsGp1O0L1
         9hlG+xiDkdSqkKQufS30f/stmiUeK+Cw/Nbcg0YWbL7CPdbVUq1Zi6OTCyCUS32BJ4KG
         TuXvlxpkWs1Hm5itdB/xCmBFsIomFmpkAnMKmdPZvRZO/ADNZ3Q6kcmVD7YQVutPQi6m
         LlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dk45XN6FkOhu9t1FuJkRILlDlvO9ehl3eSE8DEdSGq8=;
        b=QsPznACAmDW87N+/DomcPSSl1biFxPEF/xODHSVkx9tsjDfeH5+qBGXk+1U+aqp7fO
         0BpieLNsaZAB3o2OduUSrCZA1C0yRhAwas8cjyXckNXwWOGuWeoLPyP4hB9/Hdx4eM4t
         axv8fx8YLsZVIuVH9tiZ4zz+cEpJjRLjnNqNmmcVEY+RXJpGJBcXrtTvboT/BYqGfeoM
         e5izZok8y097ASextkSiUT8o+Lm2pPltiUA7i663L13aeUfU/8Sa+bRO/E2gT2YRYtae
         d2D8pyMnum8i3+Eqd1LwjDsabdte+lTfjaTmhG1KnOqxuCwEZS85RkHU9KBdRf9834PH
         hOTA==
X-Gm-Message-State: APf1xPAhLshZzKdNtjURrjwI8i7Pd31+iw4v5Ocr3vFDQyvqpdo3AvuU
        f+JSLXC5VqqJpDXvw0mK48VCQhd6uA4=
X-Google-Smtp-Source: AH8x227MFQEQKqf5ln4lDv964rpxa9vtAGJkE+JQEzTiXt08ss3AKdl4OjgkRKn1TX8XILjwdOWFgQ==
X-Received: by 10.99.96.216 with SMTP id u207mr431256pgb.167.1517876569000;
        Mon, 05 Feb 2018 16:22:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k20sm7011738pfh.49.2018.02.05.16.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 131/194] alloc: add repository argument to alloc_commit_node
Date:   Mon,  5 Feb 2018 16:16:46 -0800
Message-Id: <20180206001749.218943-33-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c           | 2 +-
 blame.c           | 2 +-
 cache.h           | 3 ++-
 commit.c          | 2 +-
 merge-recursive.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index 2c8d143075..9e2b897ec1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -88,7 +88,7 @@ unsigned int alloc_commit_index(void)
 	return count++;
 }
 
-void *alloc_commit_node(void)
+void *alloc_commit_node_the_repository(void)
 {
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
diff --git a/blame.c b/blame.c
index 8648a1ddff..592bedd0e0 100644
--- a/blame.c
+++ b/blame.c
@@ -163,7 +163,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	read_cache();
 	time(&now);
-	commit = alloc_commit_node();
+	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
diff --git a/cache.h b/cache.h
index 6a794aa903..cb41e22123 100644
--- a/cache.h
+++ b/cache.h
@@ -1579,7 +1579,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
 extern void *alloc_blob_node_the_repository(void);
 #define alloc_tree_node(r) alloc_tree_node_##r()
 extern void *alloc_tree_node_the_repository(void);
-extern void *alloc_commit_node(void);
+#define alloc_commit_node(r) alloc_commit_node_##r()
+extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
diff --git a/commit.c b/commit.c
index 953c537059..17bdd13e0d 100644
--- a/commit.c
+++ b/commit.c
@@ -55,7 +55,7 @@ struct commit *lookup_commit_the_repository(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_commit_node());
+				     alloc_commit_node(the_repository));
 	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0b4cb14773..f6d28f0d8f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -100,7 +100,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
-	struct commit *commit = alloc_commit_node();
+	struct commit *commit = alloc_commit_node(the_repository);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->tree = tree;
-- 
2.15.1.433.g936d1b9894.dirty

