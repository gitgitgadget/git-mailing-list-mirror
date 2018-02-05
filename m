Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60F91F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBFAGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:06:40 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42436 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeBFAGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:06:33 -0500
Received: by mail-pg0-f68.google.com with SMTP id m28so127845pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdLZUGe3Bn6CwATZqRE5wRkq0RB97t/fniKBaEKjJBY=;
        b=K3E/JbcvqUsrNLYqD6IpC8bqxgG2XB1yAZ2Kbak5YPBd/PYtcGg28piIAkiFEUEmo6
         q4uVgmkGf4cBfa6W1WMS9BdVvzp225a656HWy0HwX2hBKx2aOddl3cpd5zhiT/etb9kS
         PG26wvvvz53k5Al4WLsN/bsod/4JlUpam5QNWF9heobPiUgeKQFm8dvQ+uhIkqT3cXAm
         C2G+3EoIcBz7ynwImTgqnEN6jp4g1W2uXCR8gPNloZRdEYbDYwU5JfQJsNtuBJKjLe4N
         1OuEI653eEYxffht6qkXrR5N+49Og6iI1yv719+B5l8nUeFYRQXmVlKf39N4nyA7nhT9
         bTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdLZUGe3Bn6CwATZqRE5wRkq0RB97t/fniKBaEKjJBY=;
        b=PfvpN7gmqtxgQ6F7rtY98pkKXQtIV45JQUzk/Y4Yvooid6VH7TZ4BGN+zQKIyRKkAB
         TMDiLM7bnj2+OtM2f94hj3a6rKBnIGfXo9PDSqUl3gesGIMmIh4/mR/2C/V2212VOrqB
         38jbKk9KMcnQqawm3YpobLz9HLJEil2GgZ/NDdHAlm27uuKiwWPfjY295k19Z7ziObeX
         vzcAa+QwaHemAwHpJqIiSyc/712TQ5jemZM7U2QepH0TQzY5D8Oz2VdeJHskEFzF1PYQ
         lgBKD4+Sds4x9HmvSp1hU/7dEp7caORLIcCcmmXVLRwvtsEw4CvuY42l7M4Jk442acsj
         z2gQ==
X-Gm-Message-State: APf1xPD9ZSNj+8IXzu3RNzzcoiul9QCAOBjGvdgdzRl4dBXI/xWR7/F7
        Z/qw7T+kxDHX/FLI7HmEP8GE20ZnWoI=
X-Google-Smtp-Source: AH8x225sigfcU+FaiU1VSkJGuJRW8p9HOOwPZe14dspTVlqu/t+SxXh5fXIGOfiCmf8nqUGJj/JqeQ==
X-Received: by 10.98.12.23 with SMTP id u23mr541425pfi.40.1517875592601;
        Mon, 05 Feb 2018 16:06:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t66sm14645795pgc.89.2018.02.05.16.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:06:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 059/194] refs: store the main ref store inside the repository struct
Date:   Mon,  5 Feb 2018 15:55:20 -0800
Message-Id: <20180205235735.216710-39-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c       | 13 +++++--------
 refs.h       |  4 +---
 repository.c |  2 +-
 repository.h |  5 +++++
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index c2dee7a69a..f079d65030 100644
--- a/refs.c
+++ b/refs.c
@@ -1609,9 +1609,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
 	return entry;
 }
 
-/* A pointer to the ref_store for the main repository: */
-static struct ref_store *main_ref_store;
-
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
@@ -1653,13 +1650,13 @@ static struct ref_store *ref_store_init(const char *gitdir,
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
diff --git a/repository.c b/repository.c
index 0ec9648f53..6f85fade82 100644
--- a/repository.c
+++ b/repository.c
@@ -6,7 +6,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, OBJECT_STORE_INIT,
+	NULL, NULL, NULL, OBJECT_STORE_INIT, NULL,
 	NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
diff --git a/repository.h b/repository.h
index ba7b3b7cb9..727ddcea5b 100644
--- a/repository.h
+++ b/repository.h
@@ -33,6 +33,11 @@ struct repository {
 	 */
 	struct object_store objects;
 
+	/*
+	 * The store in which the refs are hold.
+	 */
+	struct ref_store *main_ref_store;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
-- 
2.15.1.433.g936d1b9894.dirty

