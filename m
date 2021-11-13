Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04633C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC696610CE
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhKMDhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54547 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235610AbhKMDhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:16 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3XxLO004951
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:01 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 0/8] protect branches checked out in all worktrees
Date:   Fri, 12 Nov 2021 19:33:50 -0800
Message-Id: <20211113033358.2179376-1-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

‘git fetch’ (without ‘--update-head-ok’), ‘git receive-pack’, and ‘git
branch -M’ protect the currently checked out branch from being
accidentally updated.  However, the code for these checks predates
‘git worktree’.  Improve it to protect branches checked out in all
worktrees, not just the current one.

Anders Kaseorg (8):
  fetch: lowercase error messages
  receive-pack: lowercase error messages
  branch: lowercase error messages
  worktree: simplify find_shared_symref() memory ownership model
  fetch: protect branches checked out in all worktrees
  receive-pack: clean dead code from update_worktree()
  receive-pack: protect current branch for bare repository worktree
  branch: protect branches checked out in all worktrees

 branch.c                        |  41 +++++++-----
 builtin/branch.c                |   7 +-
 builtin/fetch.c                 | 115 +++++++++++++++++---------------
 builtin/notes.c                 |   6 +-
 builtin/receive-pack.c          |  88 +++++++++++++-----------
 t/t2018-checkout-branch.sh      |   2 +-
 t/t3200-branch.sh               |   9 ++-
 t/t5504-fetch-receive-strict.sh |   2 +-
 t/t5516-fetch-push.sh           |  32 +++++++++
 worktree.c                      |   8 +--
 worktree.h                      |   5 +-
 11 files changed, 191 insertions(+), 124 deletions(-)

-- 
2.33.1

