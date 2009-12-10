From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 4/6] GITWEB - Makefile changes
Date: Thu, 10 Dec 2009 23:45:41 +0000
Message-ID: <1260488743-25855-5-git-send-email-warthog9@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <1260488743-25855-3-git-send-email-warthog9@kernel.org>
 <1260488743-25855-4-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsjR-0005wO-6Y
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbZLJXrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbZLJXrF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:47:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:39932 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430AbZLJXq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:46:59 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANjuJA025999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:45:57 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANjuZA025998;
	Thu, 10 Dec 2009 23:45:56 GMT
X-Mailer: git-send-email 1.6.5.5
In-Reply-To: <1260488743-25855-4-git-send-email-warthog9@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135055>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This adjust the makefiles so that you can do such things as

	make gitweb

from the top level make tree, or if your in the gitweb directory
itself typing

	make

will call back up to the main Makefile and build gitweb

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 Makefile        |    4 +++-
 gitweb/Makefile |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)
 create mode 100644 gitweb/Makefile


--------------1.6.5.2
Content-Type: text/x-patch; name="0004-GITWEB-Makefile-changes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0004-GITWEB-Makefile-changes.patch"

diff --git a/Makefile b/Makefile
index 4a1e5bc..8db9d01 100644
--- a/Makefile
+++ b/Makefile
@@ -1509,6 +1509,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
 
+.PHONY: gitweb
+gitweb: gitweb/gitweb.cgi
 ifdef JSMIN
 OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
 gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
@@ -1537,7 +1539,7 @@ endif
 	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $< >$@+ && \
+	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
diff --git a/gitweb/Makefile b/gitweb/Makefile
new file mode 100644
index 0000000..8d318b3
--- /dev/null
+++ b/gitweb/Makefile
@@ -0,0 +1,14 @@
+SHELL = /bin/bash
+
+FILES = gitweb.cgi
+
+.PHONY: $(FILES)
+
+all: $(FILES)
+
+$(FILES):
+	$(MAKE) $(MFLAGS) -C ../ -f Makefile gitweb/$@
+
+clean:
+	rm -rf $(FILES)
+

--------------1.6.5.2--
