From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Run the specified perl in Documentation/
Date: Fri, 30 Nov 2007 18:36:34 -0800
Message-ID: <7vfxyn9m4t.fsf@gitster.siamese.dyndns.org>
References: <863auuoy96.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEH-0003kJ-Ki
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758502AbXLACgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758501AbXLACgk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40290 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448AbXLACgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 83BD52F9;
	Fri, 30 Nov 2007 21:37:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C4D039BA0F;
	Fri, 30 Nov 2007 21:36:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66681>

Makefile uses $(PERL_PATH) but Documentation/Makefile uses "perl"; that
means the two Makefiles can use two different Perl installations.

Teach Documentation/Makefile to use PERL_PATH that is exported from the
toplevel Makefile, and give a sane fallback for people who run "make"
from Documentation directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Haven't tested this at all; please Ack or report breakage.

 Documentation/Makefile |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d886641..8b19130 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -45,6 +45,9 @@ infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
 INSTALL_INFO=install-info
 DOCBOOK2X_TEXI=docbook2x-texi
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
 
 -include ../config.mak.autogen
 -include ../config.mak
@@ -105,7 +108,7 @@ install-info: info
 #
 doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(RM) $@+ $@
-	perl ./build-docdep.perl >$@+
+	$(PERL_PATH) ./build-docdep.perl >$@+
 	mv $@+ $@
 
 -include doc.dep
@@ -124,7 +127,7 @@ $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl $(MAN1_TXT)
 	$(RM) $@
-	perl ./cmd-list.perl
+	$(PERL_PATH) ./cmd-list.perl
 	date >$@
 
 git.7 git.html: git.txt
@@ -161,7 +164,7 @@ user-manual.html: user-manual.xml
 git.info: user-manual.xml
 	$(RM) $@ $*.texi $*.texi+
 	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout >$*.texi+
-	perl fix-texi.perl <$*.texi+ >$*.texi
+	$(PERL_PATH) fix-texi.perl <$*.texi+ >$*.texi
 	$(MAKEINFO) --no-split $*.texi
 	$(RM) $*.texi $*.texi+
 
