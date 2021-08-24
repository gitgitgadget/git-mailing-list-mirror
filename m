Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80CC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205FD613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhHXVzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhHXVzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB9C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u15so13670461wmj.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Pd8w+/Ucvd18VCxXVzwMpUFbKHbLetNkGKRWaLyZ6pw=;
        b=HIKQB7OJfwhdQZjP/ZIeBQiPIhbvlnXoE7gmtYX2ei1DNQh0alQDUyeLdCzq5iASr6
         dm8UDH4YWsBz4xpx3ujDW6IejGZjCr8LmVRmFB8AFFNVDn+x9O/DHHQyuHMBYGy03ahe
         Qt2osQCsJNhP0YstVqKyvQ/G1JWI1uLEpM074v95Ok5gEjhqli3cWTQBQVLTAQEU7i+O
         9Xo4v9vD7qsoheSU0x4ww948n/zIP2TWTqvWfQSoRC5to+AAXvNSFm43TGIYOPEJUbev
         OXJ9YXYIoTnwPECvrUKxyFTVl5m5Buqt20WBLpBE5Ixly6XpzavuPqaksyjwpM5XF3f7
         jmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pd8w+/Ucvd18VCxXVzwMpUFbKHbLetNkGKRWaLyZ6pw=;
        b=JYtcvtzpxh+yJi9Py3Maf1thJ8IusJ5jJLDMm+oEYRPYehDRxeNgU+kdr7vVQsQJNg
         7J6wrotJG3CC1l6a2Rit0VKZ8n7ZQ6sejK9Zxag9wl3y/CrhelIwll4Diyz5KZU6IX1g
         mR64dkobwZYJ0+b9IsiU3H0OLfChi3wp8RH/zgOtT2p169/uWW1npWGJXKrt2g0RnSw0
         J3Pl50fo97HYjeQ8vCMvflzGH/xTaUAxwQw6OC7ycBIHEcs8MBbzOC3YB9GBguh0fvux
         toa0U5FseqwGnNjMpvjSpmRJEZjeESKMJP4G+uuLSBXcHUtGTU7BimMin5YUNlYecJJk
         LaeA==
X-Gm-Message-State: AOAM531XwOHD6ilPBKdhDQFnNNSvJbdMMeLxIPeCxhgYHYwnSOmKBo1n
        ZzbC1ZB2hCxBGvxvWd4a1A4eZOlzJgI=
X-Google-Smtp-Source: ABdhPJxq1s7lPu6HCn5ngcEVBWQ1tnDRaUPPL70IEkN/yKXoWAp08FypAvMoPzEUGF2x13Fwg6QZBQ==
X-Received: by 2002:a1c:202:: with SMTP id 2mr6031729wmc.122.1629842086348;
        Tue, 24 Aug 2021 14:54:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm3492010wmk.8.2021.08.24.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:46 -0700 (PDT)
Message-Id: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:32 +0000
Subject: [PATCH 00/13] [RFC] Sparse-checkout: modify 'git add', 'git rm', and 'git add' behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As requested, this series looks to update the behavior of git add, git rm,
and git mv when they attempt to modify paths outside of the sparse-checkout
cone. In particular, this care is expanded to not just cache entries with
the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
definition.

This means that commands that worked before this series can now fail. In
particular, if 'git merge' results in a conflict outside of the
sparse-checkout cone, then 'git add ' will now fail.

In order to allow users to circumvent these protections, a new '--sparse'
option is added that ignores the sparse-checkout patterns and the
SKIP_WORKTREE bit. The message for advice.updateSparsePath is adjusted to
assist with discovery of this option.

There is a subtle issue with git mv in that it does not check the index
until it discovers a directory and then uses the index to find the contained
entries. This means that in non-cone-mode patterns, a pattern such as
"sub/dir" will not match the path "sub" and this can cause an issue.

In order to allow for checking arbitrary paths against the sparse-checkout
patterns, some changes to the underlying pattern matching code is required.
It turns out that there are some bugs in the methods as advertised, but
these bugs were never discovered because of the way methods like
unpack_trees() will check a directory for a pattern match before checking
its contained paths. Our new "check patterns on-demand" approach pokes holes
in that approach, specifically with patterns that match entire directories.

I'm open to alternative designs here, too.

The patches are based on v2 of the integration with merge, cherry-pick, and
rebase. I'm sending the RFC really early in case it needs to be
significantly reworked.

Thanks, -Stolee

Derrick Stolee (13):
  t1092: behavior for adding sparse files
  dir: extract directory-matching logic
  dir: select directories correctly
  dir: fix pattern matching on dirs
  add: fail when adding an untracked sparse file
  add: skip paths that are outside sparse-checkout cone
  add: implement the --sparse option
  add: prevent adding sparse conflict files
  rm: add --sparse option
  rm: skip sparse paths with missing SKIP_WORKTREE
  mv: refuse to move sparse paths
  mv: add '--sparse' option to ignore sparse-checkout
  advice: update message to suggest '--sparse'

 Documentation/git-add.txt                |   9 +-
 Documentation/git-rm.txt                 |   6 ++
 advice.c                                 |   3 +-
 builtin/add.c                            |  22 ++++-
 builtin/mv.c                             |  39 ++++++--
 builtin/rm.c                             |  10 +-
 dir.c                                    |  54 ++++++++--
 pathspec.c                               |   5 +-
 t/t1091-sparse-checkout-builtin.sh       |   4 +-
 t/t1092-sparse-checkout-compatibility.sh |  47 ++++++---
 t/t3602-rm-sparse-checkout.sh            |  27 ++++-
 t/t3705-add-sparse-checkout.sh           |  10 +-
 t/t7002-mv-sparse-checkout.sh            | 121 +++++++++++++++++++++++
 13 files changed, 316 insertions(+), 41 deletions(-)
 create mode 100755 t/t7002-mv-sparse-checkout.sh


base-commit: df4bbec744f5cd4a060082212d95a36b812fa50b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1018%2Fderrickstolee%2Fsparse-index%2Fadd-rm-mv-behavior-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1018/derrickstolee/sparse-index/add-rm-mv-behavior-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1018
-- 
gitgitgadget
