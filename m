Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A471F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdGYVjn (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33934 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdGYVjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:41 -0400
Received: by mail-pf0-f172.google.com with SMTP id q85so63072803pfq.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I1pRzSI29o4E8mdypS4yVNUGWilQyYXEGm3KvTn6Osk=;
        b=rFE3kp82rLvZu7ymdklEG9Lq6uNkeNhkKjx7rcEp3nIBwRnD3Om/dMMmx2YH7VZVxC
         v3UaPoir+7xsJgYw6XY4y+JjngVm5u9tR+pMNOAmn3MIUK2bXSdia6Un0gfg1TRMyi5+
         u5bLS8ts9182jSbV4ylUE0ER9dtBGjY+qA2GuRQWj0zsiVTAIb2qGVvDuyRxzWA7nT0p
         KKO3xWf2CNA4C9FoOFBdWdS7pkouhOJAn1QdfkFVUoqFNMNsaTjNrC4X3Nx0A/SwBnRK
         jzd+6QdoGOTen0jqryCjfbocrbZ/shPn8dqODrUkK7P9nwyGy3pYUgCWyGdOiGaL1WdT
         jTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I1pRzSI29o4E8mdypS4yVNUGWilQyYXEGm3KvTn6Osk=;
        b=rMmjQa5YN3+fWIw9oiLMFlJkatx/ohadgMiZE20EQqw8vnzb4GDsQnGunbP3Ccy6gi
         XllODLQ/y7HmYC8WTVkUzFwJQvHcvAyZSpFKdP5mNSuRN5p9EUTjfE9jfP4YfRHNh6FO
         uM3dkqmcQ9WxVUpycyfA+YIQLayaJwYN/sXUrgCTOVT5Lnu35IPgvn562JM/wLj2O7Tc
         OufK3N+4XW2RRCCokPqz7/qgzCuH3BaQXHc4m4J4uRoiDofCxz2kyH4G+ztgopLhhfp3
         9G6EbtU9UEYLsMQmLMpcQM4fGsoGrmMK8VohbL1DdmOxfyhUmfEYWYUCyre5X2oMt5Qc
         kWkg==
X-Gm-Message-State: AIVw112Y8WQ+GaaO+XrQP9KE6M8yyCu0owVDs8eZlEnyLqsEkiTx2EJe
        PAwkN9hwGp8X9Y4w7vI9Hg==
X-Received: by 10.84.210.171 with SMTP id a40mr17788816pli.443.1501018780276;
        Tue, 25 Jul 2017 14:39:40 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/15] submodule-config cleanup
Date:   Tue, 25 Jul 2017 14:39:13 -0700
Message-Id: <20170725213928.125998-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The aim of this series is to cleanup the submodule-config and make it simpler
to use.  The two main parts to this series are:
(1) removing the ability to overlay the repository's config over the
    submodule-config.  This makes the API clunky as you don't really know when
    you want to overlay and when you don't.  So instead all the relevant
    sections (where you are interested in the repository's config) are patched
    to read the configuration directly from the repository's config.
(2) Add the ability to lazy-load the gitmodules file from the working
    directory.  Most callers are required to first populate the
    submodule-config by calling gitmodules_config.  Instead let's just
    lazy-load it if needed.  Only a couple callers will still require loading
    the gitmodules files by hand while the rest can have it lazy-loaded and no
    longer need to explicitly load it themselves.  This falls more in line with
    how specific revisions are already lazy-loaded.

As a side note, instead of having unpack-trees read configuration for the
'update' config (which is used by submodule update) we may just want to drop
respecting this all together as it doesn't make much sense in the context of a
checkout or reset.  If that's the case then we can make the parts of the code
which use 'update' even simpler.

This series is built on and requires the 'bw/grep-recurse-submodules' and
'bc/object-id' branches.

Brandon Williams (15):
  t7411: check configuration parsing errors
  submodule: don't use submodule_from_name
  add, reset: ensure submodules can be added or reset
  submodule--helper: don't overlay config in remote_submodule_branch
  submodule--helper: don't overlay config in update-clone
  fetch: don't overlay config with submodule-config
  submodule: don't rely on overlayed config when setting diffopts
  unpack-trees: don't rely on overlayed config
  submodule: remove submodule_config callback routine
  diff: stop allowing diff to have submodules configured in .git/config
  submodule-config: remove support for overlaying repository config
  submodule-config: move submodule-config functions to
    submodule-config.c
  submodule-config: lazy-load a repository's .gitmodules file
  unpack-trees: improve loading of .gitmodules
  submodule: remove gitmodules_config

 builtin/add.c                    |   1 +
 builtin/checkout.c               |   3 +-
 builtin/commit.c                 |   1 -
 builtin/diff-files.c             |   1 -
 builtin/diff-index.c             |   1 -
 builtin/diff-tree.c              |   1 -
 builtin/diff.c                   |   2 -
 builtin/fetch.c                  |   5 --
 builtin/grep.c                   |   4 --
 builtin/ls-files.c               |   6 +-
 builtin/mv.c                     |   1 -
 builtin/read-tree.c              |   2 -
 builtin/reset.c                  |   3 +-
 builtin/rm.c                     |   1 -
 builtin/submodule--helper.c      |  42 ++++++------
 diff.c                           |   3 -
 submodule-config.c               |  65 ++++++++++++++----
 submodule-config.h               |   8 +--
 submodule.c                      | 140 ++++++++++++++++-----------------------
 submodule.h                      |   8 +--
 t/helper/test-submodule-config.c |   7 --
 t/t4027-diff-submodule.sh        |  67 -------------------
 t/t7400-submodule-basic.sh       |  10 ---
 t/t7411-submodule-config.sh      |  87 +++++-------------------
 unpack-trees.c                   |  54 +++++++++------
 25 files changed, 189 insertions(+), 334 deletions(-)

-- 
2.14.0.rc0.400.g1c36432dff-goog

