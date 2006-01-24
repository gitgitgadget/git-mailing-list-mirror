From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Parametrize asciidoc and add --unsafe
Date: Tue, 24 Jan 2006 17:15:46 -0500
Message-ID: <1138140946.19065.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 24 23:16:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1WSA-0000lP-BK
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 23:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWAXWPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 17:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWAXWPv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 17:15:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55247 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750773AbWAXWPu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 17:15:50 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1WRy-00040W-QX
	for git@vger.kernel.org; Tue, 24 Jan 2006 17:15:42 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1WS2-00053e-Qj
	for git@vger.kernel.org; Tue, 24 Jan 2006 17:15:46 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15108>

Including files from the parent directory is considered unsafe by
asciidoc 7.1.0.  This is used in git.txt, which includes ../README.

Since git is developed openly, we shouldn't be afraid of exploits
lurking in the docs.  Create a make variable ASCIIDOC and use it to
always call asciidoc with the --unsafe option.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/Makefile |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a65fb1b..391f583 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,8 @@ man7=$(mandir)/man7
 
 INSTALL?=install
 
+ASCIIDOC = asciidoc --unsafe
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
@@ -69,20 +71,20 @@ clean:
 	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
 
 %.html : %.txt
-	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
+	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage -f asciidoc.conf $<
+	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
 
 git.html: git.txt ../README
 
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
 	perl sort_glossary.pl | \
-	asciidoc -b xhtml11 - > glossary.html
+	$(ASCIIDOC) -b xhtml11 - > glossary.html
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	rm -f $@+ $@
@@ -90,13 +92,13 @@ howto-index.txt: howto-index.sh $(wildca
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	asciidoc -b xhtml11 $*.txt
+	$(ASCIIDOC) -b xhtml11 $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	rm -f $@+ $@
-	sed -e '1,/^$$/d' $? | asciidoc -b xhtml11 - >$@+
+	sed -e '1,/^$$/d' $? | $(ASCIIDOC) -b xhtml11 - >$@+
 	mv $@+ $@
 
 install-webdoc : html



-- 
Regards,
Pavel Roskin
