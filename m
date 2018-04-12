Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2191F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDLAV7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33696 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeDLAVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so1694305plp.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mt0LCfHZ6wQ5sGINm62IZRKIUO/Svux/Py0JiygyPaY=;
        b=Ni7pFEeCoc8IU54Y6gSZ5miFIPW58K0Vbut3ivI/t5cuCo/3oixxgb9oDtGh5GP0jy
         +0GMRize2NeptM0wM+dD9sspSXnzgQt45jbw8vysEZ8F8ODmPDJL6T6GAqnCt3KwvTnd
         ySMKzVJdsY1RHb/s2Vig0F7FEiO1cCuU2qNNDsgyDGtpDK9+C2H7T0O9OtFCFkgPUw1x
         YRw67QZuevmMup7wTEV113z0kpyg9pu9zPixE5aqhCc0LtGksrARzeaFbB6nbPDe335D
         Kz16+saJc0nGaKl/KhE2X82nF95jAc6GM20iO9PbUPGQEzH/WK6iRCYp224r9Bote4nM
         xStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mt0LCfHZ6wQ5sGINm62IZRKIUO/Svux/Py0JiygyPaY=;
        b=bG1bOpXRAVvVCMp/sTYIM5s4I9JBY6PqwH7yD3UFYG5dxP86QBT6VMqx1imHSgQ+d6
         4+LmilAo5aTWhlsuVUE5gQJvbjb1VjuwsJgTluI+law1vHM8zp2MByoOgwU7bGSqwLzE
         6nYApUcRKUtecZ/I2LLASBOaz6RNi+VgMqtLmuycCX5BqC55WHduQKTIeN1RgOUvEkKP
         47MWm+SBdpKyRYBkKG/psYRaETQdkOqzVJzjzH4YJc6Kcr7V++bODCBnoJyXEUtYv6Si
         ngSjbZtnZkyGD/iv3rIPmFvmLywAB9jfH3x/rXHO6fLMXXWgPqiBz1V6bJYUVG9ZcJ9u
         z89A==
X-Gm-Message-State: ALQs6tA2rL/F54ZJfy+pvZNAPT9W209TFUnwaIDJNdOg7hN2rqeH/C8c
        9pmeExV7bt1dc+8Ldw+E9iwkMA==
X-Google-Smtp-Source: AIpwx4/dHMW6q4tGnCXEDph1u3gqMNAEkRTFhoiVyucxv695bd7E+nLk5LZpJdWUzUu+woZh5iEOqw==
X-Received: by 2002:a17:902:274a:: with SMTP id j10-v6mr7153242plg.28.1523492499999;
        Wed, 11 Apr 2018 17:21:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m66sm5909923pfb.82.2018.04.11.17.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 11/15] refs: store the main ref store inside the repository struct
Date:   Wed, 11 Apr 2018 17:21:14 -0700
Message-Id: <20180412002118.102976-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the 'main_ref_store', which was a global variable in refs.c
into the repository struct.

This patch does not deal with the parts in the refs subsystem which deal
with the submodules there. A later patch needs to get rid of the submodule
exposure in the refs API, such as 'get_submodule_ref_store(path)'.

Acked-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c               | 13 +++++--------
 refs.h               |  4 +---
 refs/files-backend.c |  4 ----
 repository.h         |  3 +++
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index f58b9fb7df..36df1bc73a 100644
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
+	if (r->refs)
+		return r->refs;
 
-	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
-	return main_ref_store;
+	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	return r->refs;
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bec8e30e9e..5c76a75817 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -61,10 +61,6 @@ struct ref_lock {
 	struct object_id old_oid;
 };
 
-/*
- * Future: need to be in "struct repository"
- * when doing a full libification.
- */
 struct files_ref_store {
 	struct ref_store base;
 	unsigned int store_flags;
diff --git a/repository.h b/repository.h
index 09df94a472..e6e00f541b 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,9 @@ struct repository {
 	 */
 	struct raw_object_store *objects;
 
+	/* The store in which the refs are held. */
+	struct ref_store *refs;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
-- 
2.17.0.484.g0c8726318c-goog

