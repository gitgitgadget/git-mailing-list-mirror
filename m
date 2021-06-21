Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937CC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DE560FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhFUW2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhFUW2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBEC061760
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:26:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k5so3126754ilv.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=LV8CVzdMsxFcEAyugEJ4iLA0Tc46JmKFj7d5uMFsuDBOB1Y5bCpabKvjRRoln8JT6M
         aEAz8DY0srglUflJ5szVWw/obDXoj5wRUPfd4ENuRFg4Ys6NA/e2rLAhGtZVNrDS0WeQ
         uuLpEratBabdg2SXrgtgtCueTuRXkJjvMLIXITeK7hGbxkzaT4riqf4yci5zL16UH7k1
         sf4a4XYLWwwiEFsCA6O3rRVNorJ3iQ4fD0niDMQ7Gbkvw1nUF0DLEipP44bcZvqr653j
         kzmv6TqHylZ0iHDBEuTHuxiTfj8QJen1tk4TC3fVrvLiU7mKIclGm6kyKHSrze0TCkFb
         W6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=KE91R4LZWXwVHIbgkun5mbVbkeSd2WF9oeO+vdiLOb2jCsonRAGaNC8groS+FtQK82
         zxlVH20Gq4kuvCEQg0EbT3Njzoor9H6BXu0R/q+fmfN9kQyz++mCCUXz8/v71ZLWtFM1
         X183ePvWS8O/nsgiUKly5BnX4to5diqt4jLUpopmTBtk/f0BXfLVnkaaW6fO6m3r9rz3
         RFtyQKsprdu9s3IuGocrF5HkBcJMFyJ7YZoGqKyrc1pIDPm0MdPWrcRlkJgdlovNV/uq
         k0T6xl97+tNSsx1KymQgporTxTXX2eMT2RGYAjkdtzO+OgT1lDrho/PcDcHJTDeDQH6+
         84KQ==
X-Gm-Message-State: AOAM531hlbqBBYG7Bsy0iBzBqvkhxr+oebjKbrCB53fmhq+DGE0clQ9T
        22vXgu9V80RVqpvQkA8PIO6ufOvngr6AGBGS
X-Google-Smtp-Source: ABdhPJxOOqdf75FUYkEEve7MMxxBu9yHAFb1NqWPCGQ8oJGgqrTfphJxK15RituwMVfw1DKchVd32w==
X-Received: by 2002:a05:6e02:1947:: with SMTP id x7mr356143ilu.300.1624314359945;
        Mon, 21 Jun 2021 15:25:59 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id 14sm6960640ilx.61.2021.06.21.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:59 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 23/24] p5310: extract full and partial bitmap tests
Message-ID: <98fa73a76a981ce328dc9ad1dc816d6a62bc0659.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new p5326 introduced by the next patch will want these same tests,
interjecting its own setup in between. Move them out so that both perf
tests can reuse them.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/lib-bitmap.sh         | 69 ++++++++++++++++++++++++++++++++++++
 t/perf/p5310-pack-bitmaps.sh | 65 ++-------------------------------
 2 files changed, 72 insertions(+), 62 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh

diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
new file mode 100644
index 0000000000..63d3bc7cec
--- /dev/null
+++ b/t/perf/lib-bitmap.sh
@@ -0,0 +1,69 @@
+# Helper functions for testing bitmap performance; see p5310.
+
+test_full_bitmap () {
+	test_perf 'simulated clone' '
+		git pack-objects --stdout --all </dev/null >/dev/null
+	'
+
+	test_perf 'simulated fetch' '
+		have=$(git rev-list HEAD~100 -1) &&
+		{
+			echo HEAD &&
+			echo ^$have
+		} | git pack-objects --revs --stdout >/dev/null
+	'
+
+	test_perf 'pack to file (bitmap)' '
+		git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
+	'
+
+	test_perf 'rev-list (commits)' '
+		git rev-list --all --use-bitmap-index >/dev/null
+	'
+
+	test_perf 'rev-list (objects)' '
+		git rev-list --all --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list with tag negated via --not --all (objects)' '
+		git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list with negative tag (objects)' '
+		git rev-list HEAD --not perf-tag --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list count with blob:none' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=blob:none >/dev/null
+	'
+
+	test_perf 'rev-list count with blob:limit=1k' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=blob:limit=1k >/dev/null
+	'
+
+	test_perf 'rev-list count with tree:0' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=tree:0 >/dev/null
+	'
+
+	test_perf 'simulated partial clone' '
+		git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
+	'
+}
+
+test_partial_bitmap () {
+	test_perf 'clone (partial bitmap)' '
+		git pack-objects --stdout --all </dev/null >/dev/null
+	'
+
+	test_perf 'pack to file (partial bitmap)' '
+		git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
+	'
+
+	test_perf 'rev-list with tree filter (partial bitmap)' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=tree:0 >/dev/null
+	'
+}
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 452be01056..7ad4f237bc 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -2,6 +2,7 @@
 
 test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
 test_perf_large_repo
 
@@ -25,56 +26,7 @@ test_perf 'repack to disk' '
 	git repack -ad
 '
 
-test_perf 'simulated clone' '
-	git pack-objects --stdout --all </dev/null >/dev/null
-'
-
-test_perf 'simulated fetch' '
-	have=$(git rev-list HEAD~100 -1) &&
-	{
-		echo HEAD &&
-		echo ^$have
-	} | git pack-objects --revs --stdout >/dev/null
-'
-
-test_perf 'pack to file (bitmap)' '
-	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
-'
-
-test_perf 'rev-list (commits)' '
-	git rev-list --all --use-bitmap-index >/dev/null
-'
-
-test_perf 'rev-list (objects)' '
-	git rev-list --all --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list with tag negated via --not --all (objects)' '
-	git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list with negative tag (objects)' '
-	git rev-list HEAD --not perf-tag --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list count with blob:none' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=blob:none >/dev/null
-'
-
-test_perf 'rev-list count with blob:limit=1k' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=blob:limit=1k >/dev/null
-'
-
-test_perf 'rev-list count with tree:0' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=tree:0 >/dev/null
-'
-
-test_perf 'simulated partial clone' '
-	git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
-'
+test_full_bitmap
 
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
@@ -97,17 +49,6 @@ test_expect_success 'create partial bitmap state' '
 	git update-ref HEAD $orig_tip
 '
 
-test_perf 'clone (partial bitmap)' '
-	git pack-objects --stdout --all </dev/null >/dev/null
-'
-
-test_perf 'pack to file (partial bitmap)' '
-	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
-'
-
-test_perf 'rev-list with tree filter (partial bitmap)' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=tree:0 >/dev/null
-'
+test_partial_bitmap
 
 test_done
-- 
2.31.1.163.ga65ce7f831

