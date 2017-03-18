Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152CA2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdCRV0p (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:26:45 -0400
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:52116 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdCRV0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 17:26:44 -0400
Received: from localhost.localdomain (unknown [145.129.9.233])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id B16928027D;
        Sat, 18 Mar 2017 22:00:32 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3 0/2] diff --no-index: support symlinks and pipes
Date:   Sat, 18 Mar 2017 22:00:36 +0100
Message-Id: <20170318210038.22638-1-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.12.0-437-g0cc2799
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff <(command1) <(command2) is less useful than it could be, all it outputs is:

diff --git a/dev/fd/63 b/dev/fd/62
index 9e6542b297..9f7b2c291b 120000
--- a/dev/fd/63
+++ b/dev/fd/62
@@ -1 +1 @@
-pipe:[464811685]
\ No newline at end of file
+pipe:[464811687]
\ No newline at end of file

Normal diff provides arguably better output: the diff of the output of the
commands. This series makes it possible for git diff --no-index to follow
symlinks and read from pipes, mimicking the behaviour of normal diff.

v1: http://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/
v2: http://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/

Changes since v2, prompted by feedback from Junio:

- A --derefence option was added and the default is no longer to dereference
  symlinks.
- Instead of looking at what canon_mode returns, use the original mode of 
  files to override behaviour for pipes.
- Turn the !S_ISREG(...) check into a should_mmap_file_contents helper.

Dennis Kaarsemaker (2):
  diff --no-index: optionally follow symlinks
  diff --no-index: support reading from pipes

 Documentation/diff-options.txt |  9 +++++++
 diff-no-index.c                | 16 ++++++++++---
 diff.c                         | 30 +++++++++++++++++++----
 diff.h                         |  2 +-
 t/t4053-diff-no-index.sh       | 54 ++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                  |  4 ++++
 6 files changed, 107 insertions(+), 8 deletions(-)

-- 
2.12.0-437-g0cc2799

