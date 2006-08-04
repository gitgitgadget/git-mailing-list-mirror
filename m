From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-project-version
Date: Fri, 04 Aug 2006 23:48:25 +0200
Message-ID: <87bqr0tbo6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 04 23:48:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97Wy-0006ou-JX
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161510AbWHDVs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 Aug 2006 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161511AbWHDVs3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:48:29 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:9936 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1161510AbWHDVs2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 17:48:28 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k74KmYB09314
	for <git@vger.kernel.org>; Fri, 4 Aug 2006 22:48:34 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24848>

Introduce an easy way for projects to get its git version. This is
something that other projects using git would like to do, and we don't
want them all reinventing the wheel.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

I would prefer an output with an explicit git string as:

v1.4.2-rc3-git46faaaf

Also I would prefer the dirty state with an ending M as in:

v1.4.2-rc3-git46faaaf-M

to use the same letter of the diff family.

   Santi

 Makefile               |    3 ++-
 git-project-version.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d662bd6..7c4e360 100644
--- a/Makefile
+++ b/Makefile
@@ -169,7 +169,8 @@ SCRIPT_SH =3D \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh \
+	git-project-version.sh
=20
 SCRIPT_PERL =3D \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-project-version.sh b/git-project-version.sh
new file mode 100755
index 0000000..88b21fa
--- /dev/null
+++ b/git-project-version.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# First try git-describe.
+VN=3D$(git describe --abbrev=3D4 HEAD 2>/dev/null) ||
+VN=3D$(git rev-parse --short HEAD | sed -e 's/^/g/')
+
+dirty=3D$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirt=
y=3D
+[ "$dirty" ] && VN=3D"$VN-dirty"
+
+echo $VN
--=20
1.4.2.rc3.g3f0a-dirty
