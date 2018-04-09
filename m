Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D88C1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeDIWqJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38497 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeDIWpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id c7-v6so2842963plr.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b644eyjjOTxS7dobtNeXa6DyMG84pvgIbHN9e3kKVTA=;
        b=elNdoIgSohMOfyXeInGF59iYieo0CzIy6d91Z9D0iLNWOvdzFx7qvd5VPEB35LyfaX
         VmcTYJ89q9IIYPF7iNZejTAfNiC9x45srX+eAjseBpw0K4z2fsF5hGoaqaN7TWD/JaJU
         O0rvCJF9mBRdA4dAe3e0cn86PySmBTOEszo25knMQDa3V7u0iwvSzvKY1rBK5XjF6bwI
         WGm+qk7iNEqbsqEc/SvD3XBfmOjjQP3Rinc9vNDA9e6S0Q4v7XTksYFqr0aXP+K1Yc9/
         7eQB+jB7VUBubKabXjyZ2BsOLHnvcy2EqRMOsWMZvIuA1VoYxXOm2LDT0388EX4UJOX5
         3ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b644eyjjOTxS7dobtNeXa6DyMG84pvgIbHN9e3kKVTA=;
        b=rDTK5pmcVR7DlabfJ80LYBx/x9Glo2j9xnwzGqIaa3N7syRO/NFNcsg7URVuKSgMCz
         iYYHnPYSv3M9PsnwNROXkiDsUu1axDu5baZ1JKq3hHwsvdVL8QUSrO5so0/cGRRxFSXF
         A/q7Ruzbzlxm4X5MyvA20k91OkGBNypbguzRWgIxb34XV1LtgdGSeMYuUw8iCjPQqxFK
         qJ/Uw9oz15b3QDzlz+w/wUuPlespsy2cL/vGccz3f3kp3EGvAfW0wxeKSvZFMkzBuV1M
         SowbsSX4Moz28tgWbPh0awhfbwdfg9m1nSYSM2WFJo6LW+AU3VJaDIq/5E+xqUa7iHeG
         PW9w==
X-Gm-Message-State: AElRT7FxLSwhYqGeySE4VthKL6zKDVHbGm3E8gdIAzj1MtrMpotq0IQN
        WFBdRHgfZxXJ3tUt1IaCskBX2g==
X-Google-Smtp-Source: AIpwx4/uW0RdBXTe8EaD9s2ARnw12UXDqzfAH9gxC3oy9FNiPDV8FsMkgUxth0xsZhOeJaFJKb8/2g==
X-Received: by 2002:a17:902:2941:: with SMTP id g59-v6mr40617358plb.55.1523313954982;
        Mon, 09 Apr 2018 15:45:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d83sm2622206pfl.176.2018.04.09.15.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 12/16] refs: store the main ref store inside the repository struct
Date:   Mon,  9 Apr 2018 15:45:29 -0700
Message-Id: <20180409224533.17764-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c       | 13 +++++--------
 refs.h       |  4 +---
 repository.h |  3 +++
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index f58b9fb7df..b5be754a97 100644
--- a/refs.c
+++ b/refs.c
@@ -1608,9 +1608,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
 	return entry;
 }
 
-/* A pointer to the ref_store for the main repository: */
-static struct ref_store *main_ref_store;
-
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
@@ -1652,13 +1649,13 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	return refs;
 }
 
-struct ref_store *get_main_ref_store_the_repository(void)
+struct ref_store *get_main_ref_store(struct repository *r)
 {
-	if (main_ref_store)
-		return main_ref_store;
+	if (r->main_ref_store)
+		return r->main_ref_store;
 
-	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
-	return main_ref_store;
+	r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	return r->main_ref_store;
 }
 
 /*
diff --git a/refs.h b/refs.h
index ab3d2bec2f..f5ab68c0ed 100644
--- a/refs.h
+++ b/refs.h
@@ -760,9 +760,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 
 int ref_storage_backend_exists(const char *name);
 
-#define get_main_ref_store(r) \
-	get_main_ref_store_##r()
-struct ref_store *get_main_ref_store_the_repository(void);
+struct ref_store *get_main_ref_store(struct repository *r);
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
diff --git a/repository.h b/repository.h
index 09df94a472..7d0710b273 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,9 @@ struct repository {
 	 */
 	struct raw_object_store *objects;
 
+	/* The store in which the refs are held. */
+	struct ref_store *main_ref_store;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
-- 
2.17.0.484.g0c8726318c-goog

