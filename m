Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E952C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044CE6197C
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCZMi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhCZMiP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 08:38:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A1C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 05:38:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4844955wml.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5w1Bdq42HccbTFG9k1Ip6twLpVfpPck6EDilJzSuIUU=;
        b=RsSZVW3nITAgRE6NBH252MCZgxUJifc04sGZT1Swy1njNMppQ65n4OU2YXazrI/wQ+
         xlFn04uHXnSRYhNRNJc2+BFogy07c7zvx4gqN9bEBe2y84u6QZdMCoJxq5vCcTLfJEXd
         oFblnwj2U32+hYlho3n3KUKnAPMBNcTp3QAa3oXCpGcLZ5L+EzIPNML84Ej2a9dNtQ18
         2/sEIVXgeEoiZvIoRIoxAMzkyQV6DIvn/I3ZnVxjtl91HHg1ztTkGwcCqF63cwSyk/Le
         oUKm9G3kB7E5u7JMMy8S6a5QrmEXcTKYjqbajytnOB4EtSV7FyA8k9G2ihWmru5jjAQX
         UHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5w1Bdq42HccbTFG9k1Ip6twLpVfpPck6EDilJzSuIUU=;
        b=MmUcFlQMQtye8Jvt0tgcrJmrCwPFNvKmFrbh2NkbPAq3ah+/ayATDDrNHnELZ0g8G0
         S7mzWvMNwnY5xI5zQkRNl1E4jSyx4pUfME7dl3i5gQBG8h2h2DECMMVqy2TASHGVRCyk
         UFlrcVMiBqaXPaemn2/pQckw9XEqDiK/YEzD44pn2rmR2jMZwCIzUR06LYk2By3yeM8z
         6PslcMrXhRDD7rBBDFdDmFSfftNjOwv8aWMrzQEO4EAdd50lP2VdMvAk9jwVzWtjlmB2
         HIqGM6ZjkmM98z+ggqOAuhPuPbvOK/SlZOdt4zKJisFfbfiTVzrDoreNzYPWJpcWUl3q
         zHOA==
X-Gm-Message-State: AOAM530aZLu2svMalnymG9/3tfH6lYOl+8JIVDHQQo7+8ApRULYZiwYM
        5d0uecFSfepARV3WqCV6fC9xcB4zJWs=
X-Google-Smtp-Source: ABdhPJwuwhvNyTCs4MSj11vJYjwro0rGzj5xlwPmrjM/dTHEXEfrtafxQHjqkZKP+bVLdoE3LAmMTA==
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr12646837wmc.88.1616762292844;
        Fri, 26 Mar 2021 05:38:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm12248441wrt.21.2021.03.26.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 05:38:12 -0700 (PDT)
Message-Id: <pull.914.v2.git.1616762291574.gitgitgadget@gmail.com>
In-Reply-To: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 12:38:11 +0000
Subject: [PATCH v2] csum-file: make hashwrite() more readable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The hashwrite() method takes an input buffer and updates a hashfile's
hash function while writing the data to a file. To avoid overuse of
flushes, the hashfile has an internal buffer and most writes will use
memcpy() to transfer data from the input 'buf' to the hashfile's buffer
of size 8 * 1024 bytes.

Logic introduced by a8032d12 (sha1write: don't copy full sized buffers,
2008-09-02) reduces the number of memcpy() calls when the input buffer
is sufficiently longer than the hashfile's buffer, causing nr to be the
length of the full buffer. In these cases, the input buffer is used
directly in chunks equal to the hashfile's buffer size.

This method caught my attention while investigating some performance
issues, but it turns out that these performance issues were noise within
the variance of the experiment.

However, during this investigation, I inspected hashwrite() and
misunderstood it, even after looking closely and trying to make it
faster. This change simply reorganizes some parts of the loop within
hashwrite() to make it clear that each batch either uses memcpy() to the
hashfile's buffer or writes directly from the input buffer. The previous
code relied on indirection through local variables and essentially
inlined the implementation of hashflush() to reduce lines of code.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    csum-file: make hashwrite() more readable
    
    v2 adds comments to the implementation to make some assumptions very
    clear about what is happening in each case.
    
    The commit message is almost completely rewritten based on the
    discussion on-list.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-914%2Fderrickstolee%2Fhashfile-flush-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-914/derrickstolee/hashfile-flush-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/914

Range-diff vs v1:

 1:  91995baaaa42 ! 1:  68a429b0ba7e csum-file: flush less often
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    csum-file: flush less often
     -
     -    In an independent investigation, I noticed that do_write_index() in
     -    read-cache.c has its own hashing logic and buffering mechanism.
     -    Specifically, the ce_write() method was introduced by 4990aadc (Speed up
     -    index file writing by chunking it nicely, 2005-04-20) and similar
     -    mechanisms were introduced a few months later in c38138cd
     -    (git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26).
     -    Based on the timing, in the early days of the Git codebase, I figured
     -    that these roughly equivalent code paths were never unified only because
     -    it got lost in the shuffle. The hashfile API has since been used
     -    extensively in other file formats, such as pack-indexes,
     -    mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
     -    unify the index writing code to use the same mechanism.
     -
     -    However, upon doing that refactoring process, I noticed that this caused
     -    some commands that write the index to slow down by 1-2%! I then looked
     -    for a reason why this could be.
     -
     -    First, I noticed that the mechanisms use different buffer sizes. The
     -    hashfile uses an 8KB buffer while the index uses an 128KB buffer.
     -    Testing with a variety of different buffer sizes made little difference.
     -
     -    Next, I inspected the buffering code itself, and found an important
     -    difference. Specifically, every call to hashwrite() was causing a flush
     -    of the filestream, even if it was a very small write. With many callers
     -    using helpers like hashwrite_be32() to write integers in network-byte
     -    order, this was leading to many more file flushes than necessary.
     -
     -    This change modifies hashwrite() to always populate the hashfile buffer,
     -    and only flush when that buffer is full. This is safe to do because all
     -    consumers of a hashfile must call finalize_hashfile(), which flushes the
     -    buffer at the start.
     -
     -    It is worth noting that this is modifying logic introduced by a8032d12
     -    (sha1write: don't copy full sized buffers, 2008-09-02) which reduces
     -    memcpy() calls when the input buffer is sufficiently longer than the
     -    hashfile's buffer, causing nr to be the length of the full buffer. Use
     -    the input buffer directly in these cases. Since we don't guarantee that
     -    the buffer is flushed by the end of hashwrite(), we need to group some
     -    offset logic into the condition that memcpy() is necessary. Note that nr
     -    is equal to sizeof(f->buffer) only when f->offset is zero, so that
     -    condition does not need to be added here.
     -
     -    As for performance, I focused on known commands that spend a significant
     -    amount of time writing through the hashfile API, especially if using
     -    small buffers as in hashwrite_be32(). 'git multi-pack-index write' was
     -    an excellent example (deleting the multi-pack-index file between runs)
     -    and demonstrated this performance change in the Linux kernal repo:
     -
     -    Benchmark #1: old
     -      Time (mean ± σ):      2.229 s ±  0.143 s    [User: 1.409 s, System: 0.327 s]
     -      Range (min … max):    2.160 s …  2.636 s    10 runs
     -
     -    Benchmark #2: new
     -      Time (mean ± σ):      2.162 s ±  0.005 s    [User: 1.392 s, System: 0.323 s]
     -      Range (min … max):    2.152 s …  2.172 s    10 runs
     -
     -    Summary
     -      'new' ran
     -        1.03 ± 0.07 times faster than 'old'
     -
     -    Similarly, the same command on the Git repository gave these numbers:
     -
     -    Benchmark #1: old
     -      Time (mean ± σ):     230.5 ms ±   6.3 ms    [User: 140.5 ms, System: 42.9 ms]
     -      Range (min … max):   221.7 ms … 240.6 ms    12 runs
     -
     -    Benchmark #2: new
     -      Time (mean ± σ):     220.6 ms ±   5.1 ms    [User: 139.5 ms, System: 34.1 ms]
     -      Range (min … max):   214.0 ms … 229.0 ms    13 runs
     -
     -    Summary
     -      'new' ran
     -        1.05 ± 0.04 times faster than 'old'
     -
     -    Finally, to demonstrate that performance holds when frequently using
     -    large buffers, the numbers below are for 'git pack-objects' packing all
     -    objects in the Git repository between v2.30.0 and v2.31.1:
     -
     -    Benchmark #1: old
     -      Time (mean ± σ):      1.003 s ±  0.045 s    [User: 1.877 s, System: 0.167 s]
     -      Range (min … max):    0.931 s …  1.044 s    10 runs
     -
     -    Benchmark #2: new
     -      Time (mean ± σ):     976.4 ms ±  42.2 ms    [User: 1.854 s, System: 0.192 s]
     -      Range (min … max):   940.1 ms … 1049.3 ms    10 runs
     -
     -    Summary
     -      'new' ran
     -        1.03 ± 0.06 times faster than 'old'
     -
     -    With these consistent improvements of 3-5%, it will be possible to move
     -    the index writing logic over to hashfile without performance
     -    degradation.
     -
     +    csum-file: make hashwrite() more readable
     +
     +    The hashwrite() method takes an input buffer and updates a hashfile's
     +    hash function while writing the data to a file. To avoid overuse of
     +    flushes, the hashfile has an internal buffer and most writes will use
     +    memcpy() to transfer data from the input 'buf' to the hashfile's buffer
     +    of size 8 * 1024 bytes.
     +
     +    Logic introduced by a8032d12 (sha1write: don't copy full sized buffers,
     +    2008-09-02) reduces the number of memcpy() calls when the input buffer
     +    is sufficiently longer than the hashfile's buffer, causing nr to be the
     +    length of the full buffer. In these cases, the input buffer is used
     +    directly in chunks equal to the hashfile's buffer size.
     +
     +    This method caught my attention while investigating some performance
     +    issues, but it turns out that these performance issues were noise within
     +    the variance of the experiment.
     +
     +    However, during this investigation, I inspected hashwrite() and
     +    misunderstood it, even after looking closely and trying to make it
     +    faster. This change simply reorganizes some parts of the loop within
     +    hashwrite() to make it clear that each batch either uses memcpy() to the
     +    hashfile's buffer or writes directly from the input buffer. The previous
     +    code relied on indirection through local variables and essentially
     +    inlined the implementation of hashflush() to reduce lines of code.
     +
     +    Helped-by: Jeff King <peff@peff.net>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## csum-file.c ##
     @@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned char *result, un
       			f->crc32 = crc32(f->crc32, buf, nr);
       
       		if (nr == sizeof(f->buffer)) {
     - 			/* process full buffer directly without copy */
     +-			/* process full buffer directly without copy */
      -			data = buf;
     ++			/*
     ++			 * Flush a full batch worth of data directly
     ++			 * from the input, skipping the memcpy() to
     ++			 * the hashfile's buffer. In this block,
     ++			 * f->offset is necessarily zero.
     ++			 */
      +			the_hash_algo->update_fn(&f->ctx, buf, nr);
      +			flush(f, buf, nr);
       		} else {
      -			memcpy(f->buffer + offset, buf, nr);
      -			data = f->buffer;
     ++			/*
     ++			 * Copy to the hashfile's buffer, flushing only
     ++			 * if it became full.
     ++			 */
      +			memcpy(f->buffer + f->offset, buf, nr);
      +			f->offset += nr;
      +			left -= nr;


 csum-file.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 0f35fa5ee47c..7510950fa3e9 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -89,32 +89,35 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
 void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 {
 	while (count) {
-		unsigned offset = f->offset;
-		unsigned left = sizeof(f->buffer) - offset;
+		unsigned left = sizeof(f->buffer) - f->offset;
 		unsigned nr = count > left ? left : count;
-		const void *data;
 
 		if (f->do_crc)
 			f->crc32 = crc32(f->crc32, buf, nr);
 
 		if (nr == sizeof(f->buffer)) {
-			/* process full buffer directly without copy */
-			data = buf;
+			/*
+			 * Flush a full batch worth of data directly
+			 * from the input, skipping the memcpy() to
+			 * the hashfile's buffer. In this block,
+			 * f->offset is necessarily zero.
+			 */
+			the_hash_algo->update_fn(&f->ctx, buf, nr);
+			flush(f, buf, nr);
 		} else {
-			memcpy(f->buffer + offset, buf, nr);
-			data = f->buffer;
+			/*
+			 * Copy to the hashfile's buffer, flushing only
+			 * if it became full.
+			 */
+			memcpy(f->buffer + f->offset, buf, nr);
+			f->offset += nr;
+			left -= nr;
+			if (!left)
+				hashflush(f);
 		}
 
 		count -= nr;
-		offset += nr;
 		buf = (char *) buf + nr;
-		left -= nr;
-		if (!left) {
-			the_hash_algo->update_fn(&f->ctx, data, offset);
-			flush(f, data, offset);
-			offset = 0;
-		}
-		f->offset = offset;
 	}
 }
 

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
