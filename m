Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FA91F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162279AbeBPRqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40962 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758982AbeBPRqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:45 -0500
Received: by mail-pg0-f65.google.com with SMTP id t4so2954684pgp.8
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMrMAMjbKUtAJvJSiXE7GDvo3ONv/eaeBOOcef3sLXw=;
        b=JTeuATiBjQWua0fjnbAiWt8Csp9h8FGbEcrs8GSZKWNWERtzDkvvALi6aHQGYG/HrY
         0JzsOYHfboXWoAvM0bHhlJExZPwnZ0bkoLhyWuPzgdrDo6idYfZK1ChukHHjjYHxU6AI
         xU9wxPK62bQT3zzYfNFeyv4JUe3BOjYZDSMG9ztBP7ojvqFBKptVZ5pALmcl4MJS6kRY
         o3n+i9Qi84tvwzkdvOInvTOmM4mklKeBQ6LqeZDCcJI2uRpKujo9qRVOxIamToEo+Wdi
         RGwBx6SpvcjqEclCq1V4cQhyi11qUgXvt6xaIBlUJWQaU7jcT5gEE/2/FNKvN5RLw8ue
         nuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMrMAMjbKUtAJvJSiXE7GDvo3ONv/eaeBOOcef3sLXw=;
        b=H8sYcqVEWygJ4I/X1WLwY+O8SogCxrGsa7p56L/eHsiIqb7/67W61Fm4dRAeh5NUQ4
         eiQgcucmidYN9bR3jIMQwIz6QWLQZSBc/dh52o7nfl3BxMod4MCP/R/62W8MaxJuXn90
         B9cUtNfOFli0C12J+Y1yJvdGANyBFh+uEgoxbwhrv58mYTaMvVR4/+kSbVtfwPNaBYiK
         9x7r6t8GrdIvsWWuDXrI4qH8kpUcbZvdx5vOU64HNbA894ZRXr5XfpFU4wcECuAWqckK
         HS+XAsjHqtQpURzCz404NeSPfSiUli6VDpuTWwBMEl6nvc7rlP2AMY2GSizx2sPg95io
         2sLQ==
X-Gm-Message-State: APf1xPBKrL2oK+Stnms0GZy+udXvt1KXE8UTuzZInkGfDs88wjHnDmg2
        6KTt26KY7bod+Ad9SwszWGZQzw==
X-Google-Smtp-Source: AH8x224/D44/vKsRh9EadnnyukzZIqTtSGlxxWGV5rzTXFmpYfJndVz+Jz4bVDlqixpwg/fkwWaFFQ==
X-Received: by 10.99.176.15 with SMTP id h15mr5809708pgf.374.1518803204362;
        Fri, 16 Feb 2018 09:46:44 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u25sm41713159pfh.142.2018.02.16.09.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/16] pack: move approximate object count to object store
Date:   Fri, 16 Feb 2018 09:46:17 -0800
Message-Id: <20180216174626.24677-8-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 10 +++++++++-
 packfile.c     | 11 +++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/object-store.h b/object-store.h
index 794cb0af59..80a2ca6f75 100644
--- a/object-store.h
+++ b/object-store.h
@@ -23,6 +23,14 @@ struct raw_object_store {
 
 	unsigned ignore_env : 1;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
@@ -31,7 +39,7 @@ struct raw_object_store {
 };
 
 #define MRU_LIST_INIT {NULL, NULL}
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_LIST_INIT, NULL, NULL, 0, 0 }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_LIST_INIT, NULL, NULL, 0, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index a8a2e7fe43..693bafbc98 100644
--- a/packfile.c
+++ b/packfile.c
@@ -803,8 +803,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -814,8 +812,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -825,8 +823,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -901,7 +900,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.16.1.291.g4437f3f132-goog

