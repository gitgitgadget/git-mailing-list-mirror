From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: [PATCH] instaweb: make the perl path configurable
Date: Tue, 11 Jun 2013 14:14:05 -0600
Message-ID: <20130611201400.GA28010@compy.Home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 22:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUxT-0003Qo-I7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab3FKUOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 16:14:10 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:64809 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab3FKUOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:14:08 -0400
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id F074752D2A
	for <git@vger.kernel.org>; Tue, 11 Jun 2013 14:14:07 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1370981648;
	bh=TIjd1jDoIHRw3kZGIYts6vC1em/0PUwz8GUFWHsWD9g=;
	h=Date:From:To:Subject;
	b=Ri0Vpfegf/n5Wa7d39IVAoYP1s5MyCmi9rWynSdq9NXuwVOzVJSkrk3G/RzGOseeb
	 11u12jKtJxpNKN4RhxrkW3Lx1svqBxiBmXdN4PMSraJsgvnRcS2T0OQTu4PdqPeT8R
	 3J0crMcYzz2ZW4lMIaU01k3aUavsOxfyAymfm3eQ=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700] (helo=compy)
	by vulcan.local with smtp (Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1UmUxs-0006Wz-Dy
	for git@vger.kernel.org; Tue, 11 Jun 2013 14:14:49 -0600
Received: by compy (sSMTP sendmail emulation); Tue, 11 Jun 2013 14:14:05 -0600
Content-Disposition: inline
OpenPGP: url=http://www.brokenzipper.com/chaz.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227512>

It is convenient for the user to be able to customize the path to perl if they
do not want to use the system perl.  This may be the case, for example, if the
user wants to use the plackup httpd but its extra dependencies are not
installed in the system perl; they can set the perl path to a perl that they
install and have control over in their own home directory.

Signed-off-by: Charles McGarvey <chazmcgarvey@brokenzipper.com>
---
 Documentation/config.txt | 4 ++++
 git-instaweb.sh          | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..e103594 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1549,6 +1549,10 @@ instaweb.modulepath::
 	instead of /usr/lib/apache2/modules.  Only used if httpd
 	is Apache.
 
+instaweb.perlpath::
+	The path to the perl executable used by linkgit:git-instaweb[1] to
+	run gitweb and/or verify that the HTTP daemon is running.
+
 instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 01a1b05..8cfbdf2 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -3,7 +3,6 @@
 # Copyright (c) 2006 Eric Wong
 #
 
-PERL='@@PERL@@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git instaweb [options] (--start | --stop | --restart)
@@ -26,9 +25,12 @@ local="$(git config --bool --get instaweb.local)"
 httpd="$(git config --get instaweb.httpd)"
 root="$(git config --get instaweb.gitwebdir)"
 port=$(git config --get instaweb.port)
+perl_path="$(git config --get instaweb.perlpath)"
 module_path="$(git config --get instaweb.modulepath)"
 action="browse"
 
+PERL=${perl_path:-@@PERL@@}
+
 conf="$GIT_DIR/gitweb/httpd.conf"
 
 # Defaults:
-- 
1.8.1.5
