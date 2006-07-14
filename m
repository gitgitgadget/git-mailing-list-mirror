From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] argv created by handle_alias should be NULL terminated
Date: Fri, 14 Jul 2006 18:37:06 +0200
Message-ID: <E1G1Qf4-0007Ji-MH@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jul 14 18:37:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1QfC-0004YD-Ld
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 18:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWGNQhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Jul 2006 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWGNQhK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 12:37:10 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5528 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161252AbWGNQhJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 12:37:09 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23898>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Example:
% git repo-config alias.test am
% git test
error: cannot open mbox J=DC=B7J=DC=B7J=DC=B7J=DC=B7 J=DC=B7 J=DC=B7(J=DC=
=B7(J=DC [..]
---
 git.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 102735a..ee5a0e8 100644
--- a/git.c
+++ b/git.c
@@ -133,13 +133,12 @@ static int handle_alias(int *argcp, cons
 				fflush(stderr);
 			}
=20
+			new_argv =3D realloc(new_argv, sizeof(char*) *
+					   (count + *argcp + 1));
 			/* insert after command name */
-			if (*argcp > 1) {
-				new_argv =3D realloc(new_argv, sizeof(char*) *
-						   (count + *argcp));
-				memcpy(new_argv + count, *argv + 1,
-				       sizeof(char*) * *argcp);
-			}
+			memcpy(new_argv + count, *argv + 1,
+			       sizeof(char*) * *argcp);
+			new_argv[count+*argcp] =3D NULL;
=20
 			*argv =3D new_argv;
 			*argcp +=3D count - 1;
--=20
1.4.1.g8b4b
