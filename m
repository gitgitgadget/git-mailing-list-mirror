Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F2C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBCD20757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vVD3jx3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgD2Rga (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Rga (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B2FC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so1038630pju.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2S5xsYhYRowG9QOEe65h5HgAOoKzCyp6Udz7Uaf984=;
        b=vVD3jx3CfXeTrOQXbcY1mE7+/BWRYZZQ5SkT/7Rkz0HYVZic5giiZPK0c7+HE9Ll+Y
         S+QqBYG1HdWhnRs8v6JlAUlYhpuTG4/CtgMDL6i4py9KJTfXEA2bn8U3tWQB5n9seHAw
         ZakgvKT5kFd7QH6bh9Q+iUvtmcUe6RSFzxvzgmsu8poPVWO8sNu3U6XQeVq/HNKYPnMa
         4YXRDhGtourNDlCIIEpQXkmB3fmGmpgQ/k0ukDo/p+TctR6wdrgt98GoB3Doi8+eKqlJ
         h/uTR8EEYxKbSSClVdK3Jy9e6+BYsfAYzncxgN54DMwViDz5yU3AwryG0XyNAOYspkhR
         I1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2S5xsYhYRowG9QOEe65h5HgAOoKzCyp6Udz7Uaf984=;
        b=irFVDcqvZQsj2Wfrm8nd6CPma/kXC89uIVH1qMQNNw5CLmfCl5gbNQNdRCfTLCHqbu
         fJtt2BNat/OMLjYDNiZy80xRvOq3Yp1xy+AdL5RrpV6r9Li08taxSVfzYQwwrmtF5m50
         SqdpW0DerWKsAFgoDnNVOw5EVwX0hOJJmHGk/jKBfCt93i3d+iMbjHb6P15cuJz1120i
         4zKvcxj407O5OWN33ksWSS/+K3znoOEEODL4GbNuf/PFvnnDO8wWzCqZohkH++vBCvcX
         Ke23VVU2ycocfWKfjMnASeZHPV7XLG8olMf46Mxhqlsq6M/ZSdhgmUgP5F4GRkXNRcN0
         6DLw==
X-Gm-Message-State: AGi0PuZVicveyMD1vTbkE4PPDsADEJvq3kWzQmh/VQVPQ+AsIUNZWm0o
        W0dIaykaBET6I7GCKQuaTiE82Uubu3M9dA==
X-Google-Smtp-Source: APiQypLU0++5Oclq1un195UkYdgxR08qqyL6isGT/8CGrq27wCENZYl7HtixS+UIxDS+z7Fysnlf5A==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr19031601plp.184.1588181789020;
        Wed, 29 Apr 2020 10:36:29 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 20sm1547300pfx.116.2020.04.29.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:28 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:26 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 0/5] commit-graph: write non-split graphs as read-only
Message-ID: <cover.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a brief reroll to incorporate suggestions from Junio and Peff in
the sub-thread beginning at [1]. Not much at all has changed since v2,
with the exception of:

  * fixing the aforementioned issue by sprinkling in some 'umask 022's
    in throughout the new tests

  * adding in a new final patch to apply the same treatment to
    the 'commit-graph-chain' file

[1]: https://lore.kernel.org/git/xmqqr1w85vtq.fsf@gitster.c.googlers.com/

Taylor Blau (5):
  tempfile.c: introduce 'create_tempfile_mode'
  lockfile.c: introduce 'hold_lock_file_for_update_mode'
  commit-graph.c: write non-split graphs as read-only
  commit-graph.c: ensure graph layers respect core.sharedRepository
  commit-graph.c: make 'commit-graph-chain's read-only

 commit-graph.c                | 12 ++++++++++--
 lockfile.c                    | 18 ++++++++++--------
 lockfile.h                    | 32 ++++++++++++++++++++++++++++----
 t/t5318-commit-graph.sh       | 15 ++++++++++++++-
 t/t5324-split-commit-graph.sh | 24 ++++++++++++++++++++++++
 t/t6600-test-reach.sh         |  2 ++
 tempfile.c                    |  6 +++---
 tempfile.h                    | 10 +++++++++-
 8 files changed, 100 insertions(+), 19 deletions(-)

Range-diff against v2:
1:  03c975b0bd = 1:  03c975b0bd tempfile.c: introduce 'create_tempfile_mode'
2:  c1c84552bc = 2:  c1c84552bc lockfile.c: introduce 'hold_lock_file_for_update_mode'
3:  86cf29ce9c ! 3:  8d5503d2e6 commit-graph.c: write non-split graphs as read-only
    @@ Commit message
         commit-graph file into place and then trying to replace it. For these,
         make these files writable.

    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## commit-graph.c ##
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      	}

      ## t/t5318-commit-graph.sh ##
    +@@ t/t5318-commit-graph.sh: test_expect_success 'setup full repo' '
    + 	test_oid_init
    + '
    +
    ++test_expect_success POSIXPERM 'tweak umask for modebit tests' '
    ++	umask 022
    ++'
    ++
    + test_expect_success 'verify graph with no graph file' '
    + 	cd "$TRASH_DIRECTORY/full" &&
    + 	git commit-graph verify
     @@ t/t5318-commit-graph.sh: test_expect_success 'write graph' '
      	graph_read_expect "3"
      '
4:  f83437f130 ! 4:  4b74e23af2 commit-graph.c: ensure graph layers respect core.sharedRepository
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      		hold_lock_file_for_update_mode(&lk, ctx->graph_name,

      ## t/t5324-split-commit-graph.sh ##
    +@@ t/t5324-split-commit-graph.sh: graph_read_expect() {
    + 	test_cmp expect output
    + }
    +
    ++test_expect_success POSIXPERM 'tweak umask for modebit tests' '
    ++	umask 022
    ++'
    ++
    + test_expect_success 'create commits and write commit-graph' '
    + 	for i in $(test_seq 3)
    + 	do
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'split across alternate where alternate is not split' '
      	test_cmp commit-graph .git/objects/info/commit-graph
      '
-:  ---------- > 5:  864c916067 commit-graph.c: make 'commit-graph-chain's read-only
--
2.26.0.113.ge9739cdccc
