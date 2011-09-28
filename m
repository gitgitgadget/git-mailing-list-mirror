From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: allow a domain to be set for authentication
Date: Wed, 28 Sep 2011 15:48:01 +0200
Message-ID: <1317217681-18763-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1317146100-22938-3-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 28 15:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uVH-00018c-Cz
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab1I1Nse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 09:48:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57464 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab1I1Nsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 09:48:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8SDjtMu029916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 15:45:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1R8uUa-0000iq-Ee; Wed, 28 Sep 2011 15:48:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1R8uUa-0004tF-9Q; Wed, 28 Sep 2011 15:48:08 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1317146100-22938-3-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Sep 2011 15:45:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SDjtMu029916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1317822357.83519@/OrRIZVNExYVnzdMuJrerw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182314>

When the wiki uses e.g. LDAP for authentication, the web interface shows
a popup to allow the user to chose an authentication domain, and we need
to use lgdomain in the API at login time.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index b809792..0b32d18 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -76,8 +76,10 @@ my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
 # inside a remote helper, so our stdin is connect to git, not to a
 # terminal.
 my $wiki_passwd = run_git("config --get remote.". $remotename .".mwPassword");
+my $wiki_domain = run_git("config --get remote.". $remotename .".mwDomain");
 chomp($wiki_login);
 chomp($wiki_passwd);
+chomp($wiki_domain);
 
 # Import only last revisions (both for clone and fetch)
 my $shallow_import = run_git("config --get --bool remote.". $remotename .".shallow");
@@ -158,6 +160,7 @@ sub mw_connect_maybe {
 		if (!$mediawiki->login({
 			lgname => $wiki_login,
 			lgpassword => $wiki_passwd,
+			lgdomain => $wiki_domain,
 		})) {
 			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $url\n";
 			print STDERR "(error " .
-- 
1.7.7.rc0.75.g56f27
