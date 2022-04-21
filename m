Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80CAC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385236AbiDUNaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359856AbiDUN34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF3A37AB4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c12so4852603plr.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYERQd+q7Kku86Z2xOHETiM2WP4shZojLHj3UNvXEbs=;
        b=OS3dXVcNkSb6UVlxp3Wo0M6HQY6JoKfkBROTgwklwv7O39SLsrK6aVsi207kmW/vmL
         ZoODtiT9By/yVqYx6OlFaRBNcZzQrEFScVhWoanCNzHlsRlC/7mJtpUW5+XY6P8XqUgs
         YcT0iCSgH343V5ziI/oXgAQGd9bk0woUjNQGuRkFzClqe8LLAkiNGi1arOJotMpeeICC
         IS31ZrqEdjfTP+qV4XQVwL4EXtPN2tAOkOrC77Q6R/ynQAGhtujn7khjhNUAKrmzptur
         3kF4xh3VpHQEnmXLRfF4OGnkcJT6MX3MpvZVL99Yh61ge/KhIigc0lBaYKBE3WpWzzOn
         Z11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYERQd+q7Kku86Z2xOHETiM2WP4shZojLHj3UNvXEbs=;
        b=oy76Xzfg13tekvbzODdrsdEI9mpLyjT0NPO5yl0dl4J0xHGcWEyeUu+Yte/vQQr3rP
         ifQ683HmtvSFD0cC1qVYApG5ytgSQTMABF+IFnjec5U+B0Dja6h9nY4kaWN581i7FM8c
         NtMjp3vECwE6MSsAsAUDNis+hvdhHQG30PkWN+BwRp8d7V5G2L3SaufmJfmxIzw3UEvb
         fwa7qmYS8WLXTlm+af0IwOI8jCcmrB9N3A8YfRB3S8afHs4GBGv8Gb6Ihy/2W5KJSs9o
         bLKNTSIhsnrUczXrnwQplIJRTnP0CVLG+Nn8FDRu6R6XbE3OsSVqcOF3LeOfalAm6A4E
         4sOA==
X-Gm-Message-State: AOAM5327BO+is0aqAfOLcykD0IlpXeJS9oHGI5hct3Pd2Y1mjUDrpDwZ
        BMbSnGBlb8nsWAfz7OfWsv4=
X-Google-Smtp-Source: ABdhPJz3R75+bnG71Ao+Va2M5JEBPP4Cm4Zr+wj3XAGKHjQWXAwczkeNJevQaszaxwAkbtpyyFGMSQ==
X-Received: by 2002:a17:90a:4414:b0:1cd:4c16:e7eb with SMTP id s20-20020a17090a441400b001cd4c16e7ebmr10510614pjg.166.1650547619196;
        Thu, 21 Apr 2022 06:26:59 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:26:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Thu, 21 Apr 2022 21:26:39 +0800
Message-Id: <2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1650547400.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's supported for a Git repo to use bitmap in both normal bitmap way
or a multi-pack-index bitmap.

Sometimes the debug path is not obvious, for example, when executing:

 $git rev-list  --test-bitmap  HEAD
 fatal: failed to load bitmap indexes

If we see the output like this, we are not sure about what's happened,
because the cause should be :

  1. neither normal nor midx bitmap exists
  2. only midx bitmap exists but core.multipackIndex="false"
  3. core.multipackIndex="true" but midx bitmap file is currupt
  4. core.multipackIndex="true" and no midx bitmap exists but
     normal bitmap file is currupt
  ....

These are some of the scenarios I briefly tested, but maybe there are
others (some scenarios is produced manually like "currupt bitmap file",
but it's not represent it's an existed bug.).

Therefore, we added some TRACE2 code so that when we read the bitmap
we can be more clear about the decision path, such as whether it is
working on midx bitmap or normal bitmap, or is it simply because the
related configuration is disabled. This may help with logging, user
troubleshooting, and development debugging.

Here are some output examples when executing
"$GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD" under different
situations:

1. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
"core.multipackIndex" configures as "false":

  19:38:43.007840 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.582.g8e9092487a
  19:38:43.007874 common-main.c:50             | d0 | main                     | start        |     |  0.000305 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
  19:38:43.007950 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
  19:38:43.008091 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
  19:38:43.008284 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000720 |  0.000720 | config       | feature.manyfiles:false
  19:38:43.008297 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000734 |  0.000734 | config       | feature.experimental:false
  19:38:43.008305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000742 |  0.000742 | config       | core.commitgraph:true
  19:38:43.008313 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000749 |  0.000749 | config       | commitgraph.readchangedpaths:true
  19:38:43.008320 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000756 |  0.000756 | config       | gc.writecommitgraph:true
  19:38:43.008327 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000764 |  0.000764 | config       | fetch.writecommitgraph:false
  19:38:43.008334 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000770 |  0.000770 | config       | pack.usesparse:true
  19:38:43.008341 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000777 |  0.000777 | config       | core.multipackindex:false
  19:38:43.008348 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000784 |  0.000784 | config       | index.sparse:false
  19:38:43.008724 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
  19:38:43.008738 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001173 |  0.000013 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
  19:38:43.008754 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001191 |  0.000031 | pack-bitmap  | label:open_bitmap
  Bitmap v1 test (8 entries loaded)
  Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
  19:38:43.009099 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001535 |           | progress     | label:Verifying bitmap entries
  Verifying bitmap entries: 100% (27/27), done.
  19:38:43.009294 progress.c:339               | d0 | main                     | data         | r0  |  0.001730 |  0.000195 | progress     | ..total_objects:27
  19:38:43.009302 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001739 |  0.000204 | progress     | label:Verifying bitmap entries
  OK!
  19:38:43.009321 git.c:718                    | d0 | main                     | exit         |     |  0.001757 |           |              | code:0
  19:38:43.009329 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001766 |           |              | code:0

2. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
"core.multipackIndex" configures as "true":

  (omit duplicate outputs)
  ...
  20:02:31.288797 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000811 |  0.000811 | config       | core.multipackindex:true
  20:02:31.288806 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000819 |  0.000819 | config       | index.sparse:false
  20:02:31.288836 midx.c:185                   | d0 | main                     | data         | r0  |  0.000849 |  0.000849 | midx         | load/num_packs:1
  20:02:31.288843 midx.c:186                   | d0 | main                     | data         | r0  |  0.000857 |  0.000857 | midx         | load/num_objects:27
  20:02:31.289217 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001229 |           | pack-bitmap  | label:open_bitmap
  20:02:31.289230 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001242 |  0.000013 | midx         | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/multi-pack-index-b6b04fbe053bd500d9ca13354466d3249dc275ac.bitmap
  20:02:31.289252 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001265 |  0.000036 | load_midx_re | ..source:midx
  20:02:31.289261 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001274 |  0.000045 | pack-bitmap  | label:open_bitmap
  Bitmap v1 test (8 entries loaded)
  Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
  20:02:31.289594 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001607 |           | progress     | label:Verifying bitmap entries
  Verifying bitmap entries: 100% (27/27), done.
  20:02:31.289810 progress.c:339               | d0 | main                     | data         | r0  |  0.001823 |  0.000216 | progress     | ..total_objects:27
  20:02:31.289824 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001837 |  0.000230 | progress     | label:Verifying bitmap entries
  OK!
  20:02:31.289843 git.c:718                    | d0 | main                     | exit         |     |  0.001856 |           |              | code:0
  20:02:31.289860 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001873 |           |              | code:0

3. _HAVE_ MIDX bitmap and a corrupt NORMAL bitmap file, but the
"core.multipackIndex" configures as "false" :

  (omit duplicate outputs)
  ...
  20:14:06.539305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:false
  20:14:06.539310 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000799 |  0.000799 | config       | index.sparse:false
  20:14:06.539658 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001146 |           | pack-bitmap  | label:open_bitmap
  20:14:06.539671 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001160 |  0.000014 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
  20:14:06.539686 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
  error: Corrupted bitmap index file (wrong header)
  20:14:06.539696 pack-bitmap.c:426            | d0 | main                     | data         | r0  |  0.001185 |  0.000039 | bitmap       | ..load bitmap header:failed
  20:14:06.539709 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
  error: bitmap header is invalid
  20:14:06.539719 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001208 |  0.000062 | pack-bitmap  | label:open_bitmap
  20:14:06.539726 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
  fatal: failed to load bitmap indexes
  20:14:06.539735 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
  20:14:06.539744 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001233 |           |              | code:128

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c           | 40 +++++++++++++++++++++++++++++++++-------
 repo-settings.c         |  1 +
 t/t5310-pack-bitmaps.sh |  4 ++--
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1b268f655e..a1d06c4252 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -312,9 +312,12 @@ char *pack_bitmap_filename(struct packed_git *p)
 static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 			      struct multi_pack_index *midx)
 {
+	int fd;
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
-	int fd = git_open(bitmap_name);
+	trace2_data_string("midx", the_repository, "try to open bitmap",
+			   bitmap_name);
+	fd = git_open(bitmap_name);
 
 	free(bitmap_name);
 
@@ -322,6 +325,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		return -1;
 
 	if (fstat(fd, &st)) {
+		trace2_data_string("midx", the_repository, "stat bitmap file",
+				   "failed");
 		close(fd);
 		return -1;
 	}
@@ -344,12 +349,19 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
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
@@ -375,6 +387,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 
 	bitmap_name = pack_bitmap_filename(packfile);
+	trace2_data_string("bitmap", the_repository, "try to open bitmap",
+			   bitmap_name);
 	fd = git_open(bitmap_name);
 	free(bitmap_name);
 
@@ -382,6 +396,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 
 	if (fstat(fd, &st)) {
+		trace2_data_string("bitmap", the_repository, "stat bitmap file",
+				   "failed");
 		close(fd);
 		return -1;
 	}
@@ -395,6 +411,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (!is_pack_valid(packfile)) {
+		trace2_data_string("bitmap", the_repository, "packfile", "invalid");
 		close(fd);
 		return -1;
 	}
@@ -406,6 +423,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	close(fd);
 
 	if (load_bitmap_header(bitmap_git) < 0) {
+		trace2_data_string("bitmap", the_repository,
+				   "load bitmap header", "failed");
 		munmap(bitmap_git->map, bitmap_git->map_size);
 		bitmap_git->map = NULL;
 		bitmap_git->map_size = 0;
@@ -511,11 +530,18 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
-	assert(!bitmap_git->map);
+	int ret = -1;
 
-	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+	assert(!bitmap_git->map);
+	trace2_region_enter("pack-bitmap", "open_bitmap", r);
+	if (!open_midx_bitmap(r, bitmap_git)) {
+		ret = 0;
+		goto done;
+	}
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
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index eb63b71852..664cb88b0b 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -421,8 +421,8 @@ test_expect_success 'complains about multiple pack bitmaps' '
 		test_line_count = 2 bitmaps &&
 
 		git rev-list --use-bitmap-index HEAD 2>err &&
-		grep "a bitmap has been opened" err &&
-		grep "ignoring extra bitmap file" err
+		grep "warning: a normal or midx bitmap already has been opened" err &&
+		grep "warning: ignoring extra bitmap file" err
 	)
 '
 
-- 
2.35.1.583.g30faa5f068

