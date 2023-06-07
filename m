Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A62C7EE25
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 23:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjFGXBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGXBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 19:01:06 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4FE4A
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 16:01:05 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565ba6aee5fso88489277b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178864; x=1688770864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dncsbOEL9/qN6ogPiYizkEaJ0nnBYuoh8W2FYjUh4q0=;
        b=bZlsOc0SENdowQIr0zDGdv/4LUr4MQ8awIl05z+ImxaCQ+x/fB0BmNdwJyQ8LuHBfo
         YCTyz3o7V5EANseCfGgN2e0n5CWLQSfEdl5xn7jTt4SZBvJGnc1nqZY7weJ7gx837yId
         X358A+NbIEd/dIuo4fi34hopbyQk4DSuHImhl7Vmx2R/gKbCNu2yJhGjHnZZo22vsj2m
         q7pvV+olhxqFMLX7izFg9iSeC68rQwvTR72V4nMLlFG0cDLoD037Ma/HZuh9J66VTWkf
         +v8LrsYoq2EwhlQI6Henc8GhFltk59awU43rYT1soiJuf1ORhmn1FCFrafy3qqF4I6NT
         9wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178864; x=1688770864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dncsbOEL9/qN6ogPiYizkEaJ0nnBYuoh8W2FYjUh4q0=;
        b=IXQ26uHALC/dxY0JmvrP2SUllOejXYJDFhIs5+sh3+alQyga5qlhR5Z02LX230tsnn
         0HAWo5sBg3473THtTlOk/s3vrvATNxolwyD1/m4BvfLh9R9baiXDTCpMU7n2dNkSbqhs
         gXaEIQH8GhSVU2Les79cvYwVSyIZB5qOjFXnxuQ88JQ7vLeb4Yog8gh76noe+eQ4hrav
         umY2hfGJak8vL5H/TDTBYX3CDLWfZadkLTP7W9cjrUYyngj3952Tmx7cM8NZjkUaSe+q
         n9AL/7UsY9wTbpNWzakgGkq7nh3+HQZ4IjpGyCcJzCtrnZJgeBOBSzWyrc/sPClaqtG4
         qY2w==
X-Gm-Message-State: AC+VfDxbpeKCjRTkNnNqDdueuxdm6Y1RrLdbcGlRpuSRW6ZHlKltwmDV
        nV0MKzvUDlVtnEmgpSSJn4dzkRNUpmo+tGsGvk2nA3y2
X-Google-Smtp-Source: ACHHUZ6Oqq2Dvoiajw8sbRsBEskyS0Dg/3xFmOiz5xdqlqZUznTq7MDRp/sEwgdSfGZbsDN4BZjl/g==
X-Received: by 2002:a0d:f5c7:0:b0:565:a78c:2abb with SMTP id e190-20020a0df5c7000000b00565a78c2abbmr7381029ywf.31.1686178863930;
        Wed, 07 Jun 2023 16:01:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v13-20020a81480d000000b0055a18d8479csm10370ywa.21.2023.06.07.16.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:01:03 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:01:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-bitmap.c: gracefully degrade on failure to load MIDX'd
 pack
Message-ID: <f123b68cb8a277fbf105b1789a84b9405a499b79.1686178854.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When opening a MIDX bitmap, we the pack-bitmap machinery eagerly calls
`prepare_midx_pack()` on each of the packs contained in the MIDX. This
is done in order to populate the array of `struct packed_git *`s held by
the MIDX, which we need later on in `load_reverse_index()`, since it
calls `load_pack_revindex()` on each of the MIDX'd packs, and requires
that the caller provide a pointer to a `struct packed_git`.

When opening one of these packs fails, the pack-bitmap code will `die()`
indicating that it can't open one of the packs in the MIDX. This
indicates that the MIDX is somehow broken with respect to the current
state of the repository. When this is the case, we indeed cannot make
use of the MIDX bitmap to speed up reachability traversals.

However, it does not mean that we can't perform reachability traversals
at all. In other failure modes, that same function calls `warning()` and
then returns -1, indicating to its caller (`open_bitmap()`) that we
should either look for a pack bitmap if one is available, or perform
normal object traversal without using bitmaps at all.

There is no reason why this case should cause us to die. If we instead
continued (by jumping to `cleanup` as this patch does) and avoid using
bitmaps altogether, we may again try and query the MIDX, which will also
fail. But when trying to call `fill_midx_entry()` fails, it also returns
a signal of its failure, and prompts the caller to try and locate the
object elsewhere.

In other words, the normal object traversal machinery works fine in the
presence of a corrupt MIDX, so there is no reason that the MIDX bitmap
machinery should abort in that case when we could easily continue.

Note that we *could* in theory try again to load a MIDX bitmap after
calling `reprepare_packed_git()`. Even though the `prepare_packed_git()`
code is careful to avoid adding a pack that we already have,
`prepare_midx_pack()` is not. So if we got part of the way through
calling `prepare_midx_pack()` on a stale MIDX, and then tried again on a
fresh MIDX that contains some of the same packs, we would end up with a
loop through the `->next` pointer.

For now, let's do the simplest thing possible and fallback to the
non-bitmap code when we detect a stale MIDX so that the complete fix as
above can be implemented carefully.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                 |  8 +++++---
 t/t5326-multi-pack-bitmaps.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 999f962602..1c3fd056a8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -387,9 +387,11 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
-			die(_("could not open pack %s"),
-			    bitmap_git->midx->pack_names[i]);
+		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
+			warning(_("could not open pack %s"),
+				bitmap_git->midx->pack_names[i]);
+			goto cleanup;
+		}
 	}
 
 	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index f771c442d4..70d1b58709 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -478,4 +478,39 @@ test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
 	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
 '
 
+test_expect_success 'corrupt MIDX with bitmap causes fallback' '
+	git init corrupt-midx-bitmap &&
+	(
+		cd corrupt-midx-bitmap &&
+
+		test_commit first &&
+		git repack -d &&
+		test_commit second &&
+		git repack -d &&
+
+		git multi-pack-index write --bitmap &&
+		checksum=$(midx_checksum $objdir) &&
+		for f in $midx $midx-$checksum.bitmap
+		do
+			mv $f $f.bak || return 1
+		done &&
+
+		# pack everything together, invalidating the MIDX
+		git repack -ad &&
+		# then restore the now-stale MIDX
+		for f in $midx $midx-$checksum.bitmap
+		do
+			mv $f.bak $f || return 1
+		done &&
+
+		git rev-list --count --objects --use-bitmap-index HEAD >out 2>err &&
+		# should attempt opening the broken pack twice (once
+		# from the attempt to load it via the stale bitmap, and
+		# again when attempting to load it from the stale MIDX)
+		# before falling back to the non-MIDX case
+		test 2 -eq $(grep -c "could not open pack" err) &&
+		test 6 -eq $(cat out)
+	)
+'
+
 test_done
-- 
2.41.0.1.gf123b68cb8
