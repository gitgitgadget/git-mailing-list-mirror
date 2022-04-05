Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F98C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiDEFWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiDEFWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E61148
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 125so1809354pgc.11
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsSQtk8kvYuDMzk4KAlsVDSwNinAWmFX4d77yTL+OhE=;
        b=GNFHcKCX7zEElWxTH/Mnizj4EvfqJgPG9lS0OLb6/T0XvWfXwR1N3sbO9sE3vgF54J
         23kLJNZFwpsTELVK9fDsyd3U4q5OU0IZUBeP/SXcnwdLSznCjUMaKTR8Rkb2NuDp95Q+
         wKKYO3LftztfO2i5sf5Mp5I+7IeQSi6ZbIHx3i14PFLARlAkjTYqKklq3KKKE6Tmrl76
         XkOFPm8TljEGGkXj2yqfugJQ2i4XveZpl6xKH3lWU8BsYOPvoaq6GDWLNpLMPY8Jij3O
         sUVsjdvxmUdjZJv7w9aHlUCxN8byOAa9mclCs8/q2/F/8bRsWebkY8VAOI9GuvnFPcK2
         MH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsSQtk8kvYuDMzk4KAlsVDSwNinAWmFX4d77yTL+OhE=;
        b=wJK+H1liEo4YYplP0dKOAUnXDK4vtneTzgOlNQNlTnNtYq78VSHpLYutllkvBL3AUV
         WD/7Aq4G68zDQbhQHSzkMkc8HPB/312HBRgW80efYKceWSLPp0xBltHIzSKYkg2gxFji
         0ZOVnRdKlodL7oAksKq6QzqdDkA/u0w6p+60YlSudwvsSyCfX30XkXNE3TT1TIBsEEXj
         yHEWK/MRQG/UncmIKkx6ofH8C6G9shZw6EKjh26sjLSnUyVGFiqRdZeKel0WeMDsKmWi
         phy1OGxWRHO2rQn6mU1zUkZQVxn/QZ+G9usxseAgCPBX8O2dUwEqkEDAlVEoHWZu2M+g
         49jA==
X-Gm-Message-State: AOAM5308FhsnRSjI5+bxAm+8d0huIR1FnrqE0dwOmR2Pe6iDQtqnrR9P
        jfgseSbnMMfchXm/O8NbDjo=
X-Google-Smtp-Source: ABdhPJwlM8C/3d+2ejWnkszLvkfytn+glaadGjtobIzrdPdi2/zE9xyefklZyMhsWdrwRRM2KYyF+Q==
X-Received: by 2002:a63:e952:0:b0:382:65eb:257 with SMTP id q18-20020a63e952000000b0038265eb0257mr1419015pgj.465.1649136024899;
        Mon, 04 Apr 2022 22:20:24 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:24 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 01/12] bulk-checkin: rename 'state' variable and separate 'plugged' boolean
Date:   Mon,  4 Apr 2022 22:20:07 -0700
Message-Id: <20220405052018.11247-2-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit prepares for adding batch-fsync to the bulk-checkin
infrastructure.

The bulk-checkin infrastructure is currently used to batch up addition
of large blobs to a packfile. When a blob is larger than
big_file_threshold, we unconditionally add it to a pack. If bulk
checkins are 'plugged', we allow multiple large blobs to be added to a
single pack until we reach the packfile size limit; otherwise, we simply
make a new packfile for each large blob. The 'unplug' call tells us when
the series of blob additions is done so that we can finish the packfiles
and make their objects available to subsequent operations.

Stated another way, bulk-checkin allows callers to define a transaction
that adds multiple objects to the object database, where the object
database can optimize its internal operations within the transaction
boundary.

Batched fsync will fit into bulk-checkin by taking advantage of the
plug/unplug functionality to determine the appropriate time to fsync
and make newly-added objects available in the primary object database.

* Rename 'state' variable to 'bulk_checkin_packfile', since we will
  later be adding 'bulk_fsync_objdir'. This also makes the variable
  easier to find in the debugger, since the name is more unique.

* Rename finish_bulk_checkin to flush_bulk_checkin_packfile and call it
  unconditionally from unplug_bulk_checkin. Internally it will
  conditionally do a flush if there's any work to do.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

The net effect of these changes is to make a clear separation between
the portion of the bulk-checkin infrastructure that is related to the
packfile (nearly all of it at present) and the part that is related to
other future optimizations of the ODB.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6d6c37171c9..88d72178b2c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_packfile {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_packfile;
 
 static void finish_tmp_packfile(struct strbuf *basename,
 				const char *pack_tmp_name,
@@ -39,7 +39,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 	free(idx_tmp_name);
 }
 
-static void finish_bulk_checkin(struct bulk_checkin_state *state)
+static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
@@ -80,7 +80,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	reprepare_packed_git(the_repository);
 }
 
-static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
+static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
 	int i;
 
@@ -112,7 +112,7 @@ static int already_written(struct bulk_checkin_state *state, struct object_id *o
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_to_pack(struct bulk_checkin_state *state,
+static int stream_to_pack(struct bulk_checkin_packfile *state,
 			  git_hash_ctx *ctx, off_t *already_hashed_to,
 			  int fd, size_t size, enum object_type type,
 			  const char *path, unsigned flags)
@@ -189,7 +189,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct bulk_checkin_state *state,
+static void prepare_to_stream(struct bulk_checkin_packfile *state,
 			      unsigned flags)
 {
 	if (!(flags & HASH_WRITE_OBJECT) || state->f)
@@ -204,7 +204,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_to_pack(struct bulk_checkin_state *state,
+static int deflate_to_pack(struct bulk_checkin_packfile *state,
 			   struct object_id *result_oid,
 			   int fd, size_t size,
 			   enum object_type type, const char *path,
@@ -251,7 +251,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		finish_bulk_checkin(state);
+		flush_bulk_checkin_packfile(state);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
@@ -278,21 +278,22 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 }
-- 
2.34.1.78.g86e39b8f8d

