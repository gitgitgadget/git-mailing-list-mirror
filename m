From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Rename git-core rpm to just git and rename the meta-pacakge to git-all.
Date: Fri, 15 Feb 2008 13:29:23 -0500
Message-ID: <1203100163-17509-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 19:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5K6-0005C5-PK
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbYBOS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:29:36 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYBOS3g
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:29:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121AbYBOS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:29:35 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1FITY66008169
	for <git@vger.kernel.org>; Fri, 15 Feb 2008 13:29:34 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1FITYud004308
	for <git@vger.kernel.org>; Fri, 15 Feb 2008 13:29:34 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m1FITSm9000910;
	Fri, 15 Feb 2008 13:29:30 -0500
X-Mailer: git-send-email 1.5.4.1.123.g012f
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73972>

---

So here's change to fix my favorite annoyance with the git rpm
packaging: don't pull in tla when I say yum install git!  The decision
to make 'git' a metapackage is to say the least unconventional and
continues to surprise people (here's today discussion:
http://marc.info/?t=3D120309228600004&r=3D1&w=3D2).

I know it's late and most people who use the git rpms are used to insta=
lling
git-core by now, but myself and most of my Red Hat co-workers (who shou=
ld
know a thing or two about rpm packaging) have been fooled by the 'git'
rpm that pulls in everything.  There's really no precendence for this, =
quite
the opposite: you wouldn't expect yum install gcc to pull in fortran, r=
ight?

The patch below only affects people who know that 'git' is a metapackag=
e
and actually use that to pull in everything (but who does?).  The patch
renames the 'git-core' rpm to just 'git', but adds a 'Provides: git-cor=
e'
there so people who have trained themselves to say yum install git-core
wont get burned.

cheers,
Kristian

 git.spec.in |   65 ++++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 3f9f888..51ddc08 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -3,7 +3,7 @@
 Name: 		git
 Version: 	@@VERSION@@
 Release: 	1%{?dist}
-Summary:  	Git core and tools
+Summary:  	Core git tools
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
@@ -11,80 +11,83 @@ Source: 	http://kernel.org/pub/software/scm/git/%{n=
ame}-%{version}.tar.gz
 BuildRequires:	zlib-devel >=3D 1.2, openssl-devel, curl-devel, expat-d=
evel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} =
-n)
=20
-Requires:	git-core =3D %{version}-%{release}
-Requires:	git-svn =3D %{version}-%{release}
-Requires:	git-cvs =3D %{version}-%{release}
-Requires:	git-arch =3D %{version}-%{release}
-Requires:	git-email =3D %{version}-%{release}
-Requires:	gitk =3D %{version}-%{release}
-Requires:	git-gui =3D %{version}-%{release}
 Requires:	perl-Git =3D %{version}-%{release}
+Requires:	zlib >=3D 1.2, rsync, curl, less, openssh-clients, expat
+Provides:	git-core =3D %{version}-%{release}
+Obsoletes:	git-core < %{version}-%{release}
=20
 %description
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
=20
-This is a dummy package which brings in all subpackages.
+These are the core tools with minimal dependencies.
=20
-%package core
-Summary:	Core git tools
+%package all
+Summary:	Meta-package to pull in all git tools
 Group:		Development/Tools
-Requires:	zlib >=3D 1.2, rsync, curl, less, openssh-clients, expat
-Obsoletes:	git-p4
-%description core
+Requires:	git =3D %{version}-%{release}
+Requires:	git-svn =3D %{version}-%{release}
+Requires:	git-cvs =3D %{version}-%{release}
+Requires:	git-arch =3D %{version}-%{release}
+Requires:	git-email =3D %{version}-%{release}
+Requires:	gitk =3D %{version}-%{release}
+Requires:	git-gui =3D %{version}-%{release}
+Obsoletes:	git < %{version}-%{release}
+
+%description all
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
=20
-These are the core tools with minimal dependencies.
+This is a dummy package which brings in all subpackages.
=20
 %package svn
 Summary:        Git tools for importing Subversion repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, subversion
+Requires:       git =3D %{version}-%{release}, subversion
 %description svn
 Git tools for importing Subversion repositories.
=20
 %package cvs
 Summary:        Git tools for importing CVS repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, cvs, cvsps
+Requires:       git =3D %{version}-%{release}, cvs, cvsps
 %description cvs
 Git tools for importing CVS repositories.
=20
 %package arch
 Summary:        Git tools for importing Arch repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tla
+Requires:       git =3D %{version}-%{release}, tla
 %description arch
 Git tools for importing Arch repositories.
=20
 %package email
 Summary:        Git tools for sending email
 Group:          Development/Tools
-Requires:	git-core =3D %{version}-%{release}
+Requires:	git =3D %{version}-%{release}
 %description email
 Git tools for sending email.
=20
 %package gui
 Summary:        Git GUI tool
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tk >=3D 8.4
+Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
 %description gui
 Git GUI tool
=20
 %package -n gitk
 Summary:        Git revision tree visualiser ('gitk')
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tk >=3D 8.4
+Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
 %description -n gitk
 Git revision tree visualiser ('gitk')
=20
 %package -n perl-Git
 Summary:        Perl interface to Git
 Group:          Development/Libraries
-Requires:       git-core =3D %{version}-%{release}
+Requires:       git =3D %{version}-%{release}
 Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; e=
cho $version))
 BuildRequires:  perl(Error)
=20
@@ -121,8 +124,12 @@ rm -rf $RPM_BUILD_ROOT%{_mandir}
 %clean
 rm -rf $RPM_BUILD_ROOT
=20
-%files
-# These are no files in the root package
+%files -f bin-man-doc-files
+%defattr(-,root,root)
+%{_datadir}/git-core/
+%doc README COPYING Documentation/*.txt
+%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
+%{!?_without_docs: %doc Documentation/technical}
=20
 %files svn
 %defattr(-,root,root)
@@ -173,14 +180,10 @@ rm -rf $RPM_BUILD_ROOT
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)
=20
-%files core -f bin-man-doc-files
-%defattr(-,root,root)
-%{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
-%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
-%{!?_without_docs: %doc Documentation/technical}
-
 %changelog
+* Fri Feb 15 2008 Kristian H=C3=B8gsberg <krh@redhat.com>
+- Rename git-core to just git and rename meta package from git to git-=
all.
+
 * Sun Feb 03 2008 James Bowes <jbowes@dangerouslyinc.com>
 - Add a BuildRequires for gettext
=20
--=20
1.5.4.1.123.g012f
