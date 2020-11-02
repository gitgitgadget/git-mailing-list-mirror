Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDFC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1C2084C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka+gEgU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgKBXzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgKBXzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:55:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E016C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:55:10 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so16526203wrp.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WWxbselzmMyXpO8ILk+JWT5uEumj71NzslNexNSK5Hs=;
        b=ka+gEgU77iVlz+KAbPLT4Z0aHTkZ8gRIiHmwKMKigJsbG2dz8AH1b+9a7Wz+xoXb8s
         /wpBVOwv9jWkidINRJE9MmGxBeO0hXOxaST0mVsa+/cuONIMmXkKpqlU4k91M5flCK5Z
         1+ufnUuNDNGQaNYsyb81lbkURQTgbiSV3OP0M4QCxy1hvPMw4HVyVEatRoSzb+oA1bwd
         L0WlkhGzpn/VtSCkVP2BIKYItVFyckXhqqp5/uND+cD5QG7ch8LRBQ0YpIC2Xw3bRvV2
         89nNFYtaXguDRTo8668Ct8G6r63F7TnAIDj5lY0zNYrgQgUoRPjUbW44L/pspN6ENQCA
         iH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WWxbselzmMyXpO8ILk+JWT5uEumj71NzslNexNSK5Hs=;
        b=neMJcTj5HXbqalTqXi+ohvH7SiHQKPA6dzOp6fZlSUIPJdr7ekO20JvuMUNIZ9ObQu
         uwbAF9+aviN0DuiJN0f9KakVZHoIHDwYnHNLvkozO+1IwtDTTyjk2HKu7PI+0p+Mn8BM
         SU5JR1zdGi9YOKOJjv1xz0ZkOW3n8wJ9mp7Rg6HQWpffIqKYiqCZd2VMUu0HurXGyGw9
         Ypv9AOhEteDv19ScZ47j6yMY+Cm1AtflkZf/JQzGqldxK0ZpZKYm9096QP2jQzOnVfBZ
         /m6ZaSK6+pHe26JnuqUZuaBBikg9n/sI9sTzdnatcdeSGkIRTC1pjOb4dsrz8wQ4zGYO
         sYqQ==
X-Gm-Message-State: AOAM530ayFZb1aCcG7VWlgvZyKwMZMIqeEyDyAb9X8ahw/xZxMfJdZhf
        Y6HUs/hhKA0XNLFReSDMT8uwOhPuyt8=
X-Google-Smtp-Source: ABdhPJzNLNA6iJry5PRlYVqCl6biixLZZf/XKnus6/YH5aJbkKuuveTQQWKYavdXCJWvp0/HsbgCqg==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr22550582wri.230.1604361308673;
        Mon, 02 Nov 2020 15:55:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm23824173wrp.52.2020.11.02.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:55:08 -0800 (PST)
Message-Id: <pull.761.git.1604361307.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:55:03 +0000
Subject: [PATCH 0/4]  Adjust t5515 for the upcoming change of the default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow for switching the default of init.defaultBranch to main, we adjust
the test script t5515 and its friends in t/t5515/. This is a large chunk of
modifications, but happily, most of them are a totally trivial
search-and-replace.

This patch series is part of the over-all effort tracked in 
https://github.com/gitgitgadget/git/pull/655.

Johannes Schindelin (4):
  t5515: use `main` as the name of the main branch for testing (part 1)
  t5515: use `main` as the name of the main branch for testing (part 2)
  t5515: use `main` as the name of the main branch for testing (part 3)
  t5515: use `main` as the name of the main branch for testing
    (conclusion)

 t/t5515-fetch-merge-logic.sh                  | 27 ++++++++++---------
 t/t5515/fetch.br-branches-default             |  4 +--
 t/t5515/fetch.br-branches-default-merge       |  4 +--
 ...br-branches-default-merge_branches-default |  4 +--
 t/t5515/fetch.br-branches-default-octopus     |  4 +--
 ...-branches-default-octopus_branches-default |  4 +--
 ...fetch.br-branches-default_branches-default |  4 +--
 t/t5515/fetch.br-branches-one                 |  2 +-
 t/t5515/fetch.br-branches-one-merge           |  2 +-
 .../fetch.br-branches-one-merge_branches-one  |  2 +-
 t/t5515/fetch.br-branches-one-octopus         |  2 +-
 ...fetch.br-branches-one-octopus_branches-one |  2 +-
 t/t5515/fetch.br-branches-one_branches-one    |  2 +-
 t/t5515/fetch.br-config-explicit              |  4 +--
 t/t5515/fetch.br-config-explicit-merge        |  4 +--
 ...h.br-config-explicit-merge_config-explicit |  4 +--
 t/t5515/fetch.br-config-explicit-octopus      |  4 +--
 ...br-config-explicit-octopus_config-explicit |  4 +--
 .../fetch.br-config-explicit_config-explicit  |  4 +--
 t/t5515/fetch.br-config-glob                  |  4 +--
 t/t5515/fetch.br-config-glob-merge            |  4 +--
 .../fetch.br-config-glob-merge_config-glob    |  4 +--
 t/t5515/fetch.br-config-glob-octopus          |  4 +--
 .../fetch.br-config-glob-octopus_config-glob  |  4 +--
 t/t5515/fetch.br-config-glob_config-glob      |  4 +--
 t/t5515/fetch.br-remote-explicit              |  4 +--
 t/t5515/fetch.br-remote-explicit-merge        |  4 +--
 ...h.br-remote-explicit-merge_remote-explicit |  4 +--
 t/t5515/fetch.br-remote-explicit-octopus      |  4 +--
 ...br-remote-explicit-octopus_remote-explicit |  4 +--
 .../fetch.br-remote-explicit_remote-explicit  |  4 +--
 t/t5515/fetch.br-remote-glob                  |  4 +--
 t/t5515/fetch.br-remote-glob-merge            |  4 +--
 .../fetch.br-remote-glob-merge_remote-glob    |  4 +--
 t/t5515/fetch.br-remote-glob-octopus          |  4 +--
 .../fetch.br-remote-glob-octopus_remote-glob  |  4 +--
 t/t5515/fetch.br-remote-glob_remote-glob      |  4 +--
 t/t5515/fetch.br-unconfig                     |  4 +--
 t/t5515/fetch.br-unconfig_--tags_.._.git      |  2 +-
 ....._.git_one_tag_tag-one_tag_tag-three-file |  2 +-
 ...._.git_tag_tag-one-tree_tag_tag-three-file |  2 +-
 ...unconfig_.._.git_tag_tag-one_tag_tag-three |  2 +-
 t/t5515/fetch.br-unconfig_branches-default    |  4 +--
 t/t5515/fetch.br-unconfig_branches-one        |  2 +-
 t/t5515/fetch.br-unconfig_config-explicit     |  4 +--
 t/t5515/fetch.br-unconfig_config-glob         |  4 +--
 t/t5515/fetch.br-unconfig_remote-explicit     |  4 +--
 t/t5515/fetch.br-unconfig_remote-glob         |  4 +--
 t/t5515/{fetch.master => fetch.main}          |  6 ++---
 ...tags_.._.git => fetch.main_--tags_.._.git} |  4 +--
 ...etch.master_.._.git => fetch.main_.._.git} |  2 +-
 ...ter_.._.git_one => fetch.main_.._.git_one} |  2 +-
 ...._.git_one_tag_tag-one_tag_tag-three-file} |  4 +--
 ...git_one_two => fetch.main_.._.git_one_two} |  2 +-
 ..._.git_tag_tag-one-tree_tag_tag-three-file} |  4 +--
 ...ch.main_.._.git_tag_tag-one_tag_tag-three} |  4 +--
 ...es-default => fetch.main_branches-default} |  6 ++---
 ...r_branches-one => fetch.main_branches-one} |  4 +--
 ...ig-explicit => fetch.main_config-explicit} |  6 ++---
 ...ter_config-glob => fetch.main_config-glob} |  6 ++---
 ...te-explicit => fetch.main_remote-explicit} |  6 ++---
 t/t5515/fetch.main_remote-glob                | 11 ++++++++
 t/t5515/fetch.master_remote-glob              | 11 --------
 t/t5515/refs.br-branches-default              |  6 ++---
 t/t5515/refs.br-branches-default-merge        |  6 ++---
 ...br-branches-default-merge_branches-default |  6 ++---
 t/t5515/refs.br-branches-default-octopus      |  6 ++---
 ...-branches-default-octopus_branches-default |  6 ++---
 .../refs.br-branches-default_branches-default |  6 ++---
 t/t5515/refs.br-branches-one                  |  4 +--
 t/t5515/refs.br-branches-one-merge            |  4 +--
 .../refs.br-branches-one-merge_branches-one   |  4 +--
 t/t5515/refs.br-branches-one-octopus          |  4 +--
 .../refs.br-branches-one-octopus_branches-one |  4 +--
 t/t5515/refs.br-branches-one_branches-one     |  4 +--
 t/t5515/refs.br-config-explicit               |  6 ++---
 t/t5515/refs.br-config-explicit-merge         |  6 ++---
 ...s.br-config-explicit-merge_config-explicit |  6 ++---
 t/t5515/refs.br-config-explicit-octopus       |  6 ++---
 ...br-config-explicit-octopus_config-explicit |  6 ++---
 .../refs.br-config-explicit_config-explicit   |  6 ++---
 t/t5515/refs.br-config-glob                   |  6 ++---
 t/t5515/refs.br-config-glob-merge             |  6 ++---
 t/t5515/refs.br-config-glob-merge_config-glob |  6 ++---
 t/t5515/refs.br-config-glob-octopus           |  6 ++---
 .../refs.br-config-glob-octopus_config-glob   |  6 ++---
 t/t5515/refs.br-config-glob_config-glob       |  6 ++---
 t/t5515/refs.br-remote-explicit               |  6 ++---
 t/t5515/refs.br-remote-explicit-merge         |  6 ++---
 ...s.br-remote-explicit-merge_remote-explicit |  6 ++---
 t/t5515/refs.br-remote-explicit-octopus       |  6 ++---
 ...br-remote-explicit-octopus_remote-explicit |  6 ++---
 .../refs.br-remote-explicit_remote-explicit   |  6 ++---
 t/t5515/refs.br-remote-glob                   |  6 ++---
 t/t5515/refs.br-remote-glob-merge             |  6 ++---
 t/t5515/refs.br-remote-glob-merge_remote-glob |  6 ++---
 t/t5515/refs.br-remote-glob-octopus           |  6 ++---
 .../refs.br-remote-glob-octopus_remote-glob   |  6 ++---
 t/t5515/refs.br-remote-glob_remote-glob       |  6 ++---
 t/t5515/refs.br-unconfig                      |  4 +--
 t/t5515/refs.br-unconfig_--tags_.._.git       |  4 +--
 t/t5515/refs.br-unconfig_.._.git              |  2 +-
 t/t5515/refs.br-unconfig_.._.git_one          |  2 +-
 ....._.git_one_tag_tag-one_tag_tag-three-file |  4 +--
 t/t5515/refs.br-unconfig_.._.git_one_two      |  2 +-
 ...._.git_tag_tag-one-tree_tag_tag-three-file |  4 +--
 ...unconfig_.._.git_tag_tag-one_tag_tag-three |  4 +--
 t/t5515/refs.br-unconfig_branches-default     |  6 ++---
 t/t5515/refs.br-unconfig_branches-one         |  4 +--
 t/t5515/refs.br-unconfig_config-explicit      |  6 ++---
 t/t5515/refs.br-unconfig_config-glob          |  6 ++---
 t/t5515/refs.br-unconfig_remote-explicit      |  6 ++---
 t/t5515/refs.br-unconfig_remote-glob          |  6 ++---
 ...g_tag-one_tag_tag-three-file => refs.main} |  4 +--
 ...ag-three-file => refs.main_--tags_.._.git} |  4 +--
 ...ster_.._.git_one_two => refs.main_.._.git} |  2 +-
 ...s.master_.._.git => refs.main_.._.git_one} |  2 +-
 ...._.git_one_tag_tag-one_tag_tag-three-file} |  4 +--
 ..._.._.git_one => refs.main_.._.git_one_two} |  2 +-
 ..._.git_tag_tag-one-tree_tag_tag-three-file} |  4 +--
 ...efs.main_.._.git_tag_tag-one_tag_tag-three | 11 ++++++++
 ...hes-default => refs.main_branches-default} |  6 ++---
 ...er_branches-one => refs.main_branches-one} |  4 +--
 ...fig-explicit => refs.main_config-explicit} |  6 ++---
 ...ster_config-glob => refs.main_config-glob} |  6 ++---
 ...ote-explicit => refs.main_remote-explicit} |  6 ++---
 ...ster_remote-glob => refs.main_remote-glob} |  6 ++---
 ...s.master_.._.git_tag_tag-one_tag_tag-three | 11 --------
 128 files changed, 308 insertions(+), 305 deletions(-)
 rename t/t5515/{fetch.master => fetch.main} (78%)
 rename t/t5515/{fetch.master_--tags_.._.git => fetch.main_--tags_.._.git} (81%)
 rename t/t5515/{fetch.master_.._.git => fetch.main_.._.git} (73%)
 rename t/t5515/{fetch.master_.._.git_one => fetch.main_.._.git_one} (74%)
 rename t/t5515/{fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file => fetch.main_.._.git_one_tag_tag-one_tag_tag-three-file} (77%)
 rename t/t5515/{fetch.master_.._.git_one_two => fetch.main_.._.git_one_two} (83%)
 rename t/t5515/{fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file => fetch.main_.._.git_tag_tag-one-tree_tag_tag-three-file} (74%)
 rename t/t5515/{fetch.master_.._.git_tag_tag-one_tag_tag-three => fetch.main_.._.git_tag_tag-one_tag_tag-three} (75%)
 rename t/t5515/{fetch.master_branches-default => fetch.main_branches-default} (69%)
 rename t/t5515/{fetch.master_branches-one => fetch.main_branches-one} (81%)
 rename t/t5515/{fetch.master_config-explicit => fetch.main_config-explicit} (78%)
 rename t/t5515/{fetch.master_config-glob => fetch.main_config-glob} (77%)
 rename t/t5515/{fetch.master_remote-explicit => fetch.main_remote-explicit} (78%)
 create mode 100644 t/t5515/fetch.main_remote-glob
 delete mode 100644 t/t5515/fetch.master_remote-glob
 rename t/t5515/{refs.master_.._.git_one_tag_tag-one_tag_tag-three-file => refs.main} (81%)
 rename t/t5515/{refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file => refs.main_--tags_.._.git} (81%)
 rename t/t5515/{refs.master_.._.git_one_two => refs.main_.._.git} (79%)
 rename t/t5515/{refs.master_.._.git => refs.main_.._.git_one} (79%)
 rename t/t5515/{refs.master => refs.main_.._.git_one_tag_tag-one_tag_tag-three-file} (81%)
 rename t/t5515/{refs.master_.._.git_one => refs.main_.._.git_one_two} (79%)
 rename t/t5515/{refs.master_--tags_.._.git => refs.main_.._.git_tag_tag-one-tree_tag_tag-three-file} (81%)
 create mode 100644 t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three
 rename t/t5515/{refs.master_branches-default => refs.main_branches-default} (74%)
 rename t/t5515/{refs.master_branches-one => refs.main_branches-one} (83%)
 rename t/t5515/{refs.master_config-explicit => refs.main_config-explicit} (79%)
 rename t/t5515/{refs.master_config-glob => refs.main_config-glob} (79%)
 rename t/t5515/{refs.master_remote-explicit => refs.main_remote-explicit} (79%)
 rename t/t5515/{refs.master_remote-glob => refs.main_remote-glob} (79%)
 delete mode 100644 t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three


base-commit: 5d5f4ea30def2ac765c5517f768366524768c110
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-761%2Fdscho%2Fprepare-for-main-branch-t5515-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-761/dscho/prepare-for-main-branch-t5515-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/761
-- 
gitgitgadget
