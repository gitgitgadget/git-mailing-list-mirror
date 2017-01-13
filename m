Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A50120798
	for <e@80x24.org>; Fri, 13 Jan 2017 10:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdAMK2b (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 05:28:31 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53464 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdAMK23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 05:28:29 -0500
Received: from hurricane.booking.pcln.com (unknown [5.57.20.50])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id DEDFB801F1;
        Fri, 13 Jan 2017 11:20:28 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 0/2] diff --no-index: support symlinks and pipes
Date:   Fri, 13 Jan 2017 11:20:19 +0100
Message-Id: <20170113102021.6054-1-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.11.0-234-gaf85957
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

Changes since the RFC/v1 patch:
- Following symlinks is now the default. I think an accurate summary of the
  discussion on v1 is that this behaviour is useful enough to be the default,
  but to add an escape hatch. That escape hatch is named --no-dereference, name
  stolen from gnu diff.
- Added tests and documentation

Specifically not changed:
These changes affect only diff --no-index. Using --no-dereference is an error
without --no-index.

Dennis Kaarsemaker (2):
  diff --no-index: follow symlinks
  diff --no-index: support reading from pipes

 Documentation/diff-options.txt |  7 +++++++
 diff-no-index.c                | 15 ++++++++++++---
 diff.c                         | 23 +++++++++++++++++++----
 diff.h                         |  2 +-
 t/t4053-diff-no-index.sh       | 40 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                  |  4 ++++
 6 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.11.0-234-gaf85957

