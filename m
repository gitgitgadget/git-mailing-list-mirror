Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38558EB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFUKVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFUKVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:21:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CDE10F1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:21:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso5717124276.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687342874; x=1689934874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8treZK1wQrbkGKbJPdJghlW46yrsb5CCDx0rBn6I4Nc=;
        b=RwcVw/c5/AY4vFeNdrZyxaXJNuZ4EQe6ye/M8nv6oM/ZR5q7DIlFiFSzQC2X5iP9jN
         6za5PcYBdynyY1LAItbndWKSwgVI2of2dAq5DefIf4YylXK4GmMPamYDdIgg7MTGrqwm
         iSgV74GVGdvVAxjQpfhS6KKC1p7pUNtR72h99QhRKDpg9z/O/RmqGEt6awSWcydRcOdq
         zTmRpFITk3GcEGWq3G3lo/QVX/f4PR9XrwhxBUoiS+baJv0AYvMTQkCmeLNBEE2/wvfb
         cZf7aeHN7qoHcQm4/ZMrTfKq8Mra6c6aUVR+qZRF8oyFz/NTFzqEpgXiWli3q4Ktp7Dm
         +u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342874; x=1689934874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8treZK1wQrbkGKbJPdJghlW46yrsb5CCDx0rBn6I4Nc=;
        b=AmKf/BcYrF38/P4QaIhtJEBp3vXmSqQvd9YwReqqArqTJwUI/lNbkv8EhdG+wPrhXn
         kBxY+QtRCbQjDQ1xgCDdT7eFsKDJAVNb+RE5ht2Xa8Ok9yty0JOYhfWojCcxaGQ4UFR7
         UllznbrhLCNBYe0g9TPCNqrCU3m2kk7aH9+rSKSkgkwbkzKFAylKz5aOYa9v11Xy9O2o
         d6Gi9FKVEQ592xtxgVc1BI/pFfwo0gEjXpt6Gp/9WmSB14asBDAavB0qTKVvGMJ1hdzu
         Hk/QYhHsuTXCxr3TE5cSTYZgTkSxbK2E1MZK1Owrp2gCiiaPMFM0mRhGw0/XCoYpHb8i
         ie/g==
X-Gm-Message-State: AC+VfDwpshYVeBECYpbUj3JfmMKSPu/ixE6j6TBvVzo9ai3J5C8wS+Od
        O9rDL+0pY7u9xrANnGX1ypWu2pbgu1xSCBezZEULsaPs
X-Google-Smtp-Source: ACHHUZ70vlnIDrExje4Njuj51Pvicz/s+I1v1Boq5otZM51eHMDPdgQzlIPmTB3q9f9ZIhbV5rU/CA==
X-Received: by 2002:a25:688b:0:b0:bec:9efe:100d with SMTP id d133-20020a25688b000000b00bec9efe100dmr9326000ybc.54.1687342874684;
        Wed, 21 Jun 2023 03:21:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z3-20020a5b0203000000b00bca782fcd6esm832306ybl.55.2023.06.21.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:21:14 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:21:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7701: make annotated tag unreachable
Message-ID: <48d3c2c1871c8122d22fbce7c256ca65582fcd67.1687342818.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4dc16e2cb0 (gc: introduce `gc.recentObjectsHook`, 2023-06-07), we
added tests to ensure that prune-able (i.e. unreachable and with mtime
older than the cutoff) objects which are marked as recent via the new
`gc.recentObjectsHook` configuration are unpacked as loose with
`--unpack-unreachable`.

In that test, we also ensure that objects which are reachable from other
unreachable objects which were *not* pruned are kept as well, regardless
of their mtimes. For this, we use an annotated tag pointing at a blob
($obj2) which would otherwise be pruned.

But after pruning, that object is kept around for two reasons. One, the
tag object's mtime wasn't adjusted to be beyond the 1-hour cutoff, so it
would be kept as due to its recency regardless. The other reason is
because the tag itself is reachable.

Use mktag to write the tag object directly without pointing a reference
at it, and adjust the mtime of the tag object to be older than the
cutoff to ensure that our `gc.recentObjectsHook` configuration is
working as intended.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Peff pointed this out to me after the gc.recentObjectsHook stuff was in
'next', but this should go on top. This patch is based off of the tip of
"tb/gc-recent-object-hook".

 t/t7701-repack-unpack-unreachable.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index ba428c18a8..ceb4e805d2 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -126,8 +126,19 @@ test_expect_success 'gc.recentObjectsHook' '
 	git cat-file -p $obj2 &&
 	git cat-file -p $obj3 &&

+	# make an unreachable annotated tag object to ensure we rescue objects
+	# which are reachable from non-pruned unreachable objects
 	git tag -a -m tag obj2-tag $obj2 &&
-	obj2_tag="$(git rev-parse obj2-tag)" &&
+	obj2_tag="$(git mktag <<-EOF
+	object $obj2
+	type blob
+	tag obj2-tag
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+	EOF
+	)" &&
+
+	obj2_tag_pack="$(echo $obj2_tag | git pack-objects .git/objects/pack/pack)" &&
+	git prune-packed &&

 	write_script precious-objects <<-EOF &&
 	echo $obj2_tag
@@ -136,6 +147,7 @@ test_expect_success 'gc.recentObjectsHook' '

 	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
 	test-tool chmtime =-86400 .git/objects/pack/pack-$pack3.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$obj2_tag_pack.pack &&
 	git repack -A -d --unpack-unreachable=1.hour.ago &&

 	git cat-file -p $obj1 &&
--
2.40.1.478.g4dc16e2cb0
