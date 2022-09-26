Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCDC6FA86
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiIZOwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiIZOvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:51:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E202B4A2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:18:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e18so4472998wmq.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=8R3f1ta3fPoakv/GS0c/4AKqJvEr726yGlYyMuNC3us=;
        b=jp18K+gMOiUqPToiuRKC7msM1v83+EPbAoclv8TgCNgPtytAdxFA1DUk7lAmQLYRYf
         pd0ciYj+3udZj+gkIYI9k16IMg3vGfhVpMKxRRZavfh2RoGF1oPENbacxyvyBIAR9MhH
         83xuxrEbyRqedrUOAZrGgSw9U6hDrlMbSWfbKtABgJTQieE4WKkNecfxrRvC9Mfn5vlq
         6kGIhSa4MmDOFld3EMmMebkl2luIwxkMCx4Y720fEKYA75vYGKV86jol75kmwAQDpSjA
         q3su1LpiBLIvQL0jsYGGDvDjEterIvdf5YdZH9iOhrCI8Vl6n8xp4On4FZeCAERbb0L8
         TqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8R3f1ta3fPoakv/GS0c/4AKqJvEr726yGlYyMuNC3us=;
        b=ApQjiJmCiguAur5eXGhodqYjvGRoQbbMjiCoBROePNGFhb9BusKY/4/qInhF3Dr966
         GeeAV9nh9ICbJ4nynVLA2/AkrBiNBZnVivlht69ARCwcHJFFRc4mhoXqA4obQo+g4ZHG
         d2pzmAVpGbRdk3K+XZVr8GLv7unbHQ3Ol9D7kMfsAT85h8CgObhKUrQjaXn9Ybf7tvyO
         5O5nxnr9X3yEHJvg8dJsJ1nwKOPJZbyqyxzmaBf4l3GS3AJnyGrclAiACsq7Ce3u7SAF
         Z2daJ+NbNUwAd/7TV1RzEtswmAYZWjNqCR6/oKVHkgg5V7LExiPdsPZGfqnDbfCqJ71k
         IgqQ==
X-Gm-Message-State: ACrzQf0RAG7sZC8seFtyXi8BI2iN7jlt2yA33XOAQLz178J4Rs3bMQSZ
        COeb0MGhMslt4GojqRqTkFdvYJ1S6e4=
X-Google-Smtp-Source: AMsMyM6YAtJqhQ1lqtxs5kKO4O33j1HWOnuGbvGYVJJHVz4TCTK3zLvRkh8Y1vCDqIohdnYr6myqnQ==
X-Received: by 2002:a05:600c:1f18:b0:3b4:c4ae:f666 with SMTP id bd24-20020a05600c1f1800b003b4c4aef666mr22106613wmb.88.1664198278676;
        Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003a5c244fc13sm11482056wms.2.2022.09.26.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
Message-Id: <pull.1365.v2.git.1664198277250.gitgitgadget@gmail.com>
In-Reply-To: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 13:17:57 +0000
Subject: [PATCH v2] pack-bitmap: remove trace2 region from hot path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The trace2 region around the call to lazy_bitmap_for_commit() in
bitmap_for_commit() was added in 28cd730680d (pack-bitmap: prepare to
read lookup table extension, 2022-08-14). While adding trace2 regions is
typically helpful for tracking performance, this method is called
possibly thousands of times as a commit walk explores commit history
looking for a matching bitmap. When trace2 output is enabled, this
region is emitted many times and performance is throttled by that
output.

For now, remove these regions entirely.

This is a critical path, and it would be valuable to measure that the
time spent in bitmap_for_commit() does not increase when using the
commit lookup table. The best way to do that would be to use a mechanism
that sums the time spent in a region and reports a single value at the
end of the process. This technique was introduced but not merged by [1]
so maybe this example presents some justification to revisit that
approach.

[1] https://lore.kernel.org/git/pull.1099.v2.git.1640720202.gitgitgadget@gmail.com/

To help with the 'git blame' output in this region, add a comment that
warns against adding a trace2 region. Delete a test from t5310 that used
that trace output to check that this lookup optimization was activated.
To create this kind of test again in the future, the stopwatch traces
mentioned earlier could be used as a signal that we activated this code
path.

Helpedy-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    [For 2.38.0] pack-bitmap: remove trace2 region from hot path
    
    I noticed this while trying to backport the Abhradeep's lookup table
    work into GitHub's fork. Something went wrong in that process, causing
    this region to significantly slow down. It turns out that slow down does
    not reproduce on current 'master', which is good. I must have missed
    something while I was backporting.
    
    Regardless, the use of trace2_region_enter() here should be removed or
    replaced. For the sake of 2.38.0, this simple removal is safe enough.
    However, to really dig into what was happening I had to construct a
    rebase [2] of Jeff's trace2 stopwatch work, then apply changes on top
    [3] that could replace this region with trace2_timer_*() methods.
    
    [2]
    https://github.com/git/git/compare/master...derrickstolee:trace2-stopwatch
    [3]
    https://github.com/derrickstolee/git/compare/trace2-stopwatch...bitmap-trace2
    
    As a separate discussion, it might be worth revisiting that stopwatch
    work so we have it available as a tool when doing these kinds of
    investigations.
    
    
    Updates in v2
    =============
    
     * I removed the test that was checking for trace2 regions. In [3], I
       played around with using trace2_counter() to replace that check, so
       we could reinstate the test without the performance drop from using
       repeated trace2_region() calls.
     * I squashed in Junio's comment change.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1365%2Fderrickstolee%2Fbitmap-remove-trace2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1365/derrickstolee/bitmap-remove-trace2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1365

Range-diff vs v1:

 1:  987827eaf90 ! 1:  8ef63c9e32f pack-bitmap: remove trace2 region from hot path
     @@ Commit message
      
          [1] https://lore.kernel.org/git/pull.1099.v2.git.1640720202.gitgitgadget@gmail.com/
      
     +    To help with the 'git blame' output in this region, add a comment that
     +    warns against adding a trace2 region. Delete a test from t5310 that used
     +    that trace output to check that this lookup optimization was activated.
     +    To create this kind of test again in the future, the stopwatch traces
     +    mentioned earlier could be used as a signal that we activated this code
     +    path.
     +
     +    Helpedy-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## pack-bitmap.c ##
     @@ pack-bitmap.c: struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap
       			return NULL;
       
      -		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
     ++		/* this is a fairly hot codepath - no trace2_region please */
       		/* NEEDSWORK: cache misses aren't recorded */
       		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
      -		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
       		if (!bitmap)
       			return NULL;
       		return lookup_stored_bitmap(bitmap);
     +
     + ## t/t5310-pack-bitmaps.sh ##
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'verify writing bitmap lookup table when enabled' '
     + 	grep "\"label\":\"writing_lookup_table\"" trace2
     + '
     + 
     +-test_expect_success 'lookup table is actually used to traverse objects' '
     +-	git repack -adb &&
     +-	GIT_TRACE2_EVENT="$(pwd)/trace3" \
     +-		git rev-list --use-bitmap-index --count --all &&
     +-	grep "\"label\":\"reading_lookup_table\"" trace3
     +-'
     +-
     + test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
     + 	test_config pack.writebitmaphashcache false &&
     + 	git repack -adb &&


 pack-bitmap.c           | 3 +--
 t/t5310-pack-bitmaps.sh | 7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9a208abc1fd..a2bbbbd811d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -830,10 +830,9 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 		if (!bitmap_git->table_lookup)
 			return NULL;
 
-		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
+		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
-		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
 		if (!bitmap)
 			return NULL;
 		return lookup_stored_bitmap(bitmap);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7e50f8e7653..6d693eef82f 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -455,13 +455,6 @@ test_expect_success 'verify writing bitmap lookup table when enabled' '
 	grep "\"label\":\"writing_lookup_table\"" trace2
 '
 
-test_expect_success 'lookup table is actually used to traverse objects' '
-	git repack -adb &&
-	GIT_TRACE2_EVENT="$(pwd)/trace3" \
-		git rev-list --use-bitmap-index --count --all &&
-	grep "\"label\":\"reading_lookup_table\"" trace3
-'
-
 test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_config pack.writebitmaphashcache false &&
 	git repack -adb &&

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
