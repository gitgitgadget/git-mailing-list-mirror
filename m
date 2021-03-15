Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C75C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA964F5E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhCOXoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCOXoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F75C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so434403wmj.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxKPWzJK5qd+XYCct+iAnSPJmExleIWc3WmfiVhrz1A=;
        b=nkjdzi7Eu/gJZFNu+FE/IntqAb91NL2NI2DXET6JZRWlMQeUItJfwYNtwxTI85IYKY
         XQBEvbgzn9iPc5HO1sOmKiDNmhZ/7K7TjVx3JHcf2AEHsKU4AZXj1Woyjat8O/LZp2fI
         buHHkKlu4nR2owkbX2dq8qSm0NxLg1obkMC/HX7q6XgVYf8JPqF3roMZo4PTipHPDUvO
         reEv5VrCPe5PBQ857E5OsX6+g28TuqEYgHCLiAPetB+M/lll1BjJj95nfRj8g5dfCR76
         nJd0U1/WChyVnKmg47FBioJ7iTNZvhTf1RUCPqIp2OqA8EcarXRxdV7ryinMbSXkWPlo
         IdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxKPWzJK5qd+XYCct+iAnSPJmExleIWc3WmfiVhrz1A=;
        b=mQ6OKHik6CLkM9DLXHtlvEnfyoJ28YQxMKoNn9R3Ju97mevA8fOYdOKbjtee0pfxvO
         39250dvNkMBPqEr2/fAuJ2zgSG2M1m2GNl9Ox2EZ8AlzeUuMGjX1nNUlzcxIeN4IU83H
         pIVjT/LV2mdZgdYQ6pTIkBySlwwIGmwxjfHNptLTd3fnjwZlmUkf5Be8qRJrs6SE3g62
         U/OGLM34ncJNs678e8KmeVG0YgRgaWawUid2hZdkEOXAxEnvQH1AlnN+YGlyVgErdB+y
         +VAdhqd0dABpXmvDHX4WaKM3sAUQIJrlKDIUAJB4DI7gwmc9xEZ12zEo43ggNgGTtVpa
         4byg==
X-Gm-Message-State: AOAM533wq7heBK+453zqilKidWU6wU/zOZXWuF8jB0EZ4jy7ggdAFnlx
        nQhnGh9b85anShWwHIdavewJdcfuUh8=
X-Google-Smtp-Source: ABdhPJwoIk2bTBo+FkQYBwiqxBhsHjRRuTvlUP6SKHMdceEFsCD6xaX9QiXabdPT5Szn0P0Qe0dZDA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr1824852wmc.103.1615851840177;
        Mon, 15 Mar 2021 16:44:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:43:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] read_tree() and read_tree_recursive() refactoring
Date:   Tue, 16 Mar 2021 00:43:35 +0100
Message-Id: <20210315234344.28427-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v3 of a refactoring of tree.c. See v2 at
https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/

This brings back pretty much the old read_tree_recursive() under the
name read_tree_at() as suggested in
https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (9):
  ls-files tests: add meaningful --with-tree tests
  tree.c API: move read_tree() into builtin/ls-files.c
  ls-files: don't needlessly pass around stage variable
  ls-files: refactor away read_tree()
  tree.h API: remove support for starting at prefix != ""
  tree.h API: remove "stage" parameter from read_tree_recursive()
  tree.h API: rename read_tree_recursive() to read_tree()
  show tests: add test for "git show <tree>"
  tree.h API: expose read_tree_1() as read_tree_at()

 archive.c                     |  19 +++---
 builtin/checkout.c            |   8 +--
 builtin/log.c                 |   8 +--
 builtin/ls-files.c            |  76 +++++++++++++++++++++-
 builtin/ls-tree.c             |   6 +-
 cache.h                       |   2 +-
 merge-recursive.c             |   6 +-
 t/t3060-ls-files-with-tree.sh |  41 ++++++++++++
 t/t7007-show.sh               |  39 ++++++++++++
 tree.c                        | 117 ++++------------------------------
 tree.h                        |  24 +++----
 11 files changed, 205 insertions(+), 141 deletions(-)

Range-diff:
 1:  6416da0dee2 =  1:  b338f2c01a4 ls-files tests: add meaningful --with-tree tests
 2:  765001b44cd !  2:  4578b83944c tree.c API: move read_tree() into builtin/ls-files.c
    @@ builtin/ls-files.c: static int get_common_prefix_len(const char *common_prefix)
       * Read the tree specified with --with-tree option
       * (typically, HEAD) into stage #1 and then
     
    + ## cache.h ##
    +@@ cache.h: static inline int index_pos_to_insert_pos(uintmax_t pos)
    + #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
    + #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
    + #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
    +-#define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
    ++#define ADD_CACHE_JUST_APPEND 8		/* Append only */
    + #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
    + #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
    + #define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
    +
      ## tree.c ##
     @@
      
 3:  a71ffba7d04 =  3:  33656ff63b8 ls-files: don't needlessly pass around stage variable
 4:  e78d1810b89 =  4:  1c96d5d3611 ls-files: refactor away read_tree()
 5:  05eecdd7519 !  5:  367cb99224b tree.h API: remove support for starting at prefix != ""
    @@ Commit message
         ffd31f661d5 (Reimplement read_tree_recursive() using
         tree_entry_interesting(), 2011-03-25).
     
    -    If in the future we need to support recursively reading trees without
    -    starting at the root we can easily add a read_tree_recursive_subdir(),
    -    and make that function a thin wrapper for read_tree_1().
    +    As it turns out (Murphy's law and all) we're just about to gain a new
    +    in-tree user that would need this parameter[1]. Let's remove it anyway
    +    as the common case is going to be to not supply it, A later commit
    +    will bring back this functionality in different form.
     
    -    In the meantime there's no reason to keep around what amounts to dead
    -    code, just in case we need it in the future.
    +    1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  fcecc82e1c8 =  6:  38e36780e22 tree.h API: remove "stage" parameter from read_tree_recursive()
 -:  ----------- >  7:  859902ffd83 tree.h API: rename read_tree_recursive() to read_tree()
 -:  ----------- >  8:  a63c9b49f13 show tests: add test for "git show <tree>"
 -:  ----------- >  9:  570642c8625 tree.h API: expose read_tree_1() as read_tree_at()
-- 
2.31.0.rc2.211.g1d0b8788b3

