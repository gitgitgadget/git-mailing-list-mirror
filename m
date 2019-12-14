Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25131C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B3224656
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 16:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNQPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 11:15:14 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57001 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNQPO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 11:15:14 -0500
X-Originating-IP: 157.36.95.247
Received: from localhost.localdomain (unknown [157.36.95.247])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B14CFE000D
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 16:15:11 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/1] worktree: delete branches auto-created by 'worktree add'
Date:   Sat, 14 Dec 2019 21:44:37 +0530
Message-Id: <20191214161438.16157-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This fixes a small annoyance I had with git-worktree. Most of the
feature is explained in the patch, so I'm using the cover letter to
leave a couple of notes.

- Since the patch changes current behaviour of git-worktree-remove, it
  might break existing scripts. In that case, we might want to add a
  config variable and command line option to trigger that. But for the
  sake of simplicity, I went with making the behaviour default. I don't
  mind making it optional if people think that would be a better idea.

- To make sure no commits are lost, the branch is not deleted if it has
  moved since its creation. This is a more conservative approach. An
  alternative would be to run 'git branch -d' directly without checking if
  branch has moved. This will mean new commits not in upstream branch are
  still preserved but if the branch is simply moved to another commit it
  will still be deleted.

Pratyush Yadav (1):
  worktree: delete branches auto-created by 'worktree add'

 Documentation/git-worktree.txt |  9 ++++--
 builtin/worktree.c             | 52 ++++++++++++++++++++++++++++++++--
 t/t2403-worktree-move.sh       | 45 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 5 deletions(-)

--
2.24.1

