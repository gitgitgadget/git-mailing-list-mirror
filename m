From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Added git-p4 package to the list of git RPMs.
Date: Tue, 27 Mar 2007 15:25:15 +0400
Message-ID: <20070327112514.GC14837@codelabs.ru>
References: <20070321144008.GE14837@codelabs.ru> <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321160126.GH14837@codelabs.ru> <7v1wji371q.fsf@assigned-by-dhcp.cox.net> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <7v1wjcz9x1.fsf@assigned-by-dhcp.cox.net> <20070327102601.GN14837@codelabs.ru> <7vps6vnehz.fsf@assigned-by-dhcp.cox.net> <20070327112202.GB14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9nw-0003z5-5Q
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbXC0LZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbXC0LZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:25:28 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:64531 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXC0LZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:25:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=BhZfWuQtIfJXmalMHPGa4GzJVUqN53C8+TEmhVeuzWXxQCT/LosENgLEnZEobubwr2o9XXPd/viieEN69OUNX7MYdPbUnt9hhIw7GXuYQi0kC9iqk1W6L/3J34TXt4w9Aw2CX88+hOy7tyy7qz/4ObManlYrrgYcm89WIM6sUPE=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW9nl-000Df6-Rx; Tue, 27 Mar 2007 15:25:22 +0400
Content-Disposition: inline
In-Reply-To: <20070327112202.GB14837@codelabs.ru>
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43265>

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git.spec.in |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 46aee88..8c79a79 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -50,6 +50,13 @@ Requires:       git-core = %{version}-%{release}, tla
 %description arch
 Git tools for importing Arch repositories.
 
+%package p4
+Summary:        Git tools for importing Perforce repositories
+Group:          Development/Tools
+Requires:       git-core = %{version}-%{release}, python
+%description p4
+Git tools for importing Perforce repositories.
+
 %package email
 Summary:        Git tools for sending email
 Group:          Development/Tools
@@ -86,22 +93,22 @@ Perl interface to Git
 
 %build
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} all %{!?_without_docs: doc}
+     WITH_P4IMPORT=YesPlease prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
-     WITH_OWN_SUBPROCESS_PY=YesPlease \
+     WITH_OWN_SUBPROCESS_PY=YesPlease WITH_P4IMPORT=YesPlease \
      prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
      install %{!?_without_docs: install-doc}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 
-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "archimport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "p4import|archimport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 (find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "p4import|archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
@@ -133,6 +140,13 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
 %{!?_without_docs: %doc Documentation/git-archimport.html }
 
+%files p4
+%defattr(-,root,root)
+%doc Documentation/git-p4import.txt
+%{_bindir}/git-p4import
+%{!?_without_docs: %{_mandir}/man1/git-p4import.1*}
+%{!?_without_docs: %doc Documentation/git-p4import.html }
+
 %files email
 %defattr(-,root,root)
 %doc Documentation/*email*.txt
@@ -167,6 +181,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/*.html }
 
 %changelog
+* Tue Mar 27 2007 Eygene Ryabinkin <rea-git@codelabs.ru>
+- Added the git-p4 package: Perforce import stuff.
+
 * Mon Feb 13 2007 Nicolas Pitre <nico@cam.org>
 - Update core package description (Git isn't as stupid as it used to be)
 
-- 
1.5.0.3-dirty
