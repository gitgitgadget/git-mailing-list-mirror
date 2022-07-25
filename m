Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B8C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiGYMjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiGYMjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED2BC98
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so20162451eju.8
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW8xqu2aO2fppIj0uJTNx80oKwr0gW+FTArwph7j7Lo=;
        b=lwHMH1UwtDlmWrx3ZqQ1MSY5rvo8ZnHxXKK3zYbHqO0R6iT6JUo9kHQ/W+mUd+kODT
         II7zftg3lml5aDU7EG9uc5jBtRt13MjRz31z+tgkYlQY1VHNghDc3DScSnhTMhcrRahm
         RVX9QjmlVWwsxpr2mKdb8KpBQH8lOOLPLiA2v5ibLHG2LzvllWTOxxFde8JMWJkQqRis
         OvY5xn5zbd2xaepiWKsRzx23KP9+LgL/LGMFnutICB10i7VLki2bJgFBKH54uk3FFESV
         /hunfO3fHfnKEfgq7FVxmn3+Skcktp+0K+bdyZzU54WmNt9l0XuWrjpw8vgwj6eaVO13
         su/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW8xqu2aO2fppIj0uJTNx80oKwr0gW+FTArwph7j7Lo=;
        b=NW0eFabY/6TO/3UFunEICHbAUC5S0n0GSMLCvJvTKTBWNiMIf3EVY1/AxqMwrzL5//
         xHTNmIgNWcZKTy5sdFcd4gwfvaZ7x4e13cRTPEYTwz2MmODE9chgmTbcHF95pA6ReXaK
         OB2NIYhEPwmQwResY//z0N/7Dc40Gc/9z+uqG8c+ayHaiYKmJCskf7m0lh63cpWB5LCb
         NsfrZoW71GK/nFfGLGUz4Vicn4tSxGiNB1Zh0NMYbQRJZX3dsMzGyiyCviDuQo9+6thh
         tJlwa9bnoQWyhZyHoU6Ae4ZBzFMG0l4isUPwp5HeygMCHpdgcWEWzBm3BQGYQUnd3H31
         zZ0A==
X-Gm-Message-State: AJIora/kxdujawCCV3+42S7VTW8oPDbPL0tcpEVZum+egKVNpwn43foG
        UjBHWK3Mvlt3yqaaEgfvBjBRPWObAjk=
X-Google-Smtp-Source: AGRyM1sbbKHkKi/OVtE/rkCb6JMf7IKCdX8f+phtxnf3KJJs6lrDe4CNlyEIqvsV2iGQqtehtDvYpA==
X-Received: by 2002:a17:907:94cb:b0:72f:1d8e:7305 with SMTP id dn11-20020a17090794cb00b0072f1d8e7305mr10019705ejc.625.1658752743214;
        Mon, 25 Jul 2022 05:39:03 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id dm21-20020a05640222d500b0043ab81e4230sm7013919edb.50.2022.07.25.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/20] parse-options: handle subcommands
Date:   Mon, 25 Jul 2022 14:38:37 +0200
Message-Id: <20220725123857.2773963-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several Git commands have subcommands to implement mutually exclusive
"operation modes", and they usually parse their subcommand argument
with a bunch of if-else if statements.

Teach parse-options to handle subcommands as well, which will result
in shorter and simpler code with consistent error handling and error
messages on unknown or missing subcommand, and it will also make
possible for our Bash completion script to handle subcommands
programmatically in a follow-up series [1].

Patches 1-8 are a mix of preparatory cleanups, documentation updates, and
test coverage improvements.

Patch 9 is the most important one, which teaches parse-options to handle
subcommands.

The remaining 10-20 convert most builtin commands with subcommands one by
one to use parse-options to handle their subcommand parameters.


This patch series has two conflicts with 'seen' (but none with 'next'):

  - builtin/bisect.c: after the conversion/rename from 'bisect--helper',
    cmd_bisect() doesn't use parse-options anymore.  Take what's on 'seen'
    to resolve the conflict.
    Note that the conflicting topic should have marked cmd_bisect() with
    the NO_PARSEOPT flag in 'git.c's command list.

  - builtin/stash.c: add OPT_SUBCOMMAND entries for the two new
    subcommands 'export' and 'import' to resolve the conflict.


[1] WIP with some one-liner commit messages and missing sign-offs here and
    there:

      https://github.com/szeder/git completion-subcommands


SZEDER Gábor (20):
  git.c: update NO_PARSEOPT markings
  t3301-notes.sh: check that default operation mode doesn't take
    arguments
  t5505-remote.sh: check the behavior without a subcommand
  t0040-parse-options: test parse_options() with various
    'parse_opt_flags'
  api-parse-options.txt: fix description of OPT_CMDMODE
  parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
  parse-options: clarify the limitations of PARSE_OPT_NODASH
  parse-options: drop leading space from '--git-completion-helper'
    output
  parse-options: add support for parsing subcommands
  builtin/bundle.c: let parse-options parse subcommands
  builtin/commit-graph.c: let parse-options parse subcommands
  builtin/gc.c: let parse-options parse 'git maintenance's subcommands
  builtin/hook.c: let parse-option parse subcommands
  builtin/multi-pack-index.c: let parse-options parse subcommands
  builtin/notes.c: let parse-options parse subcommands
  builtin/reflog.c: let parse-options parse subcommands
  builtin/remote.c: let parse-options parse subcommands
  builtin/sparse-checkout.c: let parse-options parse subcommands
  builtin/stash.c: let parse-options parse subcommands
  builtin/worktree.c: let parse-options parse subcommands

 Documentation/technical/api-parse-options.txt |  49 +++-
 builtin/archive.c                             |   2 +-
 builtin/bisect--helper.c                      |   2 +-
 builtin/blame.c                               |   1 +
 builtin/bundle.c                              |  25 +-
 builtin/commit-graph.c                        |  30 +--
 builtin/difftool.c                            |   2 +-
 builtin/env--helper.c                         |   2 +-
 builtin/fast-export.c                         |   2 +-
 builtin/gc.c                                  |  42 +--
 builtin/hook.c                                |  12 +-
 builtin/log.c                                 |   4 +-
 builtin/multi-pack-index.c                    |  51 ++--
 builtin/notes.c                               |  43 ++-
 builtin/reflog.c                              |  43 +--
 builtin/remote.c                              |  70 +++--
 builtin/revert.c                              |   2 +-
 builtin/shortlog.c                            |   1 +
 builtin/sparse-checkout.c                     |  48 ++--
 builtin/stash.c                               |  59 ++--
 builtin/worktree.c                            |  31 +--
 diff.c                                        |   2 +-
 git.c                                         |  14 +-
 parse-options.c                               | 118 +++++++-
 parse-options.h                               |  27 +-
 t/helper/test-parse-options.c                 | 129 +++++++++
 t/helper/test-serve-v2.c                      |   2 +-
 t/helper/test-tool.c                          |   2 +
 t/helper/test-tool.h                          |   2 +
 t/t0040-parse-options.sh                      | 255 ++++++++++++++++++
 t/t3301-notes.sh                              |   5 +
 t/t3903-stash.sh                              |   2 +-
 t/t5318-commit-graph.sh                       |   4 +-
 t/t5505-remote.sh                             |  29 ++
 t/t7900-maintenance.sh                        |  10 +-
 35 files changed, 812 insertions(+), 310 deletions(-)

-- 
2.37.1.633.g6a0fa73e39

