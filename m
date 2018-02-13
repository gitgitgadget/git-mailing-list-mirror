Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C17F1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeBMBW6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:22:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41234 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeBMBWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:54 -0500
Received: by mail-pl0-f66.google.com with SMTP id k8so5856346pli.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9AUj1eKtOEI/K15CncdTyzC8lTdqUbh27fq1bc7FFo=;
        b=sV3KvNLexhBAfu8PXX1/kzDFiKp/ry8yZHW0k039HFYbagdP97wNcQQQBE5kmF7jGX
         Y6DZBpEUrNBUeNUrT4Ylr3QKLzuTSMZzgShlZnm2CByhDl2uIoK3Bc5k7EajL0g2Og6C
         DIeJ231OUsUHnQjQYVMIzUo6JDjp4wLH0YDEkxUfgQJqCF+pE7SdPgPmkoBoUUq2T1ry
         vOsfmGbaM+QcNKTC83HzB26ewS/NB9kqsRefIvUq4CR/5mc0Vu1Mc9nTFOEQB1JlifGE
         Dhww3YUcwrF1YRAHlc4U4iN4UwScEdg/OyB9qWJrPr+2/cFl0Q9yUzhht0V9CZYHy6c8
         UpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k9AUj1eKtOEI/K15CncdTyzC8lTdqUbh27fq1bc7FFo=;
        b=DMVoL1qVhUnA4K65efCS1qOl9QZdw7RoS73G05ReyTcjZ26ikQxrGzxDJ/mo+XECJv
         XE/X+EvSwZ7uvcz0+6yKqK5PQrmmbQ3D3+CkNPP+dvarTRhwW08PgPb5V0/S67+veHy7
         zfeg5WGsGdyUNEOiRla+kDkvCVw5ocNtAIMrBEYDPLQ+kM37hElgLT/kYDEDPnMzOHVZ
         OvzSNVfZxavnwus7CnYNc9kE5a0AwOroaSTBKAi1X3PGb/Y7OyoXJoNK4qk/8Hk4zBdb
         vzLI04STAO9njI6A1vTOx4Kq/iNpFwZLICD3nUNRCnU3uogKRz0WhXE4BqvdloTEnOIe
         Fzkw==
X-Gm-Message-State: APf1xPAIdn02ziCSd660QNQQV2jLY+sqwMlEAzz4MaauwCmayWdKNq4r
        WF5RXkq+mhhasL5N6+dHH0GkWQ==
X-Google-Smtp-Source: AH8x224QMTIi0jWnOi6OFP8vK8qXXgcVTTy8H3W2mz/KjAunxzWapgAfR4UdXS3vYeUl8zAwPgROXQ==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr12596843plb.192.1518484973360;
        Mon, 12 Feb 2018 17:22:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u25sm24690940pfh.142.2018.02.12.17.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/26] object-store: close all packs upon clearing the object store
Date:   Mon, 12 Feb 2018 17:22:20 -0800
Message-Id: <20180213012241.187007-6-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
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
index acfe9d3c8c..75e16dfec6 100644
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
index 284651797e..7ec08d4696 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1200,7 +1200,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs();
+		close_all_packs(&the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..70015ccdc7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1407,7 +1407,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
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
index 81d083bec1..79c2c447bc 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "packfile.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -468,8 +469,5 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->alt_odb_tail = NULL;
 
 	mru_clear(&o->packed_git_mru);
-	/*
-	 * TODO: call close_all_packs once migrated to
-	 * take an object store argument
-	 */
+	close_all_packs(o);
 }
diff --git a/packfile.c b/packfile.c
index 11b0e6613c..2ce1b2cef7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -306,11 +306,11 @@ static void close_pack(struct packed_git *p)
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
index 0cdeb54dcd..fa547226b7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -61,7 +61,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
+extern void close_all_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.16.1.73.ga2c3e9663f.dirty

