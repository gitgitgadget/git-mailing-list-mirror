From: Adam Roben <aroben@apple.com>
Subject: [PATCH] git-svn: Ignore usernames in URLs in find_by_url
Date: Wed, 25 Apr 2007 12:42:58 -0700
Message-ID: <1177530178545-git-send-email-aroben@apple.com>
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgnPu-00085K-Ew
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992994AbXDYTnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992988AbXDYTnS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:43:18 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:64916 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992993AbXDYTnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:43:10 -0400
Received: from relay6.apple.com (a17-128-113-36.apple.com [17.128.113.36])
	by mail-out3.apple.com (8.13.8/8.13.8) with ESMTP id l3PJh9hW008875;
	Wed, 25 Apr 2007 12:43:09 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id 9B72010082;
	Wed, 25 Apr 2007 12:43:09 -0700 (PDT)
X-AuditID: 11807124-a149ebb000000872-23-462faf4d76c5 
Received: from localhost.localdomain (unknown [17.219.212.53])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 7CF7710054;
	Wed, 25 Apr 2007 12:43:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.rc0.16.ge10ca-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45551>

Usernames don't matter for the purposes of find_by_url, so always remove them
before doing any comparisons.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 90f3bc1..59008cc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1064,6 +1064,8 @@ sub init_remote_config {
 
 sub find_by_url { # repos_root and, path are optional
 	my ($class, $full_url, $repos_root, $path) = @_;
+	remove_username($full_url);
+	remove_username($repos_root) if defined $repos_root;
 	return undef unless defined $full_url;
 	my $remotes = read_all_remotes();
 	if (defined $full_url && defined $repos_root && !defined $path) {
@@ -1072,6 +1074,7 @@ sub find_by_url { # repos_root and, path are optional
 	}
 	foreach my $repo_id (keys %$remotes) {
 		my $u = $remotes->{$repo_id}->{url} or next;
+		remove_username($u);
 		next if defined $repos_root && $repos_root ne $u;
 
 		my $fetch = $remotes->{$repo_id}->{fetch} || {};
-- 
1.5.2.rc0.16.ge10ca-dirty
