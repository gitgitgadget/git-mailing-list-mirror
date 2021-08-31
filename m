Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B531C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590F96103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbhHaUxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbhHaUxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693AC0613A3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m11so785975ioo.6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vb7bbxKGSFE1XPjJzo+wKcFArRDl5UEw8MU9KNu1hqo=;
        b=h8YyDSfxulxrzgdvqPTxtZxEfn3hQzLQYYC4T7LTbGgs7QC4/qKQ9AjGRRNw5ynWA/
         qOhCPqJCVk8tmX7m5NTOrqeAVxvc6O3hYk7lrm+V+Bx3tYvSjXV3RPu5zpfkiLd6S1u1
         9GDPmfWJAqYjie4rnCEgAFDvGoCW6hi2W4dqjVGplkWhqrSD50dvZyrvgukWJ9W8nIsv
         WB7g2RLW3UG5qYboCQgZBNeXGoN3dJeShkF7Zox0Q5S76B4rq87QC8VUiJPrU98r23SG
         BPdX0D1PHNeocginyljRIPeUMEa963iBVXuadNLzv2ZGKC7tSS7VP/Nzf7l1bBDqpH6Z
         4QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vb7bbxKGSFE1XPjJzo+wKcFArRDl5UEw8MU9KNu1hqo=;
        b=Is4HF0gkNiwG4mQ258/mEnl5QOnHbFW0UFfqQiAQIt1BW5dCD957vfLzfv5f+hEKqs
         SnFLyZs5igymZTa14lRBTZ8e7thzH4lT81Vg/Op4ei/3bqjxdop8rwqKESUgHBNdBjKP
         QO40qJNkRybpayLD9U7bSvUim9vW+gq5b1xT0mfvj1CZH2qutXFeGSzqyOu2xkz152X7
         Ov/N2aH/TXMHmTbRnWL1pkieTQISAzQh9jpYNFN3DyWwdAfGfcdOS4PLcGe+1L3MtacR
         ZRn1W3eG9BcHLttSQU2B1vK/0Mmko1WNDDQlOxaP5QHO/enxVFVWtNfhGmORQpa7dG6D
         Vi7A==
X-Gm-Message-State: AOAM532jrh1Nnm257wsRuSh2igq7ZFy6mOtNVXWi/hqQxYBze8JBXH+v
        t5PCh8kMgPICbCNKT+TJl9SCWJdp3QjEC6J6
X-Google-Smtp-Source: ABdhPJyzOMQ8sDj+YRJ7tUMVBSIpfZClycISXrqNwMnI0Ufnpu6e9hASaT1ZAYbZivu3uc2ODmgCiA==
X-Received: by 2002:a05:6638:408b:: with SMTP id m11mr4742169jam.136.1630443122977;
        Tue, 31 Aug 2021 13:52:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm10938655ios.0.2021.08.31.13.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:02 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 08/27] midx: reject empty `--preferred-pack`'s
Message-ID: <db2a24a8ae072aa520812a8b1dcac2a8fee209a1.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
index 0bcb403bae..26089ec9c7 100644
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
index e953cdd6d1..d7e4988f2b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -305,6 +305,23 @@ test_expect_success 'midx picks objects from preferred pack' '
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
2.33.0.96.g73915697e6

