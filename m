From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Thu, 17 Feb 2011 22:14:05 -0600
Message-ID: <20110218041358.GB15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023126.GB23435@elie>
 <AANLkTikFLkXKKhZoDGAgh+i8H2fv+QNEVj7vEVABxee2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHje-0000jC-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab1BREON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 23:14:13 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42511 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1BREOL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 23:14:11 -0500
Received: by gyb11 with SMTP id 11so1434890gyb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hL0pVvr1Snp2NsarMn2hUOLjOpOquwtnkfO4jeuknYo=;
        b=vB2Yhy87mo4SteM1UVT8ImHjMWmq+9q1hT3X829H+hsuj7rhUCpM0+PDVivy5q8bRR
         V/xEvCr6KpVnMUnw/4YVhH+ORajAetgs2HWG16Fw7i60QCM4jl4dAoATU9NoWiPeiJry
         3uIWbpRdUmseKl6I+oqJ89ZofhUn5t+Ci4F7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KYVuXgvjMaCT+hKKqaeRN7Fp+2PaR8HsQv5Vod4z06JzAzq5NXHYDatKet/q2I/8pb
         09kti4OfbQkgMfNQrjtLpCyac+Wi1rABKj3NapnHEO6sFhZe7RX+ScTg5UXeQAPu4Hiq
         ZC1CxiZioCMecdcfkCZDlE231aXUYAVY3BmZQ=
Received: by 10.90.87.9 with SMTP id k9mr439733agb.194.1298002451339;
        Thu, 17 Feb 2011 20:14:11 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id d15sm2025194ana.35.2011.02.17.20.14.09
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:14:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikFLkXKKhZoDGAgh+i8H2fv+QNEVj7vEVABxee2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167162>

Nguyen Thai Ngoc Duy wrote:
> 2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:

>> Move sources for libgit.a to a libgit/ subdirectory. =C2=A0This way,=
 a
>> person wanting to tackle the reusable part of git will know where to
>> look, and those looking to work on individual commands know to look
>> elsewhere.
>
> You missed a few (on purpose?): block-sha1, ppc and compat.

Yes, on purpose.  They're separately reusable.

> libgit.a is produced at toplevel so I need a few more keystrokes to
> reach files inside libgit. Maybe move libgit.a to libgit too?

Mm, good idea.

> With die() all over the place in libgit.a, I doubt it would become an
> independent project. Although this certainly makes it easier to
> reimplement libgit as a thin wrapper around libgit2.

I think it's more realistic to replace functions in libgit one by one
with reentrant versions.

Jonathan

-- 8< --
Subject: Rename libgit.a to libgit/lib.a

This makes the libgit files easier to reach through tab completion.

cgit uses "make -C git libgit.a" in its build process.  Make sure
that continues to work by installing a symlink libgit.a -> libgit/lib.a
on request.

Requested-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                |    5 ++++-
 contrib/svn-fe/Makefile |    6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b812c1e..3d701d2 100644
--- a/Makefile
+++ b/Makefile
@@ -487,7 +487,7 @@ endif
 export PERL_PATH
 export PYTHON_PATH
=20
-LIB_FILE=3Dlibgit.a
+LIB_FILE=3Dlibgit/lib.a
 XDIFF_LIB=3Dxdiff/lib.a
 VCSSVN_LIB=3Dvcs-svn/lib.a
=20
@@ -2029,6 +2029,9 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http=
-walker.o $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
=20
+libgit.a: $(LIB_FILE)
+	ln -sf $(LIB_FILE) $@
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
=20
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..9dcad63 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -10,7 +10,7 @@ ALL_CFLAGS =3D $(CFLAGS)
 ALL_LDFLAGS =3D $(LDFLAGS)
 EXTLIBS =3D
=20
-GIT_LIB =3D ../../libgit.a
+GIT_LIB =3D ../../libgit/lib.a
 VCSSVN_LIB =3D ../../vcs-svn/lib.a
 LIBS =3D $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
=20
@@ -54,8 +54,8 @@ svn-fe.1: svn-fe.txt
 ../../vcs-svn/lib.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
=20
-../../libgit.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
+../../libgit/lib.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit/lib.a
=20
 clean:
 	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
--=20
1.7.4.1
