Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55973C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354023AbiETXRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354011AbiETXRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:34 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E7814A7
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e20so8326959qvr.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a2BdzLWw+7ii3abnc45jWmzx+La8U5QvCNlCowMxbOM=;
        b=s8xtZ1zYq1mgZO61IrtNyqw5YHHeYm3OYM12isICuiKRxg98yu0e1lxXpVX1oy/1H9
         J9Nl6YseafVo+4G1o0oEAj0q4Xe3/NmqtUoAeoLaXhxWZYXDSgc3ZPI3rdvIaEjxVfAr
         bV+cnWhUS8Ex92He0P1/SbQ5e7axwl3K9YglBjJZTazqPEzc8U6cGFXA4c29oApdjYK4
         UDr0y70zVc8pLnjUKmA95Aw1NJyZ5x4CTclq23mBh9FgxkcLMw/0WrK5xcrYW8jArbXr
         bFKHB3hXJKK74uR+8QM8uhWV/T0sA8hwsYLAzjPHB3RQ60jGj1Tz+pHLtR2asgjOegyu
         +jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2BdzLWw+7ii3abnc45jWmzx+La8U5QvCNlCowMxbOM=;
        b=PzKJGLSMEKgZQHy+ACdTwx840HInmUI+oYDMc8kOaDH1V07TIfe9sZA8QJQ4ihKYI2
         5dT0L1snbT8nZp1UuJHpQubhNLYLzdgpG1X7ryteVgJr3NbJX7hX68tuSxhHtCbhmDx4
         mIKDa4d3cSUNW951m8zy7dn9szcS9atWU683L8w6uWkfe6+Vay4Kxnlnr8M2dch3oOMT
         DNSe8Y3m0hGLdMMBo/WFhZxFfzeE8CMyDrsHB9rSQBDhfUlA6OCwqzKGXDc5kCqwBNmN
         hMjhEbiDdE8JGneE+ZhtT0oYKdN0uIzcmdP77H8xFOJunB20e1X2nfbjm2qQGlEiSMbC
         kltA==
X-Gm-Message-State: AOAM531SvaHlSNPqq8oop1AquuRMgAOPukXcQPcKm6WIoFDEBQO/VmUI
        oe688s1AcrtWkumdOt6+UvoEukR59FbE/MXg
X-Google-Smtp-Source: ABdhPJxLOKKS7KNE9nWvcfiQBF9VLAS8DK0YqlronWPnOQCEolX8IKa453xQlhIyYyHzxabz+j0lKA==
X-Received: by 2002:a05:6214:2a8d:b0:462:201b:4088 with SMTP id jr13-20020a0562142a8d00b00462201b4088mr1015052qvb.97.1653088650876;
        Fri, 20 May 2022 16:17:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b0069fc13ce242sm411933qkh.115.2022.05.20.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:30 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 00/17] cruft packs
Message-ID: <cover.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement "cruft packs". This is really
more like v4.1, since it has only cosmetic changes incorporated from the review
on v4 of this topic.

Since last time:

  - The new section in pack-format.txt (describing the ".mtimes" format) now
    says at the top "all 4-byte numbers are in network byte order", and avoids
    repeating "network [byte] order" throughout that section to reduce
    confusion.

  - A sub-shell in t5329 which incorrectly masked over the exit code of a "git"
    process was removed.

  - An overly-long line in builtin/repack.c::collect_pack_filenames() was
    eliminated, and matching braces are added.

...and that's pretty much it. In any case, a range-diff is included below.
Thanks again for all of the thoughtful feedback on this series.

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
 Documentation/technical/cruft-packs.txt | 123 ++++
 Documentation/technical/pack-format.txt |  19 +
 Makefile                                |   2 +
 builtin/gc.c                            |  10 +-
 builtin/pack-objects.c                  | 304 +++++++++-
 builtin/repack.c                        | 185 +++++-
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
 32 files changed, 1834 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/technical/cruft-packs.txt
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h
 create mode 100644 t/helper/test-pack-mtimes.c
 create mode 100755 t/t5329-pack-objects-cruft.sh

Range-diff against v4:
 -:  ---------- >  1:  f494ef7377 Documentation/technical: add cruft-packs.txt
 1:  8f9fd21be9 !  2:  91a9d21b0b pack-mtimes: support reading .mtimes files
    @@ Documentation/technical/pack-format.txt: Pack file entry: <+
      
     +== pack-*.mtimes files have the format:
     +
    ++All 4-byte numbers are in network byte order.
    ++
     +  - A 4-byte magic number '0x4d544d45' ('MTME').
     +
     +  - A 4-byte version identifier (= 1).
     +
     +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
     +
    -+  - A table of 4-byte unsigned integers in network order. The ith
    -+    value is the modification time (mtime) of the ith object in the
    -+    corresponding pack by lexicographic (index) order. The mtimes
    -+    count standard epoch seconds.
    ++  - A table of 4-byte unsigned integers. The ith value is the
    ++    modification time (mtime) of the ith object in the corresponding
    ++    pack by lexicographic (index) order. The mtimes count standard
    ++    epoch seconds.
     +
     +  - A trailer, containing a checksum of the corresponding packfile,
     +    and a checksum of all of the above (each having length according
     +    to the specified hash function).
    -+
    -+All 4-byte numbers are in network order.
     +
      == multi-pack-index (MIDX) files have the following format:
      
 2:  cdb21236e1 =  3:  67c4e7209d pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 3:  1d775f9850 =  4:  fc86506881 chunk-format.h: extract oid_version()
 4:  6172861bd9 =  5:  788d1f96f2 pack-mtimes: support writing pack .mtimes files
 5:  5f9a9a5b7b =  6:  2a6cfb00bf t/helper: add 'pack-mtimes' test-tool
 6:  b8a38fe2e4 =  7:  edb6fcd5ec builtin/pack-objects.c: return from create_object_entry()
 7:  94fe03cc65 =  8:  e3185741f2 builtin/pack-objects.c: --cruft without expiration
 8:  da7273f41f =  9:  1cf00d462c reachable: add options to add_unseen_recent_objects_to_traversal
 9:  58fecd1747 = 10:  d66be44d9a reachable: report precise timestamps from objects in cruft packs
10:  1740b8ef01 = 11:  1434e37623 builtin/pack-objects.c: --cruft with expiration
11:  5992a72cbf ! 12:  0d3555d595 builtin/repack.c: support generating a cruft pack
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +		git repack &&
     +
     +		tip="$(git rev-parse cruft)" &&
    -+		path="$objdir/$(test_oid_to_path "$(git rev-parse cruft)")" &&
    ++		path="$objdir/$(test_oid_to_path "$tip")" &&
     +		test-tool chmtime --get +1000 "$path" >expect &&
     +
     +		git checkout main &&
12:  1b241f8f91 = 13:  4b721d3ee9 builtin/repack.c: allow configuring cruft pack generation
13:  ffae78852c = 14:  f9e3ab56b1 builtin/repack.c: use named flags for existing_packs
14:  0743e373ba ! 15:  e9f46e7b5e builtin/repack.c: add cruft packs to MIDX during geometric repack
    @@ builtin/repack.c
      static int pack_everything;
      static int delta_base_offset = 1;
     @@ builtin/repack.c: static void collect_pack_filenames(struct string_list *fname_nonkept_list,
    + 		fname = xmemdupz(e->d_name, len);
    + 
      		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
    - 		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
    +-		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
    ++		    (file_exists(mkpath("%s/%s.keep", packdir, fname)))) {
      			string_list_append_nodup(fname_kept_list, fname);
     -		else
     -			string_list_append_nodup(fname_nonkept_list, fname);
    -+		else {
    -+			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);
    ++		} else {
    ++			struct string_list_item *item;
    ++			item = string_list_append_nodup(fname_nonkept_list,
    ++							fname);
     +			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
     +				item->util = (void*)(uintptr_t)CRUFT_PACK;
     +		}
15:  9f7e0acac6 = 16:  43c14eec07 builtin/gc.c: conditionally avoid pruning objects via loose
16:  07fa9d4b47 = 17:  1e313b89e8 sha1-file.c: don't freshen cruft packs
-- 
2.36.1.94.gb0d54bedca
