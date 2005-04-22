From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] git-pasky spec file
Date: Thu, 21 Apr 2005 18:55:21 -0700
Message-ID: <20050422015521.GK493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 03:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOnKK-0001JE-RB
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 03:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVDVBzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVDVBzv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 21:55:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:27578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261917AbVDVBz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 21:55:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3M1tLs4020953
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 18:55:22 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3M1tLSO005265;
	Thu, 21 Apr 2005 18:55:21 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j3M1tL60005264;
	Thu, 21 Apr 2005 18:55:21 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's a simple spec file to do rpm builds.  It's against the
latest Makefile (which has the s/BINDIR/bindir/ change).  I've used
DESTDIR, although it's not clear it's meant to stay in the Makefile.
For now, there's no dynamic (git.spec.in, for example) update to the
Version, so it's set against 0.6.3 (expecting it to be forthcoming
shortly).  It installs to /usr/local/bin, and expects the tarball to be
named git-pasky-0.6.3.tar.bz2.  Creates a package named git, which seems
fine since Linus' isn't likely to be packaged directly.  Enjoy.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- /dev/null	1969-12-31 16:00:00.000000000 -0800
+++ git-pasky-0.6.3/git.spec	2005-04-21 18:42:18.000000000 -0700
@@ -0,0 +1,43 @@
+Name: 		git
+Version: 	0.6.3
+Release: 	1
+Vendor: 	Petr Baudis <pasky@ucw.cz>
+Summary:  	Git core and tools
+License: 	GPL
+Group: 		Development/Tools
+URL: 		http://pasky.or.cz/~pasky/dev/git/
+Source: 	http://pasky.or.cz/~pasky/dev/git/%{name}-pasky-%{version}.tar.bz2
+Provides: 	git = %{version}
+BuildRequires:	zlib-devel openssl-devel
+BuildRoot:	%{_tmppath}/%{name}-%{version}-root
+Prereq: 	sh-utils diffutils
+
+%description
+GIT comes in two layers. The bottom layer is merely an extremely fast
+and flexible filesystem-based database designed to store directory trees
+with regard to their history. The top layer is a SCM-like tool which
+enables human beings to work with the database in a manner to a degree
+similar to other SCM tools (like CVS, BitKeeper or Monotone).
+
+%prep
+%setup -q -n %{name}-pasky-%{version}
+
+%build
+
+make
+
+%install
+rm -rf $RPM_BUILD_ROOT
+make DESTDIR=$RPM_BUILD_ROOT/usr/local/ bindir=bin/ install
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+%files
+%defattr(-,root,root)
+/usr/local/bin/*
+#%{_mandir}/*/*
+
+%changelog
+* Thu Apr 21 2005 Chris Wright <chrisw@osdl.org> 0.6.3-1
+- Initial rpm build
