Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F9C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203D361155
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbhIQVWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbhIQVWr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE6C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p80so7307727iod.10
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u4HKy7NV11ULIZEUfMYUHNPx8hTvspNv2zuQZqYUx3A=;
        b=v3I0d9znYxnnFlFkE/5jhEjjYA9SSYCWLtP1JtXmidHzQXvXiLaxoXPv6JV4sWRr/O
         TFgWDyGHXvbiHr0lZJRq0/MCoC0zsV5gNh41+j+5cOyMZAODfgr/vYK4PPC8ceFLzo4v
         S/sSaoW5rdsgtMOUqlOTKMB9V7bi4SZ/6poRU94kwsQ0xfpIrm0gc4g7PsIrZdiRyy/s
         HNie32n4fmHigtOrYkiSHz+a5qPUmA3WT/BzCJOmRtaNzhCHv810AeyiXhgqavmIO+HZ
         bnNNziuNwuIkJ9O1LLb+I9crnBy4qeGtNPdrqLOdvwZdJtN0cEfH1Kzvt1LVRqw3hwui
         iaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4HKy7NV11ULIZEUfMYUHNPx8hTvspNv2zuQZqYUx3A=;
        b=v+r1WMfV8P1jStv8Q3N3YwX18/n4Jo6mS9jnLh2QvuwX+5Pukb+QFdABPAOarTy9f+
         D5yj7owJJA4kHexNc16UdoCmhyul5cKYLK0tSjWgF+DcWgPqEQ21+A09549RFg+nvGkV
         HfCV/0TlDgmDa6QCIKAxJuYfmDyNamM3MIHI9gVtRG5r68TGJA+GXZgLI7B7dNNcxZXD
         GC6Kj0j9RfJ/EFyNo1zWiZq9W/1E/ncGmNCmq4CfEx51EyP2qdsjoZ/mNKguG+x9+k5H
         dSOsh65Gv6PVxHb3/6uEhvnc09iGJeZjc0t4YpuNT67jpH1FTHYklM4W90mhu/I2z3bG
         bDlA==
X-Gm-Message-State: AOAM530ZUMajzFrim4VhV9xsnYrvWWaysIXcrtSYoJdEEDlYTmq+BBy1
        4+WhMFH93TyhXpr1GeA6IgwRebZlACWjmAJo
X-Google-Smtp-Source: ABdhPJz42AfMOvKl2OElEZEV+LLdMSUAjl7lUrjrPZU96/RATbvQiL0mfyWTTCBRrris/Xq2Qzqxsg==
X-Received: by 2002:a02:210d:: with SMTP id e13mr6109890jaa.141.1631913683489;
        Fri, 17 Sep 2021 14:21:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m26sm4092778ioj.54.2021.09.17.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:23 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 4/7] p5326: create missing 'perf-tag' tag
Message-ID: <a8c6e845adf559a96e37c973fea16da8a42e7cba.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the tests in test_full_bitmap rely on having a tag named
perf-tag in place. We could create it in test_full_bitmap(), but we want
to have it in place before the repack starts.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index 5845109ac7..51b5636259 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -10,6 +10,12 @@ test_expect_success 'enable multi-pack index' '
 	git config core.multiPackIndex true
 '
 
+# we need to create the tag up front such that it is covered by the repack and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message="tag pointing to HEAD" perf-tag HEAD
+'
+
 test_perf 'setup multi-pack index' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap
-- 
2.33.0.96.g73915697e6

