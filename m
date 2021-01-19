Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F84CC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FB122DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhASXYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhASXYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:24:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3671C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:23:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z11so23701345qkj.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hu7h8gRv9hPTalCqiSeC++B4bIccuFjEaanICq2X8gM=;
        b=fNtgb2OezYVCxH6fRzTqHyLzjse772e7ehqX5ECoZIHHsuH6LCCsTTRaJz0tEB7V5M
         f7/zPtNPpZFEAuhgyenDUU6irTSO/0XMyxmmcae0HF8obAj2Y0y9+iG4UbhWs8zCA7N9
         l0JXSmXj8Fr5QE4X+0G9oV6NUhxI4f8xXlMoHdiYlcEB5Rf6ZfpGVrnCBjH3XjqN30ur
         OUrirXqkMMOvbpVQ1+7IEDsB9sp5Wv+cXkpJamKLgyJcGM7QmznFN3mFceGeh1dnCjz0
         iN6ZmreuaZeF9TpFx4rcS808tbF5AWWLrO86J1Vfsv+796OsjBD2r+BIttUtMeoTv5e2
         e+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hu7h8gRv9hPTalCqiSeC++B4bIccuFjEaanICq2X8gM=;
        b=qhq3TTxs/W58IcGJnH3MBAP71I47zw6ytpC2ELWax4uloqYSMirbdK+VZNpYAJTG6e
         3g+mnOCQCg2Fspppuj6Ru4DNgH2acdcYskqzca607af9lWrcF1lV0z//XRiDmHcvYCtq
         4nDEq0KvZjpDEt8AuwgfMc0/eaAKyb4FyeV80R+dvczRBIiCylddJTFhx7QQAzSs2JS5
         2IoBZjCtPtGUlqvR1UpzaWqfosjDARZlqMa5tdQBMtIXe98VWACMqTkHZrklBWIawuG4
         00UrnqgIhuwpZldMbeOrP3rFDLf3bIboSkBZLgNmplwGbKETg/PL0KBIGpZtTeizvjMS
         n1wA==
X-Gm-Message-State: AOAM532SO/4Dg8FMWriJJgqLip34uiCDCGVHUhPg1z7LdELqU6Dm6GfG
        SqawfIRfODiz5NoJ23XFoXWRf4GUnxGCew==
X-Google-Smtp-Source: ABdhPJxmp9FETfwF1EyIpw5eQJKOec1XKqgePk3amxK4OwiTv+VEuacCrFHLqzjiJVALG63tt3Lo/w==
X-Received: by 2002:a37:6141:: with SMTP id v62mr6825229qkb.500.1611098638800;
        Tue, 19 Jan 2021 15:23:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id q73sm180664qke.16.2021.01.19.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:23:58 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:23:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 00/10] repack: support repacking into a geometric sequence
Message-ID: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces a new mode of 'git repack' where (instead of packing just
loose objects or packing everything together into one pack), the set of packs
left forms a geometric progression by object count.

It does not depend on either series of the revindex patches I sent recently.

Roughly speaking, for a given factor, say "d", each pack has at least "d" times
the number of objects as the next largest pack. So, if there are "N" packs,
"P1", "P2", ..., "PN" ordered by object count (where "PN" has the most objects,
and "P1" the fewest), then:

  objects(Pi) > d * objects(P(i-1))

for all 1 < i <= N.

This is done by first ordering packs by object count, and then determining the
longest sequence of large packs which already form a geometric progression. All
packs on the small side of that cut must be repacked together, and so we check
that the existing progression can be maintained with the new pack, and adjust as
necessary.

In actuality, this is approximated in order for 'git repack' to have to create
at most one new pack. The details of this approximation are discussed at length
in the final patch.

'git repack' implements this new option by marking the packs that don't need to
be touched as "frozen" and it does this by marking them as pack_keep_in_core,
and then using a new option pack-objects option '--assume-kept-packs-closed' to
stop the reachability traversal once it encounters any objects in the kept
packs.

When repacking in this mode, the caller implicitly trusts that the unchanged
packs are closed under reachability, and thus they can halt the traversal as
soon as an object in any one of those packs is found.

The first three patches introduce the new revision and pack-objects options
necessary for this to work. The next four patches introduce an MRU cache for
kept packs only. Then a new pack-objects mode is introduced to allow callers to
specify the list of kept packs over stdin in case they are too long to be listed
as arguments. Finally, geometric repacking is introduced

Thanks in advance for your review.

Jeff King (4):
  p5303: add missing &&-chains
  p5303: measure time to repack with keep
  pack-objects: rewrite honor-pack-keep logic
  packfile: add kept-pack cache for find_kept_pack_entry()

Taylor Blau (6):
  packfile: introduce 'find_kept_pack_entry()'
  revision: learn '--no-kept-objects'
  builtin/pack-objects.c: learn '--assume-kept-packs-closed'
  builtin/pack-objects.c: teach '--keep-pack-stdin'
  builtin/repack.c: extract loose object handling
  builtin/repack.c: add '--geometric' option

 Documentation/git-pack-objects.txt |  19 +++
 Documentation/git-repack.txt       |  11 ++
 Documentation/rev-list-options.txt |   7 +
 builtin/pack-objects.c             | 161 ++++++++++++++--------
 builtin/repack.c                   | 206 ++++++++++++++++++++++++++---
 list-objects.c                     |   7 +
 object-store.h                     |  10 ++
 packfile.c                         |  69 ++++++++++
 packfile.h                         |   2 +
 revision.c                         |  15 +++
 revision.h                         |   4 +
 t/perf/p5303-many-packs.sh         |  18 ++-
 t/t6114-keep-packs.sh              | 128 ++++++++++++++++++
 t/t7703-repack-geometric.sh        |  81 ++++++++++++
 14 files changed, 663 insertions(+), 75 deletions(-)
 create mode 100755 t/t6114-keep-packs.sh
 create mode 100755 t/t7703-repack-geometric.sh

-- 
2.30.0.138.g6d7191ea01
