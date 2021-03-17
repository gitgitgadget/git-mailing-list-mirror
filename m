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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2933C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811CA64F44
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhCQSV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhCQSVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E7C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so1866235wmf.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxXaQhKKDImbKww4WtZYHgS/NFxDHSbGo40ilOcOwRs=;
        b=hIyLpHlrvsV/mrvORiM5tZ9kk4U+mcWRmvxLv6B1l1r5yGbIRiYvQqRt1x0aJDU193
         T/LN+VTzP2b2v7vNWGzOiwvJJL8Nz4gujmoKaHP+qNNoMfP9db+kaElmyVFC/wtd6mPA
         vnKe6NEXtHUlRn0taRp/g0z39xqoMZKxakcxEeBlo3DoOnSHjt9RL+SfMnevk3gTi2AG
         T2F10cehLCcnEkFseVNFwUKi7zR7vK2K4CocYfdwhi3wL+T9XzwKfO4S7BxSP5nSds2w
         SmTDYKAyw2JdpjMF+uoyeTM1VhAaqWg0wMyCbPopkEVBYYH8Xab1KJoyxZlldQVO1K+U
         vBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxXaQhKKDImbKww4WtZYHgS/NFxDHSbGo40ilOcOwRs=;
        b=oqUOULORWDdpOJ5wlHW6MaJnn6bpnfYUNUQMRJ4/mVr1/dIu9mhDXGJsd3ZmA5DKQM
         ShnBt3Q9I+MM/9h+/akt+q+uH4gNz/RXOGfeoQWePPIGgMkGPUMhX8JzLiiWMKJ/wS2E
         cR2g5iyT0NTfyobwZX5enD52OAFSogootX6yd0I3qQ9J6Zhsjtt4cSNIPV/8TUyTMoFO
         aOkM/UWTpg8ziflmMkrMRMt8TGTGooorl5ofztSYPicf5ZNetnsV6XsJMIzXgZMhGDFd
         Es3cFZs1popDLAZpH477ol1lG9R9CAsxOUe605jLlt1ne0LlbuzLYjKp9jA+pCRLGyTP
         Ot3Q==
X-Gm-Message-State: AOAM531lQYUYTypqaxZDJlHb+eNj7orMltDYF7sQeY9bWSl8jNyyL4EW
        AU9cnpWhA7DZmCJ061tabuXQf8epRQi1eg==
X-Google-Smtp-Source: ABdhPJwx4z82rCE4YnE2QVUYkdZvRc8TLwzQJISc0S5PO9VSC5GHEnd1WXVkmsIGfWa5vnaUKwPwMQ==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr85916wmc.179.1616005283195;
        Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/19] fsck.c: move gitmodules_{found,done} into fsck_options
Date:   Wed, 17 Mar 2021 19:20:51 +0100
Message-Id: <20210317182054.5986-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index 307d454d92..00760b1f42 100644
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
index 344c3ddc74..b25ae9d8b9 100644
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

