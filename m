From: Ted Percival <ted.percival@quest.com>
Subject: [PATCH] svn: Quote repository root in regex match
Date: Mon, 31 Oct 2011 16:37:12 -0600
Message-ID: <1320100632-10058-1-git-send-email-ted.percival@quest.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Ted Percival <ted.percival@quest.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 23:42:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL0Z1-0007gx-9m
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 23:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934648Ab1JaWmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 18:42:38 -0400
Received: from alvetxw02.quest.com ([12.106.87.94]:20687 "EHLO
	alvetxw02.quest.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934441Ab1JaWmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 18:42:37 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Oct 2011 18:42:37 EDT
Received: from ALVHTXW02.prod.quest.corp (10.1.135.18) by alvetxw02.quest.com
 (10.1.100.94) with Microsoft SMTP Server (TLS) id 14.1.255.0; Mon, 31 Oct
 2011 15:28:32 -0700
Received: from slc21znqg1.ipv6.vintela.com (10.1.0.6) by
 ALVHTXW02.prod.quest.corp (10.1.135.28) with Microsoft SMTP Server id
 14.1.255.0; Mon, 31 Oct 2011 15:37:28 -0700
Received: from ted by slc21znqg1.ipv6.vintela.com with local (Exim 4.72)
	(envelope-from <ted@slc21znqg1.prod.quest.corp>)	id 1RL0Tw-0002cr-24; Mon, 31
 Oct 2011 16:37:28 -0600
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184533>

Fixes a problem matching repository URLs, especially those with a '+' in
the URL, such as svn+ssh:// URLs. Parts of the URL were interpreted as
special characters by the regex matching.

Signed-off-by: Ted Percival <ted.percival@quest.com>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 351e743..4e95450 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -629,7 +629,7 @@ sub populate_merge_info {
 				fatal "merge commit $d has ancestor $parent, but that change "
                      ."does not have git-svn metadata!";
 			}
-			unless ($branchurl =~ /^$rooturl(.*)/) {
+			unless ($branchurl =~ /^\Q$rooturl\E(.*)/) {
 				fatal "commit $parent git-svn metadata changed mid-run!";
 			}
 			my $branchpath = $1;
@@ -791,7 +791,7 @@ sub cmd_dcommit {
 							 ."has uuid $uuid!";
 					}
 
-					unless ($branchurl =~ /^$rooturl(.*)/) {
+					unless ($branchurl =~ /^\Q$rooturl\E(.*)/) {
 						# This branch is very strange indeed.
 						fatal "merge parent $parent for $d is on branch "
 							 ."$branchurl, which is not under the "
-- 
1.7.7
