Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D831C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiFLHoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiFLHof (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF265250B
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11so3027022pjb.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsldcDAeLHhX4uyIb+uqN4Rn37IVrbNy62COeT6ogkU=;
        b=IU4iplb5eYTqWjDFlTzNlWv6zG7jsfIQSIGy5BO0U0j5/Pv1RI8nbB6ttKIZigU/Sw
         9aXIGO6cjWZ9mZVBUyzF8Lh6B1uUPDTM84RKsTcfaPf3NE9oJ8FhSTUMLcDgZO2Ma1YC
         xJ6Pzlk/qaTKyZT5I9D9KhqLKNa/LvQqgTLqnCjfObhuobuh21RmdtGVu2ZzSNTFHk3v
         1qM/hKkkiL8SZuob8ppkv3XVw8Ld2f5XxyQpsSVvFBBN93XG3lGT4ygYwNGv4eGO4EqY
         hLMD/DDe5yj1lrFlKjdgxW955t5SsRoyun4yjsfUKhcti+QmjR1c9M2hoQwFpVUaGZJ2
         2FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsldcDAeLHhX4uyIb+uqN4Rn37IVrbNy62COeT6ogkU=;
        b=BHVYe2hk+8OwcUpQnhKFL2Bsa2BvxIHhm9EpW2yjx/c14GT4i5/6s3W2g755mHmBhM
         zgXQWJOIFg1q25C+WdIyWWX+t1/hEj9j6dCkPGbeDfQCzIEnl73OLY+R3AavVbHvdEE3
         mJdzvOTlMTzEjS0yS0S/9vlY2mU0L/B9mjK548dlal4qnfqZY2ld03tUc39c4Qm6T4q3
         XNkiv5F8PV5f7CbbvgJxFQVNONpN49hP6MjRpyqXmx86M27pU14d2PADYBzIooBKANNW
         Bvi0sM1U6Y8bVlLCJu5zXxk6dPRAdMFIxPsXtSRoUmq39R9EBGfyIqiU5ACjDbh2CKsQ
         VNCg==
X-Gm-Message-State: AOAM5327q4eZHatijgoHdUwhx4namD7SNL4p941V/CmnMUtxvr1d3LU+
        ypSjIHLZbRQi/g22J2MsL4U=
X-Google-Smtp-Source: ABdhPJzjaLVcnxCF5X3QELaPFcaDtkXJ0YH9a7sq0CeUIicy9I8JVq+BagnUoZ/XuhKmN3mlOdEi/w==
X-Received: by 2002:a17:90b:170b:b0:1e8:6d34:eba6 with SMTP id ko11-20020a17090b170b00b001e86d34eba6mr9018533pjb.105.1655019870549;
        Sun, 12 Jun 2022 00:44:30 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:30 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/5] trace2 output for bitmap decision path
Date:   Sun, 12 Jun 2022 15:44:15 +0800
Message-Id: <cover.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <cover.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***

Teng Long (5):
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: make warnings support i18N when opening bitmap
  pack-bitmap.c: using error() instead of silently returning -1
  bitmap: add trace2 outputs during open "bitmap" file

 pack-bitmap.c   | 58 +++++++++++++++++++++++++++++++------------------
 repo-settings.c |  1 +
 2 files changed, 38 insertions(+), 21 deletions(-)

Range-diff against v2:
1:  1bfd2fb6ab ! 1:  589e3f4075 pack-bitmap.c: continue looping when first MIDX bitmap is found
    @@ Commit message
         the first one has been found, then will break out by a "return"
         directly.
     
    -    But actually, it's better to don't stop the loop until we have visited
    +    But actually, it's better to continue the loop until we have visited
         both the MIDX in our repository, as well as any alternates (along with
         _their_ alternates, recursively).
     
    +    The reason for this is, there may exist more than one MIDX file in
    +    a repo. The "multi_pack_index" struct is actually designed as a singly
    +    linked list, and if a MIDX file has been already opened successfully,
    +    then the other MIDX files will be skipped and left with a warning
    +    "ignoring extra bitmap file." to the output.
    +
         The discussion link of community:
     
           https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/
2:  1fff3b3ca7 ! 2:  b6b30047fc pack-bitmap.c: rename "idx_name" to "bitmap_name"
    @@ Commit message
     
         There may bring some confusion in this "idx_name" naming, which
         might lead us to think of ".idx "or" multi-pack-index" files,
    -    although bitmap is essentially can be understood as a kind of index
    -    , let's define this name a little more accurate here.
    +    although bitmap is essentially can be understood as a kind of index,
    +    let's define this name a little more accurate here.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
3:  5a8f5afccf ! 3:  d8dfe53dd4 pack-bitmap.c: make warnings more detailed when opening bitmap
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap.c: make warnings more detailed when opening bitmap
    +    pack-bitmap.c: make warnings support i18N when opening bitmap
     
         When calling the "open_midx_bitmap_1()" or "open_pack_bitmap_1()", there
         will be a warning if a normal bitmap or MIDX bitmap already has been
    -    opened, then let's make the warning information more detailed. For
    -    example, it makes the error clearer in case of an accidental
    -    regression where we start looking for single-pack bitmaps after
    -    successfully opening a multi-pack one.
    -
    -    At the same time, we made the previous and new warning texts support
    -    translation.
    +    opened, then let's make the warning text supporting for translation.
     
         Discussion in community:
     
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		get_midx_filename(&buf, midx->object_dir);
      		/* ignore extra bitmap file; we can only handle one */
     -		warning("ignoring extra bitmap file: %s", buf.buf);
    -+		warning(_("a normal or midx bitmap already has been opened"));
     +		warning(_("ignoring extra bitmap file: %s"), buf.buf);
      		close(fd);
      		strbuf_release(&buf);
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      	if (bitmap_git->pack || bitmap_git->midx) {
      		/* ignore extra bitmap file; we can only handle one */
     -		warning("ignoring extra bitmap file: %s", packfile->pack_name);
    -+		warning(_("a normal or midx bitmap already has been opened "));
     +		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
      		close(fd);
      		return -1;
      	}
    -
    - ## t/t5310-pack-bitmaps.sh ##
    -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'complains about multiple pack bitmaps' '
    - 		test_line_count = 2 bitmaps &&
    - 
    - 		git rev-list --use-bitmap-index HEAD 2>err &&
    -+		grep "a bitmap has been opened" err &&
    - 		grep "ignoring extra bitmap file" err
    - 	)
    - '
5:  1a169d7b5e ! 4:  72da3b5844 pack-bitmap.c: using error() instead of silently returning -1
    @@ Commit message
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    - 		trace2_data_string("midx", the_repository, "stat bitmap file",
    - 				   "failed");
    + 
    + 	if (fstat(fd, &st)) {
      		close(fd);
     -		return -1;
    -+		return error("cannot stat bitmap file");
    ++		return error(_("cannot stat bitmap file"));
      	}
      
      	if (bitmap_git->pack || bitmap_git->midx) {
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      
      static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
     @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    - 		trace2_data_string("bitmap", the_repository, "stat bitmap file",
    - 				   "failed");
    + 
    + 	if (fstat(fd, &st)) {
      		close(fd);
     -		return -1;
    -+		return error("cannot stat bitmap file");
    ++		return error(_("cannot stat bitmap file"));
      	}
      
      	if (bitmap_git->pack || bitmap_git->midx) {
     @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    + 
      	if (!is_pack_valid(packfile)) {
    - 		trace2_data_string("bitmap", the_repository, "packfile", "invalid");
      		close(fd);
     -		return -1;
    -+		return error("packfile is invalid");
    ++		return error(_("packfile is invalid"));
      	}
      
      	bitmap_git->pack = packfile;
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      		bitmap_git->map_pos = 0;
      		bitmap_git->pack = NULL;
     -		return -1;
    -+		return error("bitmap header is invalid");
    ++		return error(_("bitmap header is invalid"));
      	}
      
      	return 0;
4:  2016ef2e34 ! 5:  e118758d1d bitmap: add trace2 outputs during open "bitmap" file
    @@ Metadata
      ## Commit message ##
         bitmap: add trace2 outputs during open "bitmap" file
     
    -    It's supported for a Git repo to use bitmap in both normal bitmap way
    -    or a multi-pack-index bitmap.
    -
    -    Sometimes the debug path is not obvious, for example, when executing:
    +    It's supported for a repo to use bitmap in both "NORMAL" bitmap way
    +    or a MIDX (multi-pack-index) bitmap. Either of two bitmap kinds can
    +    exist in the repository, or both can be stored but let the config
    +    controls which kind of bitmap is used (like "core.multipackIndex",
    +    etc.). Because of this, sometimes the bitmap debug path is not
    +    obvious enough, for example, when executing:
     
          $git rev-list  --test-bitmap  HEAD
          fatal: failed to load bitmap indexes
     
    -    If we see the output like this, we are not sure about what's happened,
    -    because the cause should be :
    +    If we see the output like this, It's not sure for us to know
    +    what's happened concretely, because the cause should be :
     
    -      1. neither normal nor midx bitmap exists
    -      2. only midx bitmap exists but core.multipackIndex="false"
    -      3. core.multipackIndex="true" but midx bitmap file is currupt
    -      4. core.multipackIndex="true" and no midx bitmap exists but
    -         normal bitmap file is currupt
    +      1. Neither normal nor MIDX bitmap exists.
    +      2. Only MIDX bitmap exists but core.multipackIndex="false".
    +      3. Config core.multipackIndex set to "true" but MIDX  bitmap is
    +         corrupted.
    +      4. Config core.multipackIndex set to "true" and no MIDX bitmap
    +         exists but normal bitmap file is corrupted.
           ....
     
         These are some of the scenarios I briefly tested, but maybe there are
    -    others (some scenarios is produced manually like "currupt bitmap file",
    +    others (some scenarios is produced manually like "corrupted bitmap file",
         but it's not represent it's an existed bug.).
     
         Therefore, we added some TRACE2 code so that when we read the bitmap
         we can be more clear about the decision path, such as whether it is
    -    working on midx bitmap or normal bitmap, or is it simply because the
    -    related configuration is disabled. This may help with logging, user
    -    troubleshooting, and development debugging.
    -
    -    Here are some output examples when executing
    -    "$GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD" under different
    -    situations:
    -
    -    1. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
    -    "core.multipackIndex" configures as "false":
    -
    -      19:38:43.007840 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.582.g8e9092487a
    -      19:38:43.007874 common-main.c:50             | d0 | main                     | start        |     |  0.000305 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
    -      19:38:43.007950 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
    -      19:38:43.008091 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
    -      19:38:43.008284 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000720 |  0.000720 | config       | feature.manyfiles:false
    -      19:38:43.008297 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000734 |  0.000734 | config       | feature.experimental:false
    -      19:38:43.008305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000742 |  0.000742 | config       | core.commitgraph:true
    -      19:38:43.008313 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000749 |  0.000749 | config       | commitgraph.readchangedpaths:true
    -      19:38:43.008320 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000756 |  0.000756 | config       | gc.writecommitgraph:true
    -      19:38:43.008327 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000764 |  0.000764 | config       | fetch.writecommitgraph:false
    -      19:38:43.008334 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000770 |  0.000770 | config       | pack.usesparse:true
    -      19:38:43.008341 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000777 |  0.000777 | config       | core.multipackindex:false
    -      19:38:43.008348 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000784 |  0.000784 | config       | index.sparse:false
    -      19:38:43.008724 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
    -      19:38:43.008738 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001173 |  0.000013 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
    -      19:38:43.008754 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001191 |  0.000031 | pack-bitmap  | label:open_bitmap
    -      Bitmap v1 test (8 entries loaded)
    -      Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
    -      19:38:43.009099 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001535 |           | progress     | label:Verifying bitmap entries
    -      Verifying bitmap entries: 100% (27/27), done.
    -      19:38:43.009294 progress.c:339               | d0 | main                     | data         | r0  |  0.001730 |  0.000195 | progress     | ..total_objects:27
    -      19:38:43.009302 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001739 |  0.000204 | progress     | label:Verifying bitmap entries
    -      OK!
    -      19:38:43.009321 git.c:718                    | d0 | main                     | exit         |     |  0.001757 |           |              | code:0
    -      19:38:43.009329 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001766 |           |              | code:0
    -
    -    2. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
    -    "core.multipackIndex" configures as "true":
    -
    -      (omit duplicate outputs)
    -      ...
    -      20:02:31.288797 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000811 |  0.000811 | config       | core.multipackindex:true
    -      20:02:31.288806 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000819 |  0.000819 | config       | index.sparse:false
    -      20:02:31.288836 midx.c:185                   | d0 | main                     | data         | r0  |  0.000849 |  0.000849 | midx         | load/num_packs:1
    -      20:02:31.288843 midx.c:186                   | d0 | main                     | data         | r0  |  0.000857 |  0.000857 | midx         | load/num_objects:27
    -      20:02:31.289217 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001229 |           | pack-bitmap  | label:open_bitmap
    -      20:02:31.289230 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001242 |  0.000013 | midx         | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/multi-pack-index-b6b04fbe053bd500d9ca13354466d3249dc275ac.bitmap
    -      20:02:31.289252 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001265 |  0.000036 | load_midx_re | ..source:midx
    -      20:02:31.289261 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001274 |  0.000045 | pack-bitmap  | label:open_bitmap
    -      Bitmap v1 test (8 entries loaded)
    -      Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
    -      20:02:31.289594 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001607 |           | progress     | label:Verifying bitmap entries
    -      Verifying bitmap entries: 100% (27/27), done.
    -      20:02:31.289810 progress.c:339               | d0 | main                     | data         | r0  |  0.001823 |  0.000216 | progress     | ..total_objects:27
    -      20:02:31.289824 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001837 |  0.000230 | progress     | label:Verifying bitmap entries
    -      OK!
    -      20:02:31.289843 git.c:718                    | d0 | main                     | exit         |     |  0.001856 |           |              | code:0
    -      20:02:31.289860 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001873 |           |              | code:0
    -
    -    3. _HAVE_ MIDX bitmap and a corrupt NORMAL bitmap file, but the
    -    "core.multipackIndex" configures as "false" :
    -
    -      (omit duplicate outputs)
    -      ...
    -      20:14:06.539305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:false
    -      20:14:06.539310 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000799 |  0.000799 | config       | index.sparse:false
    -      20:14:06.539658 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001146 |           | pack-bitmap  | label:open_bitmap
    -      20:14:06.539671 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001160 |  0.000014 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
    -      20:14:06.539686 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
    -      error: Corrupted bitmap index file (wrong header)
    -      20:14:06.539696 pack-bitmap.c:426            | d0 | main                     | data         | r0  |  0.001185 |  0.000039 | bitmap       | ..load bitmap header:failed
    -      20:14:06.539709 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
    -      error: bitmap header is invalid
    -      20:14:06.539719 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001208 |  0.000062 | pack-bitmap  | label:open_bitmap
    -      20:14:06.539726 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
    -      fatal: failed to load bitmap indexes
    -      20:14:06.539735 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
    -      20:14:06.539744 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001233 |           |              | code:128
    +    working on MIDX or NORMAL bitmap at present, or the related config is
    +    enabled or not. This may help with logging, user troubleshooting, and
    +    development debugging.
    +
    +    Here are some brief output examples on different scenarios when
    +    executing:
    +
    +      $GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD
    +
    +    Scenario 1: core.multipackIndex [false], midx bitmap exists [Y],
    +    normal bitmap exists [N]
    +
    +           19:21:56.580349 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000827 |  0.000827 | config       | core.multipackindex:false
    +           19:21:56.580356 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000834 |  0.000834 | config       | index.sparse:false
    +           19:21:56.580706 pack-bitmap.c:525            | d0 | main                     | region_enter | r1  |  0.001183 |           | pack-bitmap  | label:open_bitmap
    +           19:21:56.580719 pack-bitmap.c:386            | d0 | main                     | data         | r1  |  0.001196 |  0.000013 | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +           19:21:56.580729 pack-bitmap.c:530            | d0 | main                     | region_leave | r1  |  0.001207 |  0.000024 | pack-bitmap  | label:open_bitmap
    +           19:21:56.580737 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
    +           fatal: failed to load bitmap indexes
    +           19:21:56.580746 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
    +           19:21:56.580754 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001232 |           |              | code:128
    +
    +    Scenario 2: core.multipackIndex [false], midx bitmap exists [Y],
    +    normal bitmap exists [Y]
    +
    +            19:23:44.692384 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000765 |  0.000765 | config       | core.multipackindex:false
    +            19:23:44.692755 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001135 |           | pack-bitmap  | label:open_bitmap
    +            19:23:44.692768 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001149 |  0.000014 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +            19:23:44.692790 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001171 |  0.000036 | pack-bitmap  | label:open_bitmap
    +            Bitmap v1 test (1 entries loaded)
    +            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    +            19:23:44.693119 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001500 |           | progress     | label:Verifying bitmap entries
    +            Verifying bitmap entries: 100% (3/3), done.
    +            19:23:44.693208 progress.c:339               | d0 | main                     | data         | r0  |  0.001589 |  0.000089 | progress     | ..total_objects:3
    +            19:23:44.693216 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001597 |  0.000097 | progress     | label:Verifying bitmap entries
    +            OK!
    +            19:23:44.693234 git.c:718                    | d0 | main                     | exit         |     |  0.001615 |           |              | code:0
    +            19:23:44.693244 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001625 |           |              | code:0
    +
    +    Scenario 3: core.multipackIndex [true], midx bitmap exists [Y],
    +    normal bitmap exists [Y]
    +
    +            19:26:03.625055 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000760 |  0.000760 | config       | core.multipackindex:true
    +            19:26:03.625090 midx.c:185                   | d0 | main                     | data         | r0  |  0.000795 |  0.000795 | midx         | load/num_packs:1
    +            19:26:03.625097 midx.c:186                   | d0 | main                     | data         | r0  |  0.000803 |  0.000803 | midx         | load/num_objects:3
    +            19:26:03.625455 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
    +            19:26:03.625470 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001175 |  0.000015 | midx         | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/multi-pack-index-fe8e96790bd34926423bdf3efd762dbbea9f3213.bitmap
    +            19:26:03.625489 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001194 |  0.000034 | load_midx_re | ..source:midx
    +            19:26:03.625496 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001202 |  0.000042 | pack-bitmap  | label:open_bitmap
    +            Bitmap v1 test (1 entries loaded)
    +            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    +            19:26:03.625818 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001523 |           | progress     | label:Verifying bitmap entries
    +            Verifying bitmap entries: 100% (3/3), done.
    +            19:26:03.625916 progress.c:339               | d0 | main                     | data         | r0  |  0.001622 |  0.000099 | progress     | ..total_objects:3
    +            19:26:03.625925 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001630 |  0.000107 | progress     | label:Verifying bitmap entries
    +            OK!
    +            19:26:03.625943 git.c:718                    | d0 | main                     | exit         |     |  0.001648 |           |              | code:0
    +            19:26:03.625952 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001658 |           |              | code:0
    +
    +    Situation 4: core.multipackIndex [false], midx bitmap exists [N],
    +    normal bitmap exists [Y].
    +
    +            19:27:15.383037 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000746 |  0.000746 | config       | core.multipackindex:true
    +            19:27:15.383397 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001105 |           | pack-bitmap  | label:open_bitmap
    +            19:27:15.383408 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001116 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +            19:27:15.383419 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001128 |  0.000023 | pack-bitmap  | label:open_bitmap
    +            Bitmap v1 test (1 entries loaded)
    +            Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
    +            19:27:15.383730 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001439 |           | progress     | label:Verifying bitmap entries
    +            Verifying bitmap entries: 100% (3/3), done.
    +            19:27:15.383822 progress.c:339               | d0 | main                     | data         | r0  |  0.001531 |  0.000092 | progress     | ..total_objects:3
    +            19:27:15.383830 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001539 |  0.000100 | progress     | label:Verifying bitmap entries
    +            OK!
    +            19:27:15.383848 git.c:718                    | d0 | main                     | exit         |     |  0.001557 |           |              | code:0
    +            19:27:15.383867 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001576 |           |              | code:0
    +
    +    Scenario 5: core.multipackIndex [true], midx bitmap exists [Y] but corrupted,
    +    normal bitmap exists [Y]
    +
    +            19:29:25.888233 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:true
    +            19:29:25.888591 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001152 |           | pack-bitmap  | label:open_bitmap
    +            19:29:25.888603 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001163 |  0.000011 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
    +            19:29:25.888622 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
    +            error: Corrupted bitmap index file (wrong header)
    +            19:29:25.888638 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
    +            error: bitmap header is invalid
    +            19:29:25.888650 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001211 |  0.000059 | pack-bitmap  | label:open_bitmap
    +            19:29:25.888659 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
    +            fatal: failed to load bitmap indexes
    +            19:29:25.888670 usage.c:74                   | d0 | main                     | exit         |     |  0.001231 |           |              | code:128
    +            19:29:25.888680 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001241 |           |              | code:128
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ pack-bitmap.c: char *pack_bitmap_filename(struct packed_git *p)
      	struct stat st;
      	char *bitmap_name = midx_bitmap_filename(midx);
     -	int fd = git_open(bitmap_name);
    -+	trace2_data_string("midx", the_repository, "try to open bitmap",
    -+			   bitmap_name);
    ++	trace2_data_string("midx", the_repository, "path", bitmap_name);
     +	fd = git_open(bitmap_name);
      
      	free(bitmap_name);
      
    -@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    - 		return -1;
    - 
    - 	if (fstat(fd, &st)) {
    -+		trace2_data_string("midx", the_repository, "stat bitmap file",
    -+				   "failed");
    - 		close(fd);
    - 		return -1;
    - 	}
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      				MAP_PRIVATE, fd, 0);
      	close(fd);
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      		return -1;
      
      	bitmap_name = pack_bitmap_filename(packfile);
    -+	trace2_data_string("bitmap", the_repository, "try to open bitmap",
    -+			   bitmap_name);
    ++	trace2_data_string("bitmap", the_repository, "path", bitmap_name);
      	fd = git_open(bitmap_name);
      	free(bitmap_name);
      
    -@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    - 		return -1;
    - 
    - 	if (fstat(fd, &st)) {
    -+		trace2_data_string("bitmap", the_repository, "stat bitmap file",
    -+				   "failed");
    - 		close(fd);
    - 		return -1;
    - 	}
    -@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    - 	}
    - 
    - 	if (!is_pack_valid(packfile)) {
    -+		trace2_data_string("bitmap", the_repository, "packfile", "invalid");
    - 		close(fd);
    - 		return -1;
    - 	}
    -@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    - 	close(fd);
    - 
    - 	if (load_bitmap_header(bitmap_git) < 0) {
    -+		trace2_data_string("bitmap", the_repository,
    -+				   "load bitmap header", "failed");
    - 		munmap(bitmap_git->map, bitmap_git->map_size);
    - 		bitmap_git->map = NULL;
    - 		bitmap_git->map_size = 0;
     @@ pack-bitmap.c: static int open_midx_bitmap(struct repository *r,
      static int open_bitmap(struct repository *r,
      		       struct bitmap_index *bitmap_git)
      {
     -	assert(!bitmap_git->map);
    -+	int ret = -1;
    ++	int ret = 0;
      
    --	if (!open_midx_bitmap(r, bitmap_git))
    --		return 0;
    --	return open_pack_bitmap(r, bitmap_git);
     +	assert(!bitmap_git->map);
     +	trace2_region_enter("pack-bitmap", "open_bitmap", r);
    -+	if (!open_midx_bitmap(r, bitmap_git)) {
    -+		ret = 0;
    + 	if (!open_midx_bitmap(r, bitmap_git))
    +-		return 0;
    +-	return open_pack_bitmap(r, bitmap_git);
     +		goto done;
    -+	}
     +	ret = open_pack_bitmap(r, bitmap_git);
     +done:
     +	trace2_region_leave("pack-bitmap", "open_bitmap", r);
    @@ repo-settings.c: static void repo_cfg_bool(struct repository *r, const char *key
      }
      
      void prepare_repo_settings(struct repository *r)
    -
    - ## t/t5310-pack-bitmaps.sh ##
    -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'complains about multiple pack bitmaps' '
    - 		test_line_count = 2 bitmaps &&
    - 
    - 		git rev-list --use-bitmap-index HEAD 2>err &&
    --		grep "a bitmap has been opened" err &&
    --		grep "ignoring extra bitmap file" err
    -+		grep "warning: a normal or midx bitmap already has been opened" err &&
    -+		grep "warning: ignoring extra bitmap file" err
    - 	)
    - '
    - 
-- 
2.35.1.582.g320e881567

