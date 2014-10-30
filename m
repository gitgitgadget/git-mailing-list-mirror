From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: (cleanup) remove editor param passing
Date: Thu, 30 Oct 2014 08:36:45 +0000
Message-ID: <1414658206-12629-1-git-send-email-normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 09:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjlDx-0004gS-P5
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 09:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbaJ3Igs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 04:36:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59012 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbaJ3Igr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 04:36:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C749A1F7C9
	for <git@vger.kernel.org>; Thu, 30 Oct 2014 08:36:46 +0000 (UTC)
X-Mailer: git-send-email 2.1.2.568.g4ae9a7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither find_extra_svk_parents or find_extra_svn_parents ever
used the `$ed' parameter.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 5f9d469..893b9a8 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1433,7 +1433,7 @@ sub check_author {
 }
 
 sub find_extra_svk_parents {
-	my ($self, $ed, $tickets, $parents) = @_;
+	my ($self, $tickets, $parents) = @_;
 	# aha!  svk:merge property changed...
 	my @tickets = split "\n", $tickets;
 	my @known_parents;
@@ -1736,7 +1736,7 @@ sub mergeinfo_changes {
 # note: this function should only be called if the various dirprops
 # have actually changed
 sub find_extra_svn_parents {
-	my ($self, $ed, $mergeinfo, $parents) = @_;
+	my ($self, $mergeinfo, $parents) = @_;
 	# aha!  svk:merge property changed...
 
 	memoize_svn_mergeinfo_functions();
@@ -1835,16 +1835,14 @@ sub make_log_entry {
 	my @parents = @$parents;
 	my $props = $ed->{dir_prop}{$self->path};
 	if ( $props->{"svk:merge"} ) {
-		$self->find_extra_svk_parents
-			($ed, $props->{"svk:merge"}, \@parents);
+		$self->find_extra_svk_parents($props->{"svk:merge"}, \@parents);
 	}
 	if ( $props->{"svn:mergeinfo"} ) {
 		my $mi_changes = $self->mergeinfo_changes
 			($parent_path, $parent_rev,
 			 $self->path, $rev,
 			 $props->{"svn:mergeinfo"});
-		$self->find_extra_svn_parents
-			($ed, $mi_changes, \@parents);
+		$self->find_extra_svn_parents($mi_changes, \@parents);
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
-- 
EW
