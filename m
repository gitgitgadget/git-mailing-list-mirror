Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D582C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiHDQ26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiHDQ25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:28:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC167145
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:28:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n20-20020a05600c3b9400b003a4f2261a7eso129230wms.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hBkKQLRuxNHNqhrHRfG5qtJcVz9lqIrA0PhIZloxiTU=;
        b=lgfC6T5XlaqmM1LOSBbZOYQpGx48BLZVVImB6J7WmFMv1HMLJfzp6d3sQXigcKz3D/
         Zercl9AByoAVeSkVFvduFIedo5LzeOcjcz0dv/oZl1fOlpGIZoyHcEDHyccvCcXhyfsw
         +lD5NDNZNnzFtf+ViQaoMWW9q8/qjUgQ4j13UepjMRPWSaNJWJHLsOww3GiRbMa6Xb3t
         kbyXIZs1K2IEwd9Fvznf/3oebrc6YZhkvV5A7fOvdY6NcvKdER1BuCMJ3v6Cx0q6Q9u1
         4SCYx4E6UQPHD6m0llJM2twV7MTJM7WIsaQc7O0kQ3v7cwwX0Sbk5JrmpXwisvHZagci
         Jrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hBkKQLRuxNHNqhrHRfG5qtJcVz9lqIrA0PhIZloxiTU=;
        b=5ovLaxHZkuPyvp5iVGu7rioUKpXjj3f/h1b1w/+6+EJFq2rvlLJtsqnEKh0DiZIcdU
         bFHmHgnsRIsDb89bP2+drx1ZBqAk7P1eHUC3jXhKKqLAuQiZBIDMS9O/t4Gs/OYYQIQp
         6S7snYk0J3UJ7dZdLj37cg1hF0ChaaJHMuXgrH9bmidAbrOMDKmEWJ4p++1pjtf6U1Q+
         tfJOg619y2GSpDzT2RfYnaOWwme7eyTdupPJ/mBLtl4EhRz0APSFFhU3SqHYdMHkXuvA
         6L7Kc+uYoRRZxkKxWchBkr9BnLg4a/U49TgfEM52RCl3J8GMa05y/cIslL3K4lppQgO9
         RpFw==
X-Gm-Message-State: ACgBeo2Do7/vkFOKKbrzJ2TBPvhikNKxxT5tU+/iLzJCfCTKFtbXVWg1
        mYHxigoS6WqjKpmULhh80OS2dC3IbNc=
X-Google-Smtp-Source: AA6agR7a0E1Mjr0UAdjNLoc2w4ty5wGho56eNT/hCfSQWE076fJuZnP0HidRz9KaOGmf2goTPBP7Gw==
X-Received: by 2002:a05:600c:22cc:b0:3a5:1209:bbba with SMTP id 12-20020a05600c22cc00b003a51209bbbamr2137200wmg.131.1659630532917;
        Thu, 04 Aug 2022 09:28:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:28:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 00/12]  docs: create & use "(user|developer) interfaces" categories
Date:   Thu,  4 Aug 2022 18:28:29 +0200
Message-Id: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the v5 for a general overview:
https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com/

Changes since v7:

 * Corrects the discussion of existing behavior in 1-2/12 (git-gitfoo
   v.s. git-foo).

 * Fixes a stray error in previous v7 rebasing in 6/12.

 * Splits out the "signature" and "index" format doc conversions into
   their own commits (previously part of the "pack" conversion).

 * The "gitformat-pack" now contains what was previously in
   "gitformat-cruft-pack", i.e. we discuss all of the pack files
   (*.pack, *.idx etc.) in the one file.

   (The *.bitmap bit is left out for now as before, due to in-flight
   conflicts)

 * Ejected the conversion of
   Documentation/technical/multi-pack-index.txt, we discuss the midx
   in the gitformat-pack already, that documentation is more in the
   "design notes" category.

   Perhaps we should have a gitdesign-* namespace for such things, but
   let's leave it aside for now.

Ævar Arnfjörð Bjarmason (12):
  help.c: refactor drop_prefix() to use a "switch" statement"
  help.c: remove common category behavior from drop_prefix() behavior
  git help doc: use "<doc>" instead of "<guide>"
  git docs: add a category for user-facing file, repo and command UX
  git docs: add a category for file formats, protocols and interfaces
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move index format docs to man section 5
  docs: move signature docs to man section 5
  docs: move pack format docs to man section 5
  docs: move cruft pack docs to gitformat-pack
  docs: move http-protocol docs to man section 5

 Documentation/Makefile                        |  23 +--
 Documentation/config/lsrefs.txt               |   2 +-
 Documentation/config/pack.txt                 |   2 +-
 Documentation/config/protocol.txt             |   2 +-
 Documentation/git-bundle.txt                  |  13 +-
 Documentation/git-commit-graph.txt            |   5 +
 Documentation/git-help.txt                    |  27 ++-
 Documentation/git-multi-pack-index.txt        |   4 +-
 Documentation/git-upload-pack.txt             |   7 +-
 Documentation/git.txt                         |  17 ++
 ...bundle-format.txt => gitformat-bundle.txt} |  44 ++++-
 .../chunk-format.txt => gitformat-chunk.txt}  |  29 +++-
 ...-format.txt => gitformat-commit-graph.txt} |  49 ++++--
 .../index-format.txt => gitformat-index.txt}  |  22 ++-
 .../pack-format.txt => gitformat-pack.txt}    | 160 +++++++++++++++++-
 ...ure-format.txt => gitformat-signature.txt} |  21 ++-
 ...ities.txt => gitprotocol-capabilities.txt} |  28 ++-
 ...ocol-common.txt => gitprotocol-common.txt} |  23 ++-
 ...http-protocol.txt => gitprotocol-http.txt} |  35 +++-
 ...pack-protocol.txt => gitprotocol-pack.txt} |  28 ++-
 .../protocol-v2.txt => gitprotocol-v2.txt}    |  27 ++-
 .../howto/recover-corrupted-object-harder.txt |   2 +-
 Documentation/lint-man-section-order.perl     |   3 +
 Documentation/technical/api-simple-ipc.txt    |   2 +-
 Documentation/technical/cruft-packs.txt       | 123 --------------
 .../technical/hash-function-transition.txt    |   2 +-
 .../long-running-process-protocol.txt         |   2 +-
 Documentation/technical/packfile-uri.txt      |   2 +-
 Documentation/technical/partial-clone.txt     |   2 +-
 Documentation/user-manual.txt                 |   2 +-
 Makefile                                      |   1 +
 builtin/help.c                                |  20 ++-
 cache.h                                       |   3 +-
 command-list.txt                              |  36 +++-
 help.c                                        |  41 ++++-
 help.h                                        |   2 +
 pack-revindex.h                               |   2 +-
 refspec.h                                     |   2 +-
 t/t0012-help.sh                               |  14 +-
 t/t5551-http-fetch-smart.sh                   |   4 +-
 40 files changed, 590 insertions(+), 243 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (89%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (72%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)
 rename Documentation/{technical/protocol-capabilities.txt => gitprotocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitprotocol-common.txt} (89%)
 rename Documentation/{technical/http-protocol.txt => gitprotocol-http.txt} (97%)
 rename Documentation/{technical/pack-protocol.txt => gitprotocol-pack.txt} (98%)
 rename Documentation/{technical/protocol-v2.txt => gitprotocol-v2.txt} (97%)
 delete mode 100644 Documentation/technical/cruft-packs.txt

Range-diff against v7:
 1:  2665148f45b !  1:  8ae30ce2e80 help.c: refactor drop_prefix() to use a "switch" statement"
    @@ Commit message
         we'll return the stripped string. Then we'll strip "git" if the
         command is in "CAT_guide".
     
    -    This means that we'd in principle strip "git-gitfoo" down to "foo" if
    +    This means that we'd in principle strip "git-foo" down to "foo" if
         it's in CAT_guide. That doesn't make much sense, and we don't have
         such an entry in command-list.txt, but let's preserve that behavior
         for now.
 2:  56429194634 !  2:  aebb56da6e9 help.c: remove common category behavior from drop_prefix() behavior
    @@ Commit message
     
         Before this we'd in principle strip a "git-" prefix from a "guide" in
         command-list.txt, in practice we have no such entry there. As we don't
    -    have any entry that looks like "git-gitfoo" in command-list.txt this
    +    have any entry that looks like "git-foo" in command-list.txt this
         changes nothing in practice, but it makes the intent of the code
    -    clearer.
    +    clearer. In that hypothetical case we'd now strip it down to "-foo",
    +    not "foo".
     
         When this code was added in cfb22a02ab5 (help: use command-list.h for
         common command list, 2018-05-10) the only entries in command-list.txt
 3:  2d6c00a51fa =  3:  6c3c072de6f git help doc: use "<doc>" instead of "<guide>"
 4:  8e9384a92f2 =  4:  d12db4a9540 git docs: add a category for user-facing file, repo and command UX
 5:  4367c1e7f50 =  5:  f76e775bfdd git docs: add a category for file formats, protocols and interfaces
 6:  5adabbb3a26 !  6:  df3ef265d45 docs: move commit-graph format docs to man section 5
    @@ command-list.txt: gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
      gitformat-bundle                        developerinterfaces
    -+gitformat-bundle                        developerinterfaces
     +gitformat-commit-graph                  developerinterfaces
      gitglossary                             guide
      githooks                                userinterfaces
 7:  cfd1b0afb53 !  7:  daafbf9ae90 docs: move protocol-related docs to man section 5
    @@ Documentation/technical/partial-clone.txt: Design Details
        server to request filtering during packfile construction.
     
      ## command-list.txt ##
    -@@ command-list.txt: gitdiffcore                             guide
    - giteveryday                             guide
    - gitfaq                                  guide
    - gitformat-bundle                        developerinterfaces
    --gitformat-bundle                        developerinterfaces
    - gitformat-commit-graph                  developerinterfaces
    - gitglossary                             guide
    - githooks                                userinterfaces
     @@ command-list.txt: gitk                                    mainporcelain
      gitmailmap                              userinterfaces
      gitmodules                              userinterfaces
10:  8baf1db4d30 !  8:  ea98b37e41a docs: move multi-pack-index docs to man section 5
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    docs: move multi-pack-index docs to man section 5
    +    docs: move index format docs to man section 5
     
         Continue the move of existing Documentation/technical/* protocol and
         file-format documentation into our main documentation space by moving
    -    the multi-pack-index documentation over.
    +    the index format documentation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    -@@ Documentation/Makefile: MAN5_TXT += gitformat-bundle.txt
    - MAN5_TXT += gitformat-chunk.txt
    +@@ Documentation/Makefile: MAN1_TXT += gitweb.txt
    + MAN5_TXT += gitattributes.txt
    + MAN5_TXT += gitformat-bundle.txt
      MAN5_TXT += gitformat-commit-graph.txt
    - MAN5_TXT += gitformat-index.txt
    -+MAN5_TXT += gitformat-multi-pack-index.txt
    - MAN5_TXT += gitformat-pack-cruft.txt
    - MAN5_TXT += gitformat-pack.txt
    - MAN5_TXT += gitformat-signature.txt
    -@@ Documentation/Makefile: TECH_DOCS += ToolsForGit
    - TECH_DOCS += technical/bitmap-format
    ++MAN5_TXT += gitformat-index.txt
    + MAN5_TXT += githooks.txt
    + MAN5_TXT += gitignore.txt
    + MAN5_TXT += gitmailmap.txt
    +@@ Documentation/Makefile: TECH_DOCS += technical/bitmap-format
    + TECH_DOCS += technical/cruft-packs
      TECH_DOCS += technical/hash-function-transition
    + TECH_DOCS += technical/http-protocol
    +-TECH_DOCS += technical/index-format
      TECH_DOCS += technical/long-running-process-protocol
    --TECH_DOCS += technical/multi-pack-index
    - TECH_DOCS += technical/pack-heuristics
    - TECH_DOCS += technical/parallel-checkout
    - TECH_DOCS += technical/partial-clone
    + TECH_DOCS += technical/multi-pack-index
    + TECH_DOCS += technical/pack-format
     
    - ## Documentation/git-multi-pack-index.txt ##
    -@@ Documentation/git-multi-pack-index.txt: $ git multi-pack-index verify
    - 
    - SEE ALSO
    - --------
    --See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
    --Document] and linkgit:gitformat-pack[5] for more information on the
    -+See linkgit:git-multi-pack-index[1] and
    -+linkgit:gitformat-multi-pack-index[5] for more information on the
    - multi-pack-index feature and its file format.
    - 
    - 
    -
    - ## Documentation/technical/multi-pack-index.txt => Documentation/gitformat-multi-pack-index.txt ##
    + ## Documentation/technical/index-format.txt => Documentation/gitformat-index.txt ##
     @@
    --Multi-Pack-Index (MIDX) Design Notes
    --====================================
    -+gitformat-multi-pack-index(5)
    -+=============================
    ++gitformat-index(5)
    ++==================
     +
     +NAME
     +----
    -+gitformat-multi-pack-index - The multi-pack-index file format
    ++gitformat-index - Git index format
     +
     +SYNOPSIS
     +--------
     +[verse]
    -+$GIT_DIR/objects/pack/multi-pack-index
    ++$GIT_DIR/index
     +
     +DESCRIPTION
     +-----------
    ++
    + Git index format
    +-================
      
    - The Git object directory contains a 'pack' directory containing
    - packfiles (with suffix ".pack") and pack-indexes (with suffix
    -@@ Documentation/gitformat-multi-pack-index.txt: Related Links
    + == The Git index file has the following format
      
    - [2] https://lore.kernel.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
    -     Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)
    +@@ Documentation/gitformat-index.txt: The remaining data of each directory block is grouped by type:
    +   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
    +   tools should avoid interacting with a sparse index unless they understand
    +   this extension.
     +
     +GIT
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/gitformat-pack.txt ##
    -@@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferred pack coming first).
    - The MIDX's reverse index is stored in the optional 'RIDX' chunk within
    - the MIDX itself.
    - 
    -+SEE ALSO
    -+--------
    -+
    -+linkgit:gitformat-multi-pack-index[5]
    -+
    - GIT
    - ---
    - Part of the linkgit:git[1] suite
    -
      ## command-list.txt ##
    -@@ command-list.txt: gitformat-bundle                        developerinterfaces
    - gitformat-chunk                         developerinterfaces
    +@@ command-list.txt: giteveryday                             guide
    + gitfaq                                  guide
    + gitformat-bundle                        developerinterfaces
      gitformat-commit-graph                  developerinterfaces
    - gitformat-index                         developerinterfaces
    -+gitformat-multi-pack-index              developerinterfaces
    - gitformat-pack                          developerinterfaces
    - gitformat-pack-cruft                    developerinterfaces
    - gitformat-signature                     developerinterfaces
    ++gitformat-index                         developerinterfaces
    + gitglossary                             guide
    + githooks                                userinterfaces
    + gitignore                               userinterfaces
 -:  ----------- >  9:  42a4a3c3be8 docs: move signature docs to man section 5
 8:  3505fa86039 ! 10:  576c1fef4b3 docs: move pack format docs to man section 5
    @@ Commit message
         location.
     
         By moving these we can properly link from the newly created
    -    gitformat-commit-graph do to a gitformat-chunk-format manpage we build
    -    by default.
    +    gitformat-commit-graph to a gitformat-chunk-format page.
     
    -    Creating a "gitformat-pack-bitmap" from
    -    "Documentation/technical/bitmap-format" might logically be part of
    -    this change, but it's left out for now due to a conflict with the
    -    in-flight ac/bitmap-lookup-table series.
    +    Integrating "Documentation/technical/bitmap-format.txt" and
    +    "Documentation/technical/cruft-packs.txt" might logically be part of
    +    this change, but as those cover parts of the wider "pack
    +    format" (including associated files) that's documented outside of
    +    "Documentation/technical/pack-format.txt" let's leave those for now,
    +    subsequent commit(s) will address those.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
      MAN5_TXT += gitformat-bundle.txt
     +MAN5_TXT += gitformat-chunk.txt
      MAN5_TXT += gitformat-commit-graph.txt
    -+MAN5_TXT += gitformat-index.txt
    -+MAN5_TXT += gitformat-pack-cruft.txt
    + MAN5_TXT += gitformat-index.txt
     +MAN5_TXT += gitformat-pack.txt
    -+MAN5_TXT += gitformat-signature.txt
    + MAN5_TXT += gitformat-signature.txt
      MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
    - MAN5_TXT += gitmailmap.txt
    -@@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
    - TECH_DOCS += SubmittingPatches
    - TECH_DOCS += ToolsForGit
    - TECH_DOCS += technical/bitmap-format
    --TECH_DOCS += technical/cruft-packs
    - TECH_DOCS += technical/hash-function-transition
    +@@ Documentation/Makefile: TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/http-protocol
    --TECH_DOCS += technical/index-format
      TECH_DOCS += technical/long-running-process-protocol
      TECH_DOCS += technical/multi-pack-index
     -TECH_DOCS += technical/pack-format
      TECH_DOCS += technical/pack-heuristics
      TECH_DOCS += technical/parallel-checkout
      TECH_DOCS += technical/partial-clone
    -@@ Documentation/Makefile: TECH_DOCS += technical/racy-git
    - TECH_DOCS += technical/reftable
    - TECH_DOCS += technical/send-pack-pipeline
    - TECH_DOCS += technical/shallow
    --TECH_DOCS += technical/signature-format
    - TECH_DOCS += technical/trivial-merge
    - SP_ARTICLES += $(TECH_DOCS)
    - SP_ARTICLES += technical/api-index
     
      ## Documentation/config/pack.txt ##
     @@ Documentation/config/pack.txt: permuted into their appropriate location when writing a new bitmap.
    @@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers are in network
        The remaining data in the body is described one chunk at a time, and
        these chunks may be given in any order. Chunks are required unless
     
    - ## Documentation/technical/index-format.txt => Documentation/gitformat-index.txt ##
    -@@
    -+gitformat-index(5)
    -+==================
    -+
    -+NAME
    -+----
    -+gitformat-index - Git index format
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+$GIT_DIR/index
    -+
    -+DESCRIPTION
    -+-----------
    -+
    - Git index format
    --================
    - 
    - == The Git index file has the following format
    - 
    + ## Documentation/gitformat-index.txt ##
     @@ Documentation/gitformat-index.txt: Git index format
          entry is encoded as if the path name for the previous entry is an
          empty string).  At the beginning of an entry, an integer N in the
    @@ Documentation/gitformat-index.txt: Git index format
          by a NUL-terminated string S.  Removing N bytes from the end of the
          path name for the previous entry, and replacing it with the string S
          yields the path name for this entry.
    -@@ Documentation/gitformat-index.txt: The remaining data of each directory block is grouped by type:
    -   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
    -   tools should avoid interacting with a sparse index unless they understand
    -   this extension.
    -+
    -+GIT
    -+---
    -+Part of the linkgit:git[1] suite
    -
    - ## Documentation/technical/cruft-packs.txt => Documentation/gitformat-pack-cruft.txt ##
    -@@
    --= Cruft packs
    -+gitformat-pack-cruft(5)
    -+=======================
    -+
    -+NAME
    -+----
    -+gitformat-pack-cruft - The cruft pack file format
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+$GIT_DIR/objects/pack/pack-*.mtimes
    -+
    -+DESCRIPTION
    -+-----------
    - 
    - The cruft packs feature offer an alternative to Git's traditional mechanism of
    - removing unreachable objects. This document provides an overview of Git's
    -@@ Documentation/gitformat-pack-cruft.txt: same.
    - To remove unreachable objects from your repository, Git offers `git repack -Ad`
    - (see linkgit:git-repack[1]). Quoting from the documentation:
    - 
    --[quote]
    -+----
    - [...] unreachable objects in a previous pack become loose, unpacked objects,
    - instead of being left in the old pack. [...] loose unreachable objects will be
    - pruned according to normal expiry rules with the next 'git gc' invocation.
    -+----
    - 
    - Unreachable objects aren't removed immediately, since doing so could race with
    - an incoming push which may reference an object which is about to be deleted.
    -@@ Documentation/gitformat-pack-cruft.txt: which aren't already stored in an earlier cruft pack) is significantly more
    - complicated to construct, and so aren't pursued here. The obvious drawback to
    - the current implementation is that the entire cruft pack must be re-written from
    - scratch.
    -+
    -+GIT
    -+---
    -+Part of the linkgit:git[1] suite
     
      ## Documentation/technical/pack-format.txt => Documentation/gitformat-pack.txt ##
     @@
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
     +
     +GIT
     +---
    -+Part of the linkgit:git[1] suite
    -
    - ## Documentation/technical/signature-format.txt => Documentation/gitformat-signature.txt ##
    -@@
    --Git signature format
    --====================
    -+gitformat-signature(5)
    -+======================
    - 
    --== Overview
    -+NAME
    -+----
    -+gitformat-signature - Git cryptographic signature formats
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+<[tag|commit] object header(s)>
    -+<over-the-wire protocol>
    -+
    -+DESCRIPTION
    -+-----------
    - 
    - Git uses cryptographic signatures in various places, currently objects (tags,
    - commits, mergetags) and transactions (pushes). In every case, the command which
    -@@ Documentation/gitformat-signature.txt: Date:   Wed Jun 15 09:13:29 2016 +0000
    -     # gpg:          There is no indication that the signature belongs to the owner.
    -     # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
    - ----
    -+
    -+GIT
    -+---
     +Part of the linkgit:git[1] suite
     
      ## Documentation/gitprotocol-pack.txt ##
    @@ command-list.txt: gitdiffcore                             guide
      gitformat-bundle                        developerinterfaces
     +gitformat-chunk                         developerinterfaces
      gitformat-commit-graph                  developerinterfaces
    -+gitformat-index                         developerinterfaces
    + gitformat-index                         developerinterfaces
     +gitformat-pack                          developerinterfaces
    -+gitformat-pack-cruft                    developerinterfaces
    -+gitformat-signature                     developerinterfaces
    + gitformat-signature                     developerinterfaces
      gitglossary                             guide
      githooks                                userinterfaces
    - gitignore                               userinterfaces
     
      ## pack-revindex.h ##
     @@
 -:  ----------- > 11:  b9dde9788d4 docs: move cruft pack docs to gitformat-pack
 9:  c4a7fe9d439 = 12:  c572688c525 docs: move http-protocol docs to man section 5
-- 
2.37.1.1233.g61622908797

