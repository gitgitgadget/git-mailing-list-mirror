Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA217C433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D3464E57
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhBLNaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhBLNag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:30:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728BC061756
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l17so939950wmq.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TrGl6upHR7Imypki21toDwzOQT8ac6exrCLR9VQTgc=;
        b=VM/ZfqJZ7i41dvBAATntz4OAZZSQ+P7+OT02AUlcUaS2MLtiMsExK3/6vHaYWX2BFE
         Do+Vncc4eircj7rCkOvLcLhzH1DCEDaiUQQoaeztGyPaW3vN9d70KmjgtJDwQ3Pua15X
         y3mlPbH50S+1I69Ccz9sPjATzZ2Vwc31Y/mwR4TnQqykcrag2uzxwtW4kORjtb/BHdUk
         owu1Gd0QyEflI3qUcJVPuq65rhIQw7EYZB6DDBBH+jFlXdNWDyrfBxRwpZlt2EQOpl8R
         Mh5m7u02WB4sJ5ztbDbR/7fFpxqU3K/84PJttl32RMW65ZlsU7fH/TGvxmjTTOq/5vFL
         DX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TrGl6upHR7Imypki21toDwzOQT8ac6exrCLR9VQTgc=;
        b=M1nEsI5XZ6Gw5MiJzWqF4+evmU2QlzDQQ9Fz+eay0iJ6S+NU45GKjWSPh4NUtwAe7x
         jlpULJRjGXL4B2M9K5TEilvOfOzdCdxPFI8X6U5DpI5dwOQVbCjDTHGK4uWfHP5FCBpa
         +XWCyUbX0A1GPWEVfE7lZIhzuh43Jbp4Yxh+It636z34/MmO8G+ze0WVBvbCjViPOhcg
         Lz7JSWKb6pyA1NNlHqDylxMiq72KRK0gbepePZoi3Or+8zfRpewGxmtZwRVS+9xLtGzk
         BAHQNplY8Lo5I6mwXyFPmrx6krxyAnCuDeSr5xdyWEAopeB93ueZdErVQpJyqGt/I+/D
         848w==
X-Gm-Message-State: AOAM5331xVPXT4OWpctgev50UF/jtqvVEQXrwlq0uvJwaebMCO6MXMcY
        MtjSYFwsuy75EP45sKPWPIZ40Gkq69WvIg==
X-Google-Smtp-Source: ABdhPJx/u4f2q4U1qAkUQEYDaEVam8UtCB4scsr5Hw5dNqhn6vyoFIwjkHnOMYOjl8QkmFwIH0e5Ng==
X-Received: by 2002:a1c:113:: with SMTP id 19mr2724569wmb.7.1613136594838;
        Fri, 12 Feb 2021 05:29:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] test-lib: misc improvements
Date:   Fri, 12 Feb 2021 14:29:31 +0100
Message-Id: <20210212132942.17325-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed a missing SOB and dropped the 12th patch.

Ævar Arnfjörð Bjarmason (11):
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

 t/.gitattributes                              |  4 +-
 t/README                                      |  8 +--
 t/lib-bitmap.sh                               | 26 ++++++++
 t/{test-bundle-functions.sh => lib-bundle.sh} |  0
 t/{diff-lib.sh => lib-diff.sh}                |  0
 t/{diff-lib => lib-diff}/COPYING              |  0
 t/{diff-lib => lib-diff}/README               |  0
 t/{gitweb-lib.sh => lib-gitweb.sh}            |  0
 t/t2104-update-index-skip-worktree.sh         |  5 ++
 t/t3404-rebase-interactive.sh                 |  3 +-
 t/t4000-diff-format.sh                        |  2 +-
 t/t4001-diff-rename.sh                        |  2 +-
 t/t4003-diff-rename-1.sh                      |  6 +-
 t/t4004-diff-rename-symlink.sh                |  2 +-
 t/t4005-diff-rename-2.sh                      |  6 +-
 t/t4007-rename-3.sh                           |  6 +-
 t/t4008-diff-break-rewrite.sh                 |  6 +-
 t/t4009-diff-rename-4.sh                      |  6 +-
 t/t4010-diff-pathspec.sh                      |  2 +-
 t/t4011-diff-symlink.sh                       |  2 +-
 t/t4013-diff-various.sh                       |  2 +-
 t/t4015-diff-whitespace.sh                    |  2 +-
 t/t4027-diff-submodule.sh                     |  2 +-
 t/t4034-diff-words.sh                         |  2 +-
 t/t4038-diff-combined.sh                      |  2 +-
 t/t4061-diff-indent.sh                        |  2 +-
 t/t4206-log-follow-harder-copies.sh           |  2 +-
 t/t5310-pack-bitmaps.sh                       |  2 +
 t/t5318-commit-graph.sh                       |  2 +-
 t/t5510-fetch.sh                              |  2 +-
 t/t6020-bundle-misc.sh                        |  2 +-
 t/t6113-rev-list-bitmap-filters.sh            |  1 +
 t/t6426-merge-skip-unneeded-updates.sh        | 16 +++--
 t/t6500-gc.sh                                 |  4 +-
 t/t7501-commit-basic-functionality.sh         |  2 +-
 t/t9300-fast-import.sh                        |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh        |  2 +-
 t/t9501-gitweb-standalone-http-status.sh      |  2 +-
 t/t9502-gitweb-standalone-parse-output.sh     |  2 +-
 t/test-lib-functions.sh                       | 62 +++++--------------
 t/test-lib.sh                                 | 30 ---------
 41 files changed, 107 insertions(+), 124 deletions(-)
 create mode 100644 t/lib-bitmap.sh
 rename t/{test-bundle-functions.sh => lib-bundle.sh} (100%)
 rename t/{diff-lib.sh => lib-diff.sh} (100%)
 rename t/{diff-lib => lib-diff}/COPYING (100%)
 rename t/{diff-lib => lib-diff}/README (100%)
 rename t/{gitweb-lib.sh => lib-gitweb.sh} (100%)

Range-diff:
 1:  422ffbfd16a =  1:  5243499bf03 test-lib: remove check_var_migration
 2:  47b4bf0e49d =  2:  aa67ff1e6b9 test lib: change "error" to "BUG" as appropriate
 3:  e8cb488e124 =  3:  56cff1fb482 test-lib-functions: move test_set_index_version() to its user
 4:  d4ef2a8fd5b =  4:  8960a2578da test-lib-functions: remove generate_zero_bytes() wrapper
 5:  9a164f4d49b =  5:  8bb54931234 test libs: rename bundle helper to "lib-bundle.sh"
 6:  d91be650b42 =  6:  a72b1d02225 test libs: rename gitweb-lib.sh to lib-gitweb.sh
 7:  0ffc90200f8 =  7:  ab8769ca71f test-lib-functions: move function to lib-bitmap.sh
 8:  57a258c1414 =  8:  0dfe871261d t/.gitattributes: sort lines
 9:  843a8718658 !  9:  ffde3c43099 test libs: rename "diff-lib" to "lib-diff"
    @@ Commit message
         commits there is no remaining t/*lib* which doesn't follow the
         convention of being called t/lib-*.
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## t/.gitattributes ##
     @@
      t[0-9][0-9][0-9][0-9]/* -whitespace
10:  65b2a41a784 = 10:  ea732f64704 test-lib-functions: remove bug-inducing "diagnostics" helper param
11:  9424b533f02 = 11:  3932ed40712 test-lib-functions: assert correct parameter count
12:  c649939196d <  -:  ----------- test-lib-functions: split out {debug,path,text} helpers
-- 
2.30.0.284.gd98b1dd5eaa7

