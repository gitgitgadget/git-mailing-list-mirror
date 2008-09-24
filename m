Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 25098 invoked by uid 111); 24 Sep 2008 23:33:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYIXXdA (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 19:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYIXXdA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:33:00 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50348 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752278AbYIXXc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:32:59 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 543FB2AC8DA; Thu, 25 Sep 2008 01:32:47 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org
Subject: [PATCH] Fix removing non-pushable remotes
Date:	Thu, 25 Sep 2008 01:32:47 +0200
Message-Id: <1222299167-4305-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <20080924204616.189163849@suse.cz>
References: <20080924204616.189163849@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Git-gui does not add most of the remotes to the 'push' menu
since they are missing the "Push" line in their remotespec.
In that case, removing the remote would end up with an error.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

Note that I think this should be abandoned and all remotes
added to the push menu. Having the push part of the remotespec
is actually a very rare situation and it is just not there
in most of the cases, relying on default git push behaviour.

 git-gui/lib/remote.tcl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/remote.tcl b/git-gui/lib/remote.tcl
index 1852247..b92b429 100644
--- a/git-gui/lib/remote.tcl
+++ b/git-gui/lib/remote.tcl
@@ -271,5 +271,6 @@ proc remove_remote {name} {
 	delete_from_menu $remote_m.fetch $name
 	delete_from_menu $remote_m.prune $name
 	delete_from_menu $remote_m.remove $name
-	delete_from_menu $remote_m.push $name
+	# Not all remotes are in the push menu
+	catch { delete_from_menu $remote_m.push $name }
 }
-- 
tg: (17f0c43..) t/git-gui/remove-push (depends on: git-gui/remotes)
