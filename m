Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35687C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152E461007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhDISMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhDISMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:45 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E160CC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c18so5448486iln.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4z4LT0lv5k9umGSR/ooyeHTuJXpCfSVmHmMOmakBiFE=;
        b=05AAIlsrSNWhrFoB/ePjtYTOR8WeZ4n6IkxvYT/rt9knilvhikFBd+zNd+AuUNvBQE
         GBls0EuNX4TZa3P3T6wiBswq1UtIT8XH1mjnwpjuuWLyWfNiEYB/Iy/FqRCzNnEuCNyi
         lYScuVRxcG02WtJpuhB8G9GVj17zsOGMQR626vpl/KRBG+RuuwU/BW++i7r5tdwoMewl
         g0IMuzAb2kiFzb3rVNHZq/2mi2O5+NVobj5pEdmsWV+j40XgBdWw81V+PXBDkJp8gmfv
         n3wDtvL2yCN223iBvZCoWZ/AesEVzZtjVYZn0mwQQDUGI2cFB2jC2X4ICj9C5/CbX9fo
         QfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4z4LT0lv5k9umGSR/ooyeHTuJXpCfSVmHmMOmakBiFE=;
        b=iG/473HLklgIgBNu1lP/nIpNLEGx/mHa6cZ4qVvLMOdyMjgTuUrWC0l14ZXf9jGeww
         vFpkN06YDkjFtuSPJqrNcLDnuRU5gBDhH8dIZDpz32IMS/jKeJAwgQfecvBDfaOrZg7C
         w8OGBFMBRW0nPvMNHYW6jStq8WThpLRxLBMRExs+J03tjN7/Q5ihbv5sufR3HDlQCOjb
         WDqJ1MRkMa6R/tl/3so5eV+UvJE8E2vFvF0TmbkFjAfuNJdNZsgXn+Qd92N2rRuhPH8F
         PQFkSQmecpuQu7KyK/q4juqCXktHb9fRllFiCounqLCQnhOTf2YY6U0VD5gfd7w2lHaz
         hFew==
X-Gm-Message-State: AOAM53171fhhQwiZy1OCNOHq4iHncqp1RqEpUTaU0WqKibLaVmmYLHti
        SBMSiFlCjRAcKKshxyUgBzHBYlwScA3rzR5x
X-Google-Smtp-Source: ABdhPJx5nTZoUIDykwiVRoN0e/2+6PnJDy1woQOwM750ES2p7ZlRnIFqB983ZNy659SW5bEX/3B86g==
X-Received: by 2002:a92:8752:: with SMTP id d18mr12086930ilm.22.1617991948062;
        Fri, 09 Apr 2021 11:12:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id g6sm303271ioq.6.2021.04.09.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:27 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 22/22] p5326: perf tests for MIDX bitmaps
Message-ID: <b75b534446088b20e77cbaa7f09705510ddec908.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These new performance tests demonstrate effectively the same behavior as
p5310, but use a multi-pack bitmap instead of a single-pack one.

Notably, p5326 does not create a MIDX bitmap with multiple packs. This
is so we can measure a direct comparison between it and p5310. Any
difference between the two is measuring just the overhead of using MIDX
bitmaps.

Here are the results of p5310 and p5326 together, measured at the same
time and on the same machine (using a Xenon W-2255 CPU):

    Test                                                  HEAD
    ------------------------------------------------------------------------
    5310.2: repack to disk                                96.78(93.39+11.33)
    5310.3: simulated clone                               9.98(9.79+0.19)
    5310.4: simulated fetch                               1.75(4.26+0.19)
    5310.5: pack to file (bitmap)                         28.20(27.87+8.70)
    5310.6: rev-list (commits)                            0.41(0.36+0.05)
    5310.7: rev-list (objects)                            1.61(1.54+0.07)
    5310.8: rev-list count with blob:none                 0.25(0.21+0.04)
    5310.9: rev-list count with blob:limit=1k             2.65(2.54+0.10)
    5310.10: rev-list count with tree:0                   0.23(0.19+0.04)
    5310.11: simulated partial clone                      4.34(4.21+0.12)
    5310.13: clone (partial bitmap)                       11.05(12.21+0.48)
    5310.14: pack to file (partial bitmap)                31.25(34.22+3.70)
    5310.15: rev-list with tree filter (partial bitmap)   0.26(0.22+0.04)

versus the same tests (this time using a multi-pack index):

    Test                                                  HEAD
    ------------------------------------------------------------------------
    5326.2: setup multi-pack index                        78.99(75.29+11.58)
    5326.3: simulated clone                               11.78(11.56+0.22)
    5326.4: simulated fetch                               1.70(4.49+0.13)
    5326.5: pack to file (bitmap)                         28.02(27.72+8.76)
    5326.6: rev-list (commits)                            0.42(0.36+0.06)
    5326.7: rev-list (objects)                            1.65(1.58+0.06)
    5326.8: rev-list count with blob:none                 0.26(0.21+0.05)
    5326.9: rev-list count with blob:limit=1k             2.97(2.86+0.10)
    5326.10: rev-list count with tree:0                   0.25(0.20+0.04)
    5326.11: simulated partial clone                      5.65(5.49+0.16)
    5326.13: clone (partial bitmap)                       12.22(13.43+0.38)
    5326.14: pack to file (partial bitmap)                30.05(31.57+7.25)
    5326.15: rev-list with tree filter (partial bitmap)   0.24(0.20+0.04)

There is slight overhead in "simulated clone", "simulated partial
clone", and "clone (partial bitmap)". Unsurprisingly, that overhead is
due to using the MIDX's reverse index to map between bit positions and
MIDX positions.

This can be reproduced by running "git repack -adb" along with "git
multi-pack-index write --bitmap" in a large-ish repository. Then run:

    $ perf record -o pack.perf git -c core.multiPackIndex=false \
      pack-objects --all --stdout >/dev/null </dev/null
    $ perf record -o midx.perf git -c core.multiPackIndex=true \
      pack-objects --all --stdout >/dev/null </dev/null

and compare the two with "perf diff -c delta -o 1 pack.perf midx.perf".
The most notable results are below (the next largest positive delta is
+0.14%):

    # Event 'cycles'
    #
    # Baseline    Delta  Shared Object       Symbol
    # ........  .......  ..................  ..........................
    #
                 +5.86%  git                 [.] nth_midxed_offset
                 +5.24%  git                 [.] nth_midxed_pack_int_id
         3.45%   +0.97%  git                 [.] offset_to_pack_pos
         3.30%   +0.57%  git                 [.] pack_pos_to_offset
                 +0.30%  git                 [.] pack_pos_to_midx

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
new file mode 100755
index 0000000000..5845109ac7
--- /dev/null
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='Tests performance using midx bitmaps'
+. ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
+
+test_perf_large_repo
+
+test_expect_success 'enable multi-pack index' '
+	git config core.multiPackIndex true
+'
+
+test_perf 'setup multi-pack index' '
+	git repack -ad &&
+	git multi-pack-index write --bitmap
+'
+
+test_full_bitmap
+
+test_expect_success 'create partial bitmap state' '
+	# pick a commit to represent the repo tip in the past
+	cutoff=$(git rev-list HEAD~100 -1) &&
+	orig_tip=$(git rev-parse HEAD) &&
+
+	# now pretend we have just one tip
+	rm -rf .git/logs .git/refs/* .git/packed-refs &&
+	git update-ref HEAD $cutoff &&
+
+	# and then repack, which will leave us with a nice
+	# big bitmap pack of the "old" history, and all of
+	# the new history will be loose, as if it had been pushed
+	# up incrementally and exploded via unpack-objects
+	git repack -Ad &&
+	git multi-pack-index write --bitmap &&
+
+	# and now restore our original tip, as if the pushes
+	# had happened
+	git update-ref HEAD $orig_tip
+'
+
+test_partial_bitmap
+
+test_done
-- 
2.31.1.163.ga65ce7f831
