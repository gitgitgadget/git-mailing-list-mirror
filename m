Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7F3C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9696137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhJSLlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhJSLlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448AC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t7so4635607pgl.9
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZNF28RzbzMMZMFip6ABYjWUEXRKY2hpiC/NJrfkZA4=;
        b=j0KgaV7t+X1QlfoqvXzAb3S9kdcvMDlPwulZuv7+Q7DmUbRLBdhi1q6BlQldeMC3UT
         Lt9FJBXG4BLruSApkQ1+QrO5ZWbrOrlO/fvxiwntyhs55xjjILSfgT+jyW+dGGCGSSf9
         oyjeWeoZEldGM7TGUcDIKw2bWa4XMOI6pf8QG6lQCMe2oja4yUtgWlB6cGudfsezhrHv
         830RK0GV0MmVLWKFIPjfNINDBNWL0SBMH97RiISvmR2nORsHd4FWEFITt/efyM4GCyQ5
         PWqLIg8EpaxyLwFGBmqp/4DRIfnYJ1IdPkAdcE57v/DqS3hKgUILKeldvLByOc+sO+hZ
         G4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZNF28RzbzMMZMFip6ABYjWUEXRKY2hpiC/NJrfkZA4=;
        b=rcunYEykct7gwSdHF7svrKMrUEk42YOczLnV2CyNSsyDYaPgQ2ayVUbgccdaiPiKsJ
         ilqFJqZpIuNQERcNmom5XDLeykPr6Qw7jl+LHGjshbAmNnMT/Lc2Njbxc0j6lUoOfSiD
         po/tk+xg6sDHW27wm/vNbSjfVC6AxbTgWj+Oo3JcGvH+m5KSfAbL9TC1QZK9lUSY4sxA
         B97GI580A+/fSitLMo8m5Hg3ZM5wBK2/lD0ogiLLmnG5RPnhgaYsPuNmZ9Li77yOMRVn
         wXzOkOsWD0+76XogyL2MQsj7mWKfItdCd1Cm2I5J60G9dLRYS74LYKZwzpbobYocoXti
         g2sA==
X-Gm-Message-State: AOAM53364fM1299hbq78P7XiHLMYUUuawt/LVn9J+1h/HruQT1ozgcko
        J07gCZOeunuROVps51+h+TvGZWQOguc=
X-Google-Smtp-Source: ABdhPJxpQwYYwBkby7vKb5fNu6Pn0afD1qA2NH68Ldos4PCevSa1ttPhvpCrCtexOH4B2pcn1dZdmw==
X-Received: by 2002:a63:20f:: with SMTP id 15mr28016864pgc.319.1634643541705;
        Tue, 19 Oct 2021 04:39:01 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 00/12] packfile-uri: support excluding multiple object types 
Date:   Tue, 19 Oct 2021 19:38:24 +0800
Message-Id: <cover.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


About This Patch:
-----------------
This patch has almost no reuse of previous patch's commits, because this
one redesigned the exclusion for various object types and reoganized the
commits. 

Commit (1): objects.c: introduce `exclude_level` enum

This commit introduce a new enum named `exclude_level` in object.c, it
contains three enumerated values: "ET_SELF", "ET_INCLUDE" and
"ET_REACHABLE". The commit only makes the definitions, without any
implementations.

Commit (2): Introduce function `match_packfile_uri_exclusions`

This one move the codes used for matching the URI protocols from
`want_found_object` to new function `match_packfile_uri_exclusions`. The
purpose is to improve code readability related to the feature and make
preparation for further extension about the matching and exclusion for
multiple object types.

Commit (3): Replace `show_data` with structure `show_info`

There is no feature related codes in this commit. This commit modified
the parameters in function `show_object` by replacing `show_data` with a
new structure `show_info`, this is another way of implementation about
the previous commit[1] in patch v5.

Commit (4): Introduce `uploadpack.excludeobject` configuration

This commit introduce a new and backward-compatible configuration named
`uploadpack.excludeobject`, the diff between old and new: 

	uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>
        uploadpack.excludeobject=<object-hash> <level> <pack-hash> <uri>

The <level> is correspond to the exclusion scope of the given object,
and it's mentioned as `exclude_value` in object.c  by "Commit (1)".

Commit (6,8,10): Implementations for excluding commits, trees and tags

Commit (7,9,11): Tests for excluding excluding commits, trees and tags

Commit (12): Corresponding documentation modifications

bundle-uri And packfile-uri 
----------------------------

Ævar Arnfjörð Bjarmason post a new feature patchset[2] named "bundle-uri",
it supports to let client download the full or incremental bundles
directly without any negotiations with the server (full clone first and
in a MVP progress now). I'm sorry if I misleading the meanings and
please point it out.

In "packfile-uri", different with "bundle-uri", happens in the span of
packing objects during git-upload-pack on the server. This is an
experimental feature, originally designed as a CDN for large BLOB
objects, but it's not yet fully functional. I'm currently working on it
for making it support other types of objects.

I also noticed that some opinions about the two features are mentioned
in the patch[2], so I cc to Stolee in this patch, I hope I did not
disturb you.


[1] https://public-inbox.org/git/xmqqlf4oc4u1.fsf@gitster.g/
[2] https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

Teng Long (12):
  objects.c: introduce `exclude_level` enum
  Introduce function `match_packfile_uri_exclusions`
  Replace `show_data` with structure `show_info`
  Introduce `uploadpack.excludeobject` configuration
  t5702: test cases for `uploadpack.excludeobject`
  packfile-uri: support for excluding commits
  t5702: test cases for excluding commits
  packfile-uri: support for excluding trees
  t5702: test cases for excluding trees
  packfile-uri: support for excluding tags
  t5702: test cases for excluding tags
  packfile-uri.txt: support multiple object types

 Documentation/technical/packfile-uri.txt |  74 +-
 builtin/describe.c                       |   9 +-
 builtin/pack-objects.c                   | 236 +++++--
 builtin/rev-list.c                       |  11 +-
 bundle.c                                 |   5 +-
 list-objects.c                           |  74 +-
 list-objects.h                           |  11 +-
 object.c                                 |  21 +-
 object.h                                 |  16 +-
 pack-bitmap.c                            |  16 +-
 reachable.c                              |  11 +-
 revision.c                               |  47 +-
 revision.h                               |  12 +
 shallow.c                                |   4 +-
 t/t5702-protocol-v2.sh                   | 856 +++++++++++++++++++++--
 upload-pack.c                            |   7 +
 16 files changed, 1253 insertions(+), 157 deletions(-)

Range-diff against v5:
 1:  3a885678c9 =  1:  3a885678c9 objects.c: introduce `exclude_level` enum
 2:  36426b4d9f =  2:  36426b4d9f Introduce function `match_packfile_uri_exclusions`
 3:  dced036f89 =  3:  dced036f89 Replace `show_data` with structure `show_info`
 4:  b1d779b26a =  4:  b1d779b26a Introduce `uploadpack.excludeobject` configuration
 5:  f643db3c71 =  5:  f643db3c71 t5702: test cases for `uploadpack.excludeobject`
 6:  c29efeac21 =  6:  c29efeac21 packfile-uri: support for excluding commits
 7:  ca72efd22e =  7:  ca72efd22e t5702: test cases for excluding commits
 8:  c7a885ebec =  8:  c7a885ebec packfile-uri: support for excluding trees
 9:  5fc79a9a32 =  9:  5fc79a9a32 t5702: test cases for excluding trees
10:  16c41c40a2 = 10:  16c41c40a2 packfile-uri: support for excluding tags
11:  171ece533b = 11:  171ece533b t5702: test cases for excluding tags
12:  79fc2c23cf = 12:  79fc2c23cf packfile-uri.txt: support multiple object types
-- 
2.31.1.453.g945ddc3a74.dirty

