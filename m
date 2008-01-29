From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 01:36:06 -0200
Message-ID: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 04:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJhH5-0001up-E7
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbYA2DgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 22:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYA2DgG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:36:06 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:55162 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYA2DgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:36:05 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id EF15D700003CB;
	Tue, 29 Jan 2008 01:36:03 -0200 (BRST)
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71944>

This file ($projectroot/$project/owner) is good to have when we don't want to
maintain a project  list AND when we share same SSH account for all projects,
using ssh_acl for example.

Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/gitweb.perl |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6256641..fac5f78 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1754,6 +1754,15 @@ sub git_get_project_list_from_file {
 	}
 }
 
+sub get_owner_file {
+    my $owner_file = shift;
+
+	open my $fd, "$owner_file" or return undef;
+	my $owner = <$fd>;
+	close $fd;
+	return to_utf8($owner);
+}
+
 sub git_get_project_owner {
 	my $project = shift;
 	my $owner;
@@ -1767,6 +1776,11 @@ sub git_get_project_owner {
 	if (exists $gitweb_project_owner->{$project}) {
 		$owner = $gitweb_project_owner->{$project};
 	}
+
+    if ( -f "$projectroot/$project/owner" ) {
+        $owner = get_owner_file("$projectroot/$project/owner");
+    }
+
 	if (!defined $owner) {
 		$owner = get_file_owner("$projectroot/$project");
 	}
-- 
1.5.3.8
