Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECDC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DDB61222
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhDVPSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbhDVPSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52577C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s5so37856933qkj.5
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1En0f1NBO0SWMODRgtlaszp1QfDFJ0y/frNTM5ITge0=;
        b=cV5tYJGOhkLXkqUOVE86dt3vM0MIRJ4pnUA7TmqmM8OklWtL8rox/H2rglaK1gB8ja
         m2YdHuuhJQ+E+OhK8DvXTLYlxMkcK5683W8eSi4hLZMBF/Nh7/+rmJZNqOAzyKynWrNs
         Tb62dKSG00Od7m1KMT58ouiTBF2MwJKeUI676uIxnLd5PzukEa+KFrH+aN9ZiJh0daW+
         DWDZ2XYeHYHUYyhNPdw3tLZKoykfrAchaLMRwrGuXqwnxsXCJukgfo1e3RKQPSBfcaQv
         ij1AYAHn+o50/TgWUIpS0YhCjMGvpD544R2RLS7tX127HlqfHEVy7aTy1wF58Mo2oe3I
         FTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1En0f1NBO0SWMODRgtlaszp1QfDFJ0y/frNTM5ITge0=;
        b=HTBIysxz0Lo1qLPoos6CBnwCCv1sxhAArJfgNy4X92LlReGYEgD/bNi0rmh9OfXzt9
         PQeGLg9MKzIvg1RhphOimyYZGFMJF5nQ0PfCegozyw6cRCX9sEh7RirOvHSj2T/Cq1qJ
         Zy8Ea4qKkVwpPrBy58t466OqrxwMc7H0Rd+8ipVulP5yD/tqFBCLvtM08H+LSrZO4VvW
         l7jnVm3+mAQweRwWAFRDHA33VIpMTMnNuuOYAArXyH6wN9Qz6ka3eZplezsNM1qRcmPG
         u5N4LO55f+OtjkCJbbBG99JhQ+6X5xK2DIi8oTt5wtAeyQm68cS8/VyuQhDZWVNF0EYB
         jljw==
X-Gm-Message-State: AOAM533HK1cJPYqYK8MSHqT3WzPPeDwD9mFLvwBRmKxaaEQ83ZGNIvzf
        zA//ZkJ9f79hYAh/St+AkUdqKq9Q/Mey+w==
X-Google-Smtp-Source: ABdhPJyvyS3NEfo9T5alZzQl9BYNpA4rDmnQcGNQNz0pPNh7q/YSYd2rJu5DTYhzUxx99FiEca8DGQ==
X-Received: by 2002:a37:a156:: with SMTP id k83mr3917717qke.331.1619104681891;
        Thu, 22 Apr 2021 08:18:01 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
Subject: [PATCH 0/7] Parallel Checkout (part 3)
Date:   Thu, 22 Apr 2021 12:17:46 -0300
Message-Id: <cover.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the last part of the parallel checkout series :) I have a couple
other small optimization and tuning ideas for later but, with this part,
the main functionality should be now complete.

This is based on mt/parallel-checkout-part-2.

The first three patches add parallel checkout support for three
codepaths that could not use the parallel mode yet:

- git checkout-index
- git checkout --patch
- git checkout <pathspec>

All these three call `checkout_entry()` directly instead of
`unpack_trees()`, so we need to enable parallel checkout on them before
they call `checkout_entry()`.

The four remaining patches add tests for the parallel checkout
framework.

Matheus Tavares (7):
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to path collisions
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 builtin/checkout--worker.c              |   2 +-
 builtin/checkout-index.c                |  24 +--
 builtin/checkout.c                      |  20 ++-
 builtin/difftool.c                      |   2 +-
 cache.h                                 |  11 +-
 ci/run-build-and-tests.sh               |   1 +
 parallel-checkout.c                     |  18 +++
 read-cache.c                            |  12 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +++
 t/lib-parallel-checkout.sh              |  40 +++++
 t/t0028-working-tree-encoding.sh        |  25 +--
 t/t2080-parallel-checkout-basics.sh     | 150 ++++++++++++++++++
 t/t2081-parallel-checkout-collisions.sh | 162 ++++++++++++++++++++
 t/t2082-parallel-checkout-attributes.sh | 194 ++++++++++++++++++++++++
 unpack-trees.c                          |   2 +-
 16 files changed, 643 insertions(+), 49 deletions(-)
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

-- 
2.30.1

