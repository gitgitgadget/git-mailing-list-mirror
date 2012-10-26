From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Fix t9200 on case insensitive file systems
Date: Fri, 26 Oct 2012 18:18:24 +0200
Message-ID: <201210261818.25620.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bdwalton@gmail.com, bosch@adacore.com, brian@gernhardtsoftware.com,
	robin.rosenberg@dewire.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 18:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmcX-00080H-28
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 18:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208Ab2JZQSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 12:18:41 -0400
Received: from mout.web.de ([212.227.15.3]:49722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965137Ab2JZQSk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2012 12:18:40 -0400
Received: from appes.localnet ([195.67.191.22]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MPpQU-1TVc652s5K-004bwn; Fri, 26 Oct 2012 18:18:35 +0200
X-Provags-ID: V02:K0:ieO0gwo+/HKVyOdMhP8mpDKcLis1UtwGmdT0QyCGQ/i
 DoCF6raZxUoSXNqZs2WdfZewbx5HNimcjm97efAxg6QZgbQo8/
 kZkhGcbAkXwWaNtl8FaVnqqJHyWR1xMgCuL9WsZ7uJjG6n0MXU
 iml7+FVyEisjiLfRDmxDICqmX2YbuUWYFaZyqOHMbYB41us173
 tHRq0jw94bf1r8i+eepQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208464>

t9200 defines $CVSROOT where cvs should init its repository
$CVSROOT is set to $PWD/cvsroot.
cvs init is supposed to create the repository inside $PWD/cvsroot/CVSRO=
OT

"cvs init" (e.g. version  1.11.23) checks if the last element of the pa=
th is
"CVSROOT", and if a directory with e.g. $PWD/cvsroot/CVSROOT already ex=
ists.

=46or such a $CVSROOT cvs refuses to init a repository here:
"Cannot initialize repository under existing CVSROOT:

On a case insenstive file system cvsroot and CVSROOT are the same direc=
tories
and t9200 fails.

Solution: use $PWD/tmp/cvsroot instead of cvsroot $PWD/cvsroot

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9200-git-cvsexportcommit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index b59be9a..69934b2 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -19,7 +19,7 @@ then
     test_done
 fi
=20
-CVSROOT=3D$PWD/cvsroot
+CVSROOT=3D$PWD/tmpcvsroot
 CVSWORK=3D$PWD/cvswork
 GIT_DIR=3D$PWD/.git
 export CVSROOT CVSWORK GIT_DIR
--=20
1.7.12
