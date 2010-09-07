From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/20] Makefile: add GNU_GETTEXT, set when we expect GNU gettext
Date: Tue,  7 Sep 2010 16:47:40 +0000
Message-ID: <1283878065-19349-1-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1LA-0002l0-87
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993Ab0IGQr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:47:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55698 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab0IGQrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:47:53 -0400
Received: by wyf22 with SMTP id 22so4441328wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GY8GQk2lSLw5XNkoiUIKfOvd9lrHz3IOWVIEpqC+Dgo=;
        b=OMvi0d4wntVQgrPJvoQSAHp8ulsDPIiIKdrfEdjTWl+yVuQfWypP5L6lPx8dUunxC/
         jY69+r/+qwCzOpJvyT+/Z9n7XEWED7oNTAESLM+1bDg2StARdDmjGrOPO7sf9hs9yhND
         m0xi3PmPqRxp5IAVoC+jrshE/rQuolZVVQy10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KChdx03Sd69j0oOb4OuCi4iRgdyXQxJxCuSctzYgbsYEHciNKRbUSD8O3bGtq35Ykl
         q0p+PdZ8XKtXeQB3VbLOagaQVsPUoStY0qN5O2lCCySQyPwwhp1KH+MvNZL8iGsb8Rq3
         n8ULImyMfNYlC87ljELYw8yz3A3KCFnNU9P4I=
Received: by 10.227.69.195 with SMTP id a3mr59536wbj.58.1283878070026;
        Tue, 07 Sep 2010 09:47:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.47.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:47:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155712>

Add a GNU_GETTEXT flag that's set to YesPlease by default everywhere
but on Solaris if the NO_GETTEXT flag isn't set.

Everyone uses GNU gettext these days except Solaris developers, so
having a dumb check for this that just depends on SunOS should be
OK.

I also don't plan to use this (for the time being) for anything that
would break if it isn't correctly set (e.g. if you're using GNU
libintl on Solaris), so I haven't added paranoid autoconf guards.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f26fca3..3fe2e47 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,11 @@ all::
 # on platforms where we don't expect glibc (Linux, Hurd,
 # GNU/kFreeBSD), which includes libintl.
 #
+# Define GNU_GETTEXT if you're using the GNU implementation of
+# libintl. We define this everywhere except on Solaris, which has its
+# own gettext implementation. If GNU_GETTEXT is set we'll use GNU
+# extensions like `msgfmt --check'.
+#
 # Define GETTEXT_POISON to turn all strings that use gettext into
 # gibberish. This option should only be used by the Git developers to
 # check that the Git gettext implementation itself is sane.
@@ -783,6 +788,10 @@ EXTLIBS =3D
 ifndef NO_GETTEXT
 	# Systems that use GNU gettext and glibc are the exception
 	NEEDS_LIBINTL =3D YesPlease
+
+	# Systems that don't use GNU gettext are the exception. Only
+	# Solaris has a mature non-GNU gettext implementation.
+	GNU_GETTEXT =3D YesPlease
 endif
=20
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -872,6 +881,9 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	NO_REGEX =3D YesPlease
+ifndef NO_GETTEXT
+	GNU_GETTEXT =3D
+endif
 	ifeq ($(uname_R),5.6)
 		SOCKLEN_T =3D int
 		NO_HSTRERROR =3D YesPlease
--=20
1.7.2.3.313.gcd15
