Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D1FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC89206EB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HLwsovbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEDXMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:12:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2DEC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:12:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so24626plr.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GuFIyRhAir/AJbB2BjMvSmInv3V9LGmoyOzk7hnIUVo=;
        b=HLwsovbSnHsVsCwTBqtHu7Knu6Riq2/GEkMz1V4wQlTrUjcIQn5HGFnISzsU5pWQb3
         x8ljnQ+BLbTCq4fMBcGCF8xcEjHDhZczfUDhMl0CnWG8MCc5o3f+yposLRhQWUbgelwI
         9EtOSsoWgQXuz5PtA+3728cNc3sYtZFh4/3W/aEGQlRG0qrJJyE5d30ggeCkw94F8Hej
         sCPluBHDZ3rytpQmy9XMUu+IrYVfRxs00JiUW46UACA56ReJTPYF1ESLj0aPx14dyfnS
         e1chYDFg3TmSXZBASOYU3/2RIXzUV1ZQIgyUqNR8Njgtl1xKTO/1g5WoMse5cniOiHhB
         rUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GuFIyRhAir/AJbB2BjMvSmInv3V9LGmoyOzk7hnIUVo=;
        b=E8BnoCgo+YvCkXgLh/u87fXJID42fLKfOzFwHLbm5L6KSvizUlPFoUh4aclFp3gjob
         UNdzFXZXfSvhG2GvGp5atXmay6wFQfBSaqLXDrDrwonzhLigGE4HerzK2hdKqjswM+HW
         ok/TK2xbDV0uAQkTrDX/6COJ3Fmv+BkqhPW6VcyqOUt5D4Oy1buC20SbH0G1TIJQVsxS
         UbsPQYpLnZn/m5QV2PDoGnHHJaVz9GXs8Xycypk/7Ym+iJrn5kJX5CyqmpHjavYGhrXA
         xzJKFkFzKTjJ9F22g3DQaMO2ye7+P6ldAEVBB1grKoHrybcNLfKTNxyOXzH2iBpqDMq7
         Tmcg==
X-Gm-Message-State: AGi0PubG/XdwUvz09zV+XbemED3lIjgRN6Xxwlf6zImQesrqz26FSOI3
        Xs3UzP/1GvSW9KN87HPMw0709n65lNcC9g==
X-Google-Smtp-Source: APiQypKbWHzfE54GIiA0vzCmm3CRPPvRNAoHaxLq4wR229nlIkSTsHWaCgzMI3q7koluOBoh2wWq7w==
X-Received: by 2002:a17:90a:d98e:: with SMTP id d14mr181168pjv.178.1588633960311;
        Mon, 04 May 2020 16:12:40 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j7sm139835pfi.160.2020.05.04.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:39 -0700 (PDT)
Date:   Mon, 4 May 2020 17:12:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 4/4] pack-bitmap: pass object filter to fill-in traversal
Message-ID: <f1eb194b9fdf5e385610fa3c0ddee22b89cf4f0e.1588633810.git.me@ttaylorr.com>
References: <cover.1588633810.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588633810.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Sometimes a bitmap traversal still has to walk some commits manually,
because those commits aren't included in the bitmap packfile (e.g., due
to a push or commit since the last full repack). If we're given an
object filter, we don't pass it down to this traversal. It's not
necessary for correctness because the bitmap code has its own filters to
post-process the bitmap result (which it must, to filter out the objects
that _are_ mentioned in the bitmapped packfile).

And with blob filters, there was no performance reason to pass along
those filters, either. The fill-in traversal could omit them from the
result, but it wouldn't save us any time to do so, since we'd still have
to walk each tree entry to see if it's a blob or not.

But now that we support tree filters, there's opportunity for savings. A
tree:depth=0 filter means we can avoid accessing trees entirely, since
we know we won't them (or any of the subtrees or blobs they point to).
The new test in p5310 shows this off (the "partial bitmap" state is one
where HEAD~100 and its ancestors are all in a bitmapped pack, but
HEAD~100..HEAD are not). Here are the results (run against linux.git):

  Test                                                  HEAD^               HEAD
  -------------------------------------------------------------------------------------------------
  [...]
  5310.16: rev-list with tree filter (partial bitmap)   0.19(0.17+0.02)     0.03(0.02+0.01) -84.2%

The absolute number of savings isn't _huge_, but keep in mind that we
only omitted 100 first-parent links (in the version of linux.git here,
that's 894 actual commits). In a more pathological case, we might have a
much larger proportion of non-bitmapped commits. I didn't bother
creating such a case in the perf script because the setup is expensive,
and this is plenty to show the savings as a percentage.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                | 14 +++++++++-----
 t/perf/p5310-pack-bitmaps.sh |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 195ee8cad0..4077e731e8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -506,7 +506,8 @@ static int should_include(struct commit *commit, void *_data)
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
-				   struct bitmap *seen)
+				   struct bitmap *seen,
+				   struct list_objects_filter_options *filter)
 {
 	struct bitmap *base = NULL;
 	int needs_walk = 0;
@@ -599,8 +600,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list(revs, show_commit, show_object,
-				     &show_data);
+		traverse_commit_list_filtered(filter, revs,
+					      show_commit, show_object,
+					      &show_data, NULL);
 	}
 
 	return base;
@@ -999,7 +1001,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 
 	if (haves) {
 		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
+		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL,
+					    filter);
 		reset_revision_walk();
 		revs->ignore_missing_links = 0;
 
@@ -1007,7 +1010,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			BUG("failed to perform bitmap walk");
 	}
 
-	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
+	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
+				    filter);
 
 	if (!wants_bitmap)
 		BUG("failed to perform bitmap walk");
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 75ccf9f4e3..b3e725f031 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -91,4 +91,9 @@ test_perf 'pack to file (partial bitmap)' '
 	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
 '
 
+test_perf 'rev-list with tree filter (partial bitmap)' '
+	git rev-list --use-bitmap-index --count --objects --all \
+		--filter=tree:0 >/dev/null
+'
+
 test_done
-- 
2.26.0.113.ge9739cdccc
