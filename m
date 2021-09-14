Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B63C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860CA6113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhINWHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhINWHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:38 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539CC0613E4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:17 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b6so789472ilv.0
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqoO9mYcks/QS/cXaESVnH2zQ7d2jbHdYDnIhx9CVn0=;
        b=i7ymTNSgHHqM3ssZW6ydhIvAS4snXaCjqp3XURyq9e9e76pxHayhZ7nCyVJJNykMew
         7vXKOCc5dCIr099HvR3yb9F8mk/do/H/jZJCmLgtas3v1UveF1mB5V4r6qci/kRa5E2l
         AiQE6h5n/cO69PDjwiK0v3DvLOrITRogsEOgUkI31YL3Wg8MyjVXBeGI51yf5y4b+u7d
         S2RCTzEdVgiXrZxL/S3avPKmDGRGwqr0DSNxWTD5Es1jhrO6+p/dTLM5oQ42X+L17KVp
         H1+H2wTSRkGBN1nhgOLrLrTQFHC7t6h8QOHUbs3+hT60cbE5/7uePdc5wGFeYEPhCZSm
         lhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqoO9mYcks/QS/cXaESVnH2zQ7d2jbHdYDnIhx9CVn0=;
        b=eqx+lk48NErG6O3ExohUZeq4tux4iYaUVisAMt559HPU5U98t1PFE8jOHzRs+bB7+F
         cYHjagIbPoQNlj3G8KtEDtX/pc6eGX9Dj0jtMYgTMJtzSYVTPfepTuEc27B158Zr237F
         up/9f+PelLLi0DnC9q0MaWz7SUDVO2Uc5u9XiOd859vwg2xMQs5xIEw356sOURRQsy0S
         TxvCPxvNYOrS3Dhp1WooCDf96ZTDXhajbSV0FaaFMTl7fSZw2bckiJdwHFaF5SYHrBMb
         HP7olxgE3CBS4DdhJ6j5GoqLJuBTWXA8eSnIe6cG9nLiFCYuBNJN+fd/gD4/BJCNq0iE
         xQ+w==
X-Gm-Message-State: AOAM5316KvA2hUj64VavynDiY99AtsI3akvPWTFj3TbMtnqK4ZAly8RV
        v/5LyLzeSkkZXEFh/saStzT+TzIZW4QzuMDu
X-Google-Smtp-Source: ABdhPJx43V8+HF21Y3wgclOWjmu6CF3YcDF6an0mRPZ/VPpT1tF4AQ2cvsT19YvhFNcEjZwXxiuDng==
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr14399863ilv.212.1631657177202;
        Tue, 14 Sep 2021 15:06:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s10sm7466316iom.40.2021.09.14.15.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:16 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 7/7] t5326: test propagating hashcache values
Message-ID: <fdf71432b32ef47b23b79ddfc3db8de8734ef7a5.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
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
 t/t5326-multi-pack-bitmaps.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4ad7c2c969..24148ca35b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -283,4 +283,36 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'hash-cache values are propagated from pack bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		git config pack.writeBitmapHashCache true &&
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
