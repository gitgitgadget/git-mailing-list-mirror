Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC99C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DB60F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhG0VVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhG0VVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC8EC0619F1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a14so678570ila.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d97yK6LAOgS36k1DO/Ui2IPcWwEVdCBbv5xjulAo7IE=;
        b=LBo1MGtrOPi5rIUA4Tvz1XHXmIIdvgrMuLtyQC9/4S63wcP8fLI9uI+gdaUuM/BCPE
         uWru+8tG8svD6nA8C3hfRyb6ZCljQTpr14SA8iV3mVFj8L6YPDPJW0BVgYDlIDbUmTxh
         2tlTtSs2CQT1UiCBQb2RzYjnWl/RwX8LVBkO3PcODA8mryun6rfST7oRccYt1D8selUa
         5DsY1GtsktmMTcXSK+bcVZSxfuWQbs8+bZ52YqjMVdkPSSLi70UQy1DCzgfCP37Fwm4v
         O6fSaHKJtiuMNtJEaqN2zLHldeTdk/hJoi3IzyaowyM003np5DUlWEhA+Pe0nK4rtpkY
         k09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d97yK6LAOgS36k1DO/Ui2IPcWwEVdCBbv5xjulAo7IE=;
        b=Vioc/wYoabczyq0jtEiQOZzb8JMedUuP6YfFY+CcuoVKr0kQchIXeYjSHgS6EIsmtN
         HhZynVSgnDPTIM2H7VJeJ3THZindUtvTASnGCqIJH0+Nx5JfyGoXB2XwDFZKMisCYYCS
         9FDdGqnHMBpVMQ3+ZQI1AnK3fjVlfElUgdId+Kem81MIgZBaCrHceU1Lcz9JzEFoQbLx
         7e3jLn0wdGeMJop2u3+deAcRRymivyJ5S3mssTnDinBhoSOyuY7iZSMIzZpyFvdgUWs1
         TVSxRWCMx7vfT+fkNeWZZ+E+5mlo1gcnJcvGbqWOXYP5SQSwXnHmeeTT/MVD/IiDOF2+
         QJQg==
X-Gm-Message-State: AOAM531iIQ6PFWad74rZZAYlsEoGHYWoKzohXIXwm9c7jLP+YDW3n0VI
        4NlqNN7hqhobTDTXRJ2L1jr0l4+KYcc02bFD
X-Google-Smtp-Source: ABdhPJzPAKatGBfOyJ0rhmtHb7MMJczI04bFiljhpPgUPfbSDFF7OGslzuXnzjW2MaOTqSKj2ze7vA==
X-Received: by 2002:a92:ce91:: with SMTP id r17mr15619207ilo.264.1627420779436;
        Tue, 27 Jul 2021 14:19:39 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id r12sm3305968iod.0.2021.07.27.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:39 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 06/25] midx: reject empty `--preferred-pack`'s
Message-ID: <c5513f2a75d065427395c7f7e3b261819184ffaa.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
index 3193426d24..092dbf45b6 100644
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
index 7609f1ea64..1f0a2ae852 100755
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

