X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 4/5] git-svn: collect revision properties when fetching
Date: Tue, 05 Dec 2006 16:17:38 +1100
Message-ID: <20061205051738.16552.36012.stgit@localhost>
References: <20061205051738.16552.8987.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Tue, 5 Dec 2006 05:22:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205051738.16552.8987.stgit@localhost>
User-Agent: StGIT/0.10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33302>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrSlB-0001ly-1V for gcvg-git@gmane.org; Tue, 05 Dec
 2006 06:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937342AbWLEFWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 00:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937341AbWLEFWZ
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 00:22:25 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:42239 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937342AbWLEFWY (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 00:22:24 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 8D0C5139B0E;
 Tue,  5 Dec 2006 18:22:18 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

From: Sam Vilain <sam@vilain.net>

Perhaps there is information in the "revision properties" (unversioned
metadata associated with commits) that will affect the way that we
save the revision.  Collect them.
---
Sorry for the long lines.

 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 800c579..70c34b0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -441,12 +441,16 @@ sub fetch_lib {
 					if ($last_commit) {
 						$log_msg = libsvn_fetch(
 							$last_commit, @_);
+						$log_msg->{revprops}
+							= $SVN->rev_proplist($log_msg->{revision});
 						$last_commit = git_commit(
 							$log_msg,
 							$last_commit,
 							@parents);
 					} else {
 						$log_msg = libsvn_new_tree(@_);
+						$log_msg->{revprops}
+							= $SVN->rev_proplist($log_msg->{revision});
 						$last_commit = git_commit(
 							$log_msg, @parents);
 					}
