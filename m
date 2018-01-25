Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D3B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeAYOCj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:39 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37199 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeAYOCh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:37 -0500
Received: by mail-qt0-f194.google.com with SMTP id d54so19398160qtd.4
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L29u1hMOR94E0m8zFUxrgJMguN/TguSEZTghMasOfeA=;
        b=t0wsvRxqyeVOzuI0pFezTo1yZTaZhlkZNGde6BgbHBeZqGyfvtVzBS5O0WWwi8ePDC
         j5rZ7rpcVVK6v15ANhuKmrpPQ5t+aBVUJ5rtxcQwXs07zY3fn8EnolJyplqDY7N5q9pc
         DonCSV2CCjNYhMtAKFQBOZWa/GQ4pM17/PRF5FC7g6OAgle02MslOsjksQnGFJJJXQkM
         JVhtNzP7lF0/6d3ZbsA2EQqEc0scGwuHI2qsHGyr2fFaU8EXI8gQpMysW/KgOR7iPVFt
         y4l3iBth6K/rKrls8BkPTMEJosTRl1jv1cKZoqYcW4imNChPFH/5QQH7FJSAmK/LeIS6
         F8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L29u1hMOR94E0m8zFUxrgJMguN/TguSEZTghMasOfeA=;
        b=WpGyzm2nzyuJw9kKwimy8/jC0pUWgbvSOyWkvGp9bdpGHJ5zWdS3cmrN5OZ7V3jPgV
         VR3dps2zCOna58Pu3BD8uxIn7JuyRNlQneSgrux23/HpTPOVkDn27cc4CoOCQx2MPvoK
         hhc4bGwn0koMhQBOPi5f6TZLMlE+LlfVbzW8knyDBnyD8nK3eC4HZepyuDivu1GkRLLB
         G2Jx8C+YqKccopV+SoImb/u9iENCbKSyXbBo6zwGgJLdPdr7VowvB1BjuhKxblstF2qU
         m0OSLQyfnKEuxCp4/OdUEHrvaoV4P4heEo9wEhbCx81uaR59Tn53bxAFhGoeRdtp6shP
         qvPg==
X-Gm-Message-State: AKwxytcBDrAebHR5KAZiWXBWdATJqT3PfSmxCRmhoBsRGHl6NaBaE1qE
        N3l2F7LjtRG/BfQTEr4dLcMMgU7+
X-Google-Smtp-Source: AH8x227IA5UzP/+trIm8+BTxOqb7vM3oXrnbQLMh6+ZjDF7Y97gef7tAuoPpgoS1uzRVcSn5bgj23A==
X-Received: by 10.200.36.130 with SMTP id s2mr16477562qts.0.1516888956519;
        Thu, 25 Jan 2018 06:02:36 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:34 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 00/14] Serialized Commit Graph
Date:   Thu, 25 Jan 2018 09:02:17 -0500
Message-Id: <20180125140231.65604-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As promised [1], this patch contains a way to serialize the commit graph.
The current implementation defines a new file format to store the graph
structure (parent relationships) and basic commit metadata (commit date,
root tree OID) in order to prevent parsing raw commits while performing
basic graph walks. For example, we do not need to parse the full commit
when performing these walks:

* 'git log --topo-order -1000' walks all reachable commits to avoid
  incorrect topological orders, but only needs the commit message for
  the top 1000 commits.

* 'git merge-base <A> <B>' may walk many commits to find the correct
  boundary between the commits reachable from A and those reachable
  from B. No commit messages are needed.

* 'git branch -vv' checks ahead/behind status for all local branches
  compared to their upstream remote branches. This is essentially as
  hard as computing merge bases for each.

The current patch speeds up these calculations by injecting a check in
parse_commit_gently() to check if there is a graph file and using that
to provide the required metadata to the struct commit.

The file format has room to store generation numbers, which will be
provided as a patch after this framework is merged. Generation numbers
are referenced by the design document but not implemented in order to
make the current patch focus on the graph construction process. Once
that is stable, it will be easier to add generation numbers and make
graph walks aware of generation numbers one-by-one.

Here are some performance results for a copy of the Linux repository
where 'master' has 704,766 reachable commits and is behind 'origin/master'
by 19,610 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
| branch -vv                       |  0.42s |  0.27s | -35%  |
| rev-list --all                   |  6.4s  |  1.0s  | -84%  |
| rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

To test this yourself, run the following on your repo:

	git config core.graph true
	git show-ref -s | git graph --write --update-head

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisions by toggling the 'core.graph' setting.

[1] https://public-inbox.org/git/d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com/
    Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)

[2] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

P.S. I'm sending this patch from my gmail address to avoid Outlook
munging the URLs included in the design document.

Derrick Stolee (14):
  graph: add packed graph design document
  packed-graph: add core.graph setting
  packed-graph: create git-graph builtin
  packed-graph: add format document
  packed-graph: implement construct_graph()
  packed-graph: implement git-graph --write
  packed-graph: implement git-graph --read
  graph: implement git-graph --update-head
  packed-graph: implement git-graph --clear
  packed-graph: teach git-graph --delete-expired
  commit: integrate packed graph with commit parsing
  packed-graph: read only from specific pack-indexes
  packed-graph: close under reachability
  packed-graph: teach git-graph to read commits

 Documentation/config.txt                 |   3 +
 Documentation/git-graph.txt              | 102 ++++
 Documentation/technical/graph-format.txt |  88 ++++
 Documentation/technical/packed-graph.txt | 185 +++++++
 Makefile                                 |   2 +
 alloc.c                                  |   1 +
 builtin.h                                |   1 +
 builtin/graph.c                          | 231 +++++++++
 cache.h                                  |   1 +
 command-list.txt                         |   1 +
 commit.c                                 |  20 +-
 commit.h                                 |   2 +
 config.c                                 |   5 +
 environment.c                            |   1 +
 git.c                                    |   1 +
 log-tree.c                               |   3 +-
 packed-graph.c                           | 840 +++++++++++++++++++++++++++++++
 packed-graph.h                           |  65 +++
 packfile.c                               |   4 +-
 packfile.h                               |   2 +
 t/t5319-graph.sh                         | 271 ++++++++++
 21 files changed, 1822 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-graph.txt
 create mode 100644 Documentation/technical/graph-format.txt
 create mode 100644 Documentation/technical/packed-graph.txt
 create mode 100644 builtin/graph.c
 create mode 100644 packed-graph.c
 create mode 100644 packed-graph.h
 create mode 100755 t/t5319-graph.sh

-- 
2.16.0

