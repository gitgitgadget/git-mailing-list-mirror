Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB70F1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbfGYRq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36127 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403778AbfGYRqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so23121791pfl.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bpk3wr41CYiAJ4HkSwkwTEWE0aKVSlGBPncgk2Hk5E=;
        b=hbmF3RdplgXorAm1bSOi2xZxDysiteUrnaEKOXIJorSql6UtZuYnhUJ+LOKkmGx55b
         IlBnfSF/Qab6XMsVnoM5FHuZ3hDF0dJunAtXBJR9c9U4k8vDRx+WYwIgm+CAyCnJNyKj
         IC/9QEhnnGC9XV0O8fTJTovdX7BM2FgHsZ0xFfsZqbUqa8Yj0QtL04hbfOQM6OC8uo2C
         KnRm5/TI8964P4EQdudcc+HT5OVP2EUcUD4+63Zg45wOeFJFeaxW3YbyPuR9kR8rRABc
         XFuT1u3JN2sgsIl0ltawfnSiCOUQWN/US4wWAvtgprVMVJnyzHlTzUAGwp8o24ys/lp2
         898Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bpk3wr41CYiAJ4HkSwkwTEWE0aKVSlGBPncgk2Hk5E=;
        b=opcPNe1YHQqkpd9GXRKf7hzcpLIDqi/+UhJHsFXPVDvveBVNG4NVXM8UI5bpKlMdn5
         ol/Ao6lv3vczgOIzLuzIUEU2bShl8m6cnq1Btn0NKVihNG6bJ7Ghef438K0Dsd30awGm
         zJMYHK9OIEEH4c7619zN6puo4APFccuaVgLTFe3Ksj2ML/xHVg7HI1j24rttZL0BPQww
         jdxwju/+in3VZYg7/7iRoY/3s2pb7tvF3WJW6qzYE4pRzYWq8y+bVIVOip6FtxxRbfUK
         iabDojexVbRG8lsmlv1QQ5CAmYRfWCltSldpmNHWDaRVDETQ0LXiXYa+eDZVZc+27qh6
         6OGQ==
X-Gm-Message-State: APjAAAWd3IiLGPhUVwkZM5nkqIF6hjyfCyMhxWPlJo15wzqnqVTYPEbN
        QKcyF3RBG9nP/3H922H5x8SoI53+
X-Google-Smtp-Source: APXvYqzvAfb8T6Cfe01p0HAwnZdimqKmFOEpR4hlM5OMkVWDvUgpO7fmgbKJhFaq2wMy8vcehSMNBg==
X-Received: by 2002:a63:24a:: with SMTP id 71mr9411533pgc.273.1564076783699;
        Thu, 25 Jul 2019 10:46:23 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/19] Move write_tree_from_memory() from merge-recursive to cache-tree
Date:   Thu, 25 Jul 2019 10:45:59 -0700
Message-Id: <20190725174611.14802-8-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code changes, just moving the function to what seems like a more
logical place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache-tree.c      | 30 ++++++++++++++++++++++++++++++
 cache-tree.h      |  2 ++
 merge-recursive.c | 30 ------------------------------
 merge-recursive.h |  1 -
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 706ffcf188..d2baf6baf5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -659,6 +659,36 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	return ret;
 }
 
+struct tree *write_tree_from_memory(struct repository *repo)
+{
+	struct tree *result = NULL;
+	struct index_state *istate = repo->index;
+
+	if (unmerged_index(istate)) {
+		int i;
+		fprintf(stderr, "BUG: There are unmerged index entries:\n");
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
+			if (ce_stage(ce))
+				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
+					(int)ce_namelen(ce), ce->name);
+		}
+		BUG("unmerged index entries in merge-recursive.c");
+	}
+
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(istate->cache_tree) &&
+	    cache_tree_update(istate, 0) < 0) {
+		BUG("error building trees");
+	}
+
+	result = lookup_tree(repo, &istate->cache_tree->oid);
+
+	return result;
+}
+
 static void prime_cache_tree_rec(struct repository *r,
 				 struct cache_tree *it,
 				 struct tree *tree)
diff --git a/cache-tree.h b/cache-tree.h
index 757bbc48bc..4d67c237ba 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,6 +47,8 @@ void cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
+struct tree *write_tree_from_memory(struct repository *repo);
+
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 
 int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
diff --git a/merge-recursive.c b/merge-recursive.c
index 1a3c6ab7f3..937a816288 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,36 +412,6 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->unpack_opts);
 }
 
-struct tree *write_tree_from_memory(struct repository *repo)
-{
-	struct tree *result = NULL;
-	struct index_state *istate = repo->index;
-
-	if (unmerged_index(istate)) {
-		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < istate->cache_nr; i++) {
-			const struct cache_entry *ce = istate->cache[i];
-			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
-		}
-		BUG("unmerged index entries in merge-recursive.c");
-	}
-
-	if (!istate->cache_tree)
-		istate->cache_tree = cache_tree();
-
-	if (!cache_tree_fully_valid(istate->cache_tree) &&
-	    cache_tree_update(istate, 0) < 0) {
-		BUG("error building trees");
-	}
-
-	result = lookup_tree(repo, &istate->cache_tree->oid);
-
-	return result;
-}
-
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, int stage, void *context)
diff --git a/merge-recursive.h b/merge-recursive.h
index 33f3d53c09..973f2729a8 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -97,7 +97,6 @@ int merge_recursive_generic(struct merge_options *o,
 
 void init_merge_options(struct merge_options *o,
 			struct repository *repo);
-struct tree *write_tree_from_memory(struct repository *repo);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
 
-- 
2.22.0.559.g28a8880890.dirty

