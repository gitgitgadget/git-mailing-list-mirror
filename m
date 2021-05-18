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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E997CC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9416100A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbhERIvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhERIvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:51:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D4C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f22so5581687pgb.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ABxLZ2kXd7dymUR4nNmOnnAi3rUDf/XzffP1R/U5X0=;
        b=H4p1eAS7WNqzVg+f80yQvT1v7WQ/7IP8YZz66jeudwgZeqG7+9RXbIrJJV1FtFzyC4
         M67MINN6OYYWm68eHOfInLrd8mDJxw32O90KAdYegCC8n5BoSkx2YMXxGEPM2hXxehiA
         6Kx1INk1zFU0fiwsYUr6mkvVXVqRJ4ho3hBeRgLsjoS8daBSqMQ3qd14XKHpy80YSj+M
         loJEDjXxnIsXCFhf3Em+Fod4/R/NNrOtlYspAl5qyXzv1+ow8rTMjCXEffhGve1LTKe8
         Oaq/ZeLFd5kHh1JGasvIiViML8/rIJVVnBZSfXnHs42HllUuzVyQjOvR4dUkbZEmI/7s
         rswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ABxLZ2kXd7dymUR4nNmOnnAi3rUDf/XzffP1R/U5X0=;
        b=k6SGEEnULRZu90vKYT0SypprNyV2SCZ4N/bihAhM3aYBHK8dEUsuAKdsamwQNdIEze
         3XHxw3Pf3hkJ1rzzaikVi70ampwoiVaZlCVmB40TCj3f9DMbCUCXWRQNc9n6ZluIWL2q
         5vZQrUXSZ4CiutxCuG8z6URBIYbzOi4UZ96sd4GTGUECYfE6ss9Hr3NWrUjVdROqj3jD
         yX9oERQhcZEDBk8qjBuiuRY8uEJD7Xu2OUx0LyhRvjpoDnWnAy26AIAp5N/Dy/PX8Yfg
         wMGO9MOQRIYEfVbnpCewDoloJV2sCOPE9Dkp8XyGWluBvbMPE8wOT1cKoD8y6gva/itJ
         t5mA==
X-Gm-Message-State: AOAM533yL+abLWftUm8IH1HFazGvek/pE/pbfRxHEKCBrl0hoFotSf8B
        tUDc1vDqWqahbj5JzswD/PXei8IztTTs2XHFSC8=
X-Google-Smtp-Source: ABdhPJy5wVZsTP66U4K3iodHRnZN4YCkRbXVNkGhslrikOmcl8+fkQCdJvD5dwG7p2yICTWeUaE5cQ==
X-Received: by 2002:a62:7d82:0:b029:2de:2c39:c6a4 with SMTP id y124-20020a627d820000b02902de2c39c6a4mr3021999pfc.75.1621327832696;
        Tue, 18 May 2021 01:50:32 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.147])
        by smtp.gmail.com with ESMTPSA id t1sm12231076pjo.33.2021.05.18.01.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 01:50:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 1/3] packfile-uris: support for excluding commit object
Date:   Tue, 18 May 2021 16:49:51 +0800
Message-Id: <73e64147b17cb382d34357c913616095b6169650.1621327467.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g7e39198978.dirty
In-Reply-To: <cover.1621327467.git.dyroneteng@gmail.com>
References: <cover.1621327467.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the server, more sophisticated means of excluding objects should be
supported, such as commit object. This commit introduces a new
configuration `uploadpack.excludeobject` for this.

The old configuration `uploadpack.blobpackfileuri` is only support to
exclude blobs and the name has no abstract meaning, so the configruation
name changes, to support more object types. Compatibility issues will
not be considered because packfile-uris now is an experimental feature.

In addition to the configuration name, the format of the configuration
value has also been expanded. When excluding the commits (or trees in
the future) objects, the old format `<object-hash> <pack-hash> <uri>`
can not express the meaning of recursion. So, the format is expanded,
the new format `<object-hash> <recursively> <pack-hash> <uri>` should
deal with this scenario (When processing commit objects, whether they
are absolutely recursively excluded).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 53 ++++++++++++++++++++++++++++++------------
 fetch-pack.c           |  5 ++++
 upload-pack.c          |  5 ++--
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..e687061420 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -99,6 +99,8 @@ static struct bitmap *reuse_packfile_bitmap;
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
 static int allow_pack_reuse = 1;
+static int in_commit_order;
+static int exclude_until_next_commit;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
 	WRITE_BITMAP_QUIET,
@@ -132,6 +134,7 @@ struct configured_exclusion {
 	struct oidmap_entry e;
 	char *pack_hash_hex;
 	char *uri;
+	int recursively:1;
 };
 static struct oidmap configured_exclusions;
 
@@ -1291,10 +1294,16 @@ static int want_object_in_pack_one(struct packed_git *p,
  * and its offset in these variables.
  */
 static int want_object_in_pack(const struct object_id *oid,
+			       enum object_type type,
 			       int exclude,
 			       struct packed_git **found_pack,
 			       off_t *found_offset)
 {
+	if (exclude_until_next_commit && type != OBJ_COMMIT)
+		return 0;
+	if (type == OBJ_COMMIT)
+		exclude_until_next_commit = 0 ;
+
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
@@ -1345,6 +1354,8 @@ static int want_object_in_pack(const struct object_id *oid,
 						&p) &&
 				    *p == ':') {
 					oidset_insert(&excluded_by_config, oid);
+					if(ex->recursively && type == OBJ_COMMIT)
+						exclude_until_next_commit = 1;
 					return 0;
 				}
 			}
@@ -1394,7 +1405,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
-	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
+	if (!want_object_in_pack(oid, type, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -1420,7 +1431,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
-	if (!want_object_in_pack(oid, 0, &pack, &offset))
+	if (!want_object_in_pack(oid, type, 0, &pack, &offset))
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
@@ -2985,27 +2996,33 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			pack_idx_opts.flags &= ~WRITE_REV;
 		return 0;
 	}
-	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+	if (!strcmp(k, "uploadpack.excludeobject")) {
 		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
-		const char *oid_end, *pack_end;
+		const char *oid_end, *pack_end, *recursively_end;
 		/*
 		 * Stores the pack hash. This is not a true object ID, but is
 		 * of the same form.
 		 */
 		struct object_id pack_hash;
-
+		char recursively[2];
 		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
 		    *oid_end != ' ' ||
-		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
+		    !strlcpy(recursively, oid_end + 1, sizeof(recursively)) ||
+		    parse_oid_hex(oid_end + 3, &pack_hash, &pack_end) ||
 		    *pack_end != ' ')
-			die(_("value of uploadpack.blobpackfileuri must be "
-			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
+                        die(_("value of uploadpack.excludeobject must be "
+                              "of the form '<object-hash> <recursively> <pack-hash> <uri>' (got '%s')"), v);
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
-			die(_("object already configured in another "
-			      "uploadpack.blobpackfileuri (got '%s')"), v);
-		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
-		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
+                        die(_("object already configured by an earlier "
+                              "uploadpack.excludeobject (got '%s')"), v);
+		recursively_end = oid_end + 2;
+		ex->pack_hash_hex = xcalloc(1, pack_end - recursively_end);
+		memcpy(ex->pack_hash_hex, recursively_end + 1, pack_end - recursively_end - 1);
 		ex->uri = xstrdup(pack_end + 1);
+		if (atoi(recursively)) {
+			ex->recursively = 1;
+			in_commit_order = 1;
+                }
 		oidmap_put(&configured_exclusions, ex);
 	}
 	return git_default_config(k, v, cb);
@@ -3023,7 +3040,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	struct rev_info *revs = _data;
 	struct object_info oi = OBJECT_INFO_INIT;
 	off_t ofs;
-	enum object_type type;
+	static enum object_type type;
 
 	display_progress(progress_state, ++nr_seen);
 
@@ -3031,7 +3048,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
+	if (!want_object_in_pack(oid, type, 0, &p, &ofs))
 		return 0;
 
 	oi.typep = &type;
@@ -3831,7 +3848,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
-				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+				N_("exclude any configured uploadpack.excludeobject with this protocol")),
 		OPT_END(),
 	};
 
@@ -3903,6 +3920,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fetch_if_missing = 0;
 		strvec_push(&rp, "--exclude-promisor-objects");
 	}
+
+	if (in_commit_order){
+		use_internal_rev_list = 1;
+		strvec_push(&rp, "--in-commit-order");
+	}
+
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 2318ebe680..cdf8777907 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "strmap.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1677,6 +1678,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	struct strset uris;
+	strset_init(&uris);
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1684,6 +1687,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
+		if (!strset_add(&uris, uri))
+			continue;
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
diff --git a/upload-pack.c b/upload-pack.c
index 5c1cd19612..4d994658d2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1745,9 +1745,8 @@ int upload_pack_advertise(struct repository *r,
 			strbuf_addstr(value, " sideband-all");
 
 		if (!repo_config_get_string(the_repository,
-					    "uploadpack.blobpackfileuri",
-					    &str) &&
-		    str) {
+					 "uploadpack.excludeobject",
+					 &str) && str) {
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
 		}
-- 
2.31.1.442.g7e39198978.dirty

