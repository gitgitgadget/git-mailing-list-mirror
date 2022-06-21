Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14451CCA481
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351664AbiFUNbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351710AbiFUN3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:29:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F92AC57
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d17so4138973pfq.9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FKQhvnvKUdBtDKp668V8TxC7J475P8qjey9OULrkE0=;
        b=hGADqOQ/6/Ry7p+I/X96OimNjILy6g0bwdd6Eob5c2+WJ+ANytniYxvi9o6goTFumf
         0emCObNMvKOME9AIhJgCY9vJN2no6x0FeyucxHGCqVtda4wXQybWC2S+FVvtUnE7IpMP
         OBYz961xyqIShrMjd39RWTKzib2PMbQhjBPZjeIC9U4ODEpceRNNK7Rq34By+ubV4C5y
         9SNl/oefkvF3X3zW0RYEybiihlz0eDW3xTvnuZ+zsyrF5PuTnFeaf+8uYhjFQyV+O55j
         MFJdcWTyq5C3BVr9/67IKwfAbEuMjvaeyw/JcSHyXJzZvIWT8seOW81sdQfyvgb5u1lU
         O9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FKQhvnvKUdBtDKp668V8TxC7J475P8qjey9OULrkE0=;
        b=a6MmOp2R/6izLbHOzutgLHoEi9wBXxh2lf18Tmf8dpUKWQGtTL7zqfz8KpDmCY53Ms
         WhPA2kETs2202zeT7l1b5e+muVqNDW4aBjEUsCtMh+TOT8runxXrxogSxpqQ9ZinKISC
         UuJlpEUFg0wMRdWCN+/17oegBZfjdj+51uknM91SWE2GppNmVTGwdFuJ1Zy9sdiYtz+I
         Q/IHEdgH+FiRIvuLGTqwRZlOcigTncF4u1Udvf9S2tr1VvJshknCKxgxu5cjR5vGjdxt
         3+DVswsO7wvVhxAEaOlBa3r/2IhcNEKjGiJB0dSWUUQhaiHiD1i1gzv2xVhrAOXpFzgH
         jMkQ==
X-Gm-Message-State: AJIora+ReVCi66Ulq6lbqvKl4XM+UUJfjV9juhdqLsn+XdC7vbTcRhWF
        xITjlfN2UOZqpxpcfJ0tX0o=
X-Google-Smtp-Source: AGRyM1uT5JNvmJQLZE4gifqd86+rbSey1Iq6aRckgubzQfPJtWCvnjxMvR6LS/NJAsF2wHGEngSfLw==
X-Received: by 2002:a05:6a00:1acc:b0:525:345d:cdcf with SMTP id f12-20020a056a001acc00b00525345dcdcfmr4640812pfv.76.1655817913055;
        Tue, 21 Jun 2022 06:25:13 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/5] trace2 output for bitmap decision path
Date:   Tue, 21 Jun 2022 21:25:00 +0800
Message-Id: <cover.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main diff from v4 to v3:

* Optimize the commit message of [5/5].
* Fix the missing blank line in [5/5].
* Only print the config we want to instead of the whole configs .
* use "error_errno()" instead in [4/5].

Thanks for Junio C Hamano and Taylor Blau for their help in v3.


Teng Long (5):
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: make warnings support i18N when opening bitmap
  pack-bitmap.c: using error() instead of silently returning -1
  bitmap: add trace2 outputs during open "bitmap" file

 pack-bitmap.c   | 52 ++++++++++++++++++++++++++++++-------------------
 repo-settings.c | 22 +++++++++++----------
 2 files changed, 44 insertions(+), 30 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  589e3f4075 pack-bitmap.c: continue looping when first MIDX bitmap is found
-:  ---------- > 2:  b6b30047fc pack-bitmap.c: rename "idx_name" to "bitmap_name"
-:  ---------- > 3:  d8dfe53dd4 pack-bitmap.c: make warnings support i18N when opening bitmap
1:  72da3b5844 ! 4:  917551f2b5 pack-bitmap.c: using error() instead of silently returning -1
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      	if (fstat(fd, &st)) {
      		close(fd);
     -		return -1;
    -+		return error(_("cannot stat bitmap file"));
    ++		return error_errno(_("cannot stat bitmap file"));
      	}
      
      	if (bitmap_git->pack || bitmap_git->midx) {
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      	bitmap_git->map = NULL;
      	bitmap_git->midx = NULL;
     -	return -1;
    -+	return error("cannot open midx bitmap file");
    ++	return error(_("cannot open midx bitmap file"));
      }
      
      static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      	if (fstat(fd, &st)) {
      		close(fd);
     -		return -1;
    -+		return error(_("cannot stat bitmap file"));
    ++		return error_errno(_("cannot stat bitmap file"));
      	}
      
      	if (bitmap_git->pack || bitmap_git->midx) {
2:  e118758d1d ! 5:  8735ae9979 bitmap: add trace2 outputs during open "bitmap" file
    @@ Metadata
      ## Commit message ##
         bitmap: add trace2 outputs during open "bitmap" file
     
    -    It's supported for a repo to use bitmap in both "NORMAL" bitmap way
    -    or a MIDX (multi-pack-index) bitmap. Either of two bitmap kinds can
    +    It's supported for a repo to use bitmap in both single-pack bitmap
    +    way or a multi-pack(MIDX) bitmap. Either of two bitmap kinds can
         exist in the repository, or both can be stored but let the config
         controls which kind of bitmap is used (like "core.multipackIndex",
         etc.). Because of this, sometimes the bitmap debug path is not
         obvious enough, for example, when executing:
     
    -     $git rev-list  --test-bitmap  HEAD
    +     $ git rev-list  --test-bitmap  HEAD
          fatal: failed to load bitmap indexes
     
    -    If we see the output like this, It's not sure for us to know
    -    what's happened concretely, because the cause should be :
    +    When the output look like this, it's unclear which kind(s) of
    +    .bitmap exist, and which were read. For example, it's possible a MIDX
    +    bitmap exists, but was not read (e.g., because
    +    core.multiPackIndex=false), among many other scenarios.
     
    -      1. Neither normal nor MIDX bitmap exists.
    -      2. Only MIDX bitmap exists but core.multipackIndex="false".
    -      3. Config core.multipackIndex set to "true" but MIDX  bitmap is
    -         corrupted.
    -      4. Config core.multipackIndex set to "true" and no MIDX bitmap
    -         exists but normal bitmap file is corrupted.
    -      ....
    -
    -    These are some of the scenarios I briefly tested, but maybe there are
    -    others (some scenarios is produced manually like "corrupted bitmap file",
    -    but it's not represent it's an existed bug.).
    -
    -    Therefore, we added some TRACE2 code so that when we read the bitmap
    +    Therefore, we added some trace2 code so that when we read the bitmap
         we can be more clear about the decision path, such as whether it is
    -    working on MIDX or NORMAL bitmap at present, or the related config is
    -    enabled or not. This may help with logging, user troubleshooting, and
    +    working on MIDX or single-pack bitmap at present, or the related config
    +    is enabled or not. This may help with logging, user troubleshooting, and
         development debugging.
     
    -    Here are some brief output examples on different scenarios when
    +    Here are some brief output (omitted some unrelated or repetitive rows
    +    and columns, using "..." instead of) examples on two scenarios when
         executing:
     
    -      $GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD
    -
    -    Scenario 1: core.multipackIndex [false], midx bitmap exists [Y],
    -    normal bitmap exists [N]
    -
    -           19:21:56.580349 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000827 |  0.000827 | config       | core.multipackindex:false
    -           19:21:56.580356 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000834 |  0.000834 | config       | index.sparse:false
    -           19:21:56.580706 pack-bitmap.c:525            | d0 | main                     | region_enter | r1  |  0.001183 |           | pack-bitmap  | label:open_bitmap
    -           19:21:56.580719 pack-bitmap.c:386            | d0 | main                     | data         | r1  |  0.001196 |  0.000013 | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    -           19:21:56.580729 pack-bitmap.c:530            | d0 | main                     | region_leave | r1  |  0.001207 |  0.000024 | pack-bitmap  | label:open_bitmap
    -           19:21:56.580737 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
    -           fatal: failed to load bitmap indexes
    -           19:21:56.580746 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
    -           19:21:56.580754 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001232 |           |              | code:128
    -
    -    Scenario 2: core.multipackIndex [false], midx bitmap exists [Y],
    -    normal bitmap exists [Y]
    -
    -            19:23:44.692384 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000765 |  0.000765 | config       | core.multipackindex:false
    -            19:23:44.692755 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001135 |           | pack-bitmap  | label:open_bitmap
    -            19:23:44.692768 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001149 |  0.000014 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    -            19:23:44.692790 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001171 |  0.000036 | pack-bitmap  | label:open_bitmap
    -            Bitmap v1 test (1 entries loaded)
    -            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    -            19:23:44.693119 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001500 |           | progress     | label:Verifying bitmap entries
    -            Verifying bitmap entries: 100% (3/3), done.
    -            19:23:44.693208 progress.c:339               | d0 | main                     | data         | r0  |  0.001589 |  0.000089 | progress     | ..total_objects:3
    -            19:23:44.693216 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001597 |  0.000097 | progress     | label:Verifying bitmap entries
    -            OK!
    -            19:23:44.693234 git.c:718                    | d0 | main                     | exit         |     |  0.001615 |           |              | code:0
    -            19:23:44.693244 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001625 |           |              | code:0
    -
    -    Scenario 3: core.multipackIndex [true], midx bitmap exists [Y],
    -    normal bitmap exists [Y]
    -
    -            19:26:03.625055 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000760 |  0.000760 | config       | core.multipackindex:true
    -            19:26:03.625090 midx.c:185                   | d0 | main                     | data         | r0  |  0.000795 |  0.000795 | midx         | load/num_packs:1
    -            19:26:03.625097 midx.c:186                   | d0 | main                     | data         | r0  |  0.000803 |  0.000803 | midx         | load/num_objects:3
    -            19:26:03.625455 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
    -            19:26:03.625470 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001175 |  0.000015 | midx         | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/multi-pack-index-fe8e96790bd34926423bdf3efd762dbbea9f3213.bitmap
    -            19:26:03.625489 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001194 |  0.000034 | load_midx_re | ..source:midx
    -            19:26:03.625496 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001202 |  0.000042 | pack-bitmap  | label:open_bitmap
    -            Bitmap v1 test (1 entries loaded)
    -            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    -            19:26:03.625818 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001523 |           | progress     | label:Verifying bitmap entries
    -            Verifying bitmap entries: 100% (3/3), done.
    -            19:26:03.625916 progress.c:339               | d0 | main                     | data         | r0  |  0.001622 |  0.000099 | progress     | ..total_objects:3
    -            19:26:03.625925 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001630 |  0.000107 | progress     | label:Verifying bitmap entries
    -            OK!
    -            19:26:03.625943 git.c:718                    | d0 | main                     | exit         |     |  0.001648 |           |              | code:0
    -            19:26:03.625952 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001658 |           |              | code:0
    -
    -    Situation 4: core.multipackIndex [false], midx bitmap exists [N],
    -    normal bitmap exists [Y].
    -
    -            19:27:15.383037 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000746 |  0.000746 | config       | core.multipackindex:true
    -            19:27:15.383397 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001105 |           | pack-bitmap  | label:open_bitmap
    -            19:27:15.383408 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001116 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    -            19:27:15.383419 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001128 |  0.000023 | pack-bitmap  | label:open_bitmap
    -            Bitmap v1 test (1 entries loaded)
    -            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    -            19:27:15.383730 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001439 |           | progress     | label:Verifying bitmap entries
    -            Verifying bitmap entries: 100% (3/3), done.
    -            19:27:15.383822 progress.c:339               | d0 | main                     | data         | r0  |  0.001531 |  0.000092 | progress     | ..total_objects:3
    -            19:27:15.383830 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001539 |  0.000100 | progress     | label:Verifying bitmap entries
    -            OK!
    -            19:27:15.383848 git.c:718                    | d0 | main                     | exit         |     |  0.001557 |           |              | code:0
    -            19:27:15.383867 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001576 |           |              | code:0
    -
    -    Scenario 5: core.multipackIndex [true], midx bitmap exists [Y] but corrupted,
    -    normal bitmap exists [Y]
    -
    -            19:29:25.888233 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:true
    -            19:29:25.888591 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001152 |           | pack-bitmap  | label:open_bitmap
    -            19:29:25.888603 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001163 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    -            19:29:25.888622 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
    -            error: Corrupted bitmap index file (wrong header)
    -            19:29:25.888638 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
    -            error: bitmap header is invalid
    -            19:29:25.888650 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001211 |  0.000059 | pack-bitmap  | label:open_bitmap
    -            19:29:25.888659 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
    -            fatal: failed to load bitmap indexes
    -            19:29:25.888670 usage.c:74                   | d0 | main                     | exit         |     |  0.001231 |           |              | code:128
    -            19:29:25.888680 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001241 |           |              | code:128
    +      $ GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD
    +
    +    Scenario 1:
    +      core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [N]
    +
    +      ...
    +      ... | main                     | data         | r1  | ... | config       | core.multipackindex:false
    +      ... | d0 | main                | region_enter | r1  | ... | pack-bitmap  | label:open_bitmap
    +      ... | d0 | main                | data         | r1  | ... | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +      ... | main                     | region_leave | r1  | ... | pack-bitmap  | label:open_bitmap
    +      ... | main                     | error        |     | ... |              | failed to load bitmap indexes
    +      fatal: failed to load bitmap indexes
    +      ... | d0 | main                | exit         |     | ... |              | code:128
    +      ...
    +
    +    Scenario 2:
    +      core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [Y]
    +
    +      ... | d0 | main                | region_enter | r0  | ... | pack-bitmap  | label:open_bitmap
    +      ... | d0 | main                | data         | r0  | ... | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +      ... | main                     | region_leave | r0  | ... | pack-bitmap  | label:open_bitmap
    +      Bitmap v1 test (1 entries loaded)
    +      Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    +      ... | main                     | region_enter | r0  | ... | progress     | label:Verifying bitmap entries
    +      Verifying bitmap entries: 100% (3/3), done.
    +      ... | main                     | data         | r0  | ... | progress     | ..total_objects:3
    +      ... | main                     | region_leave | r0  | ... | progress     | label:Verifying bitmap entries
    +      OK!
    +      ... | d0 | main                | exit         |     | ... |              | code:0
    +      ...
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ pack-bitmap.c: char *pack_bitmap_filename(struct packed_git *p)
      {
     +	int fd;
      	struct stat st;
    ++
      	char *bitmap_name = midx_bitmap_filename(midx);
     -	int fd = git_open(bitmap_name);
     +	trace2_data_string("midx", the_repository, "path", bitmap_name);
    @@ pack-bitmap.c: char *pack_bitmap_filename(struct packed_git *p)
      	free(bitmap_name);
      
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    - 				MAP_PRIVATE, fd, 0);
    - 	close(fd);
    - 
    --	if (load_bitmap_header(bitmap_git) < 0)
    -+	if (load_bitmap_header(bitmap_git) < 0) {
    -+		trace2_data_string("midx", the_repository, "load bitmap header",
    -+				   "failed");
    + 	if (load_bitmap_header(bitmap_git) < 0)
      		goto cleanup;
    -+	}
      
     -	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
     +	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
    -+		trace2_data_string("midx", the_repository, "verify checksum",
    -+				   "mismatch");
    ++		error(_("midx and bitmap checksum don't match"));
      		goto cleanup;
    - 
     +	}
    -+
    + 
      	if (load_midx_revindex(bitmap_git->midx) < 0) {
      		warning(_("multi-pack bitmap is missing required reverse index"));
    - 		goto cleanup;
     @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
      		return -1;
      
    @@ pack-bitmap.c: static int open_midx_bitmap(struct repository *r,
      struct bitmap_index *prepare_bitmap_git(struct repository *r)
     
      ## repo-settings.c ##
    -@@ repo-settings.c: static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
    +@@
    + #include "midx.h"
    + 
    + static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
    +-			  int def)
    ++			  int def, int trace)
      {
      	if (repo_config_get_bool(r, key, dest))
      		*dest = def;
    -+	trace2_data_string("config", r, key, *dest ? "true" : "false");
    ++	if (trace)
    ++		trace2_data_string("config", r, key, *dest ? "true" : "false");
      }
      
      void prepare_repo_settings(struct repository *r)
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
    + 
    + 	/* Booleans config or default, cascades to other settings */
    +-	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
    +-	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
    ++	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0, 0);
    ++	repo_cfg_bool(r, "feature.experimental", &experimental, 0, 0);
    + 
    + 	/* Defaults modified by feature.* */
    + 	if (experimental) {
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	}
    + 
    + 	/* Boolean config or default, does not cascade (simple)  */
    +-	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
    +-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
    +-	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
    +-	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
    +-	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
    +-	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
    +-	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
    ++	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1, 0);
    ++	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1, 0);
    ++	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1, 0);
    ++	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0, 0);
    ++	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1, 0);
    ++	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1, 1);
    ++	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0, 0);
    + 
    + 	/*
    + 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
-- 
2.35.1.582.g270d558070.dirty

