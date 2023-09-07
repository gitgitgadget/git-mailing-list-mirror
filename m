Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CCEC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjIGVwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjIGVwI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:52:08 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A51BC5
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:52:04 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-591ba8bd094so13498167b3.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694123523; x=1694728323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ACrfq6mMprtYQuODc+1y1yoHrxIiWzemU5t9znF9+w=;
        b=WWhJ5D6wtisJTnjh912TbHzUWAKIPLRkZMYzh3k6mrBnZC2suuxea15iB3MKW/xueK
         j8paLM1Usz9qC1g6esjR1B7jUU+3+XEOwWAH6G6EcYj32ZFO6XzIvgZi8EfRB5e/Xlq2
         koLSTG2OVzfbG5aHTpLWG+Zp+v95nZllnrwVxnkXxlV0FlZ0Qr5vRTnONEwvBYAzu1X9
         lmDfz1aKP7zbsN+01JjMB1c32b1l8yBJvzsiBNM/3ezvouxKyeKA2GmdCFbZ2lk+W/Wg
         iChrgw5DNa6toVtQi7brzLf8HJHOfGqPXni5BczpOiOLSN168JUGmhVsERH8InY+B4Yg
         ZazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694123523; x=1694728323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ACrfq6mMprtYQuODc+1y1yoHrxIiWzemU5t9znF9+w=;
        b=c0l1RVqYP350vni9cLCdXwwqrdvOTG0lIJ2zlXiSkRYLG/BAgpwByTDa7VT6XlCIQ9
         O+qs406hbo06kq//lI1mtjsjBObfXftZX4Z3GDle1LSxIkq75zOUkIeCNhz0oRdLfFFI
         lDranyBXmQVWoHst0Zd97KGTdCuh5wJLf9jewWN7QIEybMXk5cGpcnoN4xoyqa9CSZGn
         q3EwgFAYj9TrY0x6B9uOUbwhQYhMDfjo8Kf2tTDPuLKwQ1s3cHp6gf97HnQCq0rgn6xH
         Jxa1A8B0h+lqBEBObAj+0HldcIUs3Fcus/nHFT3pUtn8VDLsk5Hap0mrjqvIe9WqjiKu
         T8Rg==
X-Gm-Message-State: AOJu0Yx6IRUxipHTTzMk2Ff0bF5ahWATyXg0HdqNIkRxCAwy1DxwhFmk
        iaOX5j/JngX/0II/7B13zZfTlC0amG1Dz85rCrE50Q==
X-Google-Smtp-Source: AGHT+IEk6YgMLZM2sxgn3zHWMfVBTEUf1sxh+k+n5yPcUngwe3YYfGpUXqfjDNyvCvXMfIN5Q+pNrw==
X-Received: by 2002:a25:69ce:0:b0:d80:146a:52da with SMTP id e197-20020a2569ce000000b00d80146a52damr629238ybc.19.1694123523222;
        Thu, 07 Sep 2023 14:52:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o9-20020a254109000000b00d74c9618c6fsm86003yba.1.2023.09.07.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:52:02 -0700 (PDT)
Date:   Thu, 7 Sep 2023 17:52:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] t7700: split cruft-related tests to t7704
Message-ID: <de6c2a0d70c3e62bd70fdca8b5c6c2ae6eaa13f5.1694123506.git.me@ttaylorr.com>
References: <cover.1694123506.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694123506.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.42.0.138.g7e4e42e1aa

