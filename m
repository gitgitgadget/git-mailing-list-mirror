From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] configure: test whether -lresolv is needed
Date: Sun, 7 Jun 2009 07:40:29 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090607054028.GE5140@gmx.de>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <m3y6s54y8g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>,
	David Syzdek <david@syzdek.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 07:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDB8L-0003Am-J5
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 07:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbZFGFkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZFGFkk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 01:40:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:55271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751544AbZFGFkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 01:40:39 -0400
Received: (qmail invoked by alias); 07 Jun 2009 05:40:40 -0000
Received: from xdsl-87-78-92-32.netcologne.de (EHLO localhost.localdomain) [87.78.92.32]
  by mail.gmx.net (mp046) with SMTP; 07 Jun 2009 07:40:40 +0200
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1/0nwAsl1r0W2mdkoihooiqQI8qY2q1BX5wr1RSiZ
	966FMFA7oDalo7
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1MDB7N-00029s-1I; Sun, 07 Jun 2009 07:40:29 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>,
	David Syzdek <david@syzdek.net>
Content-Disposition: inline
In-Reply-To: <m3y6s54y8g.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120954>

Check if -lresolv is needed for hstrerror; set NEEDS_RESOLV
accordingly, and substitute in config.mak.in.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

* Jakub Narebski wrote on Sat, Jun 06, 2009 at 09:29:34AM CEST:
> 
> CC-ed Ralf Wildenhues and David Syzdek (who hopefully can produce
> autoconf patch to squash with this one).

Completely untested, but also completely mechanical.  HTH.

Cheers,
Ralf

 config.mak.in |    1 +
 configure.ac  |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index e8d96e8..dd60451 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -33,6 +33,7 @@ NO_EXPAT=@NO_EXPAT@
 NO_LIBGEN_H=@NO_LIBGEN_H@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
+NEEDS_RESOLV=@NEEDS_RESOLV@
 NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
 NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
diff --git a/configure.ac b/configure.ac
index 108a97f..7937e60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -467,6 +467,15 @@ AC_CHECK_LIB([c], [socket],
 AC_SUBST(NEEDS_SOCKET)
 test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
+#
+# Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
+# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
+# inet_ntop and inet_pton additionally reside there.
+AC_CHECK_LIB([resolv], [hstrerror],
+[NEEDS_RESOLV=],
+[NEEDS_RESOLV=YesPlease])
+AC_SUBST(NEEDS_RESOLV)
+test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
-- 
1.6.3.2.199.g31f34
