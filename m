Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B8C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E4464F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhBCD26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBCD26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:28:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3862C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m13so22583307wro.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYW2sLYnZrukSa7ycfOjvS1p7rDZxIHfuuOQX+44sQo=;
        b=L+hqQgOf9m0j14Fqx3Xgx+8oVGjOA1r8XP0xF9gytxKcQD67y0PSNKUXTQAttSDTQv
         oohO/8812pQVZxytWzGET91Dy3swMZHLmMKMLArB+IcrESO4FNKqnEwSeWMkAnlBjDCJ
         r4Am1D4+pMjpiOxmly0KWq6ENzNh3AToLFjismsquzIcesQtf9VmV7utg5Oy7Pl882IA
         jB1mDSMGFaBX8PJlGjD/mmP4rWv5AAOM6drt0uSvXhqYESQtKA6tSQyncGNWEpRhW3N5
         alQ9Uds/2JPb/2yQk7LKeUnu15PvKPE3tLqmP9MxOvpbxFeu5KA7ukGF92mBwVf8Lv3m
         bDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYW2sLYnZrukSa7ycfOjvS1p7rDZxIHfuuOQX+44sQo=;
        b=C9O+JbUCIuGvJq2RG5qZQnJBYeB+VXcdf+2iEM6dYTtMAt7WZSfOdZobOIaVUyjn3h
         ZNjv4NkTSwJrwofIsriqy+sf87OawuyOD2bR4LF4SESNZI941uTnE7D/efe4GYyULiRT
         y8pPMXSXAesbZZm3rsKKWm69bE1FdoK9ajwITki6E9mYsWn1QLwUFVIdZTP3bOF+b6Ty
         qT/3h5Z/bQ1gfC3LnMHaOb5fMpBDTYI7gl5RCFYSyT0sLjVZ678g34COYLbZ5U1yOQS+
         rnbhLX5nvrojE2Hdzn10bpAFg7m8gjPMEp5NcjLC44FX8ITo+KoYRGRjp74k60XylcMi
         CuTw==
X-Gm-Message-State: AOAM531vRhCvfo5aQQuaU98u8ZDGZetGMUp/ZJmyT9zVOiC78HAtzSRC
        3zB9dRLwbc8q+HPxN+hI46APIYiVw6eyCA==
X-Google-Smtp-Source: ABdhPJwrk4VUGUSFcaDqWvl+BWYH90X8eea9/DJUZzMsnKfXPC+OPEONxZGEJrYE7YvobHrCh5oa4A==
X-Received: by 2002:a5d:5902:: with SMTP id v2mr1031282wrd.426.1612322896115;
        Tue, 02 Feb 2021 19:28:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/25] grep: PCREv2 fixes, remove kwset.[ch]
Date:   Wed,  3 Feb 2021 04:27:46 +0100
Message-Id: <20210203032811.14979-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on next. I was wondering if/how to split this up, it
should arguably be a few serieses, but let's see if it gets some
traction in reviews like this. Comments below:

Ævar Arnfjörð Bjarmason (25):
  grep/pcre2 tests: reword comments referring to kwset
  grep/pcre2: drop needless assignment + assert() on opt->pcre2
  grep/pcre2: drop needless assignment to NULL
  grep/pcre2: correct reference to grep_init() in comment
  grep/pcre2: prepare to add debugging to pcre2_malloc()
  grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
  grep/pcre2: use compile-time PCREv2 version test
  grep/pcre2: use pcre2_maketables_free() function
  grep/pcre2: actually make pcre2 use custom allocator
  grep/pcre2: move back to thread-only PCREv2 structures
  grep/pcre2: move definitions of pcre2_{malloc,free}

PCRE v2 code cleanups, and fix up bugs in our pcre2_{malloc,free}()
handling.

  pickaxe tests: refactor to use test_commit --append
  pickaxe -S: support content with NULs under --pickaxe-regex
  pickaxe -S: remove redundant "sz" check in while-loop
  pickaxe/style: consolidate declarations and assignments
  pickaxe tests: add test for diffgrep_consume() internals
  pickaxe tests: add test for "log -S" not being a regex
  perf: add performance test for pickaxe

Various test prep for pickaxe.

  pickaxe -G: set -U0 for diff generation

Turns out feeding "log -G" -U10 output makes it faster.

  grep.h: make patmatch() a public function
  pickaxe: use PCREv2 for -G and -S
  Remove unused kwset.[ch]

At long last, kwset.[ch] is gone!

  xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
  xdiff-interface: support early exit in xdiff_outf()
  pickaxe -G: terminate early on matching lines

Solve an ancient todo item in pickaxe by extending our xdiff interface
so you can early exit from hunk/line handlers.

 Makefile                       |   2 -
 builtin/grep.c                 |   1 -
 combine-diff.c                 |   9 +-
 compat/obstack.c               | 413 ------------------
 compat/obstack.h               | 511 ----------------------
 ctype.c                        |  36 --
 diff.c                         |  39 +-
 diff.h                         |   4 +
 diffcore-pickaxe.c             | 184 ++++----
 git-compat-util.h              |   3 -
 grep.c                         | 103 ++---
 grep.h                         |  11 +-
 kwset.c                        | 775 ---------------------------------
 kwset.h                        |  65 ---
 range-diff.c                   |   8 +-
 t/perf/p4209-pickaxe.sh        |  82 ++++
 t/t4209-log-pickaxe.sh         |  64 ++-
 t/t7816-grep-binary-pattern.sh |   4 +-
 xdiff-interface.c              |  26 +-
 xdiff-interface.h              |  36 +-
 20 files changed, 351 insertions(+), 2025 deletions(-)
 delete mode 100644 compat/obstack.c
 delete mode 100644 compat/obstack.h
 delete mode 100644 kwset.c
 delete mode 100644 kwset.h
 create mode 100755 t/perf/p4209-pickaxe.sh

-- 
2.30.0.284.gd98b1dd5eaa7

