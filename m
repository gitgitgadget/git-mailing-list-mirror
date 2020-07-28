Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0CDC43458
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039852074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgG1Qg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:36:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:39880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbgG1QgT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:36:19 -0400
Received: (qmail 27684 invoked by uid 109); 28 Jul 2020 16:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 16:36:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26384 invoked by uid 111); 28 Jul 2020 16:36:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 12:36:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 12:36:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] making --first-parent imply -m
Message-ID: <20200728163617.GA2649887@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some projects, it's useful to walk the first parent history, looking
at each merge commit as a normal commit introducing all of the changes
no its side branch. E.g.:

  git log --first-parent -m -Sfoo -p

might show you the topic or pull request that introduced code "foo". But
I quite often forget to add "-m", and get confused that it doesn't
return any results.

This series just makes --first-parent imply -m. That doesn't change any
output by itself, but does mean that diff options like "-p", "-S", etc,
behave sensibly.

  [1/3]: log: drop "--cc implies -m" logic
  [2/3]: revision: add "--ignore-merges" option to counteract "-m"
  [3/3]: log: enable "-m" automatically with "--first-parent"

 Documentation/rev-list-options.txt            |  1 +
 builtin/log.c                                 |  7 +-
 revision.c                                    | 10 ++-
 revision.h                                    |  2 +-
 t/t4013-diff-various.sh                       |  1 +
 ...g_--ignore-merges_-p_--first-parent_master | 78 +++++++++++++++++++
 t/t4013/diff.log_-p_--first-parent_master     | 22 ++++++
 7 files changed, 113 insertions(+), 8 deletions(-)
 create mode 100644 t/t4013/diff.log_--ignore-merges_-p_--first-parent_master

-Peff
