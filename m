From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] Add a commit.signoff configuration variable to always use --signoff.
Date: Fri, 26 Dec 2008 13:56:59 +0100
Message-ID: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 26 13:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGCHI-0002QX-1s
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 13:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbYLZM5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 07:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYLZM5E
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 07:57:04 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4600
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYLZM5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 07:57:01 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C544C801BF66;
	Fri, 26 Dec 2008 13:56:59 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGCFP-0004HL-41; Fri, 26 Dec 2008 13:56:59 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103939>

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
I wrote:
> Has there even been talk of a commit.signoff configuration variable
> to always add a S-o-b line? This could allow to enable it on a
> per-project basis, which would be cool.

Well, it seemed easy enough to do, so I went ahead. Comments would be
welcome.

 Documentation/config.txt     |    6 ++++++
 Documentation/git-commit.txt |    3 ++-
 builtin-commit.c             |    5 +++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52786c7..6d195a3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -591,6 +591,12 @@ color.ui::
 commit.template::
 	Specify a file to use as the template for new commit messages.
=20
+commit.signoff::
+	If set, 'git-commit' will always add a Signed-off-by line. If
+	you don't want it always active, you can still set it in the
+	repository specific configuration file for projects that require
+	a Signed-off-by line for all commits.
+
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index b5d81be..abab839 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -96,7 +96,8 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This overrides the `commit.signoff` configuration
+	variable.
=20
 -n::
 --no-verify::
diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..fc09539 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -929,6 +929,11 @@ static int git_commit_config(const char *k, const =
char *v, void *cb)
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
=20
+	if (!strcmp(k, "commit.signoff")) {
+		signoff =3D git_config_bool(k, v);
+		return 0;
+	}
+
 	return git_status_config(k, v, cb);
 }
=20
--=20
1.6.1.307.g07803
