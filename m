Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66058C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjFBOds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjFBOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3C1A7
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ad752f433so1919094f8f.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716422; x=1688308422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OKYz0nrW99tqg8jTSCaDPCghmEFfoAU6ajGZODwqGFc=;
        b=MnFAjzgvmYC8cXv9ODmghj3VSwJjrQDobtVW5u6H6FC3M2POLQeMU3znPYCsJU5+tD
         1bJyC/vcYVb4E5Kt/M0/hvwgwAf0yV52jMqIs/Z/tvRH40YpryWj03yKpWBgQWxbcSHV
         EVzZjxfvRfowSDzAIzT+ZRf2PfHTizi+SA9tnZcVN0kZnUxXBnB79En0KidIay9fMR2v
         9snA4RzBKNJO/yOJopk/FE9JFCQTMEsPL+zJ6DZCI9f77MgjpLaToz89bm4IYmkNuwfD
         1xil5H+LIC6M4JG+KB7KJgadTE3gkzmVEhJnzlji6/3HS4yENqUWTfoo+BnQAqPnNpL/
         EABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716422; x=1688308422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKYz0nrW99tqg8jTSCaDPCghmEFfoAU6ajGZODwqGFc=;
        b=IA1kKApEE8xOCseQ/HjuTtGPKDGj/HMrldJXR7qW195S+C8Alo9kALCdUWYfXVXbHl
         yFaV/aGtpbvJePqY+ns5wenioXavZGWNwa1LvCfMkuwOKoDnw+phEDfqjkIwy2zXwoof
         NEdK5bA7ByFSwIBwXjRZ8Wl7LQnCJrSbZhDZyHlyqoN9J0GVfugWrsE5X2sYRwr0z99s
         FWwXvMG/b7C7ENsFCQlBiQ06nwqmn7iSVdmGIh5M2cIKgB6YkZvhv4p5ZUDpSJgLbo/v
         gNpTeLVlAe+6jvP/wxtpmphaZ8hgWhT/nFGwtTS7iLB0h8g/EJ05hQLw4mBZ1dcF8o/S
         UWpg==
X-Gm-Message-State: AC+VfDww4Dfx4pF5l4z+GfokoXdxBA48kNhVVCPVGPt1cOr09qDocagU
        mZu21TGY+foukbAQkWS25C0vd/cuzjk=
X-Google-Smtp-Source: ACHHUZ5hSXn8Nb/wRYlibVAeyTDoj9NKFIHh40Yht+7o1Yljf/vgZYP4P3Fl3hVfm6OKbrjAMHgHhw==
X-Received: by 2002:a5d:668c:0:b0:30a:e511:e65c with SMTP id l12-20020a5d668c000000b0030ae511e65cmr118627wru.37.1685716422253;
        Fri, 02 Jun 2023 07:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003f4b6bcbd8bsm2132527wmc.31.2023.06.02.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:41 -0700 (PDT)
Message-Id: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:34 +0000
Subject: [PATCH 0/6] [RFC] Lazy-loaded default Git config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on the stronger protections around replace refs config [1], I
wanted to think about a way to scale that concept of ensuring that we've
read the config before accessing the global to a wider scope of config keys.

[1]
https://lore.kernel.org/git/pull.1537.v2.git.1685716157.gitgitgadget@gmail.com/

If you wish to apply these patches, then do so on top of v2 of [1].

This RFC attempt to explore this space, to get a feeling whether this is
solving a worthwhile problem and what this system should look like.

One example option is presented here, but I'm not super-confident in it and
only implemented enough translations such that I could gather enough
examples to know this would work at least a little bit.

The basic idea is to create a new 'global-config' library that has enums for
different config keys, and from each enum value we can load the config
string and the stored global value, as well as access an indicator that the
value has been loaded from config yet.

In this way, we can guard accesses to the global state through a method
which will lazy-load the config value as needed. This avoids the kind of bug
where a builtin forgets to initialize config through a git_config() call at
the right time.

One of the issues that becomes particularly important is that some of our
globals are accessed before config is available. Specifically, in patch 6,
we replace the ignore_case global with the method accessor. This is used in
fspathcmp() to toggle between strcasecmp() and strcmp(). However, this
method is called as part of the process to set up the Git directory, which
must happen before we can start loading config. The current behavior is to
always use the default of 0 at this time.

To get around this, I introduce a declare_config_available() method which is
called at the right time in git.c and test-tool.c. Before this is called, we
will silently pass the default value instead of loading from config. Without
this behavior, our test suite would fail in a BUG() statement due to the
inconsistent use of the config library.

My hope with submitting this RFC is that we could come to some conclusions
on these questions:

 * Is this a worthwhile category of bug to protect against?
 * Is wrapping global state in accessor methods the right way to protect
   against that class of bugs?
 * Are there other benefits to doing this?
 * Are there reasons why this cure is worse than the disease?

There are a few things that I personally find could use improvement and I
would like to update before submitting this for full review. (I chose to not
spend extra time re-working this until there is agreement on the general
direction.) Here are the things I've identified so far:

 1. The (static) global state in global-config.c is split across two arrays
    and a bitmask. It would be better to have a single array of structs so
    we can have the default values described right next to the config key
    strings.
 2. The current accessor method is limited to returning ints, and is named
    as such. But many of the keys it replace are actually boolean-valued.
    The current implementation tries ...get_maybe_bool() before then trying
    ...get_int(), which would extend values like core.filemode to allow
    taking the value "3". This could be fixed by using the struct approach
    and signalling that some int-typed globals only allow boolean values.
    (This holds the same for int-valued things that shouldn't take "true".)
 3. The method is currently scoped globally, and does not allow for
    repository-scoped values. None of these globals are currently scoped to
    repositories, but it would be less intrusive to do repository-scoping
    later if the accessor method allowed repository scoping and then looked
    at the key-specific settings as to whether we should look globally or in
    a repository.
 4. The replacement of a constant like 'ignore_case' with a method like
    'get_int_config_global(INT_CONFIG_IGNORE_CASE)' is quite verbose and
    ugly. I specifically chose this approach instead of dedicated methods
    like 'replace_refs_enabled()' in [1] because I didn't think that
    approach would scale. However, we could perhaps use macros as a way to
    reduce the verbosity, especially when deciding to add repository-scoping
    as necessary. For instance, we could define 'get_ignore_case()' to be
    'get_int_config_global(the_repository, INT_CONFIG_IGNORE_CASE)' in
    global-config.h to avoid spreading this verbosity across the codebase.
    Alternatively, we could define these as inline methods if that is
    preferred.

Thank you for your help determining the right way forward here.

Thanks, -Stolee

Derrick Stolee (6):
  config: create new global config helpers
  config: add trust_executable_bit to global config
  config: move trust_ctime to global config
  config: move quote_path_fully to global config
  config: move has_symlinks to global config
  config: move ignore_case to global config

 Makefile                                |  1 +
 apply.c                                 |  6 ++-
 builtin/difftool.c                      |  4 +-
 builtin/mv.c                            |  2 +-
 cache.h                                 |  9 ++++-
 combine-diff.c                          |  2 +-
 config.c                                | 24 -----------
 dir.c                                   | 23 ++++++-----
 entry.c                                 |  3 +-
 environment.c                           |  4 --
 environment.h                           |  4 --
 git.c                                   |  4 ++
 global-config.c                         | 54 +++++++++++++++++++++++++
 global-config.h                         | 30 ++++++++++++++
 merge-recursive.c                       | 11 ++---
 name-hash.c                             |  6 +--
 quote.c                                 |  6 +--
 quote.h                                 |  2 -
 read-cache.c                            | 22 +++++-----
 t/helper/test-lazy-init-name-hash.c     |  5 ---
 t/helper/test-tool.c                    |  3 ++
 t/perf/p0004-lazy-init-name-hash.sh     |  6 +++
 t/t3008-ls-files-lazy-init-name-hash.sh |  1 +
 unpack-trees.c                          |  2 +-
 24 files changed, 156 insertions(+), 78 deletions(-)
 create mode 100644 global-config.c
 create mode 100644 global-config.h


base-commit: 4c7dbeb8c6dd6ab4c1903196967d5e0906a293c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1539%2Fderrickstolee%2Fdefault-config-safety-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1539/derrickstolee/default-config-safety-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1539
-- 
gitgitgadget
