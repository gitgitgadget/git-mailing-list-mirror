Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 02:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhLGCub (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhLGCuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 21:50:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE3C061354
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 18:46:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so26413404wrn.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 18:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4560Oo1asFqSCY7CyTBbvQRJTIDfLxJTwwZXXpZWrLw=;
        b=kyy2lXjzD7sEwSuY3kpu+mSZXAmvSoDI/YfbbIBsb9Xf1fhaMK7XQpLVyrPnI73FM4
         nBxaa0wrmPByaagGVqwDOVQbnivTnxXSqGKPzNEnLvKrj6Q+b9OX4m2yOAoVvsf8xmwr
         hT6C+kfGj40EMcQZZExxk9bsBbRSqP2AF3b2MGlV9XMbtYZzIcOIfjquuYOnia+jG33+
         52pS+GmrhivFlJq/ZiyPCqUvIlKjtAj3WVN4dO3+ZAA/fEzZXeCsPSB7v3cYnEpqvJM+
         cMWjXkpI+jKraBeyvM+K1HqxjvYpSEdyXaAu4+3cnwg3OO8rZdFnifShXKH+58FT9YHv
         dhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4560Oo1asFqSCY7CyTBbvQRJTIDfLxJTwwZXXpZWrLw=;
        b=3pTBjeTuiTT42i1KPwLGmYETfIo4FsHgu2IdArQYmgfb0XhYvnBinErslr5yBf6/Il
         aCItI0Q76nYHyZEU3S+QqWCwf7KAORpdyILTM9WqJeB+isaFUPsAc4iJG6p592J9uZgM
         /IXZbvzteoOSqK73aDrs4gGvvn2vcqbYLMiSXtbgK1kIJMbgNTdaRcqLCBjinAQs07j4
         BNuvpkpi5ShDbCGHGDzXtXGpU4+wR4pE0axq2VCZKqhFfnsJX/sf48T7zoeEj53wvIU5
         uFTCr9Y4ALP7+rMSLn6EWEg/YL14pucjXQDgVKpXugn5jbG3ubtzNPLcig+WXzzduLnl
         euLA==
X-Gm-Message-State: AOAM5329YuBANGVHiLZyl+s91FkE9jihEzuOx0/xE5V0OeYDyNmIQf6X
        zg2r9BK0teJARYLpBZSc3qQzliClueQ=
X-Google-Smtp-Source: ABdhPJy6IiieRg1elPa81HnmXBFOYp18Nw9hct1OpC4DrN0fi+tvqnzQHaZcpaqjIxJjWm62FETNbw==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr48308567wru.97.1638845214516;
        Mon, 06 Dec 2021 18:46:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm12859499wrm.76.2021.12.06.18.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 18:46:54 -0800 (PST)
Message-Id: <86e39b8f8d16100b33346d16e7f722064ab9615c.1638845211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
        <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 02:46:51 +0000
Subject: [PATCH v2 3/3] core.fsync: new option to harden the index
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
index 29c867aab03..17039fa9c10 100644
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
