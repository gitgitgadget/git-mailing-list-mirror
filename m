From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 4/7] contrib/subtree: Better Error Handling for add
Date: Tue,  8 Jan 2013 06:09:54 -0600
Message-ID: <1357646997-28675-5-git-send-email-greened@obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsY1e-00022P-NV
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 13:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3AHMLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 07:11:07 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51756 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755964Ab3AHMLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 07:11:06 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsY8u-0003z5-3p; Tue, 08 Jan 2013 06:18:56 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357646997-28675-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Check refspecs
    for validity before passing them on to other commands. This lets us generate
    more helpful error messages. Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/git-subtree.sh | 12 +++++++++--- 1 file changed, 9 insertions(+),
    3 deletions(-) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED      
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212956>

From: "David A. Greene" <greened@obbligato.org>

Check refspecs for validity before passing them on to other commands.
This lets us generate more helpful error messages.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index cac0680..d53eaee 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -508,12 +508,18 @@ cmd_add()
 	ensure_clean
 	
 	if [ $# -eq 1 ]; then
-		"cmd_add_commit" "$@"
+	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
+            die "'$1' does not refer to a commit"
+
+	    "cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
-		"cmd_add_repository" "$@"
+	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
+            die "'$2' does not refer to a commit"
+
+	    "cmd_add_repository" "$@"
 	else
 	    say "error: parameters were '$@'"
-	    die "Provide either a refspec or a repository and refspec."
+	    die "Provide either a commit or a repository and commit."
 	fi
 }
 
-- 
1.7.10.4
