From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 03/13] contrib/subtree: Better Error Handling for add
Date: Mon,  4 Feb 2013 22:06:03 -0600
Message-ID: <1360037173-23291-4-git-send-email-greened@obbligato.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ZpU-0005ul-FN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597Ab3BEEHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:07:38 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38005 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754584Ab3BEEHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:07:34 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2Zph-0003ZD-09; Mon, 04 Feb 2013 22:08:33 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360037173-23291-1-git-send-email-greened@obbligato.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215446>

From: "David A. Greene" <greened@obbligato.org>

Check refspecs for validity before passing them on to other commands.
This lets us generate more helpful error messages.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5598210..771f39d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -497,12 +497,18 @@ cmd_add()
 	ensure_clean
 	
 	if [ $# -eq 1 ]; then
-		"cmd_add_commit" "$@"
+	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
+	    die "'$1' does not refer to a commit"
+
+	    "cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
-		"cmd_add_repository" "$@"
+	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
+	    die "'$2' does not refer to a commit"
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
