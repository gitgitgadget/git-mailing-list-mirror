Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E7C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57CF6511B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhCPQSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhCPQSM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF433C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1781827wmi.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWprKFlNUI27M0pkOkKU3pJzus6HWEumeKCB0WZfN9s=;
        b=sK5loQs58joHPuQ251iZGqOFuYJRkWy9f0DdkwERncet7xgsKIhT9/PjeApHkbQOic
         FU94sOgZxGw36S4YRL83L4TEZ7fPbIE/4JaXH9hVQ74EGUTi4QGCrpMpzi7fH1/ATp0d
         QyKuJ/N/mU6WFA6b3ZvEmafNuRqjN+nvAj2iz+fnFY6rPyKNfZJzR9GPz2K1fPMzgQCr
         3t8Qcv9k17jc7GErW+K7eNAFIlDKeGp5DAHip+SuLH8+V+VQC+Q5OoOKvyj2XtBAEojk
         TRUAOrDrIlFfbCBeZU6AFzW/T1G3hwK4MLd/guxonKopnPbYtQ9iA1GQ7IEWxgzuW3Vp
         F9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWprKFlNUI27M0pkOkKU3pJzus6HWEumeKCB0WZfN9s=;
        b=s4xJNTpTny5iVvvWdntGcShchA82mRSpR29wzRLD6OC+HYu0q1wau8p5bzoGYlhioI
         WJp5E8wwElEk1HO0pqPAP2G662J4c7mvGpKLzWLYtCibWE9HanYyn1qEkKicopD73gac
         vPBHWIInDdXCFBaYT+1FXGDYz0+VIgJRjvnvMNoo99LgTW9dAOEJ1bdpqlPp2Va5Nz9J
         MD3E7Llqhk7zaRQr1duYTDN1fcwDpkMAkDtZ9XCUEiB860lJfGfiW6oH3TW4/GS/Q6kl
         CQqH4Zj4qvPkmlCz0DlvE1RmG7QE8tsJiTlfxRfBoMDxV4uQ6fjL7M4/185cK5YQB95o
         9Bxg==
X-Gm-Message-State: AOAM533Gz0OCzcsRNSENPJ7gHjeWcL1Q/+QElE3trMwJmzBeW+OPZ7uJ
        S7ZHSjGY5Ybc/44QgkprREtgSN+c33p0tA==
X-Google-Smtp-Source: ABdhPJy5u/rwfjxP8M/3zx+XE6MWX6n1As0j/Yc+jmL1by3ffav1+sQpLBcwGvIVMtRiTOkhyzJyCg==
X-Received: by 2002:a05:600c:4a06:: with SMTP id c6mr382796wmp.35.1615911490414;
        Tue, 16 Mar 2021 09:18:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/22] fsck.c: move gitmodules_{found,done} into fsck_options
Date:   Tue, 16 Mar 2021 17:17:35 +0100
Message-Id: <20210316161738.30254-20-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the gitmodules_{found,done} static variables added in
159e7b080bf (fsck: detect gitmodules files, 2018-05-02) into the
fsck_options struct. It makes sense to keep all the context in the
same place.

This requires changing the recently added register_found_gitmodules()
function added in 5476e1efde (fetch-pack: print and use dangling
.gitmodules, 2021-02-22) to take fsck_options. That function will be
removed in a subsequent commit, but as it'll require the new
gitmodules_found attribute of "fsck_options" we need this intermediate
step first.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c |  2 +-
 fsck.c       | 23 ++++++++++-------------
 fsck.h       |  7 ++++++-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6a61a46428..82c3c2c043 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -998,7 +998,7 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(oid);
+		register_found_gitmodules(&fo, oid);
 	if (fsck_finish(&fo))
 		die("fsck failed");
 }
diff --git a/fsck.c b/fsck.c
index f26f47b2a1..565274a946 100644
--- a/fsck.c
+++ b/fsck.c
@@ -19,9 +19,6 @@
 #include "credential.h"
 #include "help.h"
 
-static struct oidset gitmodules_found = OIDSET_INIT;
-static struct oidset gitmodules_done = OIDSET_INIT;
-
 #define STR(x) #x
 #define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
@@ -624,7 +621,7 @@ static int fsck_tree(const struct object_id *oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&gitmodules_found, oid);
+				oidset_insert(&options->gitmodules_found, oid);
 			else
 				retval += report(options,
 						 oid, OBJ_TREE,
@@ -638,7 +635,7 @@ static int fsck_tree(const struct object_id *oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&gitmodules_found, oid);
+						oidset_insert(&options->gitmodules_found, oid);
 					else
 						retval += report(options, oid, OBJ_TREE,
 								 FSCK_MSG_GITMODULES_SYMLINK,
@@ -1150,9 +1147,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
 
-	if (!oidset_contains(&gitmodules_found, oid))
+	if (!oidset_contains(&options->gitmodules_found, oid))
 		return 0;
-	oidset_insert(&gitmodules_done, oid);
+	oidset_insert(&options->gitmodules_done, oid);
 
 	if (object_on_skiplist(options, oid))
 		return 0;
@@ -1217,9 +1214,9 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
-void register_found_gitmodules(const struct object_id *oid)
+void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
 {
-	oidset_insert(&gitmodules_found, oid);
+	oidset_insert(&options->gitmodules_found, oid);
 }
 
 int fsck_finish(struct fsck_options *options)
@@ -1228,13 +1225,13 @@ int fsck_finish(struct fsck_options *options)
 	struct oidset_iter iter;
 	const struct object_id *oid;
 
-	oidset_iter_init(&gitmodules_found, &iter);
+	oidset_iter_init(&options->gitmodules_found, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
 		enum object_type type;
 		unsigned long size;
 		char *buf;
 
-		if (oidset_contains(&gitmodules_done, oid))
+		if (oidset_contains(&options->gitmodules_done, oid))
 			continue;
 
 		buf = read_object_file(oid, &type, &size);
@@ -1259,8 +1256,8 @@ int fsck_finish(struct fsck_options *options)
 	}
 
 
-	oidset_clear(&gitmodules_found);
-	oidset_clear(&gitmodules_done);
+	oidset_clear(&options->gitmodules_found);
+	oidset_clear(&options->gitmodules_done);
 	return ret;
 }
 
diff --git a/fsck.h b/fsck.h
index 6c2fd9c5cc..bb59ef05b6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -118,6 +118,8 @@ struct fsck_options {
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
+	struct oidset gitmodules_found;
+	struct oidset gitmodules_done;
 	kh_oid_map_t *object_names;
 };
 
@@ -125,6 +127,8 @@ struct fsck_options {
 	.walk = NULL, \
 	.msg_type = NULL, \
 	.skiplist = OIDSET_INIT, \
+	.gitmodules_found = OIDSET_INIT, \
+	.gitmodules_done = OIDSET_INIT, \
 	.object_names = NULL,
 #define FSCK_OPTIONS_COMMON_ERROR_FUNC \
 	FSCK_OPTIONS_COMMON \
@@ -149,7 +153,8 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
-void register_found_gitmodules(const struct object_id *oid);
+void register_found_gitmodules(struct fsck_options *options,
+			       const struct object_id *oid);
 
 /*
  * fsck a tag, and pass info about it back to the caller. This is
-- 
2.31.0.260.g719c683c1d

