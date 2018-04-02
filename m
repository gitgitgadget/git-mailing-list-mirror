Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8686C1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeDBUes (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:34:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33014 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756734AbeDBUer (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:34:47 -0400
Received: by mail-qt0-f196.google.com with SMTP id d50so9502409qtc.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wnf6DC++vwe9k1RQpjWN3x7YVp+PfK477/oIexnD9yc=;
        b=UdzMLApoOWaIFD8VtWJ/p/tUX8iz8VtA0oe0lw1Vs76mZSuasGpiPTs42CjOneqHhE
         3W/mxGZpLK/rqMKN7tRLy+5OFuBrnHxPWTUj9VLShpPFpJVkk/fNEd0x2vKeyJMnDjzQ
         sfUI9bFbFnj4oL7E57xioW4tOWXg21oe0nY0IBG2oroyKrRXuKG35KKFICnmckWo3VG+
         49MP6Z/hFzw3Kjv2di7/xwclF0G4BBun+OBig41L/Ec0S3LcORerrtlKLo/OPGzcd+t1
         O1iL1VbE/Qhiqc3iuzb0tccDw2j3AeVTDbT78SFmjLJkO52H1x066P5p5EaEVj1XTKwz
         SBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wnf6DC++vwe9k1RQpjWN3x7YVp+PfK477/oIexnD9yc=;
        b=suPloUSQ8IiuES6XPcjbEqZhrDOXqmCVdpAQ+8y8JOqOTeH+uCvNlQeuC6ogskMau8
         EJpBxGpRxLs01bz+9b/E5x1rXo5hSHsozH07BX7FXy0CbAuGgZYawFb0vdp6ssu/7Vwy
         X645fKN1Y2UDBhsxErK5v0bYhsG02oKlauzqYQq7CfjLWBua8O8AZg9eH/CizO3Xrew6
         x7lwjq1MOIN8rx4eA4Orb8qh/yk8STHTamjfErMiCF3aGY8k4YaUvfRzFEWqLhCdn8o6
         8m41AZI+/FjccpkU/7rjnjHOdOZbiFPiW9h0m75WgI5nv9WxbsobtwlsrzXhKfafp9kY
         mmCA==
X-Gm-Message-State: ALQs6tC3ZZvux84a+qSpcD3mUAeHREpqZmEHl8fOvxykTTf1HBVRAyGL
        SKZxfvqSmupp+Me4/5PCTsDAr8K0b9s=
X-Google-Smtp-Source: AIpwx48DTnuw6U2+JvPXPS71Jg35sDVpTFQUWRjBnQCJb1mVwaxkBU3CiUJecu5Isk2L9gle1LoWFg==
X-Received: by 10.200.39.210 with SMTP id x18mr16058839qtx.266.1522701286546;
        Mon, 02 Apr 2018 13:34:46 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:34:45 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 00/14] Serialized Git Commit Graph
Date:   Mon,  2 Apr 2018 16:34:13 -0400
Message-Id: <20180402203427.170177-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch has only a few changes since v6:

* Fixed whitespace issues using 'git rebase --whitespace=fix'

* The --stdin-packs docs now refer to "pack-indexes" insead of "packs"

* Modified description of --object-dir option to warn use is rare

* Replaced '--additive' with '--append'

* In "commit-graph: close under reachability" I greatly simplified
  the check that every reachable commit is included. While running
  tests I noticed that the revision walk machinery could not keep up
  with a very large queue created when combined with the '--append'
  option that added all commits from the existing file as starting
  points for the walk. The new algorithm simply appends missing commits
  to the end of the list, which are then iterated to ensure their
  parents are in the list.

I have a few patch series prepared that provide further performance
improvments following this patch.

-- >8 --

This patch contains a way to serialize the commit graph.

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

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commit walks. Here are some performance
results for a copy of the Linux repository where 'master' has 678,653
reachable commits and is behind 'origin/master' by 59,929 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  8.31s |  0.94s | -88%  |
| branch -vv                       |  1.02s |  0.14s | -86%  |
| rev-list --all                   |  5.89s |  1.07s | -81%  |
| rev-list --all --objects         | 66.15s | 58.45s | -11%  |

To test this yourself, run the following on your repo:

  git config core.commitGraph true
  git show-ref -s | git commit-graph write --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisons by toggling the 'core.commitGraph' setting.

[1] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (14):
  csum-file: rename hashclose() to finalize_hashfile()
  csum-file: refactor finalize_hashfile() method
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement write_commit_graph()
  commit-graph: implement git-commit-graph write
  commit-graph: implement git commit-graph read
  commit-graph: add core.commitGraph setting
  commit-graph: close under reachability
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits
  commit-graph: implement "--additive" option

 .gitignore                                    |   1 +
 Documentation/config.txt                      |   4 +
 Documentation/git-commit-graph.txt            |  94 +++
 .../technical/commit-graph-format.txt         |  97 +++
 Documentation/technical/commit-graph.txt      | 163 ++++
 Makefile                                      |   2 +
 alloc.c                                       |   1 +
 builtin.h                                     |   1 +
 builtin/commit-graph.c                        | 171 ++++
 builtin/index-pack.c                          |   2 +-
 builtin/pack-objects.c                        |   6 +-
 bulk-checkin.c                                |   4 +-
 cache.h                                       |   1 +
 command-list.txt                              |   1 +
 commit-graph.c                                | 738 ++++++++++++++++++
 commit-graph.h                                |  46 ++
 commit.c                                      |   3 +
 commit.h                                      |   3 +
 config.c                                      |   5 +
 contrib/completion/git-completion.bash        |   2 +
 csum-file.c                                   |  10 +-
 csum-file.h                                   |   9 +-
 environment.c                                 |   1 +
 fast-import.c                                 |   2 +-
 git.c                                         |   1 +
 pack-bitmap-write.c                           |   2 +-
 pack-write.c                                  |   5 +-
 packfile.c                                    |   4 +-
 packfile.h                                    |   2 +
 t/t5318-commit-graph.sh                       | 224 ++++++
 30 files changed, 1584 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
-- 
2.17.0.14.gba1221a8ce

