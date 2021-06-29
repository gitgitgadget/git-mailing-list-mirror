Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12047C11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED01561D97
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhF2INg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:13:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47906 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhF2INf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1ADF01F8C6
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 08:11:09 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] gracefully handling mmap failures
Date:   Tue, 29 Jun 2021 08:11:04 +0000
Message-Id: <20210629081108.28657-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With an out-of-the-box Linux kernel, I encountered failures at
all of these mmap call sites via "git cat-file --batch" on a
test repo with 100K total alternates.

While upping sys.vm.max_map_count and/or RLIMIT_DATA solves the
problem, not all users have administrative privileges to do so.

Eric Wong (4):
  use_pack: attempt to handle ENOMEM from mmap
  map_loose_object_1: attempt to handle ENOMEM from mmap
  check_packed_git_idx: attempt to handle ENOMEM from mmap
  xmmap: inform Linux users of tuning knobs on ENOMEM

 object-file.c | 16 ++++++++++++++--
 packfile.c    | 17 ++++++++++++-----
 packfile.h    |  2 ++
 3 files changed, 28 insertions(+), 7 deletions(-)
