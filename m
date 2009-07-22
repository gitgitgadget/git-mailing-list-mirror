From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] config.mak.in: continue fixing NEEDS_LIBGEN autoconfigure feature
Date: Wed, 22 Jul 2009 17:15:18 -0500
Message-ID: <57XXtFYcpNU4ayC2onbxyZE72nxUH64HrjFA1KTX3lvwrSUaKMsqemp5CX0U7W460zAC_hc0GdA@cipher.nrlssc.navy.mil>
References: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, j6t@kdbg.org, peff@peff.net, david@syzdek.net,
	jnareb@gmail.com, bonzini@gnu.org, nicolas.s.dev@gmx.fr,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 00:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTk6f-0000qw-5I
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbZGVWPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbZGVWPy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:15:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39005 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZGVWPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:15:53 -0400
Received: by mail.nrlssc.navy.mil id n6MMFXvu011046; Wed, 22 Jul 2009 17:15:33 -0500
In-Reply-To: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2009 22:15:33.0533 (UTC) FILETIME=[EE6784D0:01CA0B19]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123800>

From: Brandon Casey <drafnel@gmail.com>

An entry in the config.mak.in file is necessary for the NEEDS_LIBGEN variable
to appear in the config.mak.autogen file with the value assigned by the
configure script.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Junio,

You probably want to apply or squash this somewhere.

As I noted in the original patch, the autoconf part was untested.
I actually did some light testing on this one.  I created the configure file
on linux and ran it on Solaris and IRIX.  Both produce an error which looks
something like:

   configure[1234]: syntax error at line 4806 : `;' unexpected

And line 4806 looks like:

   for ac_lib in ; do
      ...

It works with bash though, and it works with /bin/sh on Solaris 10.  On
Solaris 10, the configure script correctly detects that hstrerror cannot be
used without -lresolv, and basename can be used without -lgen.  In
config.mak.autogen, NEEDS_RESOLV is set to 'YesPlease' and NEEDS_LIBGEN is
unset.  On my Solaris 7, bash is not available, but the informational messages
indicate the same results as for Solaris 10.  On IRIX, hstrerror() can be used
without -lresolv and basename cannot be used without -lgen.  In
config.mak.autogen, NEEDS_RESOLV is unset, and NEEDS_LIBGEN is set to
'YesPlease'.

So, I think this patch should be the final one.

-brandon


 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index dd60451..67b12f7 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -34,6 +34,7 @@ NO_LIBGEN_H=@NO_LIBGEN_H@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
 NEEDS_RESOLV=@NEEDS_RESOLV@
+NEEDS_LIBGEN=@NEEDS_LIBGEN@
 NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
 NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
-- 
1.6.3.1.24.g152f4
