Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566E320899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdHBTt3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:29 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37877 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:28 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so25099316pgy.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3aKF4YeMchevi/cVZKgEZ6L0TcJAHjVAuzIsVH540g=;
        b=OS6lliRxX2E+SZxSzyjnTm7RWc2lQJnrsa86AclNpeH4qrfTlOdrw3KR7292JrW9uk
         6gB8IpWzWUAHGaKItx9VB20cu5jO3rS5b+5vUOdAhYU1+j7MMlU0Ec9RwtMvBZapo5yj
         hcJR4R7pmKtZXVlXwlCOL/zIEWearag+jZi0p6YZDShT5epRJityi6PXsVlYLkIl8lrd
         oUbZ1gEDw1MIHkOUCaQ3r5rApbHq4nXPTD8+ZhXCic68vmGuyYgxPFiE3aIQnyyqnEuJ
         BhCUmKsCli+5jjHCKh+PHsDCBn/YEFMNTYy9TCYK2M8NEWO01KND18fggHN4USUwGOIw
         ngMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m3aKF4YeMchevi/cVZKgEZ6L0TcJAHjVAuzIsVH540g=;
        b=iH5NeM95BnfflpnbwQFJkjAqGBaa6QlI1iWI71XZiRcPjAaKpO4iwOL5/HlQFyGBW8
         Ee77pHfUGPpEwqBN5kU+5DnZsVeFz77UHUO/DJEU84lR5AahYk1OKvS3PIQAXNczydrR
         Tp9TD8z79ql8PQhV5NtXlr+oWI3X9W+Ze4mwidzTuMrhZH0+uqyEoeUBmlIX8Ce9yRtW
         DXAdWOM7MgZI9djCZh1BkxhqjABWnswUD9ZSDwPEge8LGY8I8b4ZiMXgjZ5QaXVZFqAZ
         NdGQeHo8H5QwZXGlKZNDlPz80Lpto8MEGqF399+MJISqJX0uOkrBy0jqMujlym0DlPOz
         TVqg==
X-Gm-Message-State: AIVw110jj4yXs3FdY7y8swL1kAIVNxEWGLvFzz3o7BMzDohY22eQx9hd
        c9O882UIynPdKTAldO39Rg==
X-Received: by 10.99.112.16 with SMTP id l16mr5700740pgc.143.1501703367176;
        Wed, 02 Aug 2017 12:49:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 00/10] Convert grep to recurse in-process
Date:   Wed,  2 Aug 2017 12:49:13 -0700
Message-Id: <20170802194923.88239-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v4:
 * small typo fix in commit message.
 * convert all occurrences of '.gitmodules' to use the new macro.

Brandon Williams (10):
  repo_read_index: don't discard the index
  repository: have the_repository use the_index
  cache.h: add GITMODULES_FILE macro
  config: add config_from_gitmodules
  submodule: remove submodule.fetchjobs from submodule-config parsing
  submodule: remove fetch.recursesubmodules from submodule-config
    parsing
  submodule: check for unstaged .gitmodules outside of config parsing
  submodule: check for unmerged .gitmodules outside of config parsing
  submodule: merge repo_read_gitmodules and gitmodules_config
  grep: recurse in-process using 'struct repository'

 Documentation/git-grep.txt  |   7 -
 builtin/fetch.c             |  26 ++-
 builtin/grep.c              | 396 ++++++++++----------------------------------
 builtin/mv.c                |   2 +-
 builtin/rm.c                |   2 +-
 builtin/submodule--helper.c |  17 +-
 cache.h                     |   2 +-
 config.c                    |  17 ++
 config.h                    |  10 ++
 git.c                       |   2 +-
 grep.c                      |  13 --
 grep.h                      |   1 -
 repository.c                |   6 +-
 repository.h                |   8 +
 setup.c                     |  12 +-
 submodule-config.c          |   8 +
 submodule-config.h          |   1 +
 submodule.c                 | 157 ++++++++----------
 submodule.h                 |   6 +-
 unpack-trees.c              |   2 +-
 20 files changed, 246 insertions(+), 449 deletions(-)

-- 
2.14.0.rc1.383.gd1ce394fe2-goog

