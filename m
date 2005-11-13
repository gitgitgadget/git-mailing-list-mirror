From: Thomas Matysik <thomas@matysik.co.nz>
Subject: [PATCH 2/2] Split gitk into seperate RPM package
Date: Sun, 13 Nov 2005 17:58:02 +1300
Message-ID: <4376C7DA.8070901@matysik.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 13 05:58:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb9wU-0008B7-Iq
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 05:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVKME6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 23:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVKME6M
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 23:58:12 -0500
Received: from [202.37.90.137] ([202.37.90.137]:36044 "EHLO xena.matysik.co.nz")
	by vger.kernel.org with ESMTP id S1751350AbVKME6L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 23:58:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by xena.matysik.co.nz (Postfix) with ESMTP id 3ADA9189C4C
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 17:58:01 +1300 (NZDT)
Received: from xena.matysik.co.nz ([127.0.0.1])
 by localhost (xena.matysik.co.nz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13756-09 for <git@vger.kernel.org>;
 Sun, 13 Nov 2005 17:58:00 +1300 (NZDT)
Received: from [202.37.90.142] (joxer.matysik.co.nz [202.37.90.142])
	by xena.matysik.co.nz (Postfix) with ESMTP id 3424A189C30
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 17:58:00 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.92.0.0
X-Virus-Scanned: by amavisd-new at matysik.co.nz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11726>


I don't want to have to install x11-libs and all it's dependencies on my headless machines, so this patch splits gitk out of the RPM.

The .deb already appears to have gitk split out.

Signed-off-by: Thomas Matysik <thomas@matysik.co.nz>
---

 git-core.spec.in |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

applies-to: 69a4acd3853a9d7fb26bc3620c9fb3079b2b5494
57d0a6cf0343ae19581dc2c89821605077a4035d
diff --git a/git-core.spec.in b/git-core.spec.in
index 91f8677..54a6815 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -9,7 +9,7 @@ URL: 		http://kernel.org/pub/software/sc
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, tk >= 8.4, expat
+Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, expat

 %description
 This is a stupid (but extremely fast) directory content manager.  It
@@ -47,6 +47,13 @@ Requires:	git-core = %{version}-%{releas
 %description email
 Git tools for sending email.

+%package tk
+Summary:        Git revision tree visualiser ('gitk')
+Group:          Development/Tools
+Requires:       git-core = %{version}-%{release}, tk >= 8.4
+%description tk
+Git revision tree visualiser ('gitk')
+
 %prep
 %setup -q

@@ -60,9 +67,9 @@ make %{_smp_mflags} DESTDIR=$RPM_BUILD_R
      prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}

-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 %if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %endif

 %clean
@@ -96,6 +103,13 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man1/*email*.1*}
 %{!?_without_docs: %doc Documentation/*email*.html }

+%files tk
+%defattr(-,root,root)
+%doc Documentation/*gitk*.txt
+%{_bindir}/*gitk*
+%{!?_without_docs: %{_mandir}/man1/*gitk*.1*}
+%{!?_without_docs: %doc Documentation/*gitk*.html }
+
 %files -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
---
0.99.9g
