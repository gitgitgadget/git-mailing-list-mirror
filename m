From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 3/8] Better Error Handling for add
Date: Mon, 31 Dec 2012 21:57:30 -0600
Message-ID: <1357012655-24974-4-git-send-email-greened@obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 04:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpszx-0008Jl-8r
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab3AAD6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:58:23 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48323 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751526Ab3AAD6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:58:20 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpt6h-0005na-8Q; Mon, 31 Dec 2012 22:05:39 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357012655-24974-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Check refspecs
    for validity before passing them on to other commands. This lets us generate
    more helpful error messages. Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/git-subtree.sh | 12 ++++++++++++ 1 file changed, 12 insertions(+)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212403>

From: "David A. Greene" <greened@obbligato.org>

Check refspecs for validity before passing them on to other commands.
This lets us generate more helpful error messages.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7ceb413..b8a807a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -509,8 +509,20 @@ cmd_add()
 	ensure_clean
 	
 	if [ $# -eq 1 ]; then
+	        ref=$(git check-ref-format --normalize "refs/heads/$1") ||
+                die "'$1' is not a valid refspec.  Are you missing a branch?"
+
+	        rev=$(git rev-parse --verify $1) ||
+                die "'$1' is not a valid refspec.  Are you missing a branch?"
+
 		"cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
+	        ref=$(git check-ref-format --normalize "refs/heads/$2") ||
+                die "'$2' is not a valid refspec."
+
+	        rev=$(git rev-parse --verify $2) ||
+                die "'$2' is not a valid refspec."
+
 		"cmd_add_repository" "$@"
 	else
 	    say "error: parameters were '$@'"
-- 
1.7.10.4
