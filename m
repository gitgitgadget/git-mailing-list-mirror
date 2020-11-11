Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344AC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D9C207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lVxk02Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgKKTmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKKTmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:14 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D5C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so2911877qkd.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aGJpchHTDY1Z4e1hNCHdORMrTmXRdchiVOmu8aKmyl8=;
        b=lVxk02Yy+NKT7FMca74ajqDAEzMtXzbmen+gMQEWPLSYBqQP1BAVrXmnStrBHeB1Rf
         PKF11tfx690Ti5ulvLnkj4g6NeuALUf+i6QEVXqyRBg71pop7FCUf+rvmP0FdntR75TR
         ZA2tiUNBlt8k/eHVQJMz1WK21Z5COCYUx1L4NsLbsShamtGAtWgDaWWolkaIKQYZ5sTE
         5rUgMa6jRLNgXBL23X39Cl04fm8MWZC9WqCvquO72hUN/RKRII72UWoNcULldeEH++H2
         hjuAzB2dM7CEcBnmPuTEXGLdG6xiYt9tm2cSlto+VaCzLbDVh+L6eFZqSU9c13BG7YUs
         BH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGJpchHTDY1Z4e1hNCHdORMrTmXRdchiVOmu8aKmyl8=;
        b=I8tmfDDi8P8fIl5X/Jz7dbyz2gpSoLIJ2YDqWIR4L90r6gc0cyltt1w+Dr1VF6yxxs
         +NsP+8ZU0WqFRtqHVc7yZVVMbVSdlmT7sFDQ9Er+EMHC2nA/NSPavYF1tsW1n5lVqYMx
         p38GKP2ma2WZwJ+1ryyk8Q3HxoQKQVLwMbCG/c7G51omoZWWF2TH+IEWIKevOuB4QckM
         I4UDQ6eouQoM7RRcN8Dx9EHrRcaDj6th//X9JmFbf0kLSquvx76s2OGMbJgGEUan2Ov6
         5rQ89i3k09vcwT9FA5PIwW0RAgJ67Dl1NU7i+DCyVufEde3YMmc2Fg9uImhLNeldksoC
         IMiQ==
X-Gm-Message-State: AOAM533F4b12XqcxTOtgi3KG5hVpQe1Ft22IIC3LevUgJKxyELdGGrER
        Za9dDQbIoLQWR3aERpW09DGuJBctubnd9J5p
X-Google-Smtp-Source: ABdhPJwQamuw6LB0D5Hjzsa/K1OfPllbnphfN2Z0Sp6lUzrhl0JYwf0sRUqWYMRcBRXAdOUnqTFyrw==
X-Received: by 2002:a37:f517:: with SMTP id l23mr14268528qkk.39.1605123731701;
        Wed, 11 Nov 2020 11:42:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id z20sm3330282qtb.31.2020.11.11.11.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:42:11 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:42:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 04/23] t5310: drop size of truncated ewah bitmap
Message-ID: <9db61a254af0f8369872e0ef91cbc38acfb079d0.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We truncate the .bitmap file to 512 bytes and expect to run into
problems reading an individual ewah file. But this length is somewhat
arbitrary, and just happened to work when the test was added in
9d2e330b17 (ewah_read_mmap: bounds-check mmap reads, 2018-06-14).

An upcoming commit will change the size of the history we create in the
test repo, which will cause this test to fail. We can future-proof it a
bit more by reducing the size of the truncated bitmap file.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index e2c3907a68..70a4fc4843 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -349,7 +349,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-- 
2.29.2.156.gc03786897f

