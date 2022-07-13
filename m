Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F145FC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiGMNQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGMNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37BB1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h17so15522067wrx.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IScznUx4LvfZowGng97p3qbQ72IzldFnlyuIVbZzCX8=;
        b=ozMX8qxuhZLqwNo8qz7O9PSFViT7Z5VPmGmXJ/IdbpwB11e7E/GPlaL6VHGuiIGpd8
         I0N0+AS//i9/kMY7HdsLeoYUqvvs/5CFo0IoasgZi0lwiMmg/BEqWK4oYkt+M1IVxy8y
         CSo51Sx+587YlzwHiUFyAAqDFvoNgTDMsi9iFMykNCyCIB7EAkQ24FkJvGuf059o/0wU
         rp9zeRllUF6Y+lFRcVcvRVGfJf/FuN4hpKFEgGP4A4lh71i4X2++zQQ2mNhz1Jy6wE7i
         pNXGxpGnGp31BSw/SwyFn2XxZ0WPbMmahN/nb8f6CNOu1ood9zip6waYV++TeMv+y1zH
         a/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IScznUx4LvfZowGng97p3qbQ72IzldFnlyuIVbZzCX8=;
        b=EbxzMMmKqP/+hLd1vfjneNz51sMXIO8B4I2/u6zlfByxWcv2zn5FlZmGvCY5yGXY2+
         wGisI0gD+mLL320oz81WLfER+ueZpm51lUR7JInIas24Rc0MLFTGK4l9R3cv0AKUQ8TU
         9XAAACizN2++PI+8XAiMEkko6XKrMklpRfuI6do+/0ddNSDTJ8X57HEwEa6uV7f8pddU
         DpNFeyLTonCS8nF2QDbpDLZrhYLOoQ89ziPUosFPJn1Ay/LSLNdmM8OHEiebLWjEs83M
         hQ+bd16q3xX+X82v5rxoRrjuvJQXWdjbDlZRJuTNQuTM7GI3qD/VTxqPIcR5AUbK2y15
         NoZQ==
X-Gm-Message-State: AJIora87YSVXESrWJVG427WOoNiqT0zUJAsqHkf6WHwfOM2bwM/nSSEM
        2QuhuGIo/wfUNAuEZR/STNXLDhzPRzkcsw==
X-Google-Smtp-Source: AGRyM1vWvxez/6HlsPtFPDY6aE44SXUfFuhy4YpYjTAJ2CWxNGPuQXPfvD8v0lm5pwEfCe00xt5R6g==
X-Received: by 2002:adf:f78b:0:b0:21d:6fef:f4e1 with SMTP id q11-20020adff78b000000b0021d6feff4e1mr3318901wrp.92.1657718184573;
        Wed, 13 Jul 2022 06:16:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/11] submodule--helper: fix memory leaks
Date:   Wed, 13 Jul 2022 15:16:05 +0200
Message-Id: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes most of the memory leaks in
builtin/submodule--helper.c, it needs to go on top of
gc/submodule-use-super-prefix (which in turn goes on top of my
ab/submodule-cleanup.

I'm planning to submit the patches to "git rm git-submodule.sh" after
this series, but fixing these leaks gives us a much better foundation
for doing so.

I.e. we'll eventually want to have this code invoke itself without
needing run_command(), and being able to have clear lifecycle
management of the data it uses makes it possible to eventually call
the relevant code as a utility function instead.

Ævar Arnfjörð Bjarmason (11):
  submodule.c: free() memory from xgetcwd()
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: fix "module_clone_data" memory leaks
  submodule--helper: fix "struct pathspec" memory leaks
  submodule--helper: free() leaking {run,capture}_command() argument
  submodule--helper: add and use *_release() functions
  submodule--helper: fix "errmsg_str" memory leak
  submodule--helper: fix "sm_path" and other "module_cb_list" leaks
  submodule--helper: free "char *" in "struct update_data"
  submodule--helper: fix a leak with repo_clear()
  submodule--helper:fix "reference" leak is "module_clone_data"

Ævar Arnfjörð Bjarmason (11):
  submodule.c: free() memory from xgetcwd()
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: fix "module_clone_data" memory leaks
  submodule--helper: fix "struct pathspec" memory leaks
  submodule--helper: free() leaking {run,capture}_command() argument
  submodule--helper: add and use *_release() functions
  submodule--helper: fix "errmsg_str" memory leak
  submodule--helper: fix "sm_path" and other "module_cb_list" leaks
  submodule--helper: free "char *" in "struct update_data"
  submodule--helper: fix a leak with repo_clear()
  submodule--helper: fix "reference" leak is "module_clone_data"

 builtin/submodule--helper.c        | 260 ++++++++++++++++++++++-------
 submodule.c                        |   3 +-
 t/t2403-worktree-move.sh           |   1 +
 t/t6008-rev-list-submodule.sh      |   1 +
 t/t6134-pathspec-in-submodule.sh   |   1 +
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 9 files changed, 207 insertions(+), 65 deletions(-)

-- 
2.37.0.932.g7b7031e73bc

