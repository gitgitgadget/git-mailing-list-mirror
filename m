Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0FE20281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbdIYKLN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:13 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:6263 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbdIYKLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:11 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQLzdIVI1; Mon, 25 Sep 2017 11:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334269; bh=nNHyvUDKrNxs5mtlk4iUOAvPlZjBa52VJgije42zDMU=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=hLrKLhlrIQ+yWCMT/6foprh3votuFxnx+TH7DugypQoSrKv3rq9CfI9vtUGd/LPm9
         tzpmu2+08ib5Cn5BF7gnBbcynX4oPwvPmtS+3jWXZ9ZFCXncGIS1GqcvAqOEtuj5lW
         fYryO3SS6PrlZbWOzZ1eGArsP69QSWVYW0mGoNEI=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=kmTqX9WnRFBybHNNplAA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 0/8] sequencer: dont't fork git commit
Date:   Mon, 25 Sep 2017 11:10:33 +0100
Message-Id: <20170925101041.18344-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJJ59XboN+XWzfinWRSFXj7D/RCjjMkq7mODKOv0VRH6Zw5PzsxiOUR7EECn2kVFYv7DnDILHlvDvDvH/BZvNQkwbQndVqRBtG/UDlFdzDpiO5Stcnvz
 mDKcphaN9S3yADXu6rf/Kb3viv2oHn4OujYlcfe48ZnOwadOjL1hg0hdHTuxvdamohGeX+OnLSMW3BY5jOGQN+EI+xhs+oAVW3zJ2knYjQISHAY/UyL2EC62
 aoqtIOOGGSKxufrfMjE4P5uvhgCbV2PA3j8/NU6h1eA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches teach the sequencer to create commits without forking
git commit when the commit message does not need to be edited. This
speeds up cherry picking 10 commits by 26% and picking 10 commits with
rebase --continue by 44%. The first few patches move bits of
builtin/commit.c to sequencer.c. The last two patches actually
implement creating commits in sequencer.c.

Phillip Wood (8):
  commit: move empty message checks to libgit
  commit: move code to update HEAD to libgit
  sequencer: refactor update_head()
  commit: move post-rewrite code to libgit
  commit: move print_commit_summary() to libgit
  sequencer: simplify adding Signed-off-by: trailer
  sequencer: load commit related config
  sequencer: try to commit without forking 'git commit'

 builtin/commit.c         | 269 ++--------------------------
 builtin/rebase--helper.c |  13 +-
 builtin/revert.c         |  15 +-
 sequencer.c              | 447 ++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h              |  20 +++
 5 files changed, 503 insertions(+), 261 deletions(-)

-- 
2.14.1

