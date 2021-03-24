Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9CC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B621C61A1F
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhCXRup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbhCXRuW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:50:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5BC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:50:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so1674493wmf.5
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=jDG2AY0iGtAr/UworhWYquMH6A7okfkvGUGh1IknSlY=;
        b=GUuC+8Pm+IPo1Rmtuecgzp1TWMzEoiD1iMDS8hYvEI7iPPAOKmpk/uAVLQykULu0hB
         WHwvasg6mns8qa+P4YLL4OtZ6RBF9yYXHsi2bNa9KdWkOHTGdC/ZMtp1cQYAbaU/ZF/n
         sIw9zsgAQWxQtLldbd25AxdO+d6j9QCSf5I+rFcZKHzX/dtaFcfPIOet9SAj/M0WtcjY
         eIsjH3sEJY7FV7wp8xGl+U7TQou2j18IPW3OCofffZXSI42DWVfq6aj8cx+LYC6SwV2B
         7aMkdZmCO1keU5aCByS9QVnHwo9uWYoXaNwBLAd+ePFb5Kr5LkIdGhiqN9PeoFD+Bkwu
         K06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jDG2AY0iGtAr/UworhWYquMH6A7okfkvGUGh1IknSlY=;
        b=bjTBZY+E9b1suJ/boTDqKj2MBYs+W+3NNGBuJG/lmlmwLMskT/XdWjyBZjziPiURzs
         Kna6KEJu1m0tg8vGfmDrI4A9HecTH+Cdi3vbOSGAKZtjDNKiHC+khpFa4Lwf/CyvPuGT
         25WGXGSSPconl01dtgcmwTMMAMxnSEkNzlm3iG2HXAW5pSd4EPpR/StU0dD1Tzyn8EGS
         KmIG0jxaGMbaowCb6KSk76EsSLLb8PZiNSuPubKdM8gPhu4vdxjW8mFGySte08/muHjA
         4HZQDM36sKpsna1UxYHOm7bOJRp7B7cU3gCVeOURme1kLPV5SdhVThukfAdLAfEjYvfL
         4/ZA==
X-Gm-Message-State: AOAM533I5o3acv8i9xEk/RfSDwAb3ULDOe0v5/mFC4hY0jldZW8FqRJn
        /LlMfAurSLcGoZEs76vYk6nXk6gIqk4=
X-Google-Smtp-Source: ABdhPJxnuTRCVe/MQwoWRbrBskjV1ZObBh3qtzx/UeDAMmlsl+1ML1GoyivVKSQmYp2tePzo+OOdmQ==
X-Received: by 2002:a7b:c20d:: with SMTP id x13mr4113927wmi.32.1616608221094;
        Wed, 24 Mar 2021 10:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm4031486wmm.5.2021.03.24.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:50:20 -0700 (PDT)
Message-Id: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 17:50:18 +0000
Subject: [PATCH] csum-file: flush less often
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an independent investigation, I noticed that do_write_index() in
read-cache.c has its own hashing logic and buffering mechanism.
Specifically, the ce_write() method was introduced by 4990aadc (Speed up
index file writing by chunking it nicely, 2005-04-20) and similar
mechanisms were introduced a few months later in c38138cd
(git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26).
Based on the timing, in the early days of the Git codebase, I figured
that these roughly equivalent code paths were never unified only because
it got lost in the shuffle. The hashfile API has since been used
extensively in other file formats, such as pack-indexes,
mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
unify the index writing code to use the same mechanism.

However, upon doing that refactoring process, I noticed that this caused
some commands that write the index to slow down by 1-2%! I then looked
for a reason why this could be.

First, I noticed that the mechanisms use different buffer sizes. The
hashfile uses an 8KB buffer while the index uses an 128KB buffer.
Testing with a variety of different buffer sizes made little difference.

Next, I inspected the buffering code itself, and found an important
difference. Specifically, every call to hashwrite() was causing a flush
of the filestream, even if it was a very small write. With many callers
using helpers like hashwrite_be32() to write integers in network-byte
order, this was leading to many more file flushes than necessary.

This change modifies hashwrite() to always populate the hashfile buffer,
and only flush when that buffer is full. This is safe to do because all
consumers of a hashfile must call finalize_hashfile(), which flushes the
buffer at the start.

It is worth noting that this is modifying logic introduced by a8032d12
(sha1write: don't copy full sized buffers, 2008-09-02) which reduces
memcpy() calls when the input buffer is sufficiently longer than the
hashfile's buffer, causing nr to be the length of the full buffer. Use
the input buffer directly in these cases. Since we don't guarantee that
the buffer is flushed by the end of hashwrite(), we need to group some
offset logic into the condition that memcpy() is necessary. Note that nr
is equal to sizeof(f->buffer) only when f->offset is zero, so that
condition does not need to be added here.

As for performance, I focused on known commands that spend a significant
amount of time writing through the hashfile API, especially if using
small buffers as in hashwrite_be32(). 'git multi-pack-index write' was
an excellent example (deleting the multi-pack-index file between runs)
and demonstrated this performance change in the Linux kernal repo:

Benchmark #1: old
  Time (mean ± σ):      2.229 s ±  0.143 s    [User: 1.409 s, System: 0.327 s]
  Range (min … max):    2.160 s …  2.636 s    10 runs

Benchmark #2: new
  Time (mean ± σ):      2.162 s ±  0.005 s    [User: 1.392 s, System: 0.323 s]
  Range (min … max):    2.152 s …  2.172 s    10 runs

Summary
  'new' ran
    1.03 ± 0.07 times faster than 'old'

Similarly, the same command on the Git repository gave these numbers:

Benchmark #1: old
  Time (mean ± σ):     230.5 ms ±   6.3 ms    [User: 140.5 ms, System: 42.9 ms]
  Range (min … max):   221.7 ms … 240.6 ms    12 runs

Benchmark #2: new
  Time (mean ± σ):     220.6 ms ±   5.1 ms    [User: 139.5 ms, System: 34.1 ms]
  Range (min … max):   214.0 ms … 229.0 ms    13 runs

Summary
  'new' ran
    1.05 ± 0.04 times faster than 'old'

Finally, to demonstrate that performance holds when frequently using
large buffers, the numbers below are for 'git pack-objects' packing all
objects in the Git repository between v2.30.0 and v2.31.1:

Benchmark #1: old
  Time (mean ± σ):      1.003 s ±  0.045 s    [User: 1.877 s, System: 0.167 s]
  Range (min … max):    0.931 s …  1.044 s    10 runs

Benchmark #2: new
  Time (mean ± σ):     976.4 ms ±  42.2 ms    [User: 1.854 s, System: 0.192 s]
  Range (min … max):   940.1 ms … 1049.3 ms    10 runs

Summary
  'new' ran
    1.03 ± 0.06 times faster than 'old'

With these consistent improvements of 3-5%, it will be possible to move
the index writing logic over to hashfile without performance
degradation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    csum-file: flush less often
    
    I found this while poking around the index.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-914%2Fderrickstolee%2Fhashfile-flush-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-914/derrickstolee/hashfile-flush-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/914

 csum-file.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 0f35fa5ee47c..39644af590a5 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -89,32 +89,26 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
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
 			/* process full buffer directly without copy */
-			data = buf;
+			the_hash_algo->update_fn(&f->ctx, buf, nr);
+			flush(f, buf, nr);
 		} else {
-			memcpy(f->buffer + offset, buf, nr);
-			data = f->buffer;
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
