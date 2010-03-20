From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sat, 20 Mar 2010 14:18:06 -0400
Message-ID: <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3Fd-0000F1-12
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab0CTSSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:18:15 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:53441 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab0CTSSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:18:14 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:56001 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nt3FV-0003Of-WF; Sat, 20 Mar 2010 14:18:14 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nt3FV-0002Jp-Uy; Sat, 20 Mar 2010 14:18:13 -0400
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142732>

Make the rpm spec file create a git-completion subpackage that
contains the bash completion support from the contrib/ directory.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

This is the alternate method for shipping the bash completion support.
I think I personally prefer this method, but I'd be happy to see
either solution ship as part of the .spec file so that I don't need to
continue handling it separately.

 git.spec.in |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ee74a5e..d59747a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -80,6 +80,13 @@ Requires:       git = %{version}-%{release}, tk >= 8.4
 %description gui
 Git GUI tool
 
+%package completion
+Summary:	Bash completion support for Git
+Group:		Development/Tools
+Requires:	git = %{version}-${release}, bash
+%description completion
+Bash completion support for Git
+
 %package -n gitk
 Summary:        Git revision tree visualiser ('gitk')
 Group:          Development/Tools
@@ -113,6 +120,8 @@ rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
      %{path_settings} \
      INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
+mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/bash_completion.d
+install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT/%{_sysconfdir}/bash_completion.d/git
 test ! -d $RPM_BUILD_ROOT%{python_sitelib} || rm -fr $RPM_BUILD_ROOT%{python_sitelib}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
@@ -177,6 +186,10 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man1/git-citool.1*}
 %{!?_without_docs: %doc Documentation/git-citool.html}
 
+%files completion
+%defattr(-,root,root)
+%{_sysconfdir}/bash_completion.d/git
+
 %files -n gitk
 %defattr(-,root,root)
 %doc Documentation/*gitk*.txt
@@ -192,6 +205,10 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sat Mar 20 2010 Ben Walton <bwalton@artsci.utoronto.ca>
+- Add git-completion subpackage to distribute bash completion from
+  contrib.
+
 * Sun Jan 31 2010 Junio C Hamano <gitster@pobox.com>
 - Do not use %define inside %{!?...} construct.
 
-- 
1.7.0
