Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59201C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiKRLbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiKRLbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A733769E6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:10 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n20so12476134ejh.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/v1oIjW1EdWmGp7ceiw5m+M/DBgmPaZxzgSuHjF9Kes=;
        b=ItrZ6nnVGyckaJxm1iDMIvko18sWcrzpWBVXAKWitb4n2eLf5d1Upcg+N5sffibwFl
         WvFvfNOSWqifCvfptFolnuR0zb2ly6QbGJCEBDvl6hwArWZCdRTkEUnfbk5riV8/jNM+
         mHf+in1OTpRgq6voT+169hQJsmMhYnr22B4QFLpszHjPUEM1cHAh6NOxqhm/trszuTn7
         RpMdJLAymhNHqaR9ph5TLCn4oKONwC/qmYqhgFSk0QjeYa6nqbZerLZck1qE31W1mkY4
         nb6bhbWx87g8V+eVO7XRUGlG2fNrzKiLHz2Lzlf8iFh1OBdpssutOV+P22lhgxmvJ3lG
         Q6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v1oIjW1EdWmGp7ceiw5m+M/DBgmPaZxzgSuHjF9Kes=;
        b=ULmdUcRF+OcqEEFBftFtEXtOPg214vssoZyfO+5c0hsH3B1jgTTI/L1w2wcuGSg8O8
         HJ7DeNlqLeaT1w56QN37kYugWRXCvrFm3h+MecWmW1yBWo/hrZp2kshAkLKWPWLokrEi
         sjFkWT3IL8hRQWjGGo6LUOSWybIiQnmWdXADL5xdn9jEWbIAi0uSlFOLA2Q8GP+s9aNT
         Vw7gzhpTw3Ju3tisOlcrAMR24PuWbtu03zX48o+zF0zXKukN2dxOaKGfIvic9LGvFXxJ
         9pF1k8zOAn2JowzEAz3FAd4RC4zgt3m2r2F0f9bunf6yuxP65qAQoGrSXKr2BlMhfgJ8
         eAaw==
X-Gm-Message-State: ANoB5pnOuySH8hcjxxuK5MavM4uPodV78bOYlpNyV4Y0wk4WkmlXXPHA
        OlwPIUsKjga4aQSqmTF83ejUDGVzf0Vszw==
X-Google-Smtp-Source: AA0mqf4ZOTkpPwcrRiipwOmfu515vzKyky7J2iwTDLaEfc0KHDP5AnyH/+dbzfdCq5JAwkCcRVg23A==
X-Received: by 2002:a17:906:be9:b0:78d:3e11:1036 with SMTP id z9-20020a1709060be900b0078d3e111036mr5794684ejg.76.1668771068179;
        Fri, 18 Nov 2022 03:31:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/12] tree-wide: chip away at USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Fri, 18 Nov 2022 12:30:54 +0100
Message-Id: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As 3/12 here notes we've been undergoing a sloooow migration away from
functions that provide "the_index" for you since 2007, with the last
major move away from some of them being in 2019.

This series has a large diffstat, but should be disproportionately
easy to review as I wrote almost none of the code: coccinelle did :)

I.e. after some trivial cleanup in 1-2/12 the C code changes in 3/12
are mostly generated from a new index-compatibility.cocci migration.

The commits that deviate from that are:

 * 04/12: Make a function that always returns "0" return "void"
   instead.

 * 09-10/12: Add a "USE_THE_INDEX_VARIABLE", for those leftover users
   that only need "the_index", but not the compatility macros.

 * 12/12: Manual follow-up to the cocci-applied 11/12.

The only exceptions to this are the changes to cache.h itself, and
moving things around in contrib/coccinelle/* as we can fully migrate
some things, so they move from a "pending" rule to a regular
coccinelle rule.

At the start of this the patch to migrate all of this would have been
~2k lines, after it's down to below ~1k.

I've carefully crafted this so that it doesn't have conflicts with
anything that's in-flight, or is likely to develop such conflicts (but
I could always get unlucky). If there are any the resolution should be
trivially validated by running the cocci rule on "theirs" and keeping
that version.

Branch & passing CI at:
https://github.com/avar/git/tree/avar/narrow-down-the-index-compatibilty-macros

Ævar Arnfjörð Bjarmason (12):
  cache.h: remove unused "the_index" compat macros
  builtin/{grep,log}.: don't define "USE_THE_INDEX_COMPATIBILITY_MACROS"
  cocci & cache.h: remove rarely used "the_index" compat macros
  read-cache API & users: make discard_index() return void
  cocci: add a index-compatibility.pending.cocci
  cocci & cache.h: apply a selection of "pending" index-compatibility
  cocci & cache.h: apply variable section of "pending"
    index-compatibility
  cocci: apply "pending" index-compatibility to "t/helper/*.c"
  {builtin/*,repository}.c: add & use "USE_THE_INDEX_VARIABLE"
  cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
  cocci: apply "pending" index-compatibility to some "builtin/*.c"
  builtin/*: remove or amend "USE_THE_INDEX_COMPATIBILITY_MACROS"

 add-interactive.c                             |  8 +-
 add-patch.c                                   |  3 +-
 builtin/add.c                                 | 21 ++---
 builtin/am.c                                  |  4 +-
 builtin/cat-file.c                            |  2 +-
 builtin/check-attr.c                          |  4 +-
 builtin/check-ignore.c                        |  4 +-
 builtin/checkout-index.c                      | 19 ++--
 builtin/checkout.c                            | 55 ++++++------
 builtin/clean.c                               |  6 +-
 builtin/clone.c                               |  4 +-
 builtin/commit.c                              | 20 ++---
 builtin/describe.c                            |  7 +-
 builtin/diff-files.c                          |  3 +-
 builtin/diff-index.c                          |  5 +-
 builtin/diff-tree.c                           |  4 +-
 builtin/difftool.c                            |  2 +-
 builtin/fsck.c                                | 16 ++--
 builtin/grep.c                                |  1 -
 builtin/log.c                                 |  1 -
 builtin/merge-index.c                         | 16 ++--
 builtin/merge-ours.c                          |  3 +-
 builtin/merge-tree.c                          |  2 +-
 builtin/merge.c                               | 13 +--
 builtin/mv.c                                  | 25 +++---
 builtin/pull.c                                |  6 +-
 builtin/read-tree.c                           |  6 +-
 builtin/rebase.c                              |  6 +-
 builtin/reset.c                               | 20 +++--
 builtin/rev-parse.c                           |  4 +-
 builtin/rm.c                                  | 18 ++--
 builtin/stash.c                               |  8 +-
 builtin/submodule--helper.c                   | 14 +--
 builtin/update-index.c                        | 72 +++++++--------
 cache.h                                       | 30 ++-----
 contrib/coccinelle/index-compatibility.cocci  | 87 +++++++++++++++++++
 .../index-compatibility.pending.cocci         | 78 +++++++++++++++++
 read-cache.c                                  |  4 +-
 repository.c                                  |  2 +-
 sequencer.c                                   | 15 ++--
 t/helper/test-dump-cache-tree.c               |  5 +-
 t/helper/test-dump-split-index.c              |  1 +
 t/helper/test-dump-untracked-cache.c          |  4 +-
 t/helper/test-fast-rebase.c                   |  4 +-
 t/helper/test-lazy-init-name-hash.c           | 21 ++---
 t/helper/test-read-cache.c                    |  5 +-
 t/helper/test-scrap-cache-tree.c              |  9 +-
 t/helper/test-write-cache.c                   |  6 +-
 48 files changed, 417 insertions(+), 256 deletions(-)
 create mode 100644 contrib/coccinelle/index-compatibility.cocci
 create mode 100644 contrib/coccinelle/index-compatibility.pending.cocci

-- 
2.38.0.1511.gcdcff1f1dc2

