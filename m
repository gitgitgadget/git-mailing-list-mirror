Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10744 invoked by uid 111); 8 Mar 2008 11:50:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Mar 2008 06:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYCHLuR (ORCPT <rfc822;peff@peff.net>);
	Sat, 8 Mar 2008 06:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYCHLuM
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 06:50:12 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:49778 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752746AbYCHLuK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 06:50:10 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id AD0B518DABD;
	Sat,  8 Mar 2008 03:50:09 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date:	Sat,  8 Mar 2008 06:50:07 -0500
Message-Id: <1204977007-7267-3-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.487.g5a92
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add a currently-failing test for the case when git-filter-branch
is run with the --subdirectory-filter referencing a folder that
has been added, deleted, and re-added. Such an action should work,
but as this test shows it ends up blowing up.
---
 t/t7003-filter-branch.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 868babc..933157b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -179,4 +179,17 @@ test_expect_success 'Name needing quotes' '
 
 '
 
+test_expect_success 'Subdirectory filter on folder with non-contiguous history' '
+	mkdir foo &&
+	touch foo/bar &&
+	git add foo &&
+	git commit -m "Adding foo" &&
+	git rm -r foo &&
+	git commit -m "Removing foo" &&
+	mkdir foo &&
+	touch foo/bar &&
+	git commit -m "Re-adding foo" &&
+	git filter-branch --subdirectory-filter foo
+'
+
 test_done
-- 
1.5.4.3.487.g5a92

