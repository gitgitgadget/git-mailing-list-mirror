Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD9ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 15:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJ1PYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJ1PYN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 11:24:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623F20B139
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y10so3435315wma.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt21GnXuwG7gOAIDsl41TyX124NYoVgZAXv0NYbOas0=;
        b=SJ2WGBtAKgp0PMFrFrVUaPlpSAQuiKQ2WPMHpuOGi8bwZZDY5BedcODVAq1CYqklBM
         z6g21Yjpr2RPRiO5oqTRgwqjPmZfVUKaNGCLlu8skBy2zqAoLiwqzRgVGxfx7kdJnYVp
         9Yomf+xypgSkUsIdkyySRgrcwHSmDhUFYDiGBl4G0tetlTa8mkBFlbcooEUJzn8JO1WR
         E77gWwpUGGtadrsG7SqTFMBVSiFYxerS87sGkhFSZiSD4kxcGKPLba7A23+c+oyClPGN
         8uzRAdCxxnkgtwTpAmzQ0MuiqFXlAvp1LfzRTQCfIYvPMVM4xIxNUR1c4SQGclHORa15
         gFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gt21GnXuwG7gOAIDsl41TyX124NYoVgZAXv0NYbOas0=;
        b=RNJmXp56vkYIE2Teqry+Kg0F8klq370B7EVDPNn/zMVPLa7IYhVOwrlCB3Yq7z6bMM
         4Ars7mhwCyAXGcTzAD8Gk7Tcwm2dH0HX9wicNPpR79k0qDYAGJ2Sp6Cyo2LKmUwIFbGN
         Ps9yfrl1KTRK64UDXY8WlvJt4zuraQpSmH7BEnBWyaPzvgOJlrqdazMOAlkUrOenzlJc
         Su6jWObW50t6hKkQq5EOkoudVfoQFVsLLUbGC9eCspngFiw88qbapx1IyxJmoejHDV7u
         xt5lwLJImd0b/tyUWbbfqazyEoziNAsWIAemYAS9n/0wJjUJy3/FJ7XvL0A8ivDxcBPh
         70ug==
X-Gm-Message-State: ACrzQf085OwKyNDz443fUn5wfz8RsyneyPs51dnQobE2ePNoFUuEd8Hp
        Bsb/yyWYZFSq/ZhkDW1PGPx2+bpdD+c=
X-Google-Smtp-Source: AMsMyM4QSyOrOS0DDenyqywrCN8Z/PKB4DnoIzSwochFUEHEIHp/bVKBAP0e3cNCKW7mcJ3msBxhaw==
X-Received: by 2002:a05:600c:2212:b0:3cf:6068:3c40 with SMTP id z18-20020a05600c221200b003cf60683c40mr2058938wml.57.1666970646583;
        Fri, 28 Oct 2022 08:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003a3442f1229sm7936726wmq.29.2022.10.28.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:24:05 -0700 (PDT)
Message-Id: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
From:   "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 15:24:03 +0000
Subject: [PATCH 0/2] Fix autocorrect in work tree for bare repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Simon Gerber <gesimu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, auto correction doesn't work reliably for commands which must run
in a work tree (e.g. git status) in Git work trees which are created from a
bare repository.

This patch series adds a test case illustrating the issue and proposes a fix
which adjusts the usage of read_early_config() in help_unknown_cmd() to
match other usages of read_early_config(). In particular the patch removes
the call to git_default_config() in the read config callback.

Simon Gerber (2):
  tests: add test case for autocorrect in work tree for bare clone
  help.c: don't call git_default_config in git_unknown_cmd_config

 help.c                               |  2 +-
 t/t9005-help-autocorrect-worktree.sh | 29 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 t/t9005-help-autocorrect-worktree.sh


base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1373%2Fsimu%2Ffix%2Fautocorrect-bare-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1373/simu/fix/autocorrect-bare-worktree-v1
Pull-Request: https://github.com/git/git/pull/1373
-- 
gitgitgadget
