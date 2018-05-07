Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4691C200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeEGW7l (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40086 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeEGW7e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id t22-v6so1008655plo.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4gjb/H812a4nw+TZk1mPxYF4fBi3ZCilp5VpGxaOMY=;
        b=NqrUC/Q7iG3NCCPRK7xKJX637Ewv1xT7mkPqvFPStbTpdHpqgjN8l8AWHOYM8neOHs
         s2SlQ1A0U/snVe8oFZcGX8epcWj9qnx9R+hf+1EPrGBBnuMvZA0DlPWLFNWW1z/QMvO1
         1VYch+YWdpjCU63ezP8W4Eevf/hNTGDiAT7DtRVlSlgR+rseVbwl6e0vqbbP/+f59lON
         TddI2JPR3icyPdm4vChHBd2gDJwn8Vit9hmnT/tx4cDoV05os41o3P6uFnJT+RA0wmYR
         nAYC9gGt9S2qYzU94WBQvPNkY0On/DP9pzX8qvyVIwhLZjLdrD9VOmQ1HEbGP1/kgza/
         JUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4gjb/H812a4nw+TZk1mPxYF4fBi3ZCilp5VpGxaOMY=;
        b=aU0TGm21PkNk3nsW/JwBM++P8YiYeCrd2JtDBncPzKBLz+dG7HgzBkZaUD3kT26mFC
         OuEEGlMmy/SZqk7Ct1NEPKfPvxrLcjB+kF7w2D9LDBI4Prx7nqCpfyaSd1yEw8fkFf4Z
         qgOc7W6jD8KCZdciUcxmLFuM/HSGbx3KGaabgDucHEofEZrBOugbUtNs33XWGit7IjUH
         7V9prGOSWELmFip5+lApu+3ylx8EZ27QS70wwnHEl1Y9jYRpusgbrgOwlonD5IjY2k/z
         4ebHmO4cQDv/tG/jVWvvWN2Z6tevkY7reV4AiDzKSkM5aQGKKQunMxOAqKdpCLwenO+1
         Ec9A==
X-Gm-Message-State: ALQs6tCgG2I/iptuYpNK33rSuiiKHQmlHiIwLOcionoqZ/ZukFjvFItV
        xcpqZup03IbGjRxUMvg33ptadR9gIR4=
X-Google-Smtp-Source: AB8JxZoGjZC+wIYQXOWJtw2szEXTD2lysq7Ff2gbMtK02wmLJp0zIK69dlyLqepO41TFI8me2623Ag==
X-Received: by 2002:a17:902:4003:: with SMTP id b3-v6mr38181744pld.15.1525733973551;
        Mon, 07 May 2018 15:59:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 65-v6sm811351pgh.87.2018.05.07.15.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 06/13] alloc: add repository argument to alloc_commit_node
Date:   Mon,  7 May 2018 15:59:09 -0700
Message-Id: <20180507225916.155236-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c           | 2 +-
 blame.c           | 2 +-
 cache.h           | 3 ++-
 commit.c          | 2 +-
 merge-recursive.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index 2c8d1430758..9e2b897ec1d 100644
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
index dfa24473dc6..ba9b18e7542 100644
--- a/blame.c
+++ b/blame.c
@@ -161,7 +161,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	read_cache();
 	time(&now);
-	commit = alloc_commit_node();
+	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
diff --git a/cache.h b/cache.h
index 1717d07a2c5..bf6e8c87d83 100644
--- a/cache.h
+++ b/cache.h
@@ -1768,7 +1768,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
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
index 9106acf0aad..a9a43e79bae 100644
--- a/commit.c
+++ b/commit.c
@@ -51,7 +51,7 @@ struct commit *lookup_commit(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_commit_node());
+				     alloc_commit_node(the_repository));
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..6dac8908648 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -98,7 +98,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
-	struct commit *commit = alloc_commit_node();
+	struct commit *commit = alloc_commit_node(the_repository);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->tree = tree;
-- 
2.17.0.255.g8bfb7c0704

