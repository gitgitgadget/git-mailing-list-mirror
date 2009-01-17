From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] contrib/workdir: create logs/refs and rr-cache in the origin repository
Date: Sat, 17 Jan 2009 17:15:43 +0100
Message-ID: <1232208943-31756-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 17 17:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODrA-0003Ud-AW
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbZAQQPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 11:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755569AbZAQQPr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:15:47 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1558
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbZAQQPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:15:46 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id D4A91801C025;
	Sat, 17 Jan 2009 17:15:44 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LODpo-0008Gl-0K; Sat, 17 Jan 2009 17:15:44 +0100
X-Mailer: git-send-email 1.6.1.263.g35eb3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106078>

If logs/refs or rr-cache are dangling symlinks in the workdir, and refl=
ogs
and/or rerere are enabled, commit will die with "fatal: Could not creat=
e
directory". (In the case of rr-cache, it will die after having created =
the
commit.)

This commit just creates logs/refs and rr-cache in the origin repositor=
y if
they don't exist already.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 contrib/workdir/git-new-workdir |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-=
workdir
index 993cacf..a4e89d0 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -66,6 +66,12 @@ mkdir -p "$new_workdir/.git" || die "unable to creat=
e \"$new_workdir\"!"
 for x in config refs logs/refs objects info hooks packed-refs remotes =
rr-cache svn
 do
 	case $x in
+	logs/refs|rr-cache)
+		if [ ! -e "$git_dir/$x" ]; then
+			mkdir -p "$git_dir/$x"
+		fi
+	esac
+	case $x in
 	*/*)
 		mkdir -p "$(dirname "$new_workdir/.git/$x")"
 		;;
--=20
1.6.1.263.g35eb3c
