From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] configure.ac: rework/fix the NEEDS_RESOLV and NEEDS_LIBGEN tests
Date: Tue, 21 Jul 2009 15:23:06 -0500
Message-ID: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil>
References: <qSl_KXgcJD_1H47Nrg3FwRdtL-WxwLP1_aueDE8gN-By3M0uJOpw1w@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, j6t@kdbg.org, peff@peff.net, david@syzdek.net,
	gitster@pobox.com, jnareb@gmail.com, bonzini@gnu.org,
	Brandon Casey <drafnel@gmail.com>
To: nicolas.s.dev@gmx.fr
X-From: git-owner@vger.kernel.org Tue Jul 21 22:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLtC-00036x-9u
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZGUUYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbZGUUYd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:24:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54432 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbZGUUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:24:32 -0400
Received: by mail.nrlssc.navy.mil id n6LKNYkb003321; Tue, 21 Jul 2009 15:23:34 -0500
In-Reply-To: <qSl_KXgcJD_1H47Nrg3FwRdtL-WxwLP1_aueDE8gN-By3M0uJOpw1w@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 21 Jul 2009 20:23:33.0603 (UTC) FILETIME=[1E99D330:01CA0A41]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123706>

From: Brandon Casey <drafnel@gmail.com>

The "action" parameters for these two tests were supplied incorrectly for
the way the tests were implemented.  The tests check whether a program
which calls hstrerror() or basename() successfully links when -lresolv or
-lgen are used, respectively.  A successful linking would result in
NEEDS_RESOLV or NEEDS_LIBGEN being unset, and failure would result in
setting the respective variable.

Aside from that issue, the tests did not handle the case where neither
library was necessary for accessing the functions in question.  So solve
both of these issues by re-working the two tests so that their form is like
the NEEDS_SOCKET test which attempts to link with just the c library, and
if it fails then assumes that the additional library is necessary and sets
the appropriate variable.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Maybe this is the appropriate thing to do?

-brandon


 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 74d0af5..ba44cf2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -479,13 +479,13 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
 # Notably on Solaris hstrerror resides in libresolv and on Solaris 7
 # inet_ntop and inet_pton additionally reside there.
-AC_CHECK_LIB([resolv], [hstrerror],
+AC_CHECK_LIB([c], [hstrerror],
 [NEEDS_RESOLV=],
 [NEEDS_RESOLV=YesPlease])
 AC_SUBST(NEEDS_RESOLV)
 test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
-AC_CHECK_LIB([gen], [basename],
+AC_CHECK_LIB([c], [basename],
 [NEEDS_LIBGEN=],
 [NEEDS_LIBGEN=YesPlease])
 AC_SUBST(NEEDS_LIBGEN)
-- 
1.6.3.1.24.g152f4
