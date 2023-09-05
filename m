Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539C1CA1008
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbjIEUgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjIEUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:51 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C94CE
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:45 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57361de8878so1903992eaf.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946204; x=1694551004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDlao44r7BPaMovJ24otVVwLkpGqsqayNnvJXl85O/s=;
        b=yykd89nHImCG3piD1Ai6oV1mBdW5RuvAbzjEoo9dYXBgnEjmtk4lkPj5X3eVHZD1Jx
         HwMEoavoM9fezChs24QCdcqq8pjAGnQkF/4gpKPBkkznt7bSzOAbkRPUcvCYOwCRSPdv
         ukuDZiD+S2cjwnh0WuagakXT8kDcHThPaa+XvIBG73nZaOT+jOWg07LQwSSrVyBlyRYN
         z89hauwAQsgBVTEqyI+2dSecHsSdAAgtg9coZ8AlJVpvJdOgDpsYc9KSxUypsbXO/J5S
         WNi9jvJZnsNfI9FSVFydwsAdEc2uqcwXRsamgRrpnFCo7k6M++453B5mGQBPnQnkC1Gm
         Jf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946204; x=1694551004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDlao44r7BPaMovJ24otVVwLkpGqsqayNnvJXl85O/s=;
        b=Xa7RFVBYkA+Xh7CQwZyLHVN30L8Lnh27xRWiunLplBdAOAj5/3sf4UEez+fGax2quX
         8vZFpN7bol6DYZ+Us2rmLOEtgwzgvOFkPnbjBMzl4IxRRlqikLyEXTMNvBxWezGjioIr
         xUvFWWvv0X0elg2tVNYc9LlsizzdTLkjHwy/YXDRGliBVG3sbMGGQulJGV9n8EkgltnT
         zjQdZY859Q4biLjVA+GnICHi1UWMN7mRjkRjjSG7b5e/4qbCx2aGqfst7OoQLE+MKZAp
         +8HnP5zlD0WuRtxsJHgkJBpuP6T1hsWBVWDT8U6ohxdbQkVwEe0PMMa7SKr7IQ4CtJ5O
         NmmA==
X-Gm-Message-State: AOJu0YwgYkXTxTwAwR7NbMqd2NKyN+rAcNrhZqKWTygjDaQhCVSWQ/gK
        B2RMFnm85xtxFAJSxVJddKq/dKpP/ljBl9pfpigf9w==
X-Google-Smtp-Source: AGHT+IGFmKeQM38En3FjNI8swUZSJCwxDilmQ3W/a3UMbuVw5ElR9YyuphMjSj4VUa2bNlHDDTaQuw==
X-Received: by 2002:a05:6358:9499:b0:139:688e:c73e with SMTP id i25-20020a056358949900b00139688ec73emr739863rwb.32.1693946204314;
        Tue, 05 Sep 2023 13:36:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r11-20020a25b98b000000b00d7745e2bb19sm2828559ybg.29.2023.09.05.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:44 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/8] builtin/repack.c: extract marking packs for deletion
Message-ID: <313537ef68892b15e772eaad8937a4a8c7ebbe61.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
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
index c3ab89912e..708556836e 100644
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
@@ -1141,24 +1171,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.42.0.119.gca7d13e7bf

