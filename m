From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH] git-am: fix "Applying" message when applypatch-hook was run
Date: Thu, 21 Mar 2013 00:18:29 +0100
Message-ID: <b978a77f8a37c47b2d6c2201d1f7cfffa01f8443.1363820289.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 00:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UISMS-0008Ha-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 00:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005Ab3CTXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 19:23:34 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:39078 "EHLO
	zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3CTXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 19:23:33 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2013 19:23:33 EDT
Received: from localhost (p54B5F8CF.dip.t-dialin.net [::ffff:84.181.248.207])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 21 Mar 2013 00:18:29 +0100
  id 0000000000000057.00000000514A43C5.0000674C
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218687>

---
Hello,

This patch fixes a minor issue with git-am. When the
applypatch-hook modifies the commit message, git-am displays the
original message. This patch updates the message to use the
modified version.

Regards
Simon

 git-am.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 202130f..0997077 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -795,6 +795,14 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 	then
 		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
 		stop_here $this
+
+		# applypatch-msg can update the commit message.
+		if test -f "$dotest/final-commit"
+		then
+			FIRSTLINE=$(sed 1q "$dotest/final-commit")
+		else
+			FIRSTLINE=""
+		fi
 	fi
 
 	say "$(eval_gettext "Applying: \$FIRSTLINE")"
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
