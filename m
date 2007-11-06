From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks/post-receive-email: make subject prefix configurable
Date: Tue, 6 Nov 2007 13:49:30 +0000
Message-ID: <20071106134930.24454.qmail@2bdebc2f326342.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOo2-0004fA-Nf
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbXKFNtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXKFNtK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:49:10 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:37013 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbXKFNtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:49:09 -0500
Received: (qmail 24455 invoked by uid 1000); 6 Nov 2007 13:49:30 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63679>

Email subjects are prefixed with "[SCM] " by default, make this optionally
configurable through the hooks.emailprefix config option.

Suggested by martin f krafft through
 http://bugs.debian.org/428418

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 9b9a977..3904c18 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -35,10 +35,12 @@
 # hooks.envelopesender
 #   If set then the -f option is passed to sendmail to allow the envelope
 #   sender address to be set
+# hooks.emailprefix
+#   All emails have their subjects prefixed with this prefix, or "[SCM]"
+#   if emailprefix is unset, to aid filtering
 #
 # Notes
 # -----
-# All emails have their subjects prefixed with "[SCM]" to aid filtering.
 # All emails include the headers "X-Git-Refname", "X-Git-Oldrev",
 # "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and
 # give information for debugging.
@@ -188,7 +190,7 @@ generate_email_header()
 	# Generate header
 	cat <<-EOF
 	To: $recipients
-	Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
@@ -604,7 +606,6 @@ send_mail()
 # ---------------------------- main()
 
 # --- Constants
-EMAILPREFIX="[SCM] "
 LOGBEGIN="- Log -----------------------------------------------------------------"
 LOGEND="-----------------------------------------------------------------------"
 
@@ -628,6 +629,7 @@ fi
 recipients=$(git repo-config hooks.mailinglist)
 announcerecipients=$(git repo-config hooks.announcelist)
 envelopesender=$(git-repo-config hooks.envelopesender)
+emailprefix=$(git-repo-config hooks.emailprefix || echo '[SCM] ')
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.5.3.5
