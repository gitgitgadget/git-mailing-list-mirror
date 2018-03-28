Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB8A1F42D
	for <e@80x24.org>; Wed, 28 Mar 2018 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeC1RZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:25:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46594 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeC1RY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:24:58 -0400
Received: by mail-pg0-f67.google.com with SMTP id t12so1185223pgp.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cRiJN+Ne6DL4AiVx3VDOA8DP/j9GAVYfH6Vj0batJlQ=;
        b=eLCRIMAX0ItA5a6tUZjfKbzigYWwHyBUFeXHOzbbwamp5y6IR8x7liFEk2xv2bvEbt
         MupDoNFt4xaJI5+lzMA+zshrn0xoN39WNq+iOjy7NDeVM6km9uw35wQWbxcEKZcqcr0E
         LRkWcYxZeOjjSCNdhiOUEA8V2xHPMULDDDNygU0ZGTZ4WnK+Och66t5J4uE2fGCGsiUQ
         xj0igN0O0RyyujHBUvqV+mkY3gTiuvpOa7kCnKNSAwBtyHCOMjOO/DYDfYONLR3LqAJb
         JPvWuuiDR5u3AVND8sse3kbYjpITeDIzGJie8e1C5iXKfXtpzYL8CNnHTZv4OtVkbvGG
         /9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cRiJN+Ne6DL4AiVx3VDOA8DP/j9GAVYfH6Vj0batJlQ=;
        b=UhQC1ebxaVb+t7mV5dku3TirLaSvM4TYjqVHFXIgjtmrorYv2mZe4XNMQ4tNtv93CJ
         nGBoGCwjPrvEWnPHUCm23E09A2ljMGUUgyLVNdi6QA8j69xZHRTVQGmK9N7JLxD/nIcL
         v0ExstRLb3poWJMaqkVlTDzE0HNAn1/S8vss1brqWi9e9SNnAuKnYNQexUl0N6sroaTL
         OIFvZGmP269olPa6iszFDpK4XHZpXSLBBLY3+6u7Be4kmOo9FDzXRS5A97Z2L7ghF4Nb
         7LA4aSS2/RjVEBjDUr6H+UofekxvjHAYkLHoGMj/kbOUSdPyEM0EaouZ5oDeq5t/FC4p
         SEXQ==
X-Gm-Message-State: AElRT7Gh7dCazH0QrSBfbtFF7kS8RDJCmtlsBIG+u47oSrxWX3gLRUmK
        5kXuvrfqb3qTih29twvXaIuWxg==
X-Google-Smtp-Source: AIpwx49L7Kzd7gmw8ZaHuAuRvbBVQE47Mvdco+mkWbQZ25BamqCBOwmcvrI8BTcBriKAxRxhj0oAug==
X-Received: by 2002:a17:902:a582:: with SMTP id az2-v6mr4763930plb.37.1522257897138;
        Wed, 28 Mar 2018 10:24:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z14sm7157238pgv.26.2018.03.28.10.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:24:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCH 2/6] submodule-config: allow submodule_free to handle arbitrary repositories
Date:   Wed, 28 Mar 2018 10:24:45 -0700
Message-Id: <20180328172449.27012-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At some point we may want to rename the function so that it describes what
it actually does as 'submodule_free' doesn't quite describe that this
clears a repository's submodule cache.  But that's beyond the scope of
this series.

While at it remove the extern key word from its declaration.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt | 2 +-
 builtin/grep.c                                   | 2 +-
 submodule-config.c                               | 6 +++---
 submodule-config.h                               | 2 +-
 t/helper/test-submodule-config.c                 | 2 +-
 unpack-trees.c                                   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index ee907c4a82..fb06089393 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -38,7 +38,7 @@ Data Structures
 Functions
 ---------
 
-`void submodule_free()`::
+`void submodule_free(struct repository *r)`::
 
 	Use these to free the internally cached values.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 789a89133a..8f04cde18e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -651,7 +651,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free();
+			submodule_free(repo);
 			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
diff --git a/submodule-config.c b/submodule-config.c
index 602ba8ca8b..a3efff1a34 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -642,8 +642,8 @@ const struct submodule *submodule_from_cache(struct repository *repo,
 			   key, lookup_path);
 }
 
-void submodule_free(void)
+void submodule_free(struct repository *r)
 {
-	if (the_repository->submodule_cache)
-		submodule_cache_clear(the_repository->submodule_cache);
+	if (r->submodule_cache)
+		submodule_cache_clear(r->submodule_cache);
 }
diff --git a/submodule-config.h b/submodule-config.h
index a5503a5d17..6b71a8cd30 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -46,6 +46,6 @@ extern const struct submodule *submodule_from_path(
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
 						    const char *key);
-extern void submodule_free(void);
+void submodule_free(struct repository *r);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index f23db3b19a..9971c5e9dd 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -64,7 +64,7 @@ int cmd_main(int argc, const char **argv)
 		arg += 2;
 	}
 
-	submodule_free();
+	submodule_free(the_repository);
 
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index d5685891a5..05e5fa77eb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -290,7 +290,7 @@ static void load_gitmodules_file(struct index_state *index,
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
 			repo_read_gitmodules(the_repository);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
-			submodule_free();
+			submodule_free(the_repository);
 			checkout_entry(ce, state, NULL);
 			repo_read_gitmodules(the_repository);
 		}
-- 
2.17.0.rc1.321.gba9d0f2565-goog

