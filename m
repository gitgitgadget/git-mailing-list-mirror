Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FEC433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 03:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiBADd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 22:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiBADdv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 22:33:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF1C06173B
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so29198345wrv.10
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AgZew7ky/nbRHYXi94LQzSIIx2HllTTTMJfHESY22Nc=;
        b=ChAsD/EKse3Ym6EZuIJrq6LxxFedqZNn03tLaAkPNIXGE5ApoNz46WXJrnx4uWdBR1
         1fa0bqUyC7JJDv1IRbqRthNgHlpbIPLO1j8jnvxD1389ROmNNhWwoXEDTWr7iAIn6AvW
         09Bg80WZDJJ6UdegryokFjLyBs5MFBQdtyAk41E5TbUstxP0csAzioYlEUonezgvhqsI
         EexbtzCaRqjLNEjT1FXteoAOsZisy5wWabTwTPKvZbXZV8GIQenYOHqYFlzjVs8jHXJy
         5SRW1NOHZS10kx0eZo3b06OIf/DlCvJzsHxgL6A7Z4+ZwYY03zSAQwFG7ha33pRpSSNf
         Qj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AgZew7ky/nbRHYXi94LQzSIIx2HllTTTMJfHESY22Nc=;
        b=3WSUISYPDJ4c0MAuCy2a8T5QDhh3gGQ5xkMllUfwP86sgReSJ8N9GOicLl4llAoDlk
         NxS9PJyQhHPCSaa1gfTaI6jAhXGVLys+uSacTQAEWubeQTsuY2erypNJAAxXsKYf4dCo
         YPG6XCTkNNRy5Ze2swHvjaIsroY3gZ475M95rEzlvHqoWAaQA+eZpt/vaU7/3mjyRvQ7
         R0jUa/FzqPU8CBnkQiGSf7inQGgbULX5QwGTw9YWyLc2pucZcAEgwamh8TuUSsdW9+fp
         a7H4NHlbeT71xGMq6gyCo/MR/dGq216zRfrKs04asYQnDmMtJ4wWlg+RXLFDIEHaNOc6
         aIGQ==
X-Gm-Message-State: AOAM530G3STxHFLRZSV0tFFN25KrGQHtAOl0xdhR3OieFE99+iyLhkW5
        yTm0FdLaSo2jbc9AlE2fG0LBeNJj9aY=
X-Google-Smtp-Source: ABdhPJyO3t8DyYM5eKVzMZ8+9tBs2qgGfr14RPfG+Xore3nWYCKv+wZ6lxuYFxqBKEwcaik4TvI7xA==
X-Received: by 2002:adf:e18c:: with SMTP id az12mr19758540wrb.322.1643686429134;
        Mon, 31 Jan 2022 19:33:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm810248wmf.37.2022.01.31.19.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 19:33:48 -0800 (PST)
Message-Id: <f217dba77a19714668f352825e5c91ee24f46779.1643686425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 03:33:43 +0000
Subject: [PATCH v4 3/4] core.fsync: new option to harden the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the new ability for the user to harden
the index. In the event of a system crash, the index must be
durable for the user to actually find a file that has been added
to the repo and then deleted from the working tree.

We use the presence of the COMMIT_LOCK flag and absence of the
alternate_index_output as a proxy for determining whether we're
updating the persistent index of the repo or some temporary
index. We don't sync these temporary indexes.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt |  1 +
 cache.h                       |  4 +++-
 config.c                      |  1 +
 read-cache.c                  | 19 +++++++++++++------
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 4f1747ec871..8e5b7a795ab 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -561,6 +561,7 @@ core.fsync::
 * `pack` hardens objects added to the repo in packfile form.
 * `pack-metadata` hardens packfile bitmaps and indexes.
 * `commit-graph` hardens the commit graph file.
+* `index` hardens the index when it is modified.
 * `objects` is an aggregate option that includes `loose-objects`, `pack`,
   `pack-metadata`, and `commit-graph`.
 * `default` is an aggregate option that is equivalent to `objects,-loose-object`
diff --git a/cache.h b/cache.h
index b3cd7d928de..9f3c1ec4c42 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,6 +1004,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_PACK			= 1 << 1,
 	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
 	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+	FSYNC_COMPONENT_INDEX			= 1 << 4,
 };
 
 #define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
@@ -1018,7 +1019,8 @@ enum fsync_component {
 #define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
 			      FSYNC_COMPONENT_PACK | \
 			      FSYNC_COMPONENT_PACK_METADATA | \
-			      FSYNC_COMPONENT_COMMIT_GRAPH)
+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
+			      FSYNC_COMPONENT_INDEX)
 
 
 /*
diff --git a/config.c b/config.c
index 224563c7b3e..325644e3c2c 100644
--- a/config.c
+++ b/config.c
@@ -1221,6 +1221,7 @@ static const struct fsync_component_entry {
 	{ "pack", FSYNC_COMPONENT_PACK },
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+	{ "index", FSYNC_COMPONENT_INDEX },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
 	{ "default", FSYNC_COMPONENTS_DEFAULT },
 	{ "all", FSYNC_COMPONENTS_ALL },
diff --git a/read-cache.c b/read-cache.c
index a0de70195c8..eb02439ab4b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2837,7 +2837,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions)
+			  int strip_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2851,6 +2851,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
+	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
@@ -3081,7 +3082,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_IN_STREAM);
+	csum_fsync_flag = 0;
+	if (!alternate_index_output && (flags & COMMIT_LOCK))
+		csum_fsync_flag = CSUM_FSYNC;
+
+	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
+			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
@@ -3136,7 +3143,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0);
+	ret = do_write_index(istate, lock->tempfile, 0, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3230,7 +3237,7 @@ static int clean_shared_index_files(const char *current_hex)
 }
 
 static int write_shared_index(struct index_state *istate,
-			      struct tempfile **temp)
+			      struct tempfile **temp, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
 	int ret, was_full = !istate->sparse_index;
@@ -3240,7 +3247,7 @@ static int write_shared_index(struct index_state *istate,
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, 1);
+	ret = do_write_index(si->base, *temp, 1, flags);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
@@ -3349,7 +3356,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 			ret = do_write_locked_index(istate, lock, flags);
 			goto out;
 		}
-		ret = write_shared_index(istate, &temp);
+		ret = write_shared_index(istate, &temp, flags);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
-- 
gitgitgadget

