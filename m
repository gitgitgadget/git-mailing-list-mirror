X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 3/4] git-svn: collect revision properties when fetching
Date: Mon, 4 Dec 2006 20:40:39 +1100
Message-ID: <20061204235724.61843139B0D@magnus.utsl.gen.nz>
NNTP-Posting-Date: Mon, 4 Dec 2006 23:57:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33269>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNgg-0005UP-NJ for gcvg-git@gmane.org; Tue, 05 Dec
 2006 00:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936091AbWLDX51 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937175AbWLDX51
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 18:57:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60225 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S936091AbWLDX5Z (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 18:57:25 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 61843139B0D;
 Tue,  5 Dec 2006 12:57:24 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Perhaps there is information in the "revision properties" (unversioned
metadata associated with commits) that will affect the way that we
save the revision.  Collect them.
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c5f82be..74b04d0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -441,12 +441,16 @@ sub fetch_lib {
 					if ($last_commit) {
 						$log_msg = libsvn_fetch(
 							$last_commit, @_);
+						$log_msg->{revprops}
+						    = $SVN->rev_proplist($log_msg->{revision});
 						$last_commit = git_commit(
 							$log_msg,
 							$last_commit,
 							@parents);
 					} else {
 						$log_msg = libsvn_new_tree(@_);
+						$log_msg->{revprops}
+						    = $SVN->rev_proplist($log_msg->{revision});
 						$last_commit = git_commit(
 							$log_msg, @parents);
 					}
-- 
1.4.4.1.ge918e-dirty
