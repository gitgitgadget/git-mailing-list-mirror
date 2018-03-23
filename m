Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B2A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCWRXK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:23:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34066 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeCWRVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id c78-v6so14702691lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZ9/1PGa0ltNv7SgbRNl8RHwqJPCt518gTlKcVG72GI=;
        b=oDcyKadwOIwtqGNppqRcZQ+/iw6woiyJfYYR1EaSLt2OtCdhhvN03rkoCqyvXk/8Hr
         emEJTwcK+GTmZYgkk+6/auRMTF46xitnixAIteXdgUL70i0nMJHXnpb3D8vtMc45zS6k
         008RFusj+pPGUfY33qyc8113J8jE02pPKEIqbaT9zuUhu4eTg7YHaPD9VepUSp6Ny7PR
         N9uOYENeSfpJ5/PCenOcQUhjLoinkSIgyMAnFHazFetZ6Z5q3I/k5vNuQh57VxD1Eaem
         qPR5LDfLtgvlFcolHDhRz8rzrPJt5MNztF4Sd5wL5Maz26xBxBNn8cBqxgRrTvXTOnit
         Wu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZ9/1PGa0ltNv7SgbRNl8RHwqJPCt518gTlKcVG72GI=;
        b=ORYUN2870fMYxGz8YV8ihxg3pE5OxcJPx5a7E8CP2SIxhCi5ZCLY2ePFaoZ1eP+0sn
         Nlb0oIiVZtf8r1KoMOa4Q5A13uhZEVFW1/Npa8IZRxieRQat3/uWJRQMTPMd+l3mKpam
         GKNOz9wNk7uQLOyVOM06/9ZxEYyOvd9QOa0hlM0mv+i8s8c1YSGBImPrUX4giiwihqMq
         6Xv+0wWYD9hVoVVs78Jv2bOXEJVbuG9o/TnoEOutn01X+T8PkbWTE5C+kY7EJVsnEe+n
         PI3f/ibi/MqUn1VXc1Dy8mXaoVsfbFIHHGA7fLLTeggnL0pG3kgOVDnHvXeoy0mitQJi
         nfPA==
X-Gm-Message-State: AElRT7HpyeHhi9fHnmZoAYU/ronWBlYxamfWtIHR7yFFCyBfUygEKmcu
        +c/oQeggGuevNL+wf3dauZ4=
X-Google-Smtp-Source: AIpwx49deBpQOxPMzSsFl7GcTwDfxGPiPojN4gdOVnu29D69n+RKjHtXPoJ3T1FEEcASG9Gcok/YUw==
X-Received: by 2002:a19:f101:: with SMTP id p1-v6mr6051093lfh.118.1521825707969;
        Fri, 23 Mar 2018 10:21:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/27] object-store: close all packs upon clearing the object store
Date:   Fri, 23 Mar 2018 18:21:00 +0100
Message-Id: <20180323172121.17725-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
index 5bdd2d7578..47beddbe24 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1859,7 +1859,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_all_packs();
+		close_all_packs(the_repository->objects);
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 855947f1ab..7df5932b85 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1218,7 +1218,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs();
+		close_all_packs(the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..a39e9d7b15 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs();
+	close_all_packs(the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..96d56cbdd2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -411,7 +411,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_all_packs();
+			close_all_packs(the_repository->objects);
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f52..1a298a6711 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2026,7 +2026,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.git_cmd = 1;
 			proc.argv = argv_gc_auto;
 
-			close_all_packs();
+			close_all_packs(the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
diff --git a/object.c b/object.c
index 04631ee841..4c2cf7ff5d 100644
--- a/object.c
+++ b/object.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "object-store.h"
+#include "packfile.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -483,8 +484,6 @@ void raw_object_store_clear(struct raw_object_store *o)
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
index 39f4a85200..f2dc084745 100644
--- a/packfile.c
+++ b/packfile.c
@@ -311,11 +311,11 @@ static void close_pack(struct packed_git *p)
 	close_pack_index(p);
 }
 
-void close_all_packs(void)
+void close_all_packs(struct raw_object_store *o)
 {
 	struct packed_git *p;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = o->packed_git; p; p = p->next)
 		if (p->do_not_close)
 			die("BUG: want to close pack marked 'do-not-close'");
 		else
diff --git a/packfile.h b/packfile.h
index 76496226bb..5b1ce00f84 100644
--- a/packfile.h
+++ b/packfile.h
@@ -66,7 +66,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
+extern void close_all_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.17.0.rc0.348.gd5a49e0b6f

