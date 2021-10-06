Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDACC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6043B61075
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhJFJmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJFJmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:42:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE307C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:40:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so6911579wro.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FaZOD2dtbPNwWJOtkYnU0t47l5nRJGxzHkO6hdkxtfg=;
        b=otK1dz4l7bNl9/lU78N+rLrs5xvf6db3cW2eM0Pisi+/vvZLh9+IpOtqdvRgLMchmS
         qpeg3VANdkvW8+P+VVAqsrCHsd9WNSIwaT2fUr3rEwvGO4OdO6xBL4a8jNN5ltQHVqdy
         pfITtZuxQrf0nEa0y9P6tDlzs/sJ4LnJeSC2HJh1GJYYj6932N6oDiDoC3FjWdmI65GR
         FEf7UVHdIABdg4ppCgB17nJJjFyOZyo38fp5cjd/n0vmjbgRFgEOGZLWdWMHQjljEtxn
         kIhwluDGAxAsP99XD2/527esmvNRQwYb5D6rI3lUwERrQvi02gixqywP8X4iEkhCFaxp
         7yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FaZOD2dtbPNwWJOtkYnU0t47l5nRJGxzHkO6hdkxtfg=;
        b=FP7x39PibUr4bjpBab54Vn5U/zOBNVDLxCqP14Cf09BghLPvq/eZTHmh6BVdKGfz3k
         iRLBqSlZWA7xiYSwByIZJAEzZOr/8YrPAM/dRsr/GwBLpRv1yrPu0ycNsxbrjDu6XOnM
         xOX42y/JqiGpx/jfGeCzu86IDe9G+/MS/ZttC9Ce0V+L3FjFC3kqOdbjeYUNWkMNXcAP
         v8hq11uJb5EgnI3KJmUMBXuYFt2PBXfp6o2t/RISt7CDCQH37NIWdeMtp7tlps4K940P
         MUXaAxBRZ0J7i4TEP7pwmox6GMXVYvxmDmWXeQe/NSSHqvOx4J1nrvV4GDnE1tKvsait
         HaVA==
X-Gm-Message-State: AOAM5333XXeVn37Hx0thIwV1KIizEX9XdDROqw8fzSjAHCPPOIgF+yNq
        bdCHj7ZWggPS/3Bps7ywyNyUq/QrgAKvlQ==
X-Google-Smtp-Source: ABdhPJyvJnOvBfKs7CH4Tac/S46IOGK3bVkkCZJAxtE3dba/xZDHkrrhU9+LDaprloOzUGjN46Gg0w==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr8772696wmj.60.1633513258242;
        Wed, 06 Oct 2021 02:40:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm4741868wmk.42.2021.10.06.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:40:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] dir & unpak-trees: memory-leak fixes
Date:   Wed,  6 Oct 2021 11:40:46 +0200
Message-Id: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These couple of patches fix some remaining memory leaks in
unpack-trees.c, which mostly happen via a lack of calls to dir_clear()
fixed in 2/2.

This goes on top of ab/sanitize-leak-ci (but not
en/removing-untracked-fixes). In 1/2 I mark a test as passing under
SANITIZE=leak, which assumes that an environment variable added by
ab/sanitize-leak-ci is understood. Without ab/sanitize-leak-ci it'll
be silently ignored.

Elijah has parallel work in fixing leaks in dir.c, but without his
ab/sanitize-leak-ci that test will also pass, it's not one of the ones
that needed something like his leak fixes to {dir,unpack-trees}.c to
pass.

Ævar Arnfjörð Bjarmason (2):
  unpack-trees: don't leak memory in verify_clean_subdirectory()
  built-ins & lib: plug memory leaks with unpack_trees_options_release()

 archive.c                   | 11 ++++++++---
 builtin/am.c                | 17 ++++++++++++-----
 builtin/checkout.c          |  9 +++++++--
 builtin/clone.c             |  1 +
 builtin/commit.c            |  6 +++++-
 builtin/merge.c             |  6 ++++--
 builtin/read-tree.c         | 14 ++++++++++----
 builtin/reset.c             | 13 +++++++++----
 builtin/stash.c             | 14 ++++++++++----
 diff-lib.c                  |  5 ++++-
 sequencer.c                 |  2 ++
 t/t1001-read-tree-m-2way.sh |  2 ++
 unpack-trees.c              |  3 ++-
 13 files changed, 76 insertions(+), 27 deletions(-)

-- 
2.33.0.1441.gbbcdb4c3c66

