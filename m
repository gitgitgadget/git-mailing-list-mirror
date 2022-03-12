Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB71CC433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiCLAJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCLAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:09:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9B226C37
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k24so15221519wrd.7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iEAz3zZwGccgQzt5TASS7taHdCMoJf5ZX+beHwlPy2A=;
        b=S18GgJ+s2idqZqo2l+kekuoSMdkqIDEP8iD/asjfn0g5HyabcsJGXNfXfrXr/9X37y
         tA/18EYGQYAqcIKXik5YBjDlOefc4N3BrLxAwFnE9hQhnpnHvCRS1Z5/7ZbV+AxbcNf+
         VEMYdu8qHt7tp0cZki+Yw9O7iAPvfeGrTA8Vc1YmGnLkR7gZpU3JW6PTH+WSP/dJQLyo
         U6XWgarNMVrzSdHYkPgw57G9XsRivzR2zP2k9Rn96Kb2Y/BkG9m1Zg3bvM/LbeRc5y3r
         j1gLZYL84ia0YE479BC/wUYfOjU0WRwUYkc56L+YKkyRT2UsMAsW9yZrW4T4qS0g3AI/
         H22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iEAz3zZwGccgQzt5TASS7taHdCMoJf5ZX+beHwlPy2A=;
        b=Gu1ALct57FFMvXHREMMPq0ZIWKjNagYJyGPWUdowZsV4zhImxjr70UM/fr6up39Kl1
         Hg4RcYU2Hv2URqsm9BvyB9mMvd7pW5RcRErLVNItn6UgcIUgJslhVzha5ij8eCwn0pp1
         ogd1orNBVruEOtBj0Dyv9oWWz9ox47TGjXJ6tECNOXVPiq804z9pi2xix5xOVyQf/FaJ
         IA0cG84wSg4B7YtUcrlq7LBEo5U8zL1LHo6E2TSnoocVZ0li6jpBXiYxh9B+Mzm83oh4
         3Ae9B2dyDHEpdvjr8b1I1/WDtQx3rxOgr0b7aA4yCHIfcAz2hSH3/BaTFnTZEdIaoJFb
         Lfvw==
X-Gm-Message-State: AOAM533ugBLZe4sWDYuO+DXk2GPHQP9X59qvMinLkU1R0Pmvk2XyFBIB
        wfQFXxBJh7zDJKXuujW/d67V1EDo3Q8=
X-Google-Smtp-Source: ABdhPJzM7l3V0YmzqR1UwdbMk6zmoTv0NFogUzY7NdBn0ADljFhNCqitBm0IKTpsO8r6L3Inp1wDBw==
X-Received: by 2002:a05:6000:15cb:b0:1f1:e283:fcc0 with SMTP id y11-20020a05600015cb00b001f1e283fcc0mr8853819wry.18.1647043731020;
        Fri, 11 Mar 2022 16:08:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm7575769wrx.47.2022.03.11.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:50 -0800 (PST)
Message-Id: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:44 +0000
Subject: [PATCH 0/5] Separate '--skip-refresh' from '--quiet' in 'reset', use '--quiet'
 internally in 'stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the process of working on tests for 'git stash' sparse index integration,
I found that the '--quiet' option in 'git stash' does not suppress all
non-error output when used with '--index'. Specifically, this comes from an
invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
enabling that flag, though, I discovered that 1) 'reset' does not refresh
the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
index to be refreshed after the reset.

This series aims to decouple the "suppress logging" and "skip index refresh"
behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
with logs suppressed but index refresh enabled. This is accomplished by
introducing the '--[no-]refresh' option and 'reset.refresh' config setting
to 'git reset'. Additionally, in the spirit of backward-compatibility,
'--quiet' and/or 'reset.quiet=true' without any specified "refresh"
option/config will continue to skip 'refresh_index(...)'.

There are also some minor updates to the advice that suggests skipping the
index refresh:

 * replace recommendation to use "--quiet" with "--no-refresh"
 * use 'advise()' rather than 'printf()'
 * rename the advice config setting from 'advice.resetQuiet' to to
   'advice.resetNoRefresh'
 * suppress advice if '--quiet' is specified in 'reset'

Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
no longer prints extraneous logs.

[1] https://lore.kernel.org/git/20181023190423.5772-2-peartben@gmail.com/

Thanks! -Victoria

Victoria Dye (5):
  reset: revise index refresh advice
  reset: introduce --[no-]refresh option to --mixed
  reset: replace '--quiet' with '--no-refresh' in performance advice
  reset: suppress '--no-refresh' advice if logging is silenced
  stash: make internal resets quiet and refresh index

 Documentation/config/advice.txt |  8 +--
 Documentation/git-reset.txt     |  9 ++++
 advice.c                        |  2 +-
 advice.h                        |  2 +-
 builtin/reset.c                 | 21 ++++++--
 builtin/stash.c                 |  5 +-
 t/t3903-stash.sh                | 12 +++++
 t/t7102-reset.sh                | 95 ++++++++++++++++++++++++++++++---
 8 files changed, 134 insertions(+), 20 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1170%2Fvdye%2Fstash%2Fmake-reset-quiet-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1170/vdye/stash/make-reset-quiet-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1170
-- 
gitgitgadget
