From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GIT GUI PATCH 1/2] git-gui: teach _which procedure to work with absolute paths
Date: Fri, 23 Mar 2012 18:30:27 +0100
Message-ID: <e7a733b5ad4e2009aec205235a95a610ee18947b.1332523097.git.hvoigt@hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8RE-0004HI-SA
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab2CWRhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:37:52 -0400
Received: from darksea.de ([83.133.111.250]:59640 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755227Ab2CWRhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:37:52 -0400
Received: (qmail 14364 invoked from network); 23 Mar 2012 18:31:10 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2012 18:31:10 +0100
X-Mailer: git-send-email 1.7.10.rc1.29.gf035d
In-Reply-To: <cover.1332523097.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1332523097.git.hvoigt@hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193777>

_which is useful to check whether a certain command can be called.
Previously when given an absolute path it would not recognize it as
an existing program. Lets change that so it transparently handles such
cases.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui/git-gui.sh |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ba4e5c1..35cdee8 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -429,6 +429,10 @@ proc _git_cmd {name} {
 proc _which {what args} {
 	global env _search_exe _search_path
 
+	if {[file exists $what]} {
+		return [file normalize $what]
+	}
+
 	if {$_search_path eq {}} {
 		if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
 			set _search_path [split [exec cygpath \
-- 
1.7.10.rc1.29.gf035d
