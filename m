Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211BBC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDJWxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDJWxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E525210D
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54c0c86a436so245956337b3.6
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167213; x=1683759213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qguh8l2CvGX8dlC/4PABDvsvoriHxwl7xwHwVE/Erk=;
        b=Y00B+MgxYMBouIaypcc/4KWtEYr+xYGXjRfwrwELaNhUOhhqY5K/9F8JwlILXQzDOX
         n0gz34FLeR2+B1WNcM9UZuxZjvqObzUqJ6PaG1mGvIfd0pZnvyKw9U0OpETj+ECBouha
         Pfd/ZiikYNKyC1a7b50a/PMxtWl/jqht2omWKXAnu0cd7gtSOYELxZ2krU6Izs/rprH7
         utIDUnY89Xyj+cq5O6FMFBuktFg6rZkQu9gSoPbfKa1jfPTVytoBM8Z7pgcpZXeBqcfr
         Knnebh2OyY3XYHgvMyVomU6arhtPuk+3ZbxJT17hypduVWzEWJp4P5eH9zZktnzanliC
         ejlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167213; x=1683759213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qguh8l2CvGX8dlC/4PABDvsvoriHxwl7xwHwVE/Erk=;
        b=rTfS6WBbkiIgAmzC+WADNiGS0K3C53ZmFc5iMuMoah1dlL5X+Cju2DFHV1fOUmv8PU
         PVpVDGtkmfTTjmu+6xVipkDxMhXhLCYrOuaKAe6VLopJHDEPQPQ7EbPW2p4hrwGKq+Qm
         7AtqjUb9OkWCCbSjfaA0OEGJZZj0nhK0nL4a6AG3pbC0hxug+LkYiHEOD2SYDht8xJtG
         lkbS/Tu5cJkLRuLDl3BSR1KWukz1KzMIQGGdvDil7XBorSy9nVxyB+U91i8BjcgUjdPi
         oJAM2cizaycP5MKLNKbtHzb2tymc6G+S7hrYBTrWqX3g3j5YPbvWSE7O0oEyNGm/DQec
         aLLw==
X-Gm-Message-State: AAQBX9chALYGD5sQlo9hQ6BNZXlTU7Ho+5of0yyq+aRQv0szYnDsVpbn
        w6hoeLhk+T17mfZvFZZVrrWelxoAnS6u63yRUiWOxA==
X-Google-Smtp-Source: AKy350bA8SFBLSr/AN5whzOM1jqnra4lsFimYg2Gb+zAjGZqQ3N0MhAj8H/P5dxMUrn4sf3BiXWYHg==
X-Received: by 2002:a0d:ddcc:0:b0:54f:baa:2c with SMTP id g195-20020a0dddcc000000b0054f0baa002cmr810000ywe.0.1681167213098;
        Mon, 10 Apr 2023 15:53:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y207-20020a814bd8000000b00545a0818496sm3105739ywa.38.2023.04.10.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:32 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] pack-revindex: make `load_pack_revindex` take a
 repository
Message-ID: <be4faf11011efcfab479e5785e6c2bbac95309bd.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will introduce a `pack.readReverseIndex`
configuration, which forces Git to generate the reverse index from
scratch instead of loading it from disk.

In order to avoid reading this configuration value more than once, we'll
use the `repo_settings` struct to lazily load this value.

In order to access the `struct repo_settings`, add a repository argument
to `load_pack_revindex`, and update all callers to pass the correct
instance (in all cases, `the_repository`).

Signed-off-by: Taylor Blauy <me@ttaylorr.com>
---
 pack-bitmap.c   | 5 +++--
 pack-revindex.c | 4 ++--
 pack-revindex.h | 3 ++-
 packfile.c      | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b2e7d06d60..8e3bb00931 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -477,13 +477,14 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 		 * since we will need to make use of them in pack-objects.
 		 */
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
+			ret = load_pack_revindex(the_repository,
+						 bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
 		}
 		return 0;
 	}
-	return load_pack_revindex(bitmap_git->pack);
+	return load_pack_revindex(the_repository, bitmap_git->pack);
 }
 
 static int load_bitmap(struct bitmap_index *bitmap_git)
diff --git a/pack-revindex.c b/pack-revindex.c
index 03c7e81f9d..e3d69cc0f7 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -283,7 +283,7 @@ static int load_pack_revindex_from_disk(struct packed_git *p)
 	return ret;
 }
 
-int load_pack_revindex(struct packed_git *p)
+int load_pack_revindex(struct repository *r, struct packed_git *p)
 {
 	if (p->revindex || p->revindex_data)
 		return 0;
@@ -356,7 +356,7 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
 
-	if (load_pack_revindex(p) < 0)
+	if (load_pack_revindex(the_repository, p) < 0)
 		return -1;
 
 	lo = 0;
diff --git a/pack-revindex.h b/pack-revindex.h
index 4974e75eb4..3d1969ce8b 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -39,6 +39,7 @@
 
 struct packed_git;
 struct multi_pack_index;
+struct repository;
 
 /*
  * load_pack_revindex populates the revindex's internal data-structures for the
@@ -47,7 +48,7 @@ struct multi_pack_index;
  * If a '.rev' file is present it is mmap'd, and pointers are assigned into it
  * (instead of using the in-memory variant).
  */
-int load_pack_revindex(struct packed_git *p);
+int load_pack_revindex(struct repository *r, struct packed_git *p);
 
 /*
  * load_midx_revindex loads the '.rev' file corresponding to the given
diff --git a/packfile.c b/packfile.c
index b120405ccc..717fd685c9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2151,7 +2151,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(p))
+		if (load_pack_revindex(the_repository, p))
 			return -1;
 	}
 
-- 
2.40.0.323.g9c80379958

