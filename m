From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] Have make fail when $(DOCBOOK2X_TEXI) fails in building gitman.texi
Date: Sun, 24 May 2009 18:51:05 -0400
Message-ID: <1243205465-12139-1-git-send-email-naesten@gmail.com>
Cc: git@vger.kernel.org, Samuel Bronson <naesten@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 25 00:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8MYQ-0007lR-IF
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZEXWwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZEXWwW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:52:22 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:31742 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbZEXWwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:52:21 -0400
Received: from mr08.lnh.mail.rcn.net ([207.172.157.28])
  by smtp02.lnh.mail.rcn.net with ESMTP; 24 May 2009 18:52:22 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr08.lnh.mail.rcn.net (MOS 3.10.5-GA)
	with ESMTP id KWO69722;
	Sun, 24 May 2009 18:51:57 -0400 (EDT)
Received: from 207-172-203-39.c3-0.upd-ubr7.trpr-upd.pa.cable.rcn.com (HELO hydrogen) ([207.172.203.39])
  by smtp01.lnh.mail.rcn.net with ESMTP; 24 May 2009 18:51:57 -0400
Received: from naesten by hydrogen with local (Exim 4.69)
	(envelope-from <naesten@gmail.com>)
	id 1M8MXs-0003Ai-OU; Sun, 24 May 2009 18:51:56 -0400
X-Mailer: git-send-email 1.6.3.1
X-Junkmail-Whitelist: YES (by domain whitelist at mr08.lnh.mail.rcn.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119871>

This is handy for when docbook2x isn't installed. Without this change,
we would just build a mostly-empty gitman.texi rather than failing as we
should.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..2998f0d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -205,9 +205,11 @@ user-manual.pdf: user-manual.xml
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl
-	$(RM) $@+ $@
+	$(RM) $@++ $@+ $@
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml);)) | $(PERL_PATH) cat-texi.perl $@ >$@+
+		--to-stdout $(xml);)) >$@++
+	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+
+	$(RM) $@++
 	mv $@+ $@
 
 gitman.info: gitman.texi
-- 
1.6.3.1
