From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/2] Move all dashed-form commands to libexecdir
Date: Wed, 28 Nov 2007 23:21:57 +0700
Message-ID: <20071128162157.GA5386@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 17:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPgE-0007br-Jt
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020AbXK1QWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757908AbXK1QWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:22:09 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:53407 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXK1QWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:22:08 -0500
Received: by an-out-0708.google.com with SMTP id d31so310818and
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=AjJzXxxPqsUNYck3hGoHWHEbPKIYHTiRgA83+IghHrU=;
        b=Znvba3AqjCoqjs3iuAobRtNHqLnek2PRIUKUwDsUhDjtFoyCfa2ZLzPI/HELgZnVCgZ7iy3FgVlyKR++vW158jPcGSZJu0EqlpEHbA+me69A741WTOd0pEC2eTJz+AKuR+Oh0E/mHW2EQy4XyN9Cxq24VCje90odpn26Quq+T3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=N2tpmOO64gwxGAQW6n73VPY8Afx858mL+dtdOPK81t4PqqpwIANFKyBrYjKW0SWUeTnqZh/+CGd9I7BXv0DOrmtVbiVR08bSXn5OmhdADTU5mm1XjbOf67LrreTxzIkuLsbvaFlyBo0b/fokmuwYrR9BQpI224Dn4gqYDNG9Zgw=
Received: by 10.101.70.5 with SMTP id x5mr9366506ank.1196266924760;
        Wed, 28 Nov 2007 08:22:04 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.8])
        by mx.google.com with ESMTPS id b7sm291455ana.2007.11.28.08.21.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 08:22:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 28 Nov 2007 23:21:57 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66370>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Third version. Changes include
  - warn users if they have old commands in bindir
  - update git.spec.in (I did not use, but rpm2targz output seemed
    correct)

 Makefile      |    3 ++-
 check_bindir  |   13 +++++++++++++
 config.mak.in |    2 +-
 git.spec.in   |   13 +++++++------
 4 files changed, 23 insertions(+), 8 deletions(-)
 create mode 100755 check_bindir

diff --git a/Makefile b/Makefile
index 313f9a2..3cf791f 100644
--- a/Makefile
+++ b/Makefile
@@ -154,7 +154,7 @@ STRIP ?=3D strip
=20
 prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
-gitexecdir =3D $(bindir)
+gitexecdir =3D $(prefix)/libexec/git-core
 sharedir =3D $(prefix)/share
 template_dir =3D $(sharedir)/git-core/templates
 ifeq ($(prefix),/usr)
@@ -1034,6 +1034,7 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS=
) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
+	./check_bindir 'z$(bindir_SQ)' 'z$(gitexecdir_SQ)' '$(DESTDIR_SQ)$(bi=
ndir_SQ)/git-shell$X'
=20
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/check_bindir b/check_bindir
new file mode 100755
index 0000000..a1c4c3e
--- /dev/null
+++ b/check_bindir
@@ -0,0 +1,13 @@
+#!/bin/sh
+bindir=3D"$1"
+gitexecdir=3D"$2"
+gitcmd=3D"$3"
+if test "$bindir" !=3D "$gitexecdir" -a -x "$gitcmd"
+then
+	echo
+	echo "!! You have installed git-* commands to new gitexecdir."
+	echo "!! Old version git-* commands still remain in bindir."
+	echo "!! Mixing two versions of Git will lead to problems."
+	echo "!! Please remove old version commands in bindir now."
+	echo
+fi
diff --git a/config.mak.in b/config.mak.in
index 11d256e..1db0338 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,7 +11,7 @@ TCLTK_PATH =3D @TCLTK_PATH@
 prefix =3D @prefix@
 exec_prefix =3D @exec_prefix@
 bindir =3D @bindir@
-#gitexecdir =3D @libexecdir@/git-core/
+gitexecdir =3D @libexecdir@/git-core/
 datarootdir =3D @datarootdir@
 template_dir =3D @datadir@/git-core/templates/
=20
diff --git a/git.spec.in b/git.spec.in
index bdb293d..b6637a7 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -105,6 +105,7 @@ find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -e=
xec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
=20
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "archimport|svn|cvs=
|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)         =
      > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_libexecdir}/git-core -type f | grep -vE "archi=
mport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROO=
T@@)               >> bin-man-doc-files
 (find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_=
ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
 (find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f =
| grep -vE "archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed=
 -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
@@ -120,7 +121,7 @@ rm -rf $RPM_BUILD_ROOT
=20
 %files svn
 %defattr(-,root,root)
-%{_bindir}/*svn*
+%{_libexecdir}/git-core/*svn*
 %doc Documentation/*svn*.txt
 %{!?_without_docs: %{_mandir}/man1/*svn*.1*}
 %{!?_without_docs: %doc Documentation/*svn*.html }
@@ -128,28 +129,28 @@ rm -rf $RPM_BUILD_ROOT
 %files cvs
 %defattr(-,root,root)
 %doc Documentation/*git-cvs*.txt
-%{_bindir}/*cvs*
+%{_libexecdir}/git-core/*cvs*
 %{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
 %{!?_without_docs: %doc Documentation/*git-cvs*.html }
=20
 %files arch
 %defattr(-,root,root)
 %doc Documentation/git-archimport.txt
-%{_bindir}/git-archimport
+%{_libexecdir}/git-core/git-archimport
 %{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
 %{!?_without_docs: %doc Documentation/git-archimport.html }
=20
 %files email
 %defattr(-,root,root)
 %doc Documentation/*email*.txt
-%{_bindir}/*email*
+%{_libexecdir}/git-core/*email*
 %{!?_without_docs: %{_mandir}/man1/*email*.1*}
 %{!?_without_docs: %doc Documentation/*email*.html }
=20
 %files gui
 %defattr(-,root,root)
-%{_bindir}/git-gui
-%{_bindir}/git-citool
+%{_libexecdir}/git-core/git-gui
+%{_libexecdir}/git-core/git-citool
 %{_datadir}/git-gui/
 %{!?_without_docs: %{_mandir}/man1/git-gui.1*}
 %{!?_without_docs: %doc Documentation/git-gui.html}
--=20
1.5.3.6.2041.g106f-dirty
