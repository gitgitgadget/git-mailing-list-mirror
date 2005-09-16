From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] Update git-core.spec.in
Date: Fri, 16 Sep 2005 13:38:49 -0700
Message-ID: <20050916203847.GO8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:40:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMzA-0004St-Iv
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVIPUi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIPUi6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:38:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751263AbVIPUi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 16:38:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GKcnBo014560
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 13:38:49 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GKcnKH011719;
	Fri, 16 Sep 2005 13:38:49 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8GKcnc1011718;
	Fri, 16 Sep 2005 13:38:49 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8731>

Update git-core spec file based on feedback from Fedora Extras review.

- update BuildRoot to be more specific
- eliminate Requires that must be satisfied for base system install
- drop Vendor
- use dist tag to differentiate between branches
- own %{_datadir}/git-core/
- use RPM_OPT_FLAGS in spec file

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 git-core.spec.in |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/git-core.spec.in b/git-core.spec.in
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -1,16 +1,15 @@
 # Pass --without docs to rpmbuild if you don't want the documetnation
 Name: 		git-core
 Version: 	@@VERSION@@
-Release: 	1
-Vendor: 	Junio C Hamano <junkio@cox.net>
+Release: 	1%{?dist}
 Summary:  	Git core and tools
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
-BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Requires: 	sh-utils, curl, diffutils, less, rsync, rcs, openssh-clients, perl, python >= 2.4, tk
+BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
+Requires:	rsync, rcs, curl, less, openssh-clients, python >= 2.4, tk
 
 %description
 This is a stupid (but extremely fast) directory content manager.  It
@@ -24,7 +23,7 @@ elsewhere for tools for ordinary humans 
 %setup -q
 
 %build
-make prefix=%{_prefix} all %{!?_without_docs: doc}
+make COPTS="$RPM_OPT_FLAGS" prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
@@ -37,13 +36,16 @@ rm -rf $RPM_BUILD_ROOT
 %files
 %defattr(-,root,root)
 %{_bindir}/*
-%{_datadir}/git-core/templates/*
+%{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html }
 %{!?_without_docs: %{_mandir}/man1/*.1*}
 %{!?_without_docs: %{_mandir}/man7/*.7*}
 
 %changelog
+* Fri Sep 16 2005 Chris Wright <chrisw@osdl.org> 0.99.6-1
+- update to 0.99.6
+
 * Fri Sep 16 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 - Linus noticed that less is required, added to the dependencies
 
@@ -51,6 +53,18 @@ rm -rf $RPM_BUILD_ROOT
 - Updated dependencies
 - Don't assume manpages are gzipped
 
+* Thu Aug 18 2005 Chris Wright <chrisw@osdl.org> 0.99.4-4
+- drop sh_utils, sh-utils, diffutils, mktemp, and openssl Requires
+- use RPM_OPT_FLAGS in spec file, drop patch0
+
+* Wed Aug 17 2005 Tom "spot" Callaway <tcallawa@redhat.com> 0.99.4-3
+- use dist tag to differentiate between branches
+- use rpm optflags by default (patch0)
+- own %{_datadir}/git-core/
+
+* Mon Aug 15 2005 Chris Wright <chrisw@osdl.org>
+- update spec file to fix Buildroot, Requires, and drop Vendor
+
 * Sun Aug 07 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 - Redid the description
 - Cut overlong make line, loosened changelog a bit
