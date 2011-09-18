From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Sun, 18 Sep 2011 15:34:41 +0200
Message-ID: <1316352884-26193-2-git-send-email-jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Sep 18 15:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5HWn-00027Y-Q4
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 15:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab1IRNfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 09:35:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59914 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1IRNfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 09:35:16 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3099867fxe.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dbuwzxkgKHYJsuzYgryk/AMX7aK5Sm+a44JIky2/Ma8=;
        b=icmWusJ/ejici1WM4aF4F1Sso+UoP4sBVUBixBKcBdHleOGAhM3QL/Kh04CTAErH3Q
         V/wtoMehDp6AtenMeCMDFcP2ppOhpv03EQjq7LPqg0XEtq/QA8H+RRivo6FRyvFzSiFJ
         zWFAX9K0CdlMzLeLgIImj5KlM3s2BPdcaOva4=
Received: by 10.223.56.216 with SMTP id z24mr3242183fag.4.1316352915504;
        Sun, 18 Sep 2011 06:35:15 -0700 (PDT)
Received: from localhost.localdomain (abvm199.neoplus.adsl.tpnet.pl. [83.8.210.199])
        by mx.google.com with ESMTPS id x22sm18322348faa.5.2011.09.18.06.35.13
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 06:35:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181606>

Gitweb documentation currently consist of gitweb/README, gitweb/INSTALL
and comments in gitweb source code.  This is harder to find, use and
browse that manpages ("man gitweb" or "git help gitweb") and HTML
documentation ("git help --web gitweb").

The goal is to move documentation out of gitweb/README to gitweb.txt and
gitweb.conf.txt manpages, reducing its size 10x from around 500 to
around 50 lines (two pages), and move information not related drectly to
building and installing gitweb out of gitweb/INSTALL there.

The idea is to have gitweb manpage sources reside in AsciiDoc format
in Documentation/ directory, like for gitk and git-gui.  Alternate
solution would be to have gitweb documentation in gitweb/ directory,
perhaps in POD format (see perlpod(1)).


This patch adds infrastructure for easy generating gitweb-related
manpages.  It adds currently empty 'gitweb-doc' target to
Documentation/Makefile, and 'doc' proxy target to gitweb's Makefile.

This way to build gitweb documentation one can use

  make -C gitweb doc

or

  cd gitweb; make doc

The gitweb.conf(5) and gitweb(1) manpages will be added in subsequent
commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This changes were part of patch adding first gitweb manpage in
previous version of this series.

Compared to v3 series it lacks the following hunk (at the very end of
Documentation/Makefile):

  @@ -334,4 +337,4 @@ quick-install-man:
   quick-install-html:
   	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
  
  -.PHONY: FORCE
  +.PHONY: FORCE gitweb-doc

This is because it would introduce inconsistency, as 'gitweb-doc'
would be only one of many phony targets in Documentation/Makefile
that is explicitly marked .PHONY

So this is something left for other commit.

 Documentation/Makefile |    3 +++
 gitweb/Makefile        |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6346a75..44be67b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -170,6 +170,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
+gitweb-doc: $(GITWEB_DOC)
+
 install: install-man
 
 install-man: man
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 1c85b5f..3014d80 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -174,6 +174,11 @@ test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
+### Documentation
+
+doc:
+	$(MAKE) -C ../Documentation gitweb-doc
+
 ### Installation rules
 
 install: all
@@ -187,5 +192,5 @@ install: all
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install test test-installed doc .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.6
