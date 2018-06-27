Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77FD1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeF0NYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:24:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37320 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeF0NYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:24:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so993514qke.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9OHVe6Y3T+7byITFU95FwlRv9Y/9YJxcWfqbavfR46E=;
        b=IsyCe0TqcFju787z9IUUsGAKaErYbGbVHPm7wwMBTrxifXbOQQeZNJtHjlcfBltVYd
         Pqfg3spWPezz3vJtvIIelfQyOlGfEo0kNViwwiKNMe3L4Hqdv5SvzryIKcVFTsmWc0Uh
         3RLB850DMfk2mmEsfkEBd+pRHRJEt5GIQAMeLXNLa0mchX7AVJC6S5PlKJDOa6qJ36Yk
         cyUTzoMyRxayqcG13gVkg9VVsh8tLz0vPpHCrmWLXJY9MtNmhiTnN0S8g1csMB4yRSu8
         iUwilCAAQ2KVMU0yHJaoA0FjvivlDSBmojFm+U2EZuIcHtlxU6bBqRMhmWhJRNN2HA9j
         EqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OHVe6Y3T+7byITFU95FwlRv9Y/9YJxcWfqbavfR46E=;
        b=NA/mScwELfGGSUdM1ia7WZNpMAxuacfalq9fKfMg5AH2aABirXSvt/ZvQz+vfM482n
         CLB9S8m5ZxqUKZMwrnfFUMXnZWFGREj/O6FjFTvYgpxi7ztpiiORy10NrsRX41LKIkMc
         v5aLzWyY9qcvTciq+ToY7hQXDuLkEEmkLX1Qgn+YgLYHQv/rV84uHkcEYA3miXJ0KQLu
         eHzu/vA/45aLPveoh7Yhs3SZFqbNCqt6chHZ74g7B8i+V4ROCbGaUjSqqEtnKbF70mio
         /qSC+3SXyjlNxWb5S0m8n5hagqkGWws0lFa+iRsJRI6Ihe+/vgsYGcf6vG2V1B1sk5f7
         8B+A==
X-Gm-Message-State: APt69E2IVoorpocUeN0Sg9MtaSxD2w1MQSjOR5JGU7wtsnema9wY8Izj
        Sr/52ry786Fi0nPkde5tCJu0wZy0I8w=
X-Google-Smtp-Source: AAOMgpdJgpr5jIDIfgO5JRmn6p/67Pnocu9+DlANahDYZI8cqujl8DrGIavv8RLtRTeHNLQK47ZFZA==
X-Received: by 2002:a37:86c3:: with SMTP id i186-v6mr5248632qkd.70.1530105891046;
        Wed, 27 Jun 2018 06:24:51 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:24:50 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v7 00/22] Integrate commit-graph into 'fsck' and 'gc'
Date:   Wed, 27 Jun 2018 09:24:25 -0400
Message-Id: <20180627132447.142473-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

This v7 has very little material difference from the previous version.
The only changes are:

* Rename 'gc.commitGraph' to 'gc.writeCommitGraph'

* Add 't5318-commit-graph.sh: use core.commitGraph' patch that was
  dropped.

* Rebase onto latest master, which appears to fix any issues merging
  into 'next' and 'pu'.

I'm sending this from my gmail account to hopefully avoid any message
munging that happened in v6.

You can see my commits on GitHub [1].

[1] https://github.com/gitgitgadget/git/pull/6

Thanks,
-Stolee

Derrick Stolee (22):
  t5318-commit-graph.sh: use core.commitGraph
  commit-graph: UNLEAK before die()
  commit-graph: fix GRAPH_MIN_SIZE
  commit-graph: parse commit from chosen graph
  commit: force commit to parse from object database
  commit-graph: load a root tree from specific graph
  commit-graph: add 'verify' subcommand
  commit-graph: verify catches corrupt signature
  commit-graph: verify required chunks are present
  commit-graph: verify corrupt OID fanout and lookup
  commit-graph: verify objects exist
  commit-graph: verify root tree OIDs
  commit-graph: verify parent list
  commit-graph: verify generation number
  commit-graph: verify commit date
  commit-graph: test for corrupted octopus edge
  commit-graph: verify contents match checksum
  fsck: verify commit-graph
  commit-graph: use string-list API for input
  commit-graph: add '--reachable' option
  gc: automatically write commit-graph files
  commit-graph: update design document

 Documentation/config.txt                 |   9 +-
 Documentation/git-commit-graph.txt       |  14 +-
 Documentation/git-fsck.txt               |   3 +
 Documentation/git-gc.txt                 |   4 +
 Documentation/technical/commit-graph.txt |  22 --
 builtin/commit-graph.c                   |  99 ++++++---
 builtin/fsck.c                           |  21 ++
 builtin/gc.c                             |   6 +
 commit-graph.c                           | 249 +++++++++++++++++++++--
 commit-graph.h                           |  11 +-
 commit.c                                 |  10 +-
 commit.h                                 |   1 +
 t/t5318-commit-graph.sh                  | 205 ++++++++++++++++++-
 13 files changed, 572 insertions(+), 82 deletions(-)


base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
-- 
2.18.0.24.g1b579a2ee9

