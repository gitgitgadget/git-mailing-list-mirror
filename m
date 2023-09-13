Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D8DEE020B
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjIMTRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMTRw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:52 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC15170F
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-592976e5b6dso1841407b3.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632667; x=1695237467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q8EDzEHrVv485b+ivCzs2soqfK0oEq7Q7hDwtxBeGo=;
        b=df7U2+mIh8NTZqzGiI/yJS9RDqzTirnSJAVNei6Oj0qAr3I1hIwyRx2HHp1OXCZJO2
         hYiEXK4eJSDyq/hVsxsH9uUnRftcI78TbSEXQnUP8WfFZVv+mC/4O4bf/lBwhoH9d+Oy
         56h6ZBl6lYCLfrj37SKs5uCZNBTabstAItq48QIOW0lYIpkzrJOlBuPfwTyGno3Kwr4T
         zLXXpxMwbOW7+x0v60+z+/y/9VPqY7TL6qugNtUy1M+zKeTJlskNtjaMhY4+u+9YymoG
         bAjEFXRlpsCwqWO3iczl32rIgh0eKu7ZzTIxa8KOCDcmOxnv1oBeMz92VMg8relPPlnp
         fiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632667; x=1695237467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q8EDzEHrVv485b+ivCzs2soqfK0oEq7Q7hDwtxBeGo=;
        b=inlaXLAMQwtsm0ln0uI8Sau/MewYvnd2rljL6EjTj8X0lL9wsrXpoxHRxs1EKtRQHB
         6VV7aizS18gIPkxo3LXw6jc902rkEmdr0I5d7kiIpGYTw3OXiNNERMnxBjxj9BcawN5a
         I+qD1k/bLqkvcKeTiS7DnK/Rp4V29UH0+hezmi8LtnN9HZaS7lSC8J4oSPMWKypneRnU
         Pkpkiqzc6hYGjCka3lSMFCmMxX/mkESUoh3pyGzARWpGs4d95uBFpOdXQGtpu3xV3a8w
         w2tq3xZ2kpbshAGWWO0TobX4OZeQn/O66p07Gp/qZtzPY1bspPpY4kutl4/IH3A8uJSo
         D4Cg==
X-Gm-Message-State: AOJu0YwZKr2ZH4x0M6FofKX4VC/o2GZ0ncqsP4BTNPMyKNfcjXG22Ban
        LU6EDSXHGVfWRlvlAmI04GY3Mxjq7f50+ORizLVGqQ==
X-Google-Smtp-Source: AGHT+IHgVcZMifWSurEDDobaULahvwPBYefgoj1Xlck4KzENP10mRIMofyLDug6TOiqI5wbFbBZ4TQ==
X-Received: by 2002:a0d:ef86:0:b0:59b:2458:f608 with SMTP id y128-20020a0def86000000b0059b2458f608mr3713386ywe.30.1694632667303;
        Wed, 13 Sep 2023 12:17:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x83-20020a0dd556000000b0058c4e33b2d6sm3295731ywd.90.2023.09.13.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:47 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/8] builtin/repack.c: extract marking packs for deletion
Message-ID: <62d916169d33a7569d83b72dfb1cb90d56568f01.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the end of a repack (when given `-d`), Git attempts to remove any
packs which have been made "redundant" as a result of the repacking
operation. For example, an all-into-one (`-A` or `-a`) repack makes
every pre-existing pack which is not marked as kept redundant. Geometric
repacks (with `--geometric=<n>`) make any packs which were rolled up
redundant, and so on.

But before deleting the set of packs we think are redundant, we first
check to see whether or not we just wrote a pack which is identical to
any one of the packs we were going to delete. When this is the case, Git
must avoid deleting that pack, since it matches a pack we just wrote
(so deleting it may cause the repository to become corrupt).

Right now we only process the list of non-kept packs in a single pass.
But a future change will split the existing non-kept packs further into
two lists: one for cruft packs, and another for non-cruft packs.

Factor out this routine to prepare for calling it twice on two separate
lists in a future patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 50 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 67bf86567f..0eee430951 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -105,6 +105,36 @@ struct existing_packs {
 	.non_kept_packs = STRING_LIST_INIT_DUP, \
 }
 
+static void mark_packs_for_deletion_1(struct string_list *names,
+				      struct string_list *list)
+{
+	struct string_list_item *item;
+	const int hexsz = the_hash_algo->hexsz;
+
+	for_each_string_list_item(item, list) {
+		char *sha1;
+		size_t len = strlen(item->string);
+		if (len < hexsz)
+			continue;
+		sha1 = item->string + len - hexsz;
+		/*
+		 * Mark this pack for deletion, which ensures that this
+		 * pack won't be included in a MIDX (if `--write-midx`
+		 * was given) and that we will actually delete this pack
+		 * (if `-d` was given).
+		 */
+		if (!string_list_has_string(names, sha1))
+			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
+	}
+}
+
+static void mark_packs_for_deletion(struct existing_packs *existing,
+				    struct string_list *names)
+
+{
+	mark_packs_for_deletion_1(names, &existing->non_kept_packs);
+}
+
 static void existing_packs_release(struct existing_packs *existing)
 {
 	string_list_clear(&existing->kept_packs, 0);
@@ -1142,24 +1172,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 	/* End of pack replacement. */
 
-	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
-		const int hexsz = the_hash_algo->hexsz;
-		for_each_string_list_item(item, &existing.non_kept_packs) {
-			char *sha1;
-			size_t len = strlen(item->string);
-			if (len < hexsz)
-				continue;
-			sha1 = item->string + len - hexsz;
-			/*
-			 * Mark this pack for deletion, which ensures that this
-			 * pack won't be included in a MIDX (if `--write-midx`
-			 * was given) and that we will actually delete this pack
-			 * (if `-d` was given).
-			 */
-			if (!string_list_has_string(&names, sha1))
-				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
-		}
-	}
+	if (delete_redundant && pack_everything & ALL_INTO_ONE)
+		mark_packs_for_deletion(&existing, &names);
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_NODUP;
-- 
2.42.0.166.g68748eb9c8

