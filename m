Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D63ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 13:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIWNAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIWNAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 09:00:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2737F6843
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 06:00:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so3127910wms.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=Jgp2bNssHrfkbEJW9ksKkgHq0gl+TL2jyTNSSiRYzS8=;
        b=AwkHVKMIowS9Bn7HKMxRWke3e58RS7nxtDCrW4dNMroSeQN/opdWkZmydIJhA11g2G
         DjB0wp/XgIRDv/GToZ4llS4KZYJc9p4N/1AGwAaJBBQC/wH8RbwjVELg/NclY3BPVzvr
         HgwoM/H4+rpY8m8Sf1FW+Qyg5uEO5PP741E287d7PaKp1yLu/s+CV51T9WgQLumsWN7u
         GGhl9u7bycz6Oy190MQkJHmBAcKTuzQiEzSzEKXFnqDrPdYldMWPFTMymjTToMHyyw0D
         zRIO0q1dzb0zttb777CgYDHcvte+xGTdPYrIcouvvTcy9GfTKt1MBFZGGGbAXez0v0Qo
         Ltlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Jgp2bNssHrfkbEJW9ksKkgHq0gl+TL2jyTNSSiRYzS8=;
        b=21WCiWboZjEbruwDvvsPH1+XJ9eofmu1lk2nbGoxZ+jUD7mjnLGmPcCZRCLyaOPZsk
         P2M9DKD7IGwmqLFd2qR5mTIBUPNLiLBoQ7fpotjtB/NFzIxuiVp5ZsoJ+9KYhT+KI2A4
         Xi1rdKHhiL03e4/kAlqLB0RYycfj6+uYaIyvE2TXFyiG+0uh4IW41beaIdzRx3EfBrBm
         ALunEF76nX3kZPM0W/bsHYtI5fAQozUIdJ2Fu/0js2suqO4GC6XrtMogachNMX2r1Mxk
         Cj1v490gwyQ4plwWELPLFUBYQmSd0l9C9MCn2JUwoymLQwfMbeylruNK/GJt2vSYctrf
         tx0g==
X-Gm-Message-State: ACrzQf3lzuKQCDKzYhm25SaY+58GTGFj0KcNt/TogvxXVdLo4y75drDD
        fdarMsu6138/Zik349xuy9CtvIcmvl8=
X-Google-Smtp-Source: AMsMyM7Y2znUDsRNmNoGGOvrV36I0cxYDZZ7RRaneo1T0mmzBQ71yALKoJKQCMy5zgsFQTeksua/bg==
X-Received: by 2002:a05:600c:3555:b0:3b4:c0fd:918e with SMTP id i21-20020a05600c355500b003b4c0fd918emr5726394wmq.61.1663938035917;
        Fri, 23 Sep 2022 06:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c4e4400b003a682354f63sm2646690wmq.11.2022.09.23.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:00:35 -0700 (PDT)
Message-Id: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 13:00:34 +0000
Subject: [PATCH] pack-bitmap: remove trace2 region from hot path
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
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1365%2Fderrickstolee%2Fbitmap-remove-trace2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1365/derrickstolee/bitmap-remove-trace2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1365

 pack-bitmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9a208abc1fd..13457dd77e5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -830,10 +830,8 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 		if (!bitmap_git->table_lookup)
 			return NULL;
 
-		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
-		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
 		if (!bitmap)
 			return NULL;
 		return lookup_stored_bitmap(bitmap);

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
