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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC7C433EC
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA9B6196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC1NQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhC1NQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F0C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 12so5228083wmf.5
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0jKUhbnAdlCRSN9qe3wlw58/aokVl+4Onhy95KtYSs=;
        b=RxCunq2C/iqavje+crlLezah9QAf8E6RI3g2suQKjqIg7Xkt0xpxRcDA4nZOr3+fyp
         vUwugzBk3zP4rN/eEfY1SoTxYHNVh7ygH9jcTGcYTfr66Ym6ZT86OJMVhTUH3GtbckMz
         1Ugs9+EQVUqO3aqiHQoU8RNivVD1n+UzxwO68BNWpFhWqEcz/TRbwT26v7FkKMYQNhXZ
         ILcmSznzuZFYGKGy9lgS6Tganthk4B0uLFUhQlZSW8BGoaiekFVsuX28jJxXE5U3Dg70
         Wo4qzkmeKrOqWVU5rIBxRYequEhJ8+d4F1EsHeA/hSHOYWxypefSqlS9NNR18mUXwmRE
         sC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0jKUhbnAdlCRSN9qe3wlw58/aokVl+4Onhy95KtYSs=;
        b=ljlqJyKCWkaho5Vxl3bY9V/M8ZPcGLAygQo4NvKyVhZ2sjzaL+hKuvJc4Dndml09xY
         niL0jrBgWPx01a0APIZr5sp/Q/0tzoLlqhJkYT/GpQjmv0uySLgl0G1rrILneRvj0UVN
         16TmriwyK/95GtA6QXUEWSX+edF8ikK0YXTto9DZwRFaNa5UtaHrihaRTv5Wt/8rfbPR
         NTTDPqokIlAUe5WHysE34CSeAclw6kyP6SKHuoS2N7skN2XfoQ/TPKWpKRPX7xGAziC1
         MuDuUyUM5gNmutzbvjD7nJ/nYKL0D8C3sIGhOtQ8oYqTcsQufn07DXDTV4+O+WtZdKUm
         j8nw==
X-Gm-Message-State: AOAM531ZTUT7Adk6Z/YpGbgbrgFiv7gx/+RMiXKgVNi7grasiCRYOsjo
        69ngKKM92wkQx5d1VEO+OVrBnW96Z5uS8A==
X-Google-Smtp-Source: ABdhPJz8TmQIb5EISgMLOWYgp2UFJ2GmeFz81LVaPSU+lza+z+KLrdh58nnVHMqBYd/aHUnMNAEpDQ==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr10657251wmf.185.1616937367654;
        Sun, 28 Mar 2021 06:16:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/19] fsck.c: move gitmodules_{found,done} into fsck_options
Date:   Sun, 28 Mar 2021 15:15:48 +0200
Message-Id: <patch-16.20-611631dd779-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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

An earlier version of this patch removed the small amount of
duplication we now have between FSCK_OPTIONS_{DEFAULT,STRICT} with a
FSCK_OPTIONS_COMMON macro. I don't think such de-duplication is worth
it for this amount of copy/pasting.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c |  2 +-
 fsck.c       | 23 ++++++++++-------------
 fsck.h       |  9 ++++++++-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index fb04a76ca26..0f898a5ae14 100644
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
index a59832a1650..642bd2ef9da 100644
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
@@ -606,7 +603,7 @@ static int fsck_tree(const struct object_id *oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&gitmodules_found, oid);
+				oidset_insert(&options->gitmodules_found, oid);
 			else
 				retval += report(options,
 						 oid, OBJ_TREE,
@@ -620,7 +617,7 @@ static int fsck_tree(const struct object_id *oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&gitmodules_found, oid);
+						oidset_insert(&options->gitmodules_found, oid);
 					else
 						retval += report(options, oid, OBJ_TREE,
 								 FSCK_MSG_GITMODULES_SYMLINK,
@@ -1132,9 +1129,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
 
-	if (!oidset_contains(&gitmodules_found, oid))
+	if (!oidset_contains(&options->gitmodules_found, oid))
 		return 0;
-	oidset_insert(&gitmodules_done, oid);
+	oidset_insert(&options->gitmodules_done, oid);
 
 	if (object_on_skiplist(options, oid))
 		return 0;
@@ -1199,9 +1196,9 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
-void register_found_gitmodules(const struct object_id *oid)
+void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
 {
-	oidset_insert(&gitmodules_found, oid);
+	oidset_insert(&options->gitmodules_found, oid);
 }
 
 int fsck_finish(struct fsck_options *options)
@@ -1210,13 +1207,13 @@ int fsck_finish(struct fsck_options *options)
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
@@ -1241,8 +1238,8 @@ int fsck_finish(struct fsck_options *options)
 	}
 
 
-	oidset_clear(&gitmodules_found);
-	oidset_clear(&gitmodules_done);
+	oidset_clear(&options->gitmodules_found);
+	oidset_clear(&options->gitmodules_done);
 	return ret;
 }
 
diff --git a/fsck.h b/fsck.h
index d284bac3614..e20f9bcb394 100644
--- a/fsck.h
+++ b/fsck.h
@@ -118,15 +118,21 @@ struct fsck_options {
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
+	struct oidset gitmodules_found;
+	struct oidset gitmodules_done;
 	kh_oid_map_t *object_names;
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
 	.skiplist = OIDSET_INIT, \
+	.gitmodules_found = OIDSET_INIT, \
+	.gitmodules_done = OIDSET_INIT, \
 	.error_func = fsck_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
+	.gitmodules_found = OIDSET_INIT, \
+	.gitmodules_done = OIDSET_INIT, \
 	.error_func = fsck_error_function, \
 }
 
@@ -146,7 +152,8 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
-void register_found_gitmodules(const struct object_id *oid);
+void register_found_gitmodules(struct fsck_options *options,
+			       const struct object_id *oid);
 
 /*
  * fsck a tag, and pass info about it back to the caller. This is
-- 
2.31.1.445.g087790d4945

