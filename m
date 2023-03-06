Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E72CC6FD1A
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCFU7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 15:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCFU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 15:59:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833839B94
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 12:59:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h11so10198254wrm.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 12:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678136372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9zEvisco4ZswSbxsYJxW2xK6OZTvD3xhlMNLHM/TgkI=;
        b=e5Qvresj3QwTlf01OQBhdqUjId/wNSUUoILtigMVwDMFKN8Rkm1CkgwUYlUwCZ3EJs
         lAlGkoyOiPL0p2CyQ2r5NmLcltg4qk+Gcq08wepTPF0U2sbIu5wvkRaZsBN/ZWieZ1PM
         MlV5Iv65QiW4LjhQxqorL1yefTMDdtZy4Lr91WjwHO6tnWPUoQ89VKXWAcpOrjzo4q9B
         5Z6jcPPufm+G/V6wgPqN8DK1GVacOe2wYaquFPH89xX4AJ1gqpB9DKVqR58ZCAUewwuY
         +a7lItZR5y0MmMrT5q6bzRbCdQ1K8meJQTaM55CEUZiMLMjG8+3fyPDJWwrn3fXffN1Y
         B/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678136372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zEvisco4ZswSbxsYJxW2xK6OZTvD3xhlMNLHM/TgkI=;
        b=RxuMLvukylZ/q+YJpj2B4GZxv9wkJidyItTuNbZVVkHVFEfSnfVSkOcVg2rPeKc/FE
         0MN9nCK/wgOyvHGdUv6dAITD9tHLBxzxy/TesCLAQz3jNNK5d2NOpFBxnCyqdq6+raDd
         gsXn2LgfIuPiKycL9FcLf7QR59dE/cs2zKmmtLtDefYXdTTDPupctDzE3XzJnKYiZYPc
         e+RYTloFp08g+mHtnH3LRVVi7Q91mALSz6UlaXc87Nb+kCw3/xSP3NVjKRS5h7E0v0HE
         kCIJF0YuY4EzaoA9WOcd0COQlqGyyiLL5ZZqy3zMntUDOIbETQ+ALpHoW832tsRR37w8
         /ORA==
X-Gm-Message-State: AO0yUKXDP8ChpgJrvP8PcrI38MGTcEa61IsbgQW7uQ2RANqvarEX2HKC
        B+F8YrL+cjDXig/1M1qo+nraL6HjLE8=
X-Google-Smtp-Source: AK7set/ISkikdfF9PeDKfqpRPgxUz4kAwIPVdXw8DoKpHB1aI3qTBOImDQsShZRXHk6AV4nx4L3bBw==
X-Received: by 2002:adf:f8d1:0:b0:2c7:1483:88d6 with SMTP id f17-20020adff8d1000000b002c7148388d6mr7166185wrq.23.1678136371609;
        Mon, 06 Mar 2023 12:59:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d66c8000000b002c573a6216fsm10745777wrw.37.2023.03.06.12.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 12:59:30 -0800 (PST)
Message-Id: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 20:59:29 +0000
Subject: [PATCH] object-file: reprepare alternates when necessary
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When an object is not found in a repository's object store, we sometimes
call reprepare_packed_git() to see if the object was temporarily moved
into a new pack-file (and its old pack-file or loose object was
deleted). This process does a scan of each pack directory within each
odb, but does not reevaluate if the odb list needs updating.

Create a new reprepare_alt_odb() method that is a similar wrapper around
prepare_alt_odb(). Call it from reprepare_packed_git() under the object
read lock to avoid readers from interacting with a potentially
incomplete odb being added to the odb list.

prepare_alt_odb() already avoids adding duplicate odbs to the list
during its progress, so it is safe to call it again from
reprepare_alt_odb() without worrying about duplicate odbs.

This change is specifically for concurrent changes to the repository, so
it is difficult to create a test that guarantees this behavior is
correct. I manually verified by introducing a reprepare_packed_git() call
into get_revision() and stepped into that call in a debugger with a
parent 'git log' process. Multiple runs of reprepare_alt_odb() kept
the_repository->objects->odb as a single-item chain until I added a
.git/objects/info/alternates file in a different process. The next run
added the new odb to the chain and subsequent runs did not add to the
chain.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    object-file: reprepare alternates when necessary
    
    This subtlety was notice by Michael Haggerty due to how alternates are
    used server-side at $DAYJOB. Moving pack-files from a repository to the
    alternate occasionally causes failures because processes that start
    before the alternate exists don't know how to find that alternate at
    run-time.
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1490%2Fderrickstolee%2Fstolee%2Freprepare-alternates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1490/derrickstolee/stolee/reprepare-alternates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1490

 object-file.c  | 6 ++++++
 object-store.h | 1 +
 packfile.c     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/object-file.c b/object-file.c
index 939865c1ae0..22acc7fd8e9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -944,6 +944,12 @@ void prepare_alt_odb(struct repository *r)
 	r->objects->loaded_alternates = 1;
 }
 
+void reprepare_alt_odb(struct repository *r)
+{
+	r->objects->loaded_alternates = 0;
+	prepare_alt_odb(r);
+}
+
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
diff --git a/object-store.h b/object-store.h
index 1a713d89d7c..750c29daa54 100644
--- a/object-store.h
+++ b/object-store.h
@@ -56,6 +56,7 @@ KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
 void prepare_alt_odb(struct repository *r);
+void reprepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 struct object_directory *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct object_directory *, void *);
diff --git a/packfile.c b/packfile.c
index 79e21ab18e7..2b28918a05e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
 	struct object_directory *odb;
 
 	obj_read_lock();
+	reprepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);
 

base-commit: d15644fe0226af7ffc874572d968598564a230dd
-- 
gitgitgadget
