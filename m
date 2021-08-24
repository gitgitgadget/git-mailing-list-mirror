Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FEC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EAB610A3
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhHXQQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhHXQQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:50 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69882C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id u7so21064276ilk.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2XzWdz7EESNopwj6BDpfpE36HwWK9E1PabZFQ1q7w1I=;
        b=YTmpn2Y4Jxd9yjy3dY/yc05aRc7xg/zQQUS8bgI9l2dBhZQ0u3t6tJJYnMRssXsicv
         W1irpJuAHu3B1Ue7IjlJC2zHlj8xvCltB2WCcfxVq5purNjs119AhCkNHYUK5hRHusGW
         2y+04tPCtqkJp9NyoFS74H0T5Csll80Skmn8jQVAMoHchuMmtgpElWon341t5NseK7Z5
         5d65QTpz53U7Ex+NhaX51zz32TMeLXE6Y+KC8RbDL/gTLGT/CRSaDAV2Rz49WlGV4tw/
         DxfqzPxu3wHZWqaUX/2Eq96rFIcM4Pet7TGVEdLM+22R82nmgK3YMN6Va319rSifzycV
         ddoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2XzWdz7EESNopwj6BDpfpE36HwWK9E1PabZFQ1q7w1I=;
        b=kME4stxkubt0bcSO8s6v5SoyQWXjwTWp8QxeeDYSpSvJ0ahYxm7GEZxxflq9TITut6
         wv8npxFAwaidq5N6cibgcWKR8Y419C2t3HmQh8ALLdigqPrh3VHCnTF/EuSj00sb33aT
         wGgMXrTMfPMRiT3RtHLjYCyeRJNrNx7hd8QsKTHDoLwqrW2n/8XhwU5oVutAUie95FWI
         MZmyXy7iYdkdgNsOM3SP0ovkYqVEwj+6L1PqWlNjQYD23T3ci8jZMjGUiID0vddMxuDK
         GUOuINoIzFjNqoGAfhUv+j5tTx9CCSufNLbDaZn7XN1PPeSZcN2bLWSkx/kcOLJHmvr4
         /RRg==
X-Gm-Message-State: AOAM531pYzJwKKRRddN4ywvg6EBIOhySerLEDs6gnIzseOhfeWobWZWp
        17phKtJDnLInkIbQ4WO0Vu3nh/bnfqQ0Yfhj
X-Google-Smtp-Source: ABdhPJwdOWQtA3Sxw68DYBgHR3AGtdtxImnFkOVl8MffiJ/dDrsBAAQHesjX0F+vWhPBuBRQAV7jmg==
X-Received: by 2002:a92:194c:: with SMTP id e12mr25776402ilm.199.1629821765704;
        Tue, 24 Aug 2021 09:16:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm10170701ilo.38.2021.08.24.09.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:05 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 06/25] midx: reject empty `--preferred-pack`'s
Message-ID: <dab5dbf228a5e6d698d28e643e99f6b5492d40b6.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The soon-to-be-implemented multi-pack bitmap treats object in the first
bit position specially by assuming that all objects in the pack it was
selected from are also represented from that pack in the MIDX. In other
words, the pack from which the first object was selected must also have
all of its other objects selected from that same pack in the MIDX in
case of any duplicates.

But this assumption relies on the fact that there is at least one object
in that pack to begin with; otherwise the object in the first bit
position isn't from a preferred pack, in which case we can no longer
assume that all objects in that pack were also selected from the same
pack.

Guard this assumption by checking the number of objects in the given
preferred pack, and failing if the given pack is empty.

To make sure we can safely perform this check, open any packs which are
contained in an existing MIDX via prepare_midx_pack(). The same is done
for new packs via the add_pack_to_midx() callback, but packs picked up
from a previous MIDX will not yet have these opened.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  6 +++---
 midx.c                                 | 29 ++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh            | 17 +++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ffd601bc17..c9b063d31e 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -37,9 +37,9 @@ write::
 --
 	--preferred-pack=<pack>::
 		Optionally specify the tie-breaking pack used when
-		multiple packs contain the same object. If not given,
-		ties are broken in favor of the pack with the lowest
-		mtime.
+		multiple packs contain the same object. `<pack>` must
+		contain at least one object. If not given, ties are
+		broken in favor of the pack with the lowest mtime.
 --
 
 verify::
diff --git a/midx.c b/midx.c
index 73b199ca49..551e5c2ee5 100644
--- a/midx.c
+++ b/midx.c
@@ -934,6 +934,25 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
 			ctx.info[ctx.nr].p = NULL;
 			ctx.info[ctx.nr].expired = 0;
+
+			if (flags & MIDX_WRITE_REV_INDEX) {
+				/*
+				 * If generating a reverse index, need to have
+				 * packed_git's loaded to compare their
+				 * mtimes and object count.
+				 */
+				if (prepare_midx_pack(the_repository, ctx.m, i)) {
+					error(_("could not load pack"));
+					result = 1;
+					goto cleanup;
+				}
+
+				if (open_pack_index(ctx.m->packs[i]))
+					die(_("could not open index for %s"),
+					    ctx.m->packs[i]->pack_name);
+				ctx.info[ctx.nr].p = ctx.m->packs[i];
+			}
+
 			ctx.nr++;
 		}
 	}
@@ -961,6 +980,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		}
 	}
 
+	if (ctx.preferred_pack_idx > -1) {
+		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
+		if (!preferred->num_objects) {
+			error(_("cannot select preferred pack %s with no objects"),
+			      preferred->pack_name);
+			result = 1;
+			goto cleanup;
+		}
+	}
+
 	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
 					 ctx.preferred_pack_idx);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c3..9b184bd45e 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -277,6 +277,23 @@ test_expect_success 'midx picks objects from preferred pack' '
 	)
 '
 
+test_expect_success 'preferred packs must be non-empty' '
+	test_when_finished rm -rf preferred.git &&
+	git init preferred.git &&
+	(
+		cd preferred.git &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
+
+		test_must_fail git multi-pack-index write \
+			--preferred-pack=pack-$empty.pack 2>err &&
+		grep "with no objects" err
+	)
+'
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
-- 
2.31.1.163.ga65ce7f831

