From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Use the config file to set repository owner's name.
Date: Fri,  8 Feb 2008 02:41:53 -0200
Message-ID: <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 05:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNL4x-0005L9-L2
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759981AbYBHEmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758309AbYBHEmf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:42:35 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:51688 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758172AbYBHEmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:42:20 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 70C737000042D;
	Fri,  8 Feb 2008 02:42:19 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
In-Reply-To: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73036>

From: Git Managment for C3SL <git@git.c3sl.ufpr.br>

Now gitweb checks if gitweb.owner exists before trying to get filesystem's
owner.

Allow to use configuration variable gitweb.owner set the repository owner,
it checks the gitweb.owner, if not set it uses filesystem directory's owner.

Useful when we don't want to maintain project list file, and all
repository directories have to have the same owner (for example when the
same SSH account is shared for all projects, using ssh_acl to control
access instead).

Signed-off-by: Git Managment for C3SL <git@git.c3sl.ufpr.br>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8ef2735..e8a43b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1767,7 +1767,12 @@ sub git_get_project_owner {
 	if (exists $gitweb_project_owner->{$project}) {
 		$owner = $gitweb_project_owner->{$project};
 	}
-	if (!defined $owner) {
+
+	if (!defined $owner){
+		$owner = git_get_project_config('owner');
+	}
+
+	if (!$owner) {
 		$owner = get_file_owner("$projectroot/$project");
 	}
 
-- 
1.5.4.34.g053d9-dirty
