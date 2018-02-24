Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9275F1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBXAsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:17 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41719 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeBXAsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:08 -0500
Received: by mail-pf0-f196.google.com with SMTP id a17so4187596pff.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWahokPkyOn8WoTDuDboMqGR9s1Py5qjeauxkfr0taQ=;
        b=jYa9fyoQmgWC+7cpvt5OYGi8T8iekakd2xURP4JNpiOOJu0MET1+eTOanZghwz1TEH
         W2iRH7BF2fjHTGt0qmcDAkN2SMn4hgzjdN8ZOq8QuUD7/m9g1SVf6wQVt6Cs9HgiT3Ey
         KE0v7Xd+SsuEtEdVu1eCuEwmRxZKj2hIxyPULePFbLhPhT95PBhx8HHSVU6992hni8uZ
         fWjZ11NPjI0u1V9SQv++DEQP8R8zj5D0CCl5glyZCxYkZ5LcOZVQGTZ9L5WscHQ7soxs
         RLM0CjNRMlV2hBGhY7vBNn94c2DFtXoBt7JVgmqsS+mYg2UToPwaOlI70SFYDwtR5THa
         qJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWahokPkyOn8WoTDuDboMqGR9s1Py5qjeauxkfr0taQ=;
        b=iDj/ZhdpgQNZJjbKw0cAwqq6m4VHS8ce65vdBjTSWol3d/driTywR8Y6hmwRnjQiRY
         EOZHDLnAU3MgdeQFMzheXIUZcQYDM8jIxV9C87MPoJX9oLoSMDyVdw+n7x7w5vzjcdZY
         KzDN9ukZx1zpWbIWBWwKacEibzwaOQH0B0+2dc6c4JN6jp5bRGZlcBza6DAONORtXDjh
         lJJPgx8fHkYVqpElh/VLG+nnjufv7KwMkZuOyHXciYUMRGTFoFnxryBjCjH9bRgHZdw8
         w27seSK+g2zkNY+7ecF2dMXkFBNrcRRrpzmYQBO8pztE0Vw7+xe6w5c6ZfeO5+bbWSV4
         dK0g==
X-Gm-Message-State: APf1xPAIXsJUtpDhe13Rohs/ZPeJKLV2eikRmGlYgYTyWAn0CcO2KAb/
        1Cma6hWus+wvq6AfcZE4y8Kkjry/5y4=
X-Google-Smtp-Source: AH8x226TM8U6usGFo2YzlH8+g7jayRZebWWzSgjfbyofxYs8r8i3oQCB5GY8nsWHp66jPS0S2E791g==
X-Received: by 10.99.135.65 with SMTP id i62mr2747396pge.331.1519433287378;
        Fri, 23 Feb 2018 16:48:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p1sm6178934pgr.44.2018.02.23.16.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 06/27] object-store: close all packs upon clearing the object store
Date:   Fri, 23 Feb 2018 16:47:33 -0800
Message-Id: <20180224004754.129721-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
 object.c               | 7 +++----
 packfile.c             | 4 ++--
 packfile.h             | 2 +-
 8 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6661edc162b..fc1d9b43c51 100644
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
index 101c27a593f..13cfaa6488a 100644
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
index 8ee998ea2ee..4d72efca781 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs();
+	close_all_packs(&the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 92ba99a1a5e..0af0c53a632 100644
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
index 75e7f18acef..8e25aae54c8 100644
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
index 367441efa94..a7c238339bd 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "packfile.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -468,8 +469,6 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->alt_odb_tail = NULL;
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
-	/*
-	 * TODO: call close_all_packs once migrated to
-	 * take an object store argument
-	 */
+	close_all_packs(o);
+	o->packed_git = NULL;
 }
diff --git a/packfile.c b/packfile.c
index 59210deaaf7..65d9a4f6c61 100644
--- a/packfile.c
+++ b/packfile.c
@@ -310,11 +310,11 @@ static void close_pack(struct packed_git *p)
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
index a7fca598d67..6a2c57045ca 100644
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

