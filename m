Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EF01F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162435AbeBPRrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:47:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33746 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758974AbeBPRqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:42 -0500
Received: by mail-pg0-f68.google.com with SMTP id g12so2976085pgs.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMajzGF2/pxI9GZZpmpYQL0TT70ulV1I8YrgIurnVGg=;
        b=Gu01VM4NVR26/oDSGZG2oLugrPGoVZTfWAzUdZuZjDxAfLoJcoOjTRW1CJgLmEtLFi
         Fi894IxXn3YuKqYPhJ/E8jbguQt+5dBjPoDGQDhe6HA2fpQIxyqvjDt2LWRgwavrrf+Y
         938WsFmWPt3U1NU6ltqXNqA44MEbF7uJerk05GyLUCgXLjVL3A3XWNew5Vzm44XCDmiy
         QhXujNCn9UtID4LT/6ZalmdRKzIsUHBqlKCmULZTJZWEjJG4yMN378WyRWLtUeoNdWWZ
         1WKH2iy2OXdtiG5KJKsQnRbeRyzdyUpwFueDdXBvOyfl2QqMuGa/znzDy9s344mIGMUr
         6iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMajzGF2/pxI9GZZpmpYQL0TT70ulV1I8YrgIurnVGg=;
        b=tlsmq9DmDhmrEMTwlu1yeu/bRas/h4ycWkXECrRcNangxQjAvBulCTRiBfjWhriAjr
         bWOy0mU63wABN2tPK+d2sz5tVgxDhM2FqA8x4zB53Tp81XwLjn8UIz2Hymhj0XIFowGn
         gW2hvCgGd6zjxWLCRsRN9iueygyDt1Pj58slPs4mxzjHICBWtZNLZd1mLKdXEh02gbML
         k2Q85AUK2cXhIn3mvkmdFipBbQH0XCskT+wLZNgjjyQ7EG+krxg3nn33Pr4YOx7gnqCb
         ItYbWXLFX8LhBTKgj1SvIxvmzusPbI16skNWsHWYRmC8ibVAmodWTX6ONN+ixncYVLN7
         c/Og==
X-Gm-Message-State: APf1xPDbTa+PQMAf33pJTpTkhNj3Tyzn0k64bUa5cqX2IOHZkTAgwzGS
        c/WsnKlEa9owMGwe2CK6Vah6/Q==
X-Google-Smtp-Source: AH8x226qSvcMhKsHfPuvqf3LCtzMk5Bfq4QnRbde3gYyke8YXj+JIzbAzJ80MzVeUlaFtu8Y0dV85Q==
X-Received: by 10.101.85.204 with SMTP id k12mr5936655pgs.40.1518803201128;
        Fri, 16 Feb 2018 09:46:41 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j1sm38776091pff.94.2018.02.16.09.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 05/16] object-store: close all packs upon clearing the object store
Date:   Fri, 16 Feb 2018 09:46:15 -0800
Message-Id: <20180216174626.24677-6-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c           | 2 +-
 builtin/clone.c        | 2 +-
 builtin/fetch.c        | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 object.c               | 6 ++----
 packfile.c             | 4 ++--
 packfile.h             | 2 +-
 8 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5bdd2d7578..4762a702e3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1859,7 +1859,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_all_packs();
+		close_all_packs(&the_repository->objects);
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 101c27a593..13cfaa6488 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1217,7 +1217,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs();
+		close_all_packs(&the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..4d72efca78 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs();
+	close_all_packs(&the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..907ae44ab5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -411,7 +411,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_all_packs();
+			close_all_packs(&the_repository->objects);
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b2eac79a6e..954fc72c7c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2027,7 +2027,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.git_cmd = 1;
 			proc.argv = argv_gc_auto;
 
-			close_all_packs();
+			close_all_packs(&the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
diff --git a/object.c b/object.c
index c76b62572a..34daaf37b3 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "packfile.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -469,8 +470,5 @@ void raw_object_store_clear(struct raw_object_store *o)
 
 	while (!list_empty(&o->packed_git_mru))
 		list_del(&o->packed_git_mru);
-	/*
-	 * TODO: call close_all_packs once migrated to
-	 * take an object store argument
-	 */
+	close_all_packs(o);
 }
diff --git a/packfile.c b/packfile.c
index d41e4c83d0..511a2b0cdf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -311,11 +311,11 @@ static void close_pack(struct packed_git *p)
 	close_pack_index(p);
 }
 
-void close_all_packs(void)
+void close_all_packs(struct raw_object_store *o)
 {
 	struct packed_git *p;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = o->packed_git; p; p = p->next)
 		if (p->do_not_close)
 			die("BUG: want to close pack marked 'do-not-close'");
 		else
diff --git a/packfile.h b/packfile.h
index a7fca598d6..6a2c57045c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,7 +63,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
+extern void close_all_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.16.1.291.g4437f3f132-goog

