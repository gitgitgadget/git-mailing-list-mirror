Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2089EC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DF164E2F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBRDPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBRDPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:15:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423EC06178A
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:33 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w20so497842qta.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qijf3IlhB1tp7PkvrvMj/xijeNQlItQ/WjZtP7G/JP8=;
        b=bCtirxWZmflq3BeNqtuSYr5AqozHTyyfUUeJpC/zKMmnfnzXnlRQ2V9SfyEOfpaNZP
         eEP80WzVHy+aHe30pyOdZDN+GWJj+F1ZhS3655W0XZc4v4Ll1969DtZTm9KNat5I4iit
         VwUhRJWI/n5QzsjdYVZKda4OSPkqcAvZKbWQxYNM5mZWPegADDlW6sOHJlilcT96U8Re
         tBbAE2JJ46OaSYvd0s1zcRlcCTqmJy71y+weUdz6BAQDIJF4RRSIbN20CpLmZmtUibqu
         o8axU0NUoGdMakYXioyf89YL9DkRSCFT6MoyML6E2LMD2MXBj6kOmyOuqBrhk39ma31Q
         VbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qijf3IlhB1tp7PkvrvMj/xijeNQlItQ/WjZtP7G/JP8=;
        b=X1a3ZI0csN4JG8nX9bROglVTVEsYVSn/DBffXA+CnWGz0vih1GtKQFFB6kZEtozyzc
         y370xXaGBkMFRvzqNlxYDKWAI7wNmUHadDeOv/HDuoSl2tvWHJ2Q0SbqdSXxl6Zu3BGg
         +PyLY6c65JTr92BZktHdWyo6026Vin6S96rvISz1EuB80Rem7P3ulcL17ycEToE3OTf+
         gE2VrjnzQGJv4YgPTRe2QC7Wx0YcHpQEEgaShlI0kDjVoFvxCc5/Niy3m9FZ7vtH9JVV
         84TXjfsDKKWBO+iAL6G1y3xT9iCc5oEUkHyAdJCxsJceyyGeZsm1euWcvx24P3ki8lHi
         S8wg==
X-Gm-Message-State: AOAM533MePlHBW2QG359042r3aPgXZ5nrPlrWBVYfpD3V6YoVXSwOxGx
        5puflun13ze/owDxzcSmahE+VSlQJ5jwczRn
X-Google-Smtp-Source: ABdhPJyxCOvl+Qe/te67/lWvaO7JP13IJrlLQAEBfLKQfZO4Q2QZAMts4i4cxi8CogUjyNV+f47Dmw==
X-Received: by 2002:ac8:530f:: with SMTP id t15mr2409638qtn.167.1613618072030;
        Wed, 17 Feb 2021 19:14:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id e23sm2577703qtr.76.2021.02.17.19.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:31 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 5/8] p5303: measure time to repack with keep
Message-ID: <181c104a038f1ad8c30e68013bcdbc79cf394ea4.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Add two new tests to measure repack performance. Both test split the
repository into synthetic "pushes", and then leave the remaining objects
in a big base pack.

The first new test marks an empty pack as "kept" and then passes
--honor-pack-keep to avoid including objects in it. That doesn't change
the resulting pack, but it does let us compare to the normal repack case
to see how much overhead we add to check whether objects are kept or
not.

The other test is of --stdin-packs, which gives us a sense of how that
number scales based on the number of packs we provide as input. In each
of those tests, the empty pack isn't considered, but the residual pack
(objects that were left over and not included in one of the synthetic
push packs) is marked as kept.

(Note that in the single-pack case of the --stdin-packs test, there is
nothing do since there are no non-excluded packs).

Here are some timings on a recent clone of the kernel:

  5303.5: repack (1)                          57.26(54.59+10.84)
  5303.6: repack with kept (1)                57.33(54.80+10.51)

in the 50-pack case, things start to slow down:

  5303.11: repack (50)                        71.54(88.57+4.84)
  5303.12: repack with kept (50)              85.12(102.05+4.94)

and by the time we hit 1,000 packs, things are substantially worse, even
though the resulting pack produced is the same:

  5303.17: repack (1000)                      216.87(490.79+14.57)
  5303.18: repack with kept (1000)            665.63(938.87+15.76)

Likewise, the scaling is pretty extreme on --stdin-packs:

  5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
  5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
  5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)

That's because the code paths around handling .keep files are known to
scale badly; they look in every single pack file to find each object.
Our solution to that was to notice that most repos don't have keep
files, and to make that case a fast path. But as soon as you add a
single .keep, that part of pack-objects slows down again (even if we
have fewer objects total to look at).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index d90d714923..35c0cbdf49 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -31,8 +31,15 @@ repack_into_n () {
 	' "$1" >pushes &&
 
 	# create base packfile
-	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack &&
+	base_pack=$(
+		head -n 1 pushes |
+		git pack-objects --delta-base-offset --revs staging/pack
+	) &&
+	test_export base_pack &&
+
+	# create an empty packfile
+	empty_pack=$(git pack-objects staging/pack </dev/null) &&
+	test_export empty_pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
@@ -49,6 +56,12 @@ repack_into_n () {
 		last=$rev
 	done <pushes &&
 
+	(
+		find staging -type f -name 'pack-*.pack' |
+			xargs -n 1 basename | grep -v "$base_pack" &&
+		printf "^pack-%s.pack\n" $base_pack
+	) >stdin.packs
+
 	# and install the whole thing
 	rm -f .git/objects/pack/* &&
 	mv staging/* .git/objects/pack/
@@ -91,6 +104,23 @@ do
 		  --reflog --indexed-objects --delta-base-offset \
 		  --stdout </dev/null >/dev/null
 	'
+
+	test_perf "repack with kept ($nr_packs)" '
+		git pack-objects --keep-true-parents \
+		  --keep-pack=pack-$empty_pack.pack \
+		  --honor-pack-keep --non-empty --all \
+		  --reflog --indexed-objects --delta-base-offset \
+		  --stdout </dev/null >/dev/null
+	'
+
+	test_perf "repack with --stdin-packs ($nr_packs)" '
+		git pack-objects \
+		  --keep-true-parents \
+		  --stdin-packs \
+		  --non-empty \
+		  --delta-base-offset \
+		  --stdout <stdin.packs >/dev/null
+	'
 done
 
 # Measure pack loading with 10,000 packs.
-- 
2.30.0.667.g81c0cbc6fd

