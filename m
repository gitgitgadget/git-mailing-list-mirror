Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35156C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiCCAVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCCAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:28 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4F13AA11
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:20:43 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bc10so3276854qtb.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EHywdYmCfnCLYsFHf9zIRpzrkpDi9ZBFfkMN+EYW5zI=;
        b=mLS+bdj2wbSsUBpCrulCOPUQMscK67h/gBVCOwbOr1en9RZGm12oEquTGVZEHcyjWV
         r/+3FHDOA2BDUy5OrTX67cSNjCHVCUHKJHgykDOmtHGbz4+ARdXrL8Ey651T7XTf99aH
         Uu6DUhpCfHrDaykABEfBVe1KyUMtNcgmCjJuOnoBvc+mhsCbKCAL49nrpziKiRUC7FMz
         bM5qVB+pdrlsbVEGE0x4jeBAFRxZtGNsaCBWLq4+mhClAzwBpK6HP62Co4aM3PjPfKCm
         C6HY4xVsmifc1xl0XI+LBuDbHfURyz7MW525vzwwg5f/hX5YU2dslJnkA6pHE2nSQipN
         hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EHywdYmCfnCLYsFHf9zIRpzrkpDi9ZBFfkMN+EYW5zI=;
        b=ZvxWYsRq/mAz6zsRK14nctgQuzmwpPY13tLQx/6AztwrfYjYBqgVq5xc29x9XER51P
         whk9vKoS9Kg78CjRyPC+hkvLRhoAtKIDjr6GAqBX+dWbaBo4AazX06+RWbumgldjIyx8
         rSt7JeTlTP0k7+i6G78plLwb2+N4+n8qFIoe2dMlTjvwYm7CmmQ3wJ72VySozXQv+XQ/
         R1+jZozUsMa6qMxQdNxWgaGfkgNqpEdP50t3KYfNkI/essjQ9zmwZItYXOlkqyLPidSR
         cXD1hB2Ru2gUG5/lwfeGsUZSCNVObnNRS16nBfy2MHa/JE/T9+YRKYkdadUyob6PFU/Q
         hg9A==
X-Gm-Message-State: AOAM5312vPCGoKDfKHWB/UQh7ENUbW+5CaXTwjL8v2b97AfCfvu1jJ5N
        0zubDfDoaS/kSuZOOjTlOacoQU1hfrKPrFsh
X-Google-Smtp-Source: ABdhPJxn6USUhv1deiG8QaCpqvWdQhy5VGbMO30cQsgE62PdgHsKEbicgROclb/mXr9AJ6N6hPPGyg==
X-Received: by 2002:ac8:588a:0:b0:2de:2dfc:77a5 with SMTP id t10-20020ac8588a000000b002de2dfc77a5mr25751638qta.357.1646266842568;
        Wed, 02 Mar 2022 16:20:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002de711a190bsm368860qty.71.2022.03.02.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:20:42 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:20:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 00/17] cruft packs
Message-ID: <cover.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small reroll of my series to implement "cruft packs", based on
Stolee's review.

The changes here are minor, and mostly are limited to removing a
redundant "if" statement, avoiding an unnecessary header include, and
moving the tests (again!) to t5329's territory.

As always, a range-diff is below. Thanks in advance for taking another
look!

Taylor Blau (17):
  Documentation/technical: add cruft-packs.txt
  pack-mtimes: support reading .mtimes files
  pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
  chunk-format.h: extract oid_version()
  pack-mtimes: support writing pack .mtimes files
  t/helper: add 'pack-mtimes' test-tool
  builtin/pack-objects.c: return from create_object_entry()
  builtin/pack-objects.c: --cruft without expiration
  reachable: add options to add_unseen_recent_objects_to_traversal
  reachable: report precise timestamps from objects in cruft packs
  builtin/pack-objects.c: --cruft with expiration
  builtin/repack.c: support generating a cruft pack
  builtin/repack.c: allow configuring cruft pack generation
  builtin/repack.c: use named flags for existing_packs
  builtin/repack.c: add cruft packs to MIDX during geometric repack
  builtin/gc.c: conditionally avoid pruning objects via loose
  sha1-file.c: don't freshen cruft packs

 Documentation/Makefile                  |   1 +
 Documentation/config/gc.txt             |  21 +-
 Documentation/config/repack.txt         |   9 +
 Documentation/git-gc.txt                |   5 +
 Documentation/git-pack-objects.txt      |  30 +
 Documentation/git-repack.txt            |  11 +
 Documentation/technical/cruft-packs.txt |  97 ++++
 Documentation/technical/pack-format.txt |  19 +
 Makefile                                |   2 +
 builtin/gc.c                            |  10 +-
 builtin/pack-objects.c                  | 304 +++++++++-
 builtin/repack.c                        | 183 +++++-
 bulk-checkin.c                          |   2 +-
 chunk-format.c                          |  12 +
 chunk-format.h                          |   3 +
 commit-graph.c                          |  18 +-
 midx.c                                  |  18 +-
 object-file.c                           |   4 +-
 object-store.h                          |   7 +-
 pack-mtimes.c                           | 126 ++++
 pack-mtimes.h                           |  15 +
 pack-objects.c                          |   6 +
 pack-objects.h                          |  25 +
 pack-write.c                            |  93 ++-
 pack.h                                  |   4 +
 packfile.c                              |  19 +-
 reachable.c                             |  58 +-
 reachable.h                             |   9 +-
 t/helper/test-pack-mtimes.c             |  56 ++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5329-pack-objects-cruft.sh           | 739 ++++++++++++++++++++++++
 32 files changed, 1807 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/technical/cruft-packs.txt
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h
 create mode 100644 t/helper/test-pack-mtimes.c
 create mode 100755 t/t5329-pack-objects-cruft.sh

Range-diff against v2:
 -:  ---------- >  1:  784ee7e0ee Documentation/technical: add cruft-packs.txt
 1:  101b34660c !  2:  1ec754ad1b pack-mtimes: support reading .mtimes files
    @@ pack-mtimes.c (new)
     +				    p->num_objects,
     +				    &p->mtimes_map,
     +				    &p->mtimes_size);
    -+	if (ret)
    -+		goto cleanup;
    -+
     +cleanup:
     +	free(mtimes_name);
     +	return ret;
 2:  a94d7dfeb3 =  3:  0f5d6d6492 pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 3:  1e0ed363ae =  4:  135a07276b chunk-format.h: extract oid_version()
 4:  5236490688 =  5:  0600503856 pack-mtimes: support writing pack .mtimes files
 5:  78313bc441 =  6:  4780c8437b t/helper: add 'pack-mtimes' test-tool
 6:  142098668d =  7:  33862a07c9 builtin/pack-objects.c: return from create_object_entry()
 7:  2517a6be3d !  8:  22705e4887 builtin/pack-objects.c: --cruft without expiration
    @@ object-store.h: int repo_has_object_file_with_flags(struct repository *r,
      
      /*
     
    - ## t/t5328-pack-objects-cruft.sh (new) ##
    + ## t/t5329-pack-objects-cruft.sh (new) ##
     @@
     +#!/bin/sh
     +
 8:  6f0e84273f =  9:  cebb30b667 reachable: add options to add_unseen_recent_objects_to_traversal
 9:  a8bde361f9 = 10:  fa4de8859d reachable: report precise timestamps from objects in cruft packs
10:  d68ce28132 ! 11:  92318f8700 builtin/pack-objects.c: --cruft with expiration
    @@ builtin/pack-objects.c: static void read_cruft_objects(void)
      		enumerate_cruft_objects();
      
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: basic_cruft_pack_tests () {
    + ## reachable.h ##
    +@@
    + #ifndef REACHEABLE_H
    + #define REACHEABLE_H
    + 
    +-#include "object.h"
    +-
    + struct progress;
    + struct rev_info;
    ++struct object;
    ++struct packed_git;
    + 
    + typedef void report_recent_object_fn(const struct object *, struct packed_git *,
    + 				     off_t, time_t);
    +
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: basic_cruft_pack_tests () {
      }
      
      basic_cruft_pack_tests never
11:  e5317cd472 ! 12:  1e94b33cb4 builtin/repack.c: support generating a cruft pack
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
      	}
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned' '
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned' '
      	)
      '
      
12:  b548dbbf80 ! 13:  9cfcd123bd builtin/repack.c: allow configuring cruft pack generation
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      				       &existing_kept_packs);
      		if (ret)
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'cruft repack ignores pack.packSizeLimit' '
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft repack ignores pack.packSizeLimit' '
      	)
      '
      
13:  e6eee7f15c = 14:  1a58807df0 builtin/repack.c: use named flags for existing_packs
14:  b09dbc9fe5 ! 15:  ed05cf536b builtin/repack.c: add cruft packs to MIDX during geometric repack
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      		for_each_string_list_item(item, existing_nonkept_packs) {
      			if ((uintptr_t)item->util & DELETE_PACK)
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'cruft --local drops unreachable objects' '
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft --local drops unreachable objects' '
      	)
      '
      
15:  7a21ae1494 ! 16:  1d5f334138 builtin/gc.c: conditionally avoid pruning objects via loose
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      			if (quiet)
      				strvec_push(&prune, "--no-progress");
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'loose objects mtimes upsert others' '
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: test_expect_success 'loose objects mtimes upsert others' '
      	)
      '
      
16:  b729b80963 ! 17:  f74b425872 sha1-file.c: don't freshen cruft packs
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
      		return 1;
      	if (!freshen_file(e.p->pack_name))
     
    - ## t/t5328-pack-objects-cruft.sh ##
    -@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
    + ## t/t5329-pack-objects-cruft.sh ##
    +@@ t/t5329-pack-objects-cruft.sh: test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
      	)
      '
      
-- 
2.35.1.73.gccc5557600
