Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261981F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeHIAjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:39:45 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:38741 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:39:45 -0400
Received: by mail-ua0-f202.google.com with SMTP id z17-v6so3003363uap.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XAXOu9QBJMro9FXMFfPs/8S4UJP8VoNwgy1HxuLihI8=;
        b=nKDfTIhmC/cGG5+hT18OHddUlYwpqkSz+lNmI6Rlci3Nc4me0UonMU07/19uX58YKA
         O0kNtja67pmXJvjCW6NsqLKjXhWKUSV/KgchV1ufRKGPJVsEAi3cJQOf6LFGTCu9gSbw
         Lg23vq0ka+nOE8ppBLRB0X109SU6/0iLUadJzvGfSLSY8hcJtfXt6fZf0LPxWNtmW+HZ
         S1Fgp6AIy2ZWwpcqEswq4d6ARGXFwjyQE9Z1qExcIr1imClcyCHFdsWHCXLctJAFUwf9
         wGwZL+GJC5Az/4bdjNgEsxOyXiSxzGa3RdMge5Hly0BnLHRgQTSxg64aUDKMnBdhYtOD
         xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XAXOu9QBJMro9FXMFfPs/8S4UJP8VoNwgy1HxuLihI8=;
        b=tsXcTgSpkOA3E+lpmsxfvgdSbC0K/ldNYbGwrMa5zFk8O37jfeNtUzE4YuC8Jfv9co
         gb5Cr3IQgxktiy/pcAUARK3TXrj6lyY1eqRu7ZJPeX8izhanTmR/RB6ekbP3zWllq0is
         BBiiNuRQtKqbqJQ7dV0hBmiYilLmnD5VnXxmug+5zFua9VYBE2P0ftaI9iA4tJhskPmS
         g3JaK/mnUPVKgD0wo8SFq7yL/3XwIW/26evHrF8KH/YgUKgs7gXffiqTmMURwDjrjMxw
         82MYPJKtzwFNLj2vrOP8TdgFlR5bqgTFFgCoYe4IpsGrUesi2OG6tPbUOExBAHsWhjq3
         xVGw==
X-Gm-Message-State: AOUpUlFhbRdnqLGed+hAUiOSeB3GFeRBu6Z88fgQNMZqlTl/Cr5uSmwg
        x6BheyFiMkg1BqwBgxYAb7ob5Yxdy8scTmh566sMHSonM05AQGUiBwHLMiP4SlXgd/7oO0PXvMz
        dVGZ5qVbKFf9brETGP4FsTeN/mIltlrAMKl+V8OCQqGVQkPtlhtovr8tkHCT1
X-Google-Smtp-Source: AA+uWPyJpJwJwZt/gqPpar/TXNL+on26ptGZtkrQaSQw+F+pTa/DpvJbbcL+/j5++MV8KYFLIr/1g0pd+07A
X-Received: by 2002:a1f:b10c:: with SMTP id a12-v6mr2378192vkf.112.1533766684282;
 Wed, 08 Aug 2018 15:18:04 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:42 -0700
Message-Id: <20180808221752.195419-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC PATCH 00/10] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows, not so well in others,
which this series aims to fix.

The first patches provide new basic functionality and do some refactoring;
the interesting part is in the two last patches.

Thanks,
Stefan

Stefan Beller (10):
  string_list: print_string_list to use trace_printf
  string-list.h: add string_list_pop function.
  sha1-array: provide oid_array_remove_if
  submodule.c: convert submodule_move_head new argument to object id
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if sha1 were not fetched

 builtin/fetch.c             |   9 +-
 entry.c                     |   6 +-
 sha1-array.c                |  39 ++++++++
 sha1-array.h                |   3 +
 string-list.c               |  12 ++-
 string-list.h               |   6 ++
 submodule.c                 | 194 +++++++++++++++++++++++++++---------
 submodule.h                 |   2 +-
 t/t5526-fetch-submodules.sh |  23 ++++-
 unpack-trees.c              |  13 +--
 10 files changed, 241 insertions(+), 66 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

