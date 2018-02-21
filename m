Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1601F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBUB4U (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:56:20 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37382 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeBUByt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:49 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so89676plb.4
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMajzGF2/pxI9GZZpmpYQL0TT70ulV1I8YrgIurnVGg=;
        b=Bp4IUJF11Eg20g1En5ElUrSh3XWntwO0oxOZ+VDfn5ReXj8Z0Xd+eXLS01r0hRTZvQ
         rbA16JnVgWUfTICZqKkH094kX7lek+jwy2gXpdi4mZvkfwAXgv/CIXuvkXzxxF2SFbOW
         X7D0p931bHRjjSD1iJ8W/L5tw/HLqGRWQAbE9dn08VAFtSdMBHUgki7ESuQ2zx0WSdnA
         ZE6Y2aCZ7RmbRCf8LvESeXoTjSmc8ZxvskRFaJYCxZ40XGtwvvvnhV+cE7t9dNmUEhDk
         oIyDD5hVvYgRS4aoiZ1UjfpL+4eJhwtbahMs7XDJpTt1jUd2VU2Dy7VuF5JSjEg9kBj0
         nC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMajzGF2/pxI9GZZpmpYQL0TT70ulV1I8YrgIurnVGg=;
        b=KJx+97jmElH4pG1AucmXZF3AbwlMPTiuou6qsd1Cihl2rzHFyc2SclM9HMHxbcENkM
         m3e4DHu+oLT2ZrP0uPfM09MNolP5TIrYc+AqZJRcTHCf9ANSkV5r2kcu2NYS4cunL2gH
         EzPBs2saSdRSu0WJPFI7KyY4ZJ5lGB3JwXmSeBMoj7vJF+35zzXoG9MxLsw+xfYVrlCG
         4G8Lich2HUb1OSLPqPXC504zNLUe3hG05YLLzqeWSodh2YSzijSOWdGMhV7lm6AfAYnv
         +yhHmFDTmD0xKCO7IdbcWw/wgEE7uU7TCUVd+tU3hRx6vZsrIicK/51rW6Sdz/n+XTLv
         CePA==
X-Gm-Message-State: APf1xPACYtewQiUlGnbFYxMwA+cKcidKmix/z3bybtp+rtNPMSqZOuQT
        rVDCzMRsNsJcNAbdRhSv+p7Bn4OPNcQ=
X-Google-Smtp-Source: AH8x226Gt/fVgSBzmCkkHU3TyGH86TRQhNltUwLZI/e77lZ0u68SCaeE6qBQ7E3b+7or4e6NRCJ78g==
X-Received: by 2002:a17:902:365:: with SMTP id 92-v6mr1518982pld.127.1519178088379;
        Tue, 20 Feb 2018 17:54:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d13sm280508pgn.64.2018.02.20.17.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH 06/27] object-store: close all packs upon clearing the object store
Date:   Tue, 20 Feb 2018 17:54:09 -0800
Message-Id: <20180221015430.96054-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
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

