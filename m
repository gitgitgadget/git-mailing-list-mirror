Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7814C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiFLHow (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiFLHoq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5315251B
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so2964317pgc.7
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzQH5G4iMnInFMG6a4HHz4FLecDCMI7RHFpXVHGR6Lk=;
        b=cUncIs+ZPKRc/8slMjxH8DElO37MRY9BXv7efx1STqxmaZNeGXu2juJA8dpvQl1Lsh
         4xQtkO1aFh+psrnrOKjejRcIxqNZHAKvC6YnciR4Piz4IY0II1pCzCY2eIBRz+YlkRWi
         RQk8ky+WFjsCh0fD2tYfDo3YHksAQXTz9vvbMpYk7Vl+Qsw/76ZArf4s9FWlwAoMJaTY
         YduRruO1f6+tPvPy8yPlYCfa5xW9xdYFrWHECH0PEgrmghQ9VIuflx2w9e56/wK0x3n4
         fV6FmeXt/epj+p/Q+//rJdPyjwOVpd0KZws4Id3RA26D19/k6gxIg+dwJA9rPBwM101F
         STbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzQH5G4iMnInFMG6a4HHz4FLecDCMI7RHFpXVHGR6Lk=;
        b=tg6O5UKDmL3VjPlzws+bk09PoWFdxwChR40ztQOg7jv8mxdzfkNp9wddBDfrHuzXzu
         Uj1SskHpPUcvNrRWzz6CCSvT99txFcLosBhNqEf6iVUkzKxwEI00/MDh+1/oqk/X/pDD
         /JPO2ZQizjUFSZB89KNYnVTWyu10n4jiG2S6b7dKDugPpgtYAOFvvfvMM2bxzKkIchHB
         aDdPEAkE1ABdWTQdljWQigKf4f9WpkOmxwE5eKrBUPEmVOccjKbFeU7GfhelImFHRBrA
         U5hDYG/zz7rzGk1xFnd539z6t6HMXn96eRBZkhh2+dUQ71mn0E/kvETc7Fie/4Gwtjvq
         nuSQ==
X-Gm-Message-State: AOAM533QnmRN49Ks71Ehlzw2bkWJJOsw4iIv/fyd5UVoJ6+FGxshU9DB
        TJdmPDbvL55sc6dTISxSHG0=
X-Google-Smtp-Source: ABdhPJyPn7xQEGN2YXrSPz2Ru+4uPUd+LFaGIFUG2nTS1lEWKbqCTu7PDPSzrfQ1FSA3GT1gaI0UoA==
X-Received: by 2002:a63:2686:0:b0:3fc:98b0:a950 with SMTP id m128-20020a632686000000b003fc98b0a950mr48283587pgm.194.1655019881979;
        Sun, 12 Jun 2022 00:44:41 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:41 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Sun, 12 Jun 2022 15:44:20 +0800
Message-Id: <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's supported for a repo to use bitmap in both "NORMAL" bitmap way
or a MIDX (multi-pack-index) bitmap. Either of two bitmap kinds can
exist in the repository, or both can be stored but let the config
controls which kind of bitmap is used (like "core.multipackIndex",
etc.). Because of this, sometimes the bitmap debug path is not
obvious enough, for example, when executing:

 $git rev-list  --test-bitmap  HEAD
 fatal: failed to load bitmap indexes

If we see the output like this, It's not sure for us to know
what's happened concretely, because the cause should be :

  1. Neither normal nor MIDX bitmap exists.
  2. Only MIDX bitmap exists but core.multipackIndex="false".
  3. Config core.multipackIndex set to "true" but MIDX  bitmap is
     corrupted.
  4. Config core.multipackIndex set to "true" and no MIDX bitmap
     exists but normal bitmap file is corrupted.
  ....

These are some of the scenarios I briefly tested, but maybe there are
others (some scenarios is produced manually like "corrupted bitmap file",
but it's not represent it's an existed bug.).

Therefore, we added some TRACE2 code so that when we read the bitmap
we can be more clear about the decision path, such as whether it is
working on MIDX or NORMAL bitmap at present, or the related config is
enabled or not. This may help with logging, user troubleshooting, and
development debugging.

Here are some brief output examples on different scenarios when
executing:

  $GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD

Scenario 1: core.multipackIndex [false], midx bitmap exists [Y],
normal bitmap exists [N]

       19:21:56.580349 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000827 |  0.000827 | config       | core.multipackindex:false
       19:21:56.580356 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000834 |  0.000834 | config       | index.sparse:false
       19:21:56.580706 pack-bitmap.c:525            | d0 | main                     | region_enter | r1  |  0.001183 |           | pack-bitmap  | label:open_bitmap
       19:21:56.580719 pack-bitmap.c:386            | d0 | main                     | data         | r1  |  0.001196 |  0.000013 | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
       19:21:56.580729 pack-bitmap.c:530            | d0 | main                     | region_leave | r1  |  0.001207 |  0.000024 | pack-bitmap  | label:open_bitmap
       19:21:56.580737 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
       fatal: failed to load bitmap indexes
       19:21:56.580746 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
       19:21:56.580754 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001232 |           |              | code:128

Scenario 2: core.multipackIndex [false], midx bitmap exists [Y],
normal bitmap exists [Y]

	19:23:44.692384 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000765 |  0.000765 | config       | core.multipackindex:false
	19:23:44.692755 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001135 |           | pack-bitmap  | label:open_bitmap
	19:23:44.692768 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001149 |  0.000014 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
	19:23:44.692790 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001171 |  0.000036 | pack-bitmap  | label:open_bitmap
	Bitmap v1 test (1 entries loaded)
	Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
	19:23:44.693119 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001500 |           | progress     | label:Verifying bitmap entries
	Verifying bitmap entries: 100% (3/3), done.
	19:23:44.693208 progress.c:339               | d0 | main                     | data         | r0  |  0.001589 |  0.000089 | progress     | ..total_objects:3
	19:23:44.693216 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001597 |  0.000097 | progress     | label:Verifying bitmap entries
	OK!
	19:23:44.693234 git.c:718                    | d0 | main                     | exit         |     |  0.001615 |           |              | code:0
	19:23:44.693244 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001625 |           |              | code:0

Scenario 3: core.multipackIndex [true], midx bitmap exists [Y],
normal bitmap exists [Y]

	19:26:03.625055 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000760 |  0.000760 | config       | core.multipackindex:true
	19:26:03.625090 midx.c:185                   | d0 | main                     | data         | r0  |  0.000795 |  0.000795 | midx         | load/num_packs:1
	19:26:03.625097 midx.c:186                   | d0 | main                     | data         | r0  |  0.000803 |  0.000803 | midx         | load/num_objects:3
	19:26:03.625455 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
	19:26:03.625470 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001175 |  0.000015 | midx         | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/multi-pack-index-fe8e96790bd34926423bdf3efd762dbbea9f3213.bitmap
	19:26:03.625489 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001194 |  0.000034 | load_midx_re | ..source:midx
	19:26:03.625496 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001202 |  0.000042 | pack-bitmap  | label:open_bitmap
	Bitmap v1 test (1 entries loaded)
	Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
	19:26:03.625818 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001523 |           | progress     | label:Verifying bitmap entries
	Verifying bitmap entries: 100% (3/3), done.
	19:26:03.625916 progress.c:339               | d0 | main                     | data         | r0  |  0.001622 |  0.000099 | progress     | ..total_objects:3
	19:26:03.625925 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001630 |  0.000107 | progress     | label:Verifying bitmap entries
	OK!
	19:26:03.625943 git.c:718                    | d0 | main                     | exit         |     |  0.001648 |           |              | code:0
	19:26:03.625952 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001658 |           |              | code:0

Situation 4: core.multipackIndex [false], midx bitmap exists [N],
normal bitmap exists [Y].

	19:27:15.383037 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000746 |  0.000746 | config       | core.multipackindex:true
	19:27:15.383397 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001105 |           | pack-bitmap  | label:open_bitmap
	19:27:15.383408 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001116 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
	19:27:15.383419 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001128 |  0.000023 | pack-bitmap  | label:open_bitmap
	Bitmap v1 test (1 entries loaded)
	Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
	19:27:15.383730 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001439 |           | progress     | label:Verifying bitmap entries
	Verifying bitmap entries: 100% (3/3), done.
	19:27:15.383822 progress.c:339               | d0 | main                     | data         | r0  |  0.001531 |  0.000092 | progress     | ..total_objects:3
	19:27:15.383830 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001539 |  0.000100 | progress     | label:Verifying bitmap entries
	OK!
	19:27:15.383848 git.c:718                    | d0 | main                     | exit         |     |  0.001557 |           |              | code:0
	19:27:15.383867 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001576 |           |              | code:0

Scenario 5: core.multipackIndex [true], midx bitmap exists [Y] but corrupted,
normal bitmap exists [Y]

	19:29:25.888233 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:true
	19:29:25.888591 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001152 |           | pack-bitmap  | label:open_bitmap
	19:29:25.888603 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001163 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
	19:29:25.888622 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
	error: Corrupted bitmap index file (wrong header)
	19:29:25.888638 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
	error: bitmap header is invalid
	19:29:25.888650 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001211 |  0.000059 | pack-bitmap  | label:open_bitmap
	19:29:25.888659 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
	fatal: failed to load bitmap indexes
	19:29:25.888670 usage.c:74                   | d0 | main                     | exit         |     |  0.001231 |           |              | code:128
	19:29:25.888680 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001241 |           |              | code:128

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c   | 27 +++++++++++++++++++++------
 repo-settings.c |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5654eb7b8d..ced5993560 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -312,9 +312,11 @@ char *pack_bitmap_filename(struct packed_git *p)
 static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 			      struct multi_pack_index *midx)
 {
+	int fd;
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
-	int fd = git_open(bitmap_name);
+	trace2_data_string("midx", the_repository, "path", bitmap_name);
+	fd = git_open(bitmap_name);
 
 	free(bitmap_name);
 
@@ -343,12 +345,19 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 				MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	if (load_bitmap_header(bitmap_git) < 0)
+	if (load_bitmap_header(bitmap_git) < 0) {
+		trace2_data_string("midx", the_repository, "load bitmap header",
+				   "failed");
 		goto cleanup;
+	}
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
+		trace2_data_string("midx", the_repository, "verify checksum",
+				   "mismatch");
 		goto cleanup;
 
+	}
+
 	if (load_midx_revindex(bitmap_git->midx) < 0) {
 		warning(_("multi-pack bitmap is missing required reverse index"));
 		goto cleanup;
@@ -374,6 +383,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 
 	bitmap_name = pack_bitmap_filename(packfile);
+	trace2_data_string("bitmap", the_repository, "path", bitmap_name);
 	fd = git_open(bitmap_name);
 	free(bitmap_name);
 
@@ -509,11 +519,16 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
-	assert(!bitmap_git->map);
+	int ret = 0;
 
+	assert(!bitmap_git->map);
+	trace2_region_enter("pack-bitmap", "open_bitmap", r);
 	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+		goto done;
+	ret = open_pack_bitmap(r, bitmap_git);
+done:
+	trace2_region_leave("pack-bitmap", "open_bitmap", r);
+	return ret;
 }
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..5bc7a97a6d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -8,6 +8,7 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 {
 	if (repo_config_get_bool(r, key, dest))
 		*dest = def;
+	trace2_data_string("config", r, key, *dest ? "true" : "false");
 }
 
 void prepare_repo_settings(struct repository *r)
-- 
2.35.1.582.g320e881567

