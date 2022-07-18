Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6EBCCA479
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiGRN3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGRN3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F29C06
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so5218293wmi.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRyfpyguLUHE/hw0hmA+SMY8XMy7Jt3UHMwa9U5l98s=;
        b=eM5ZznqZbqA0AzY2BMWqMnU3fc6fVrFEIgl8SYclxfIfEsFWwqOXM6ghwqtdARA/Dc
         e5qmh9/lYVwe6Nqaz0OUcXSeqtO4Q5nAP69PdeTGpTYRPmzj2pKUHNeAiYuMeS4jugXR
         BLyL9ITlHyTX6kOEbPohH1A1lcfb5Kzqj9OTudn80TFA+FMP73f/ShWEbgHUHGRn5qFx
         nbwwug7OJpGcg6QudedxNMA3pTVyPfrR3uNs40UGJfDabj5gyog48ZW7Bs7H0qLb1SAm
         5AHUDFqSi8WXTskKfBN43QsvB9dScY7iZrmkxsieAhXmjArXo5yv8fFcwX6JwynfsUGw
         l1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRyfpyguLUHE/hw0hmA+SMY8XMy7Jt3UHMwa9U5l98s=;
        b=PpOaXKkd/Mvki/MJpRukEqEU8GwEEa5gB365YNiw8pWLAwqg+WUImnSp0Gc5Wh4/XS
         U5X5/w7xgqW1A0J7n66kJRiP2raxDdb91dhtX73cjQ5Fy/lTC4KbqFbY6rFO9hG1p8pb
         Y6mg7m7kFGdSF8oDMGyI2A8szFctJkJWlUS3FmzqVv78Bp9RB1VLCaWsTXpG6rpEnrJW
         QLEIUk8eJvnv9pqE5hV49UEutrUQqxc3L6HEwAhJvNNDWlvwUOk322gqzZx+ltYaWvV8
         sH79Qs4C2kUYKtxxa5W3Q2L6dRIMnjxJMWRRuL2dqMzqnHa/+62Fd7oAjFt4YvezTRq7
         vXxQ==
X-Gm-Message-State: AJIora9u4cqo8CTXpCHthEI5l2tDvaA5hi2PIEawGG56uOftzEP7W5Yb
        73D/9SU1rePxiABbN5nY/9iNHxcx0mpAFA==
X-Google-Smtp-Source: AGRyM1uji4Ei/Wephpb+ShzeNFz0N1+OLf50HfOjROOemNp+dmQxFswf6j16bAu19aSsFC76XlLBWA==
X-Received: by 2002:a7b:ce8f:0:b0:3a3:150c:d8ff with SMTP id q15-20020a7bce8f000000b003a3150cd8ffmr9224553wmj.152.1658150979532;
        Mon, 18 Jul 2022 06:29:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:39 -0700 (PDT)
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
Subject: [PATCH v4 0/8] git doc + "git help": move "format" docs from technical/*
Date:   Mon, 18 Jul 2022 15:29:26 +0200
Message-Id: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves the discoverability of the technical/*
documentation covering those "formats" where we interact with users
(e.g. "gitattributes") by moving them to its own "git help" category.

It then moves various technical documentation from technical/* to our
main documentation namespace, allowing us to cross-link e.g. from
"git-bundle(1)" to a new "gitformat-bundle(5)".

See the v3 CL[1] for more details.

Changes since v3:

 * Made a condition that never happened but which -fanalyzer
   complained about a BUG() (required knowing about the nature of
   command-list.txt).

 * Ejected the conflict with ac/bitmap-lookup-table by punting on
   gitformat-pack-bitmap(5). We can migrate that later, but this way
   there's no conflicts with "seen".

1. https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  help.c: BUG() out if "help --guides" can't remove "git" prefixes
  git docs: split "User-facing file formats" off from "Guides"
  git docs: create a "Git file formats and protocols" section
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move pack format docs to man section 5
  docs: move http-protocol docs to man section 5
  docs: move multi-pack-index docs to man section 5

 Documentation/Makefile                        | 26 +++++-----
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 11 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 14 ++++--
 Documentation/git-multi-pack-index.txt        |  7 +--
 Documentation/git-upload-pack.txt             |  7 ++-
 Documentation/git.txt                         | 15 ++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 27 ++++++++--
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++-
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++-
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++-
 ...otocol.txt => gitformat-pack-protocol.txt} | 26 ++++++++--
 .../pack-format.txt => gitformat-pack.txt}    | 39 +++++++++++++--
 ...xt => gitformat-protocol-capabilities.txt} | 28 ++++++++---
 ...mmon.txt => gitformat-protocol-common.txt} | 23 ++++++++-
 ...otocol.txt => gitformat-protocol-http.txt} | 35 ++++++++++---
 ...tocol-v2.txt => gitformat-protocol-v2.txt} | 26 ++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 18 ++++++-
 cache.h                                       |  3 +-
 command-list.txt                              | 33 ++++++++++---
 help.c                                        | 32 +++++++++++-
 help.h                                        |  2 +
 pack-revindex.h                               |  2 +-
 t/t0012-help.sh                               | 14 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 39 files changed, 482 insertions(+), 115 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (90%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-protocol.txt => gitformat-pack-protocol.txt} (98%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/protocol-capabilities.txt => gitformat-protocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitformat-protocol-common.txt} (88%)
 rename Documentation/{technical/http-protocol.txt => gitformat-protocol-http.txt} (97%)
 rename Documentation/{technical/protocol-v2.txt => gitformat-protocol-v2.txt} (97%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

Range-diff against v3:
-:  ----------- > 1:  4428f0a6fb1 help.c: BUG() out if "help --guides" can't remove "git" prefixes
1:  929d9192828 ! 2:  883c483d4e7 git docs: split "User-facing file formats" off from "Guides"
    @@ help.c: static struct category_description main_categories[] = {
      };
      
     @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    - 
    - 	if (skip_prefix(name, "git-", &new_name))
    - 		return new_name;
    --	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
    -+	switch (category) {
    -+	case CAT_guide:
    + 	switch (category)
    + 	{
    + 	case CAT_guide:
     +	case CAT_userformats:
    -+		skip_prefix(name, "git", &new_name);
    + 		if (!skip_prefix(name, "git", &new_name))
    + 			BUG("category #%d but no 'git' prefix?", category);
      		return new_name;
    -+	}
    - 	return name;
    - 
    - }
     @@ help.c: void list_guides_help(void)
      	putchar('\n');
      }
2:  1fd57d5caf4 ! 3:  d196bcd1db0 git docs: create a "Git file formats and protocols" section
    @@ help.c: static struct category_description main_categories[] = {
      };
      
     @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    - 	switch (category) {
    + 	{
      	case CAT_guide:
      	case CAT_userformats:
     +	case CAT_gitformats:
    - 		skip_prefix(name, "git", &new_name);
    + 		if (!skip_prefix(name, "git", &new_name))
    + 			BUG("category #%d but no 'git' prefix?", category);
      		return new_name;
    - 	}
     @@ help.c: void list_user_formats_help(void)
      	putchar('\n');
      }
3:  d548c6aaba7 = 4:  b59e001a4ca docs: move commit-graph format docs to man section 5
4:  f404987f94d = 5:  968aa977b67 docs: move protocol-related docs to man section 5
5:  6c46b4dccea ! 6:  858ce9c6999 docs: move pack format docs to man section 5
    @@ Commit message
         gitformat-commit-graph do to a gitformat-chunk-format manpage we build
         by default.
     
    +    Creating a "gitformat-pack-bitmap" from
    +    "Documentation/technical/bitmap-format" might logically be part of
    +    this change, but it's left out for now due to a conflict with the
    +    in-flight ac/bitmap-lookup-table series.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
     +MAN5_TXT += gitformat-chunk.txt
      MAN5_TXT += gitformat-commit-graph.txt
     +MAN5_TXT += gitformat-index.txt
    -+MAN5_TXT += gitformat-pack-bitmap.txt
     +MAN5_TXT += gitformat-pack-cruft.txt
      MAN5_TXT += gitformat-pack-protocol.txt
     +MAN5_TXT += gitformat-pack.txt
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
      MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
      MAN5_TXT += gitmailmap.txt
    -@@ Documentation/Makefile: TECH_DOCS += MyFirstContribution
    - TECH_DOCS += MyFirstObjectWalk
    +@@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
      TECH_DOCS += SubmittingPatches
      TECH_DOCS += ToolsForGit
    --TECH_DOCS += technical/bitmap-format
    + TECH_DOCS += technical/bitmap-format
     -TECH_DOCS += technical/cruft-packs
      TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/http-protocol
    @@ Documentation/gitformat-index.txt: The remaining data of each directory block is
     +
     +GIT
     +---
    -+Part of the linkgit:git[1] suite
    -
    - ## Documentation/technical/bitmap-format.txt => Documentation/gitformat-pack-bitmap.txt ##
    -@@
    --GIT bitmap v1 format
    --====================
    -+gitformat-pack-bitmap(5)
    -+========================
    - 
    --== Pack and multi-pack bitmaps
    -+NAME
    -+----
    -+gitformat-pack-bitmap - The bitmap file format
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+$GIT_DIR/objects/pack/pack-*.bitmap
    -+
    -+DESCRIPTION
    -+-----------
    -+
    -+Bitmaps are a file format associated with .pack files. See
    -+the pack format documentation in linkgit:gitformat-pack[5] and
    -+linkgit:git-pack-objects[1].
    -+
    -+== GIT bitmap v1 format
    -+
    -+=== Pack and multi-pack bitmaps
    - 
    - Bitmaps store reachability information about the set of objects in a packfile,
    - or a multi-pack index (MIDX). The former is defined obviously, and the latter is
    -@@ Documentation/gitformat-pack-bitmap.txt: Certain bitmap extensions are supported (see: Appendix B). No extensions are
    - required for bitmaps corresponding to packfiles. For bitmaps that correspond to
    - MIDXs, both the bit-cache and rev-cache extensions are required.
    - 
    --== On-disk format
    -+=== On-disk format
    - 
    -     * A header appears at the beginning:
    - 
    -@@ Documentation/gitformat-pack-bitmap.txt: in the index.
    - 	TRAILER: ::
    - 		Trailing checksum of the preceding contents.
    - 
    --== Appendix A: Serialization format for an EWAH bitmap
    -+Appendix A - Serialization format for an EWAH bitmap
    -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    - 
    - Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
    - library, making them backwards compatible with the JGit
    -@@ Documentation/gitformat-pack-bitmap.txt: chunk.  For efficient appending to the bitstream, the EWAH stores a
    - pointer to the last RLW in the stream.
    - 
    - 
    --== Appendix B: Optional Bitmap Sections
    -+Appendix B - Optional Bitmap Sections
    -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    - 
    - These sections may or may not be present in the `.bitmap` file; their
    - presence is indicated by the header flags section described above.
    - 
    - Name-hash cache
    -----------------
    -+~~~~~~~~~~~~~~~
    - 
    - If the BITMAP_OPT_HASH_CACHE flag is set, the end of the bitmap contains
    - a cache of 32-bit values, one per object in the pack/MIDX. The value at
    -@@ Documentation/gitformat-pack-bitmap.txt: Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
    - If implementations want to choose a different hashing scheme, they are
    - free to do so, but MUST allocate a new header flag (because comparing
    - hashes made under two different schemes would be pointless).
    -+
    -+GIT
    -+---
     +Part of the linkgit:git[1] suite
     
      ## Documentation/technical/cruft-packs.txt => Documentation/gitformat-pack-cruft.txt ##
    @@ command-list.txt: gitdiffcore                             guide
      gitformat-commit-graph                  gitformats
     +gitformat-index                         gitformats
     +gitformat-pack                          gitformats
    -+gitformat-pack-bitmap                   gitformats
     +gitformat-pack-cruft                    gitformats
      gitformat-pack-protocol                 gitformats
      gitformat-protocol-capabilities         gitformats
6:  5cf8b526bff ! 7:  499ee582644 docs: move http-protocol docs to man section 5
    @@ Documentation/Makefile: MAN5_TXT += gitformat-pack-protocol.txt
      MAN5_TXT += gitformat-protocol-v2.txt
      MAN5_TXT += gitformat-signature.txt
      MAN5_TXT += githooks.txt
    -@@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
    - TECH_DOCS += SubmittingPatches
    +@@ Documentation/Makefile: TECH_DOCS += SubmittingPatches
      TECH_DOCS += ToolsForGit
    + TECH_DOCS += technical/bitmap-format
      TECH_DOCS += technical/hash-function-transition
     -TECH_DOCS += technical/http-protocol
      TECH_DOCS += technical/long-running-process-protocol
7:  aabdc4a4151 ! 8:  f186950e673 docs: move multi-pack-index docs to man section 5
    @@ Documentation/Makefile: MAN5_TXT += gitformat-bundle.txt
      MAN5_TXT += gitformat-commit-graph.txt
      MAN5_TXT += gitformat-index.txt
     +MAN5_TXT += gitformat-multi-pack-index.txt
    - MAN5_TXT += gitformat-pack-bitmap.txt
      MAN5_TXT += gitformat-pack-cruft.txt
      MAN5_TXT += gitformat-pack-protocol.txt
    -@@ Documentation/Makefile: TECH_DOCS += SubmittingPatches
    - TECH_DOCS += ToolsForGit
    + MAN5_TXT += gitformat-pack.txt
    +@@ Documentation/Makefile: TECH_DOCS += ToolsForGit
    + TECH_DOCS += technical/bitmap-format
      TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/long-running-process-protocol
     -TECH_DOCS += technical/multi-pack-index
    @@ command-list.txt: gitformat-bundle                        gitformats
      gitformat-index                         gitformats
     +gitformat-multi-pack-index              gitformats
      gitformat-pack                          gitformats
    - gitformat-pack-bitmap                   gitformats
      gitformat-pack-cruft                    gitformats
    + gitformat-pack-protocol                 gitformats
-- 
2.37.1.1032.gb00b5447790

