From: Jeff Muizelaar <jeff@infidigm.net>
Subject: [PATCH] fix contrib/hooks/post-receive-email hooks.recipients error message
Date: Thu, 11 Oct 2007 17:49:21 -0400
Message-ID: <20071011214921.GA11852@infidigm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 00:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig6RL-0007YO-IG
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 00:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbXJKWXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 18:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbXJKWXV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 18:23:21 -0400
Received: from beta2.look.ca ([207.136.100.3]:54872 "EHLO beta.look.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753931AbXJKWXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 18:23:20 -0400
X-Greylist: delayed 1747 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 18:23:20 EDT
Received: from [209.161.218.26] (helo=freiheit.infidigm.net)
	by beta.look.ca with esmtp (Exim 4.20)
	id 1Ig5yt-000513-VS; Thu, 11 Oct 2007 21:54:12 +0000
Received: from jeff by freiheit.infidigm.net with local (Exim 4.50)
	id 1Ig5uD-00037o-P1; Thu, 11 Oct 2007 17:49:21 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Mail-From: jeff@infidigm.net
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on psi.look.ca
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=8.0 tests=none autolearn=no version=2.63
X-SA-Exim-Version: 3.1 (built Tue Feb 24 05:09:27 GMT 2004)
X-SA-Exim-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60647>

Have the error message for missing recipients actually report the
missing config variable and not a fictional one.

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index cbbd02f..b188aa3 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -138,7 +138,15 @@ generate_email()
 
 	# Check if we've got anyone to send to
 	if [ -z "$recipients" ]; then
-		echo >&2 "*** hooks.recipients is not set so no email will be sent"
+		case "$refname_type" in
+			"annotated tag")
+				config_name="hooks.announcelist"
+				;;
+			*)
+				config_name="hooks.mailinglist"
+				;;
+		esac
+		echo >&2 "*** $config_name is not set so no email will be sent"
 		echo >&2 "*** for $refname update $oldrev->$newrev"
 		exit 0
 	fi
