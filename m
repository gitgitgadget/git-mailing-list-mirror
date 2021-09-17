Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D525C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C02D60EE5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbhIQVW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbhIQVWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0AAC061766
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:31 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a15so13863308iot.2
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jf5+uvNILF9fNHcOhq5RlhgWtj5PuFsYfRDxh+jKScw=;
        b=iYYShyiChABvxOPw07z3VvSjtVJ93VNz62T18NamgLzXMii6gRJQaWTgbmBadfBm7J
         BjHVAFUl2eMpa0yYanteigAltnDHqmPw2zrRctTNq1mVDJ5dDJ546cLR1fvJROGsvCoN
         jHYuG8RaQRKY9oqzJ2P/Ov9eSIxGEoNQyD10KrpeOfrVHC7lx/I0+TnR/owHMJg6DWLJ
         8KKW+4PdGCxlmsTYgSDvORNHdJvgw/ghXme24BCC5+fnU+yk+GvFhYh2bEU+YAtU/mtq
         8HqYszLb1WvWAqpNuB6dDfRxoRQBp2A3U9SRk5zBOs1gcLCKHvQIRQADfXTONDBNp7HW
         Fpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jf5+uvNILF9fNHcOhq5RlhgWtj5PuFsYfRDxh+jKScw=;
        b=qkoN4QXOxbaN6oEjcjrdoyio7xOjotPN1BXif9d1JHidQUGyc6b8f31rtOsMlezdEh
         ewvYp63U+31uv+MxLcye6jtvjVKdrOp4e73wl61n/bADTxGAg5BdHVhYAFe6LizgIBKS
         y4YP92HWB95Yg5L3IustqV+T8bVVGjhQ4PMWr3tz6pTceGSax5uUIQkbsbLcjmkO+6wu
         d6VBCQOnvKciVmCWUBaYngsJmCVu/UsZr//JFka4lrtmwKdVuQ4zjbaHXQ7AKERtYAg9
         FpX/riDyk/JRue2hlqcocyAX8nLf1nzOeRriDV+W0mXmbevF68j0J5jRgZADG/HBZzvr
         Ux8w==
X-Gm-Message-State: AOAM533coj0N8ejP3V1G08DCR5iTP/AmNeJz/dgmYAMZMrE7Xyb6LuVD
        Ehtw1yaJ/8GQgRzVjChJ0Yu6L75AACfCtp0L
X-Google-Smtp-Source: ABdhPJxpDhOqFXVXruRlcd3ooDKy7cIt93N3EyluXwhzqf17DaWcVXNSQTeN/Sr5sm7DubELoUQATg==
X-Received: by 2002:a6b:7212:: with SMTP id n18mr9786904ioc.175.1631913690842;
        Fri, 17 Sep 2021 14:21:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3sm4490787ilm.20.2021.09.17.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 7/7] t5326: test propagating hashcache values
Message-ID: <bb1612591516bf7e88886d405fc06dd1d2e9a8bb.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we both can propagate values from the hashcache, and respect
the configuration to enable the hashcache at all, test that both of
these function correctly by hardening their behavior with a test.

Like the hash-cache in classic single-pack bitmaps, this helps more
proportionally the more up-to-date your bitmap coverage is. When our
bitmap coverage is out-of-date with the ref tips, we spend more time
proportionally traversing, and all of that traversal gets the name-hash
filled in.

But for the up-to-date bitmaps, this helps quite a bit. These numbers
are on git.git, with `pack.threads=1` to help see the difference
reflected in the overall runtime.

    Test                            origin/tb/multi-pack-bitmaps   HEAD
    -------------------------------------------------------------------------------------
    5326.4: simulated clone         1.87(1.80+0.07)                1.46(1.42+0.03) -21.9%
    5326.5: simulated fetch         2.66(2.61+0.04)                1.47(1.43+0.04) -44.7%
    5326.6: pack to file (bitmap)   2.74(2.62+0.12)                1.89(1.82+0.07) -31.0%

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4ad7c2c969..ec4aa89f63 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -283,4 +283,34 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'hash-cache values are propagated from pack bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		test_commit base2 &&
+		git repack -adb &&
+
+		test-tool bitmap dump-hashes >pack.raw &&
+		test_file_not_empty pack.raw &&
+		sort pack.raw >pack.hashes &&
+
+		test_commit new &&
+		git repack &&
+		git multi-pack-index write --bitmap &&
+
+		test-tool bitmap dump-hashes >midx.raw &&
+		sort midx.raw >midx.hashes &&
+
+		# ensure that every namehash in the pack bitmap can be found in
+		# the midx bitmap (i.e., that there are no oid-namehash pairs
+		# unique to the pack bitmap).
+		comm -23 pack.hashes midx.hashes >dropped.hashes &&
+		test_must_be_empty dropped.hashes
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6
