From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cogito rpm package to include manuals
Date: Tue, 01 Nov 2005 23:30:50 -0500
Message-ID: <1130905850.9704.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 05:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXAHF-0002nd-1N
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 05:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVKBEa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVKBEa5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 23:30:57 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:25287 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751488AbVKBEa4
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 23:30:56 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EXAGz-0007ts-40
	for git@vger.kernel.org; Tue, 01 Nov 2005 23:30:53 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EXAGw-00044l-LP; Tue, 01 Nov 2005 23:30:50 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10999>

The cogito rpm package created by "make rpm" lacks manual pages.  I can
understand why manuals are not generated for local installations by
default (asciidoc is slow, and the commands are self-documented), but
rpm packages should be closer to perfection.

Since there is no way to install manuals without also installing the
text documentation, so the later is deleted after installation.

Nothing from the Documentation directory except tutorial-script should
be included as documentation.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cogito.spec.in b/cogito.spec.in
index 080b988..1ed9305 100644
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -8,6 +8,7 @@ URL: 		http://kernel.org/pub/software/sc
 Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires: 	git-core >= 0.99.7
+BuildRequires: 	asciidoc
 BuildArch:	noarch
 
 %description
@@ -21,11 +22,13 @@ many other version control systems.
 
 %build
 
-make
+make all doc
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} libdir=%{_libdir}/cogito install
+make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} libdir=%{_libdir}/cogito mandir=%{_mandir} \
+	install install-doc
+rm -rf $RPM_BUILD_ROOT/%{_prefix}/share/doc/cogito/txt
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -35,9 +38,13 @@ rm -rf $RPM_BUILD_ROOT
 %{_bindir}/*
 %dir %{_libdir}/cogito
 %{_libdir}/cogito/*
-%doc README COPYING Documentation/*
+%{_mandir}/man*/*
+%doc README COPYING Documentation/tutorial-script
 
 %changelog
+* Tue Nov 1 2005 Pavel Roskin <proski@gnu.org> 0.15.1-1
+- generate and include manuals
+
 * Tue Oct 11 2005 Chris Wright <chrisw@osdl.org> 0.15.1-1
 - use %dist
 


-- 
Regards,
Pavel Roskin
