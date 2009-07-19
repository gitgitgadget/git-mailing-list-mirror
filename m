From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Sun, 19 Jul 2009 14:48:21 +0200
Message-ID: <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr>
References: <m34ot9c67t.fsf_-_@localhost.localdomain>
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 14:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSVoj-0007aR-6g
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 14:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbZGSMsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbZGSMs3
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 08:48:29 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:35997 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbZGSMs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 08:48:28 -0400
Received: by ewy26 with SMTP id 26so1763543ewy.37
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=BosPZrSLWnU14Q89tjaFgqVlrldBuFKxAFwP62wH4D4=;
        b=Mj62ydgE8ZBl6uixoKfjI0nQ4hY+VK3nhu4rBA45Qcf5PXk7yjfZv32oCEVaSse685
         hKHzU0vK4ulPf4FtzcDrUlMuLp9nug2Ny7m9SSt61tzNXDarAKZopxQA7FwaYHQB7TZl
         KV0emdAZSPueYGjhJFrOEXRLoYQUurZVhLVDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=KcZ3ieptwch2Q/QFuSHtB4/sDNb4fRJgT6hCbynnE5OXHePzgMkx7Wr7qlueEhs8g1
         S3+MZTZDwAq7rA/CwTJHo182m4ZeANUR+JNz5bHWBr2bR3QgwHMQkkTVE4dRZyxxRBNq
         l90ocTB3kDexEihOgmgA2J7z54+ZfpwLZ4y3o=
Received: by 10.210.30.10 with SMTP id d10mr245292ebd.17.1248007707232;
        Sun, 19 Jul 2009 05:48:27 -0700 (PDT)
Received: from localhost (91-165-140-71.rev.libertysurf.net [91.165.140.71])
        by mx.google.com with ESMTPS id 10sm3476658eyd.39.2009.07.19.05.48.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 05:48:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc1.170.ge727
In-Reply-To: <m34ot9c67t.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123550>


> It looks like some recent bug in configure.ac, as I have run
> ./configure without "make configure" and it had
> 
>   NO_LIBGEN_H=@NO_LIBGEN_H@
>   NEEDS_RESOLV=@NEEDS_RESOLV@
> 
>   SNPRINTF_RETURNS_BOGUS=
> 
> and when I did "rm configure ; make configure ; ./configure"
> it gave me
> 
>   NO_LIBGEN_H=
>   NEEDS_RESOLV=
> 
>   SNPRINTF_RETURNS_BOGUS=UnfortunatelyYes
> 
> I have tried to find which commit introduced this regression.
> 
>  $ git bisect start origin v1.6.3 v1.6.3.2 -- configure.ac config.mak.in
>  $ git bisect run ~/git/test.sh
> 
> finds ecc395c (Makefile: add NEEDS_LIBGEN to optionally add -lgen to
> compile arguments, 2009-07-10) as a first bad commit.  But I don't see
> how it could have changed it... Strange...
> 
> CC-ed Brandon Casey, author of blamed changeset, and David Syzdek who
> offered at some time help with maintaining autoconf.

Thank you, I did the same investigation here. :-)


AC_CHECK_LIB may fail to check the good libraries. Use
AC_SEARCH_LIBS instead as pointed out by the autotool
documentation.

http://www.gnu.org/software/autoconf/manual/html_node/Libraries.html#Libraries

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

 configure.ac |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 74d0af5..48dd5f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -339,9 +339,9 @@ AC_MSG_NOTICE([CHECKS for libraries])
 
 GIT_STASH_FLAGS($OPENSSLDIR)
 
-AC_CHECK_LIB([crypto], [SHA1_Init],
+AC_SEARCH_LIBS([SHA1_Init], [crypto],
 [NEEDS_SSL_WITH_CRYPTO=],
-[AC_CHECK_LIB([ssl], [SHA1_Init],
+[AC_SEARCH_LIBS([SHA1_Init], [ssl],
  [NEEDS_SSL_WITH_CRYPTO=YesPlease
   NEEDS_SSL_WITH_CRYPTO=],
  [NO_OPENSSL=YesPlease])])
@@ -358,7 +358,7 @@ AC_SUBST(NO_OPENSSL)
 
 GIT_STASH_FLAGS($CURLDIR)
 
-AC_CHECK_LIB([curl], [curl_global_init],
+AC_SEARCH_LIBS([curl_global_init], [curl],
 [NO_CURL=],
 [NO_CURL=YesPlease])
 
@@ -372,7 +372,7 @@ AC_SUBST(NO_CURL)
 
 GIT_STASH_FLAGS($EXPATDIR)
 
-AC_CHECK_LIB([expat], [XML_ParserCreate],
+AC_SEARCH_LIBS([XML_ParserCreate], [expat],
 [NO_EXPAT=],
 [NO_EXPAT=YesPlease])
 
@@ -469,7 +469,7 @@ AC_SUBST(NO_DEFLATE_BOUND)
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-AC_CHECK_LIB([c], [socket],
+AC_SEARCH_LIBS([socket], [c],
 [NEEDS_SOCKET=],
 [NEEDS_SOCKET=YesPlease])
 AC_SUBST(NEEDS_SOCKET)
@@ -479,13 +479,13 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
 # Notably on Solaris hstrerror resides in libresolv and on Solaris 7
 # inet_ntop and inet_pton additionally reside there.
-AC_CHECK_LIB([resolv], [hstrerror],
+AC_SEARCH_LIBS([hstrerror], [resolv],
 [NEEDS_RESOLV=],
 [NEEDS_RESOLV=YesPlease])
 AC_SUBST(NEEDS_RESOLV)
 test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
-AC_CHECK_LIB([gen], [basename],
+AC_SEARCH_LIBS([basename], [gen],
 [NEEDS_LIBGEN=],
 [NEEDS_LIBGEN=YesPlease])
 AC_SUBST(NEEDS_LIBGEN)
@@ -647,7 +647,7 @@ AC_SUBST(SNPRINTF_RETURNS_BOGUS)
 
 
 ## Checks for library functions.
-## (in default C library and libraries checked by AC_CHECK_LIB)
+## (in default C library and libraries checked by AC_SEARCH_LIBS)
 AC_MSG_NOTICE([CHECKS for library functions])
 #
 # Define NO_LIBGEN_H if you don't have libgen.h.
-- 
1.6.4.rc1.170.ge727
