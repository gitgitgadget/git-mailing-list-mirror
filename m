From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Update the spec file so it can build and install the
 documentation
Date: Thu, 14 Jul 2005 19:24:23 -0600
Message-ID: <m1k6jsx3nc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:25:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEwW-0004oS-DU
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVGOBYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbVGOBYk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:24:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40381 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263061AbVGOBYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:24:39 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F1OOmC021964;
	Thu, 14 Jul 2005 19:24:24 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F1ONhV021963;
	Thu, 14 Jul 2005 19:24:23 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If you don't want the documentation simply build with
make RPMBUILD="rpmbuild --without docs"

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 git-core.spec.in |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

18d85dbab2fca214bfb625e65733d5fa52502111
diff --git a/git-core.spec.in b/git-core.spec.in
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -1,3 +1,4 @@
+# Pass --without docs to rpmbuild if you don't want the documetnation
 Name: 		git-core
 Version: 	@@VERSION@@
 Release: 	1
@@ -7,7 +8,7 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel, openssl-devel, curl-devel
+BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
 Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
 
@@ -23,11 +24,11 @@ similar to other SCM tools (like CVS, Bi
 
 %build
 
-make
+make all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make dest=$RPM_BUILD_ROOT prefix=%{_prefix} install
+make dest=$RPM_BUILD_ROOT prefix=%{_prefix} mandir=%{_mandir} install %{!?_without_docs: install-doc}
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -35,8 +36,13 @@ rm -rf $RPM_BUILD_ROOT
 %files
 %defattr(-,root,root)
 %{_bindir}/*
-%doc README COPYING Documentation/*
+%doc README COPYING Documentation/*.txt
+%{!?_without_docs: %doc Documentation/*.html }
+%{!?_without_docs: %{_mandir}/man1/*.1.gz}
+%{!?_without_docs: %{_mandir}/man7/*.7.gz}
 
 %changelog
+* Thu Jul 14 2005 Eric Biederman <ebiederm@xmission.com>
+- Add the man pages, and the --without docs build option
 * Wed Jul 7 2005 Chris Wright <chris@osdl.org>
 - initial git spec file
