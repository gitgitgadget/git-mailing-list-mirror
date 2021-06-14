Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35174C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B9461352
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhFNPxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhFNPxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:53:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88E7C061767
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l2so15117846wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4OHcT78GTIKQC/OACUpiZAP0UG5Wm9XiPwGfbqerTi8=;
        b=GyTWnRZzg04Ic1IrGJNxgOMSyf5tuyBd1dgIn+rdrZA18NxA52/QZvKVONt5F44dsQ
         7/dGgorRI7SVwgp8dwMbah1so1MytHo6PmRuKV3OT8cwTnSTMJkk2LUyVwVJ6rbW/eah
         IpDtQoJ6UEt8UP/9vhwcTzbk2b6T3Keuk1G0ax6SOOMzEsIex7gt3/+HLwIQl4Kk5p7j
         nIj949FozQJ1ZB4e7YiUfIhIaryzXNiIy+HFGrGHrwa9QTR5JUkKCfpNXBtnE7kn7ZVD
         g9fw8YPXQvvSbrZD4myDGCgeoMP9Zl1mgwRs3LhvwiawN3ZUks6cjTriWTLmqMEkprjd
         mTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4OHcT78GTIKQC/OACUpiZAP0UG5Wm9XiPwGfbqerTi8=;
        b=GVRdgy/g1X20prUNxZRZ2vA8U01MO1cp1QsHXiEZCkpOAsy+sTZae/EBlakMCch+sC
         yBnZxd0Un5zFuGi9IiQU5AIAbF70lxXKg+9dFy2m1vtpshrlZt8bk9itby134Co450rb
         tOt2NZ0Lnc0OPbD08uX7gwo5r/+if7bvTQgSJEZ5O3pwZQG8jL/3sukbcMvITUEZuUKB
         eTJpBQLsTVk3/GXvOqPq1AAnwlXLzkjufy+l5xckp7Q+pMAIhjsQyWzfBE1WE6c3TIZG
         AFFgBnMfYINybs/E2XBeirHsbkCPiBx+qHwpcJOLuNAqLbq6l4jnqy2NE7PQktnia98M
         hgww==
X-Gm-Message-State: AOAM532bxi8AuQ2UJjJ2F88V4PeDAz+LmQ1f45tvyAzI46gVGB4g9O9N
        MkHdLJnVlgPI0BDZhO4xcC/s6yCiwWA=
X-Google-Smtp-Source: ABdhPJzjhXopAMrsHpKFsSf7/pdmGsj9BEAmXg+0djN/45333I2fopcIS1hAnk/51IpvWFS4Lrlx6g==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr19113904wrn.202.1623685879352;
        Mon, 14 Jun 2021 08:51:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm14890162wmq.41.2021.06.14.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:51:19 -0700 (PDT)
Message-Id: <6943eb511bee8323eb65f1466634ce9307694796.1623685877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
        <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 15:51:15 +0000
Subject: [PATCH v2 2/3] split-index: use oideq instead of memcmp to compare
 object_id's
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

cache_entry contains an object_id, and compare_ce_content() would
include that field when calling memcmp on a subset of the cache_entry.
Depending on which hashing algorithm is being used, only part of
object_id.hash is actually being used, therefore including it in a
memcmp() is incorrect. Instead we choose to exclude the object_id when
calling memcmp(), and call oideq() separately.

This issue was found when running t1700-split-index with MSAN, see MSAN
output below (on my machine, offset 76 corresponds to 4 bytes after the
start of object_id.hash).

Uninitialized bytes in MemcmpInterceptorCommon at offset 76 inside [0x7f60e7c00118, 92)
==27914==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x4524ee in memcmp /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/msan/../sanitizer_common/sanitizer_common_interceptors.inc:873:10
    #1 0xc867ae in compare_ce_content /home/ahunt/git/git/split-index.c:208:8
    #2 0xc859fb in prepare_to_write_split_index /home/ahunt/git/git/split-index.c:336:9
    #3 0xb4bbca in write_split_index /home/ahunt/git/git/read-cache.c:3107:2
    #4 0xb42b4d in write_locked_index /home/ahunt/git/git/read-cache.c:3295:8
    #5 0x638058 in try_merge_strategy /home/ahunt/git/git/builtin/merge.c:758:7
    #6 0x63057f in cmd_merge /home/ahunt/git/git/builtin/merge.c:1663:9
    #7 0x4a1e76 in run_builtin /home/ahunt/git/git/git.c:461:11
    #8 0x49e1e7 in handle_builtin /home/ahunt/git/git/git.c:714:3
    #9 0x4a0c08 in run_argv /home/ahunt/git/git/git.c:781:4
    #10 0x49d5a8 in cmd_main /home/ahunt/git/git/git.c:912:19
    #11 0x7974da in main /home/ahunt/git/git/common-main.c:52:11
    #12 0x7f60e928e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
    #13 0x421bd9 in _start /home/abuild/rpmbuild/BUILD/glibc-2.26/csu/../sysdeps/x86_64/start.S:120

  Uninitialized value was stored to memory at
    #0 0x447eb9 in __msan_memcpy /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/msan/msan_interceptors.cpp:1558:3
    #1 0xb4d1e6 in dup_cache_entry /home/ahunt/git/git/read-cache.c:3457:2
    #2 0xd214fa in add_entry /home/ahunt/git/git/unpack-trees.c:215:18
    #3 0xd1fae0 in keep_entry /home/ahunt/git/git/unpack-trees.c:2276:2
    #4 0xd1ff9e in twoway_merge /home/ahunt/git/git/unpack-trees.c:2504:11
    #5 0xd27028 in call_unpack_fn /home/ahunt/git/git/unpack-trees.c:593:12
    #6 0xd2443d in unpack_nondirectories /home/ahunt/git/git/unpack-trees.c:1106:12
    #7 0xd19435 in unpack_callback /home/ahunt/git/git/unpack-trees.c:1306:6
    #8 0xd0d7ff in traverse_trees /home/ahunt/git/git/tree-walk.c:532:17
    #9 0xd1773a in unpack_trees /home/ahunt/git/git/unpack-trees.c:1683:9
    #10 0xdc6370 in checkout /home/ahunt/git/git/merge-ort.c:3590:8
    #11 0xdc51c3 in merge_switch_to_result /home/ahunt/git/git/merge-ort.c:3728:7
    #12 0xa195a9 in merge_ort_recursive /home/ahunt/git/git/merge-ort-wrappers.c:58:2
    #13 0x637fff in try_merge_strategy /home/ahunt/git/git/builtin/merge.c:751:12
    #14 0x63057f in cmd_merge /home/ahunt/git/git/builtin/merge.c:1663:9
    #15 0x4a1e76 in run_builtin /home/ahunt/git/git/git.c:461:11
    #16 0x49e1e7 in handle_builtin /home/ahunt/git/git/git.c:714:3
    #17 0x4a0c08 in run_argv /home/ahunt/git/git/git.c:781:4
    #18 0x49d5a8 in cmd_main /home/ahunt/git/git/git.c:912:19
    #19 0x7974da in main /home/ahunt/git/git/common-main.c:52:11

  Uninitialized value was created by a heap allocation
    #0 0x44e73d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/msan/msan_interceptors.cpp:901:3
    #1 0xd592f6 in do_xmalloc /home/ahunt/git/git/wrapper.c:41:8
    #2 0xd59248 in xmalloc /home/ahunt/git/git/wrapper.c:62:9
    #3 0xa17088 in mem_pool_alloc_block /home/ahunt/git/git/mem-pool.c:22:6
    #4 0xa16f78 in mem_pool_init /home/ahunt/git/git/mem-pool.c:44:3
    #5 0xb481b8 in load_all_cache_entries /home/ahunt/git/git/read-cache.c
    #6 0xb44d40 in do_read_index /home/ahunt/git/git/read-cache.c:2298:17
    #7 0xb48a1b in read_index_from /home/ahunt/git/git/read-cache.c:2389:8
    #8 0xbd5a0b in repo_read_index /home/ahunt/git/git/repository.c:276:8
    #9 0xb4bcaf in repo_read_index_unmerged /home/ahunt/git/git/read-cache.c:3326:2
    #10 0x62ed26 in cmd_merge /home/ahunt/git/git/builtin/merge.c:1362:6
    #11 0x4a1e76 in run_builtin /home/ahunt/git/git/git.c:461:11
    #12 0x49e1e7 in handle_builtin /home/ahunt/git/git/git.c:714:3
    #13 0x4a0c08 in run_argv /home/ahunt/git/git/git.c:781:4
    #14 0x49d5a8 in cmd_main /home/ahunt/git/git/git.c:912:19
    #15 0x7974da in main /home/ahunt/git/git/common-main.c:52:11
    #16 0x7f60e928e349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/msan/../sanitizer_common/sanitizer_common_interceptors.inc:873:10 in memcmp
Exiting

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 split-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 4d6e52d46f75..8e52e891c3bc 100644
--- a/split-index.c
+++ b/split-index.c
@@ -207,7 +207,8 @@ static int compare_ce_content(struct cache_entry *a, struct cache_entry *b)
 	b->ce_flags &= ondisk_flags;
 	ret = memcmp(&a->ce_stat_data, &b->ce_stat_data,
 		     offsetof(struct cache_entry, name) -
-		     offsetof(struct cache_entry, ce_stat_data));
+		     offsetof(struct cache_entry, oid)) ||
+		!oideq(&a->oid, &b->oid);
 	a->ce_flags = ce_flags;
 	b->ce_flags = base_flags;
 
-- 
gitgitgadget

