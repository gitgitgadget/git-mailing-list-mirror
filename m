Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF1C10F1E
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiLTMn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiLTMnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9351CFFD
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso8656380wmp.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/tDF5SsgqQFvRfiFTMNCJO40gjqJuLof4e8sV+HjLs=;
        b=D0hyCQzExaOHU/fu6Erp/czqNB5CIegg5O0kUhTswxiI+X220u7u/zivnnQic4hJOc
         QdZL/YNbRGeEfYfJftxwAxrgddLkzeCZz9CBfeUtvpYBImiNFUkfzpmOuL6een9xe7SR
         Zh8HGix2V56a3yDyVSR5Mw/vCW3ldq1FUKq6PTXc+X5OUQtOrFBnIepTHD0LPHVhoWvO
         YSd/EbnMS/KiDJaF8wHCFY3XRBg82KibqMM0NvqerULTD2PINWNGecZNV5lvddhE/Ac2
         KyCmTFfYuU0AoqlHaXZH6Sr7X/YJM34xxH2tk54ACrfU8/vNmEY3xDTRd2/WmSydKmjU
         8+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/tDF5SsgqQFvRfiFTMNCJO40gjqJuLof4e8sV+HjLs=;
        b=SvSjfeytMvdBRUiw0Wp2xFf72X1CDU0eHg1IHMxEiuIS5eKH6A8wnXXiA/MHSRQQBd
         e+8bnUu2Xy1BEwGgrAULAzT0mHkZFnX46MRAHJLY8EGboYfoyYB43mXoBzIAcMgzbeTT
         xQSnS13MgCU/ggRSv4aqMNcBScYizhcBUuUIASgS1WwQklwY/tR/Uw94q6UQFlnU8hov
         s9g07/lpWvc6cLKmnxaEfwALRNATPV75oucFGL+XS36PYWPYs23k2OXliv8d67C4oGg6
         87gygLZu5HUajcm7ohc++zRVEqYqyhhhGoJmq8if2hmPKGHXYI8dwOHl0Wmx7gAjmJRd
         nKZg==
X-Gm-Message-State: ANoB5pmcdRY8lezTzaIWG32Ked50eXHVpwkAPPqIdx8O0gDuq+0QrwyH
        cNXfDG1dKJ7C3EjLYl9PHBGS1NMavLnRvw==
X-Google-Smtp-Source: AA0mqf6ZZEv+uPWId/HYql41HrBv0pjajo1zE2+x97efKOBBTMdg1F9KUcTzKxoy/8leZos3+8PFLA==
X-Received: by 2002:a05:600c:538f:b0:3d1:d396:1ade with SMTP id hg15-20020a05600c538f00b003d1d3961ademr35340427wmb.9.1671540001549;
        Tue, 20 Dec 2022 04:40:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/9] Get rid of "git --super-prefix"
Date:   Tue, 20 Dec 2022 13:39:47 +0100
Message-Id: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a general summary see the v3's CL at
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com/

[Trivial] changes since v4:

 * Remove stray ad-hoc testing env variable from test.
 * s/passs/pass/ typo fix
 * Adjust commit message for the tests not checking relative paths anymore.

Branch & passing CI at:
https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local-5

Glen Choo (1):
  read-tree + fetch tests: test failing "--super-prefix" interaction

Ævar Arnfjörð Bjarmason (8):
  submodule absorbgitdirs tests: add missing "Migrating git..." tests
  submodule.c & submodule--helper: pass along "super_prefix" param
  submodule--helper: don't use global --super-prefix in "absorbgitdirs"
  submodule--helper: convert "foreach" to its own "--super-prefix"
  submodule--helper: convert "sync" to its own "--super-prefix"
  submodule--helper: convert "status" to its own "--super-prefix"
  submodule--helper: convert "{update,clone}" to their own
    "--super-prefix"
  read-tree: add "--super-prefix" option, eliminate global

 Documentation/git.txt              |  8 +--
 builtin.h                          |  4 --
 builtin/checkout.c                 |  2 +-
 builtin/read-tree.c                |  1 +
 builtin/rm.c                       |  2 +-
 builtin/submodule--helper.c        | 87 ++++++++++++++++--------------
 cache.h                            |  2 -
 entry.c                            | 12 ++---
 entry.h                            |  6 ++-
 environment.c                      | 13 -----
 git.c                              | 41 +++-----------
 parse-options.h                    |  4 ++
 submodule.c                        | 50 ++++++++---------
 submodule.h                        |  8 +--
 t/t1001-read-tree-m-2way.sh        |  2 +-
 t/t5616-partial-clone.sh           | 43 +++++++++++++++
 t/t7412-submodule-absorbgitdirs.sh | 64 +++++++++++++++++++---
 t/t7527-builtin-fsmonitor.sh       | 36 +++++--------
 unpack-trees.c                     | 24 +++++----
 unpack-trees.h                     |  1 +
 20 files changed, 230 insertions(+), 180 deletions(-)

Range-diff against v4:
 1:  f479003941b !  1:  f062cb2f265 submodule absorbgitdirs tests: add missing "Migrating git..." tests
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a
     +	'\''$cwd/repo-wt/sub2/.git'\'' to
     +	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
     +	EOF
    -+	DO_IT=1 git -C repo-wt submodule absorbgitdirs 2>actual &&
    ++	git -C repo-wt submodule absorbgitdirs 2>actual &&
     +	test_cmp expect actual
     +'
     +
 2:  6424307a432 =  2:  5fa05492b62 read-tree + fetch tests: test failing "--super-prefix" interaction
 3:  b2e543bde03 !  3:  3fb2a1b16cd submodule.c & submodule--helper: pass along "super_prefix" param
    @@ Commit message
         directly or by indirection. The exceptions are:
     
         - builtin/rm.c: Doesn't declare SUPPORT_SUPER_PREFIX, so we'd have
    -      died if this was provided, so it's safe to passs "NULL".
    +      died if this was provided, so it's safe to pass "NULL".
     
         - deinit_submodule(): The "deinit_submodule()" function has never been
           able to use the "git -super-prefix". It will call
           "absorb_git_dir_into_superproject()", but it will only do so from the
           top-level project.
     
    -      If "absorbgitdirs" recurses it will use the "path" passed to
    +      If "absorbgitdirs" recurses will use the "path" passed to
           "absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
           starting "--super-prefix". So we can safely remove the
           get_super_prefix() call here, and pass NULL instead.
 4:  bde9038c4e3 !  4:  0b30497f187 submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    @@ Commit message
         The "fsmonitor--daemon" test adjusted here was added in [3]. To assert
         that it didn't run into the "--super-prefix" message it was asserting
         the output it didn't have. Let's instead assert the full output that
    -    we *do* have, which we can do here as this is based on a change[4] to
    -    make it predictable (until [4] it contained absolute paths).
    +    we *do* have, using the same pattern as a preceding change to
    +    "t/t7412-submodule-absorbgitdirs.sh" used.
     
    -    We could also remove the test entirely (as [5] did), but even though
    +    We could also remove the test entirely (as [4] did), but even though
         the initial reason for having it is gone we're still getting some
         marginal benefit from testing the "fsmonitor" and "submodule
         absorbgitdirs" interaction, so let's keep it.
    @@ Commit message
     
         As we'll be changing the rest of the "git --super-prefix" users to the
         same pattern, leaving them all consistent makes sense. Why not pick ""
    -    over NULL? Because that's how the "prefix" works[6], and having
    +    over NULL? Because that's how the "prefix" works[5], and having
         "prefix" and "super_prefix" work the same way will be less
         confusing. That "prefix" picked NULL instead of "" is itself
         arbitrary, but as it's easy to make this small bit of our overall API
    @@ Commit message
            2022-05-26)
         3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
            2022-05-26)
    -    4. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
    -    5. https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com/
    -    6. 9725c8dda20 (built-ins: trust the "prefix" from run_builtin(),
    +    4. https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com/
    +    5. 9725c8dda20 (built-ins: trust the "prefix" from run_builtin(),
            2022-02-16)
     
         Signed-off-by: Glen Choo <chooglen@google.com>
 5:  4da58e7ea50 =  5:  13f1f0db07a submodule--helper: convert "foreach" to its own "--super-prefix"
 6:  8dff576df7d =  6:  ace2920ccff submodule--helper: convert "sync" to its own "--super-prefix"
 7:  8800a433e29 =  7:  1ccd1a57b64 submodule--helper: convert "status" to its own "--super-prefix"
 8:  54c1e29de1e =  8:  72e774ebb06 submodule--helper: convert "{update,clone}" to their own "--super-prefix"
 9:  4824f33224f =  9:  48ba8d4938c read-tree: add "--super-prefix" option, eliminate global
-- 
2.39.0.1071.g97ce8966538

