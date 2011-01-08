From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Sat, 8 Jan 2011 10:01:05 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110108090105.GB14536@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 10:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbUj0-0004Ki-Tx
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 10:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab1AHJEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 04:04:20 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:53633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751058Ab1AHJER (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 04:04:17 -0500
Received: (qmail invoked by alias); 08 Jan 2011 09:04:15 -0000
Received: from xdsl-89-0-77-84.netcologne.de (EHLO localhost.localdomain) [89.0.77.84]
  by mail.gmx.net (mp061) with SMTP; 08 Jan 2011 10:04:15 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX18E4PhA+tgEABg5mAEw9R+MjQpsLJTob/hPW7xfOH
	ipctQ+71G/Lw3C
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PbUfZ-0000jS-Nm
	for git@vger.kernel.org; Sat, 08 Jan 2011 10:01:05 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164812>

Some shells parse them wrongly, esp. pdksh.  On the other hand,
the right-hand side of assignments is not word-split, so they
can be used as workarounds.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 contrib/examples/git-fetch.sh |    2 +-
 t/t9107-git-svn-migrate.sh    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch.sh
index a314273..06caf6b 100755
--- a/contrib/examples/git-fetch.sh
+++ b/contrib/examples/git-fetch.sh
@@ -67,7 +67,7 @@ do
 		keep='-k -k'
 		;;
 	--depth=*)
-		shallow_depth="--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`"
+		shallow_depth=--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`
 		;;
 	--depth)
 		shift
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 289fc31..3d2ae3e 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -94,7 +94,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
 		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
 	done &&
 	git svn migrate --minimize &&
-	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
+	! git config -l | grep "^svn-remote\.git-svn\." &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/trunk$" fetch.out &&
 	grep "^branches/a:refs/remotes/a$" fetch.out &&
-- 
1.7.4.rc1
