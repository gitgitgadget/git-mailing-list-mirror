Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37701F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeA3VkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:07 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36199 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeA3VkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:05 -0500
Received: by mail-qk0-f194.google.com with SMTP id d21so12130146qkj.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JxImKW6hQzdICIcso2+KahiLeQhXdHhVlfvlUUsXaek=;
        b=Z1DC6PuXVtS9eqyWxqwvFsoto/pgb1zfebYPFnACRkcRNMtt9MOhvJ8HT0xKwPttTW
         3GDab7dKzAb/06z+H7cyHhX3VONZZrTrKCEV4hfpAaC4IWpamNXnYyHV2YnWI91If28e
         OyAF9d+vOcbztf0cJ+r+7jLDhQUckYwHmNyd9z5cJi72iImPybbWr7yEEx+mxgI9W3+s
         yUIdKqg1RAzAvdOS2RAWCxSXJEPBueoL+Sti3Yq/7OiR+SPE4Kt9En/h+kkawe9f0BiJ
         LUp7Ra8YATiTUnixWli7Vk49KVMwyf/YdJrdyLTD5CRiwP5+DjtDFaxaOhvhRajRlPdf
         FgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JxImKW6hQzdICIcso2+KahiLeQhXdHhVlfvlUUsXaek=;
        b=LhiIwmFZLVVgVudGEsY+rdz10LsM1MCx5R4oLo8lveM6xVo+RfZdjsXas4WFWracRx
         57fsond5Ppzw7g3sSxf5m0gmvHNqwXan7BVQ8v0A2rS4QHjNQyES4jwAuvvIC46RODAq
         gBZAFyBo/mLvheVEd9r4mLqrVa0ldk+qcK2IhER+qGEfRBmO5XS2q/Hu2UyD0oVHfuJ3
         AqQUYesQoJsRwfwWMEaQiCe+EBF/M9Xr6UMtjEQLPXVhbMZTWKzeMcsRzQwATdmUho0l
         luCBuGehbk5IZ/MzHOldsvo8N2ADOykrq4QjL4EZxlYXkX0KbbI/VLaC/R434iMTglc5
         3VUQ==
X-Gm-Message-State: AKwxytfeJw78Y7mcngv6kG8swbdBvBt0NoeHX0jbehB5usDswjBChZug
        I4VkmZKgcOyTA7x50zPbNGzvGhKR
X-Google-Smtp-Source: AH8x226CIfVnsoVf7X1hvGZx9EsjGmL2p2V9LpnKFWrT73QpPC8/hQoCd0hyKRJpcQRA1iYciDNJYg==
X-Received: by 10.55.160.206 with SMTP id j197mr46596454qke.245.1517348404413;
        Tue, 30 Jan 2018 13:40:04 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:03 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 00/14] Serialized Git Commit Graph
Date:   Tue, 30 Jan 2018 16:39:29 -0500
Message-Id: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone who gave comments on v1. I tried my best to respond to
all of the feedback, but may have missed some while I was doing several
renames, including:

* builtin/graph.c -> builtin/commit-graph.c
* packed-graph.[c|h] -> commit-graph.[c|h]
* t/t5319-graph.sh -> t/t5318-commit-graph.sh

Because of these renames (and several type/function renames) the diff
is too large to conveniently share here.

Some issues that came up and are addressed:

* Use <hash> instead of <oid> when referring to the graph-<hash>.graph
  filenames and the contents of graph-head.
* 32-bit timestamps will not cause undefined behavior.
* timestamp_t is unsigned, so they are never negative.
* The config setting "core.commitgraph" now only controls consuming the
  graph during normal operations and will not block the commit-graph
  plumbing command.
* The --stdin-commits is better about sanitizing the input for strings
  that do not parse to OIDs or are OIDs for non-commit objects.

One unresolved comment that I would like consensus on is the use of
globals to store the config setting and the graph state. I'm currently
using the pattern from packed_git instead of putting these values in
the_repository. However, we want to eventually remove globals like
packed_git. Should I deviate from the pattern _now_ in order to keep
the problem from growing, or should I keep to the known pattern?

Finally, I tried to clean up my incorrect style as I was recreating
these commits. Feel free to be merciless in style feedback now that the
architecture is more stable.

Thanks,
-Stolee

-- >8 --

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

  git config core.commitgraph true
  git show-ref -s | git graph --write --update-head --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisions by toggling the 'core.commitgraph' setting.

[1] https://public-inbox.org/git/d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com/
    Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)

[2] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (14):
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement construct_commit_graph()
  commit-graph: implement git-commit-graph --write
  commit-graph: implement git-commit-graph --read
  commit-graph: implement git-commit-graph --update-head
  commit-graph: implement git-commit-graph --clear
  commit-graph: teach git-commit-graph --delete-expired
  commit-graph: add core.commitgraph setting
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: close under reachability
  commit-graph: build graph from starting commits

 .gitignore                                      |   1 +
 Documentation/config.txt                        |   3 +
 Documentation/git-commit-graph.txt              | 100 +++
 Documentation/technical/commit-graph-format.txt |  89 +++
 Documentation/technical/commit-graph.txt        | 189 ++++++
 Makefile                                        |   2 +
 alloc.c                                         |   1 +
 builtin.h                                       |   1 +
 builtin/commit-graph.c                          | 229 +++++++
 cache.h                                         |   1 +
 command-list.txt                                |   1 +
 commit-graph.c                                  | 841 ++++++++++++++++++++++++
 commit-graph.h                                  |  69 ++
 commit.c                                        |  10 +-
 commit.h                                        |   4 +
 config.c                                        |   5 +
 environment.c                                   |   1 +
 git.c                                           |   1 +
 log-tree.c                                      |   3 +-
 packfile.c                                      |   4 +-
 packfile.h                                      |   2 +
 t/t5318-commit-graph.sh                         | 272 ++++++++
 22 files changed, 1824 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh

-- 
2.16.0

