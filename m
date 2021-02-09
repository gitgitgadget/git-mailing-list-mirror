Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C31C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DF764E3C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhBIW1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhBIWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE7C0698E6
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so77738wmz.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DPs8/wF5GnZtOnKxrKbtQVmaZcMBZy+PSXWaJr6Tkk=;
        b=QCDHef6W2Tic0fFWbmJKZ1PNwsc9rhUkmQIiW4xRIn7eaYrUFqxRsjJBEjqOKszoMv
         52EPi9cSmarq9ivNNwyreq43uvMs1x0EqhufTP6NSVvIf4kfJ5QJ5wmNJswusha8QJny
         Kn8FU817EzoIFamErp/rzHBV2sWvFOY8GFRJqynaHBzhw3m3+81MQ2cfKk9FUyyWIs3U
         ugXR9gijXsK6dtdmuH+EZVOBl0R8+zvGgm9MfeYi0g8qC6ppjEbOip+JgEpBLgyPyzeR
         sx27HsvcoUQ51wuP/W8FG059nJpSVO+fpxjOmXGMcf7GuNQqFO6EAkla40SUopJli3x3
         mofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DPs8/wF5GnZtOnKxrKbtQVmaZcMBZy+PSXWaJr6Tkk=;
        b=nYPUNJ4E80Q5ao3w3MOoqL1mJLt76pAqka54/n+MZNbeJuPCAcosAt6DthydamTNiX
         Lksp3RkivpRgYwGcphnBcG04fTEg2ZSz9isCMXDaWyDWMFKoJxXeCPtuuvlmGAlfK6p3
         dVHyY6CmRFe1/RTj4qRKgreUHKYKfnmIgkURFgepwBEVY74GR/9OqoZlAltKjhS/CZZX
         kcV60KrfYsXO4Y3k6cslEorkPPvPm6VbaZo+n/i/SWCwW4aQO8mWtYe6msPYIZlPn9eZ
         kBf3J0QAzxRumr1LMutjksRoKSCeGVWJ2mv8fWHmCIaJExCOXvxNc/+yU1SZN2J7iurK
         B8jg==
X-Gm-Message-State: AOAM533ckOMsNIlF7BaGkCU2bcASuJFHbI1RiLAvN7BXadKBpIJFb4te
        UrONlIUyo6xKx9Q6qR2otuKNr5460hPoSA==
X-Google-Smtp-Source: ABdhPJxrn528xbFP/+oI++tOzeaRKpyK6RoLyDcMRPddcVb1LPOh2ghIRBcniU5dkhv+kGFIi8tt9Q==
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr95260wmq.67.1612906931730;
        Tue, 09 Feb 2021 13:42:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/12] test-lib: misc improvements
Date:   Tue,  9 Feb 2021 22:41:47 +0100
Message-Id: <20210209214159.22815-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various miscellaneous small and easy to review cleanups & fixes to the
test libraries. This doesn't conflict with the current "seen" branch.

Ævar Arnfjörð Bjarmason (12):
  test-lib: remove check_var_migration
  test lib: change "error" to "BUG" as appropriate
  test-lib-functions: move test_set_index_version() to its user
  test-lib-functions: remove generate_zero_bytes() wrapper
  test libs: rename bundle helper to "lib-bundle.sh"
  test libs: rename gitweb-lib.sh to lib-gitweb.sh
  test-lib-functions: move function to lib-bitmap.sh
  t/.gitattributes: sort lines
  test libs: rename "diff-lib" to "lib-diff"
  test-lib-functions: remove bug-inducing "diagnostics" helper param
  test-lib-functions: assert correct parameter count
  test-lib-functions: split out {debug,path,text} helpers

 t/.gitattributes                              |   4 +-
 t/README                                      |   8 +-
 t/lib-bitmap.sh                               |  26 ++
 t/{test-bundle-functions.sh => lib-bundle.sh} |   0
 t/{diff-lib.sh => lib-diff.sh}                |   0
 t/{diff-lib => lib-diff}/COPYING              |   0
 t/{diff-lib => lib-diff}/README               |   0
 t/{gitweb-lib.sh => lib-gitweb.sh}            |   0
 t/t2104-update-index-skip-worktree.sh         |   5 +
 t/t3404-rebase-interactive.sh                 |   3 +-
 t/t4000-diff-format.sh                        |   2 +-
 t/t4001-diff-rename.sh                        |   2 +-
 t/t4003-diff-rename-1.sh                      |   6 +-
 t/t4004-diff-rename-symlink.sh                |   2 +-
 t/t4005-diff-rename-2.sh                      |   6 +-
 t/t4007-rename-3.sh                           |   6 +-
 t/t4008-diff-break-rewrite.sh                 |   6 +-
 t/t4009-diff-rename-4.sh                      |   6 +-
 t/t4010-diff-pathspec.sh                      |   2 +-
 t/t4011-diff-symlink.sh                       |   2 +-
 t/t4013-diff-various.sh                       |   2 +-
 t/t4015-diff-whitespace.sh                    |   2 +-
 t/t4027-diff-submodule.sh                     |   2 +-
 t/t4034-diff-words.sh                         |   2 +-
 t/t4038-diff-combined.sh                      |   2 +-
 t/t4061-diff-indent.sh                        |   2 +-
 t/t4206-log-follow-harder-copies.sh           |   2 +-
 t/t5310-pack-bitmaps.sh                       |   2 +
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5510-fetch.sh                              |   2 +-
 t/t6020-bundle-misc.sh                        |   2 +-
 t/t6113-rev-list-bitmap-filters.sh            |   1 +
 t/t6426-merge-skip-unneeded-updates.sh        |  16 +-
 t/t6500-gc.sh                                 |   4 +-
 t/t7501-commit-basic-functionality.sh         |   2 +-
 t/t9300-fast-import.sh                        |   2 +-
 t/t9500-gitweb-standalone-no-errors.sh        |   2 +-
 t/t9501-gitweb-standalone-http-status.sh      |   2 +-
 t/t9502-gitweb-standalone-parse-output.sh     |   2 +-
 t/test-lib-functions.sh                       | 305 +-----------------
 t/test-lib-functions/debug.sh                 |  99 ++++++
 t/test-lib-functions/path.sh                  | 137 ++++++++
 t/test-lib-functions/text.sh                  |  33 ++
 t/test-lib.sh                                 |  30 --
 44 files changed, 370 insertions(+), 373 deletions(-)
 create mode 100644 t/lib-bitmap.sh
 rename t/{test-bundle-functions.sh => lib-bundle.sh} (100%)
 rename t/{diff-lib.sh => lib-diff.sh} (100%)
 rename t/{diff-lib => lib-diff}/COPYING (100%)
 rename t/{diff-lib => lib-diff}/README (100%)
 rename t/{gitweb-lib.sh => lib-gitweb.sh} (100%)
 create mode 100644 t/test-lib-functions/debug.sh
 create mode 100644 t/test-lib-functions/path.sh
 create mode 100644 t/test-lib-functions/text.sh

-- 
2.30.0.284.gd98b1dd5eaa7

