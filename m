From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] contrib/hooks/post-receive-email:  checks for gitweb.description
Date: Tue, 12 Feb 2008 01:25:46 -0200
Message-ID: <1202786746-12890-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 04:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlmp-0001r2-OF
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 04:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYBLDZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 22:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbYBLDZt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 22:25:49 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:36442 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbYBLDZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 22:25:48 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 9BAC7700000A8;
	Tue, 12 Feb 2008 01:25:46 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73625>

Check repository configuration gitweb.description for project description,
if $GIT_DIR/description does not exist

Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 contrib/hooks/post-receive-email |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 77c88eb..bdd21fa 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -614,7 +614,11 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+if [ -f "$GIT_DIR/description" ]; then
+	projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+else
+	projectdesc=$(git-config gitweb.description)
+fi
 # Check if the description is unchanged from it's default, and shorten it to
 # a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-- 
1.5.4.24.gce08d
