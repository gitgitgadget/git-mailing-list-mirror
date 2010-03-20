From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: [PATCH/RFC v2] RPM spec: optionally include bash completion support
Date: Fri, 19 Mar 2010 17:32:14 -0700
Message-ID: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 01:32:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsmc1-0000GC-Nt
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 01:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0CTAcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 20:32:17 -0400
Received: from smtp2.Stanford.EDU ([171.67.219.82]:41955 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751978Ab0CTAcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 20:32:17 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id AD569170731
	for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:32:16 -0700 (PDT)
Received: from ashbury.stanford.edu (ashbury.Stanford.EDU [171.67.43.200])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 8BD75170701
	for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:32:14 -0700 (PDT)
Received: by ashbury.stanford.edu (Postfix, from userid 26037)
	id 672C41D0054; Fri, 19 Mar 2010 17:32:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142667>

Include the bash completion routines from contrib/ in our core RPM, in the
standard system-wide location, when our spec is built "--with completion". The
completion routines are not packaged by default.
---

 git.spec.in |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ee74a5e..65a0db8 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -1,4 +1,5 @@
 # Pass --without docs to rpmbuild if you don't want the documentation
+# Pass --with completion to rpmbuild if you want shell completion support
 
 Name: 		git
 Version: 	@@VERSION@@
@@ -127,6 +128,11 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
 
+%if %{?_with_completion:1}0
+mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
+install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git
+%endif
+
 %clean
 rm -rf $RPM_BUILD_ROOT
 
@@ -136,6 +142,7 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
+%{?_with_completion: %{_sysconfdir}/bash_completion.d}
 
 %files svn
 %defattr(-,root,root)
-- 
1.7.0.2
