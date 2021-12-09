Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F3C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbhLIBA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbhLIBAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:00:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECAEC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 16:57:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so4319888wmi.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 16:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FTWJHoSVmwxYnnW3XFe39EGz1hNwR2AP/w3YE/tC71E=;
        b=EO1zHrHirPYM7URETKQr6ijuJg24FnYqyDMATl/rTWD0aM0pZVZx1tnMXGAVv/Ym6q
         3fHFJ8/MBjXUG7WZJHlbRSDxL++/fgBzEWvz/ndeZ1UGZpA8QYxf0mwFQIY16eKODfn+
         RkwSKrDChlY16lDL0E1VTV9tR8iCCx2nM7VMz00XJywDPnng8Jt5yY2DuJkQxUzK93cg
         0BCUmOPab5YRr1uQJ5XYdEgMxxCX7yGgtG+IxGpOr+jV1Rgji0FFlbLC3FMzmJFvfYg4
         XT7XO/XZDrmOfTym03Vc3by7WS5kUKxeUye+QLlaNxY+vjO1dBgqfnhtK5INPXTwiHkc
         o5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FTWJHoSVmwxYnnW3XFe39EGz1hNwR2AP/w3YE/tC71E=;
        b=rTTqGxATjehvEot3hAbaRgzD28MndMtOV3qvxU5wsm2a5KO9o3yczO1FsDWSl2liL6
         dKCretj6PGoCt1mQQMZQAPEknfiq9hrCSc6eBAqWRofVxsNJHznxBs1mE7Rb33Hyqlw7
         CntcjLzXXjVMgLDVFtZTYqRA1UTgvTtm1wheozi3wChdPYGXA32LPOY5UX+rAWnJeZDR
         xvWgL1RO48cumES9Li2Tgowj8mj8msyJZqDXPOq2Re16xNI5peeHLj1mBAx9vnCvM/rk
         ZdRjgBgz331oQC6MKfvkieZqWf40D/0t1lGHxfkpXP1O4dvB+PyO859aU7QxEO8bd2bD
         6y+A==
X-Gm-Message-State: AOAM531jfaJ35zESUCtP7gswN/yDKBlxIRSZypoYtEBRPPBSf/ISc/Iy
        7gglyG2l+qtBu3tweBlm4tXnqrHg+yc=
X-Google-Smtp-Source: ABdhPJzq/nUz38wDKgmjxlaxPNv3ogOdjbXhRFN/FssTsWUJ+hTScCYOjE0h5fov/qSLFDmKhPHsVA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr2973013wml.23.1639011439557;
        Wed, 08 Dec 2021 16:57:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm5526937wrb.75.2021.12.08.16.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:57:18 -0800 (PST)
Message-Id: <2207950beba89b690690f98c77761c27c5da8dcc.1639011434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
        <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 00:57:12 +0000
Subject: [PATCH v3 3/4] core.fsync: new option to harden the index
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
index d83fbaf2619..4dc26d7b2c9 100644
--- a/cache.h
+++ b/cache.h
@@ -996,6 +996,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_PACK			= 1 << 1,
 	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
 	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+	FSYNC_COMPONENT_INDEX			= 1 << 4,
 };
 
 #define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
@@ -1010,7 +1011,8 @@ enum fsync_component {
 #define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
 			      FSYNC_COMPONENT_PACK | \
 			      FSYNC_COMPONENT_PACK_METADATA | \
-			      FSYNC_COMPONENT_COMMIT_GRAPH)
+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
+			      FSYNC_COMPONENT_INDEX)
 
 
 /*
diff --git a/config.c b/config.c
index 5ab381388f9..b3e7006c68e 100644
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
index f3539681f49..783cb3ea5db 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2816,7 +2816,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions)
+			  int strip_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2830,6 +2830,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
+	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
@@ -3060,7 +3061,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
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
@@ -3115,7 +3122,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0);
+	ret = do_write_index(istate, lock->tempfile, 0, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3209,7 +3216,7 @@ static int clean_shared_index_files(const char *current_hex)
 }
 
 static int write_shared_index(struct index_state *istate,
-			      struct tempfile **temp)
+			      struct tempfile **temp, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
 	int ret, was_full = !istate->sparse_index;
@@ -3219,7 +3226,7 @@ static int write_shared_index(struct index_state *istate,
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, 1);
+	ret = do_write_index(si->base, *temp, 1, flags);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
@@ -3328,7 +3335,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 			ret = do_write_locked_index(istate, lock, flags);
 			goto out;
 		}
-		ret = write_shared_index(istate, &temp);
+		ret = write_shared_index(istate, &temp, flags);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
-- 
gitgitgadget

