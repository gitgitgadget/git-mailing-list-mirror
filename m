Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633861FAED
	for <e@80x24.org>; Thu,  8 Jun 2017 05:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdFHFy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 01:54:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38010 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbdFHFy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 01:54:26 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jun 2017 01:54:25 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <glandium@glandium.org>)
        id 1dIq5c-0002Nn-Qh; Thu, 08 Jun 2017 14:34:36 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] fast-import: Increase the default pack depth to 50
Date:   Thu,  8 Jun 2017 14:34:36 +0900
Message-Id: <20170608053436.9121-1-mh@glandium.org>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 618e613a70, 10 years ago, the default for pack depth used for
git-pack-objects and git-repack was changed from 10 to 50, while
leaving fast-import's default to 10.

There doesn't seem to be a reason besides oversight for the change not
having happened in fast-import as well.

Interestingly, fast-import uses pack.depth when it's set, and the
git-config manual says the default for pack.depth is 50. While the
git-fast-import manual does say the default depth is 10, the
inconsistency is also confusing.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/git-fast-import.txt | 2 +-
 fast-import.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2b762654bf..3d3d219e58 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -121,7 +121,7 @@ Performance and Compression Tuning
 
 --depth=<n>::
 	Maximum delta depth, for blob and tree deltification.
-	Default is 10.
+	Default is 50.
 
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
diff --git a/fast-import.c b/fast-import.c
index e69d219682..05c73858b0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -280,7 +280,7 @@ struct recent_command {
 };
 
 /* Configured limits on output */
-static unsigned long max_depth = 10;
+static unsigned long max_depth = 50;
 static off_t max_packsize;
 static int unpack_limit = 100;
 static int force_update;
-- 
2.13.0

