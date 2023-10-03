Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C441E784A4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 00:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjJCAoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 20:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCAod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 20:44:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492AAD
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 17:44:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65af75a0209so2200426d6.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696293868; x=1696898668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf5gwYAdkOmq0sXofq4M9wKkCPW524vfIFetgd3RC2g=;
        b=r/jvVzb/KK+fQfxAMyTotCWcATqxXhi/Z/UiAkNeVh5fbeBJHXlqyuCHCcDRcS9DOD
         xaMl69vh1c0b8PHNtMOrn7s8sYt6PD9P56AHj/Fd/V9YlozIetAJOY1f6zS6jwEkPfNF
         R1PfhFMn8G4gJA1q/80M/vDEW+fogigc2uor+BIlTUap6X5M8nANKA8HFigbeQSbuHXs
         fg4Rw3rNpePd7M/USsk+YDjwJZW1kXS31Uqzw5sMHgwEC1yNCa2djuAD1X33FFyLhwyU
         BoFk7GNaBKCSnavf32D7R6jcHUTaGaaI5l2Fvj1yrReiVSY2S6EIIXvQRC3vZheYEwl+
         i8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293868; x=1696898668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf5gwYAdkOmq0sXofq4M9wKkCPW524vfIFetgd3RC2g=;
        b=pngPOU2u66sFUPJdwjJJWTQbznUxMjfLbxXDqhH/4eIf+cD45GUpxvhTF5j1K3TOcQ
         rnfvugGMA/PXLERDlo14qpOB3WIgxtV2kBgCUR3Rc/ZWhExJtu1QCbcbdZ1bNBw0cVQ+
         TP/1+sU6lDUaWbD1aTz1nFQs3j+gfUiAyIyP3RV22kHg90xgA8jCdEgydviWPe6JTS0z
         aRpfKJ8IkSJ9CGXw3aUcw2ktRLliYrr1JJtSzEf2NVceRkJ1/QLOGi344jGs40+iXfmb
         JaZr4sUX2y9OOHRml/fmLpwKC4Ge+NPp2OdAwKoVMTxOYAfUN3VFRYXm4SpbBT/51ezi
         VkYA==
X-Gm-Message-State: AOJu0YwIoP1YlVZ70lfF1aNJjQ2gNV6zpBa7JsGsiDumJ1mhacWZrklv
        mM5FszqqpbAfTinbGfn4by5Q/7mONtEOuDcLBEvQDw==
X-Google-Smtp-Source: AGHT+IGhOkbtQNCFiuw2yQcsWARmM0N1XSBv85W+63hjFj+sl803xS9PfQD/MPBtU3kib7mTwRXcUg==
X-Received: by 2002:ad4:5de1:0:b0:658:41ee:faf2 with SMTP id jn1-20020ad45de1000000b0065841eefaf2mr16786682qvb.23.1696293868008;
        Mon, 02 Oct 2023 17:44:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e20-20020a0ce3d4000000b0065654f67a6fsm31105qvl.77.2023.10.02.17.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:44:27 -0700 (PDT)
Date:   Mon, 2 Oct 2023 20:44:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] t7700: split cruft-related tests to t7704
Message-ID: <3ed4ab61f6aa260fe96f624f62d0d917c0a30761.1696293862.git.me@ttaylorr.com>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696293862.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small handful of the tests in t7700 (the main script for testing
functionality of 'git repack') are specifically related to cruft pack
operations.

Prepare for adding new cruft pack-related tests by moving the existing
set into a new test script.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7700-repack.sh       | 121 -------------------------------------
 t/t7704-repack-cruft.sh | 130 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 121 deletions(-)
 create mode 100755 t/t7704-repack-cruft.sh

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 27b66807cd..55ee3eb8ae 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -633,125 +633,4 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
-test_expect_success '--expire-to stores pruned objects (now)' '
-	git init expire-to-now &&
-	(
-		cd expire-to-now &&
-
-		git branch -M main &&
-
-		test_commit base &&
-
-		git checkout -b cruft &&
-		test_commit --no-tag cruft &&
-
-		git rev-list --objects --no-object-names main..cruft >moved.raw &&
-		sort moved.raw >moved.want &&
-
-		git rev-list --all --objects --no-object-names >expect.raw &&
-		sort expect.raw >expect &&
-
-		git checkout main &&
-		git branch -D cruft &&
-		git reflog expire --all --expire=all &&
-
-		git init --bare expired.git &&
-		git repack -d \
-			--cruft --cruft-expiration="now" \
-			--expire-to="expired.git/objects/pack/pack" &&
-
-		expired="$(ls expired.git/objects/pack/pack-*.idx)" &&
-		test_path_is_file "${expired%.idx}.mtimes" &&
-
-		# Since the `--cruft-expiration` is "now", the effective
-		# behavior is to move _all_ unreachable objects out to
-		# the location in `--expire-to`.
-		git show-index <$expired >expired.raw &&
-		cut -d" " -f2 expired.raw | sort >expired.objects &&
-		git rev-list --all --objects --no-object-names \
-			>remaining.objects &&
-
-		# ...in other words, the combined contents of this
-		# repository and expired.git should be the same as the
-		# set of objects we started with.
-		cat expired.objects remaining.objects | sort >actual &&
-		test_cmp expect actual &&
-
-		# The "moved" objects (i.e., those in expired.git)
-		# should be the same as the cruft objects which were
-		# expired in the previous step.
-		test_cmp moved.want expired.objects
-	)
-'
-
-test_expect_success '--expire-to stores pruned objects (5.minutes.ago)' '
-	git init expire-to-5.minutes.ago &&
-	(
-		cd expire-to-5.minutes.ago &&
-
-		git branch -M main &&
-
-		test_commit base &&
-
-		# Create two classes of unreachable objects, one which
-		# is older than 5 minutes (stale), and another which is
-		# newer (recent).
-		for kind in stale recent
-		do
-			git checkout -b $kind main &&
-			test_commit --no-tag $kind || return 1
-		done &&
-
-		git rev-list --objects --no-object-names main..stale >in &&
-		stale="$(git pack-objects $objdir/pack/pack <in)" &&
-		mtime="$(test-tool chmtime --get =-600 $objdir/pack/pack-$stale.pack)" &&
-
-		# expect holds the set of objects we expect to find in
-		# this repository after repacking
-		git rev-list --objects --no-object-names recent >expect.raw &&
-		sort expect.raw >expect &&
-
-		# moved.want holds the set of objects we expect to find
-		# in expired.git
-		git rev-list --objects --no-object-names main..stale >out &&
-		sort out >moved.want &&
-
-		git checkout main &&
-		git branch -D stale recent &&
-		git reflog expire --all --expire=all &&
-		git prune-packed &&
-
-		git init --bare expired.git &&
-		git repack -d \
-			--cruft --cruft-expiration=5.minutes.ago \
-			--expire-to="expired.git/objects/pack/pack" &&
-
-		# Some of the remaining objects in this repository are
-		# unreachable, so use `cat-file --batch-all-objects`
-		# instead of `rev-list` to get their names
-		git cat-file --batch-all-objects --batch-check="%(objectname)" \
-			>remaining.objects &&
-		sort remaining.objects >actual &&
-		test_cmp expect actual &&
-
-		(
-			cd expired.git &&
-
-			expired="$(ls objects/pack/pack-*.mtimes)" &&
-			test-tool pack-mtimes $(basename $expired) >out &&
-			cut -d" " -f1 out | sort >../moved.got &&
-
-			# Ensure that there are as many objects with the
-			# expected mtime as were moved to expired.git.
-			#
-			# In other words, ensure that the recorded
-			# mtimes of any moved objects was written
-			# correctly.
-			grep " $mtime$" out >matching &&
-			test_line_count = $(wc -l <../moved.want) matching
-		) &&
-		test_cmp moved.want moved.got
-	)
-'
-
 test_done
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
new file mode 100755
index 0000000000..d91fcf1af1
--- /dev/null
+++ b/t/t7704-repack-cruft.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='git repack works correctly'
+
+. ./test-lib.sh
+
+objdir=.git/objects
+
+test_expect_success '--expire-to stores pruned objects (now)' '
+	git init expire-to-now &&
+	(
+		cd expire-to-now &&
+
+		git branch -M main &&
+
+		test_commit base &&
+
+		git checkout -b cruft &&
+		test_commit --no-tag cruft &&
+
+		git rev-list --objects --no-object-names main..cruft >moved.raw &&
+		sort moved.raw >moved.want &&
+
+		git rev-list --all --objects --no-object-names >expect.raw &&
+		sort expect.raw >expect &&
+
+		git checkout main &&
+		git branch -D cruft &&
+		git reflog expire --all --expire=all &&
+
+		git init --bare expired.git &&
+		git repack -d \
+			--cruft --cruft-expiration="now" \
+			--expire-to="expired.git/objects/pack/pack" &&
+
+		expired="$(ls expired.git/objects/pack/pack-*.idx)" &&
+		test_path_is_file "${expired%.idx}.mtimes" &&
+
+		# Since the `--cruft-expiration` is "now", the effective
+		# behavior is to move _all_ unreachable objects out to
+		# the location in `--expire-to`.
+		git show-index <$expired >expired.raw &&
+		cut -d" " -f2 expired.raw | sort >expired.objects &&
+		git rev-list --all --objects --no-object-names \
+			>remaining.objects &&
+
+		# ...in other words, the combined contents of this
+		# repository and expired.git should be the same as the
+		# set of objects we started with.
+		cat expired.objects remaining.objects | sort >actual &&
+		test_cmp expect actual &&
+
+		# The "moved" objects (i.e., those in expired.git)
+		# should be the same as the cruft objects which were
+		# expired in the previous step.
+		test_cmp moved.want expired.objects
+	)
+'
+
+test_expect_success '--expire-to stores pruned objects (5.minutes.ago)' '
+	git init expire-to-5.minutes.ago &&
+	(
+		cd expire-to-5.minutes.ago &&
+
+		git branch -M main &&
+
+		test_commit base &&
+
+		# Create two classes of unreachable objects, one which
+		# is older than 5 minutes (stale), and another which is
+		# newer (recent).
+		for kind in stale recent
+		do
+			git checkout -b $kind main &&
+			test_commit --no-tag $kind || return 1
+		done &&
+
+		git rev-list --objects --no-object-names main..stale >in &&
+		stale="$(git pack-objects $objdir/pack/pack <in)" &&
+		mtime="$(test-tool chmtime --get =-600 $objdir/pack/pack-$stale.pack)" &&
+
+		# expect holds the set of objects we expect to find in
+		# this repository after repacking
+		git rev-list --objects --no-object-names recent >expect.raw &&
+		sort expect.raw >expect &&
+
+		# moved.want holds the set of objects we expect to find
+		# in expired.git
+		git rev-list --objects --no-object-names main..stale >out &&
+		sort out >moved.want &&
+
+		git checkout main &&
+		git branch -D stale recent &&
+		git reflog expire --all --expire=all &&
+		git prune-packed &&
+
+		git init --bare expired.git &&
+		git repack -d \
+			--cruft --cruft-expiration=5.minutes.ago \
+			--expire-to="expired.git/objects/pack/pack" &&
+
+		# Some of the remaining objects in this repository are
+		# unreachable, so use `cat-file --batch-all-objects`
+		# instead of `rev-list` to get their names
+		git cat-file --batch-all-objects --batch-check="%(objectname)" \
+			>remaining.objects &&
+		sort remaining.objects >actual &&
+		test_cmp expect actual &&
+
+		(
+			cd expired.git &&
+
+			expired="$(ls objects/pack/pack-*.mtimes)" &&
+			test-tool pack-mtimes $(basename $expired) >out &&
+			cut -d" " -f1 out | sort >../moved.got &&
+
+			# Ensure that there are as many objects with the
+			# expected mtime as were moved to expired.git.
+			#
+			# In other words, ensure that the recorded
+			# mtimes of any moved objects was written
+			# correctly.
+			grep " $mtime$" out >matching &&
+			test_line_count = $(wc -l <../moved.want) matching
+		) &&
+		test_cmp moved.want moved.got
+	)
+'
+
+test_done
-- 
2.42.0.310.g9604b54f73.dirty

