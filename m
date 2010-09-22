From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 3/3] gitweb/Makefile: Add test-installed target
Date: Wed, 22 Sep 2010 16:21:26 +0200
Message-ID: <1285165286-12452-4-git-send-email-jnareb@gmail.com>
References: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 16:22:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyQD6-0005nk-Be
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab0IVOVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 10:21:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0IVOVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 10:21:49 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so464599bwz.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eEkNoMrESTQGnAh/UM9X7wEBU5TOhcaf4H3KBT5kdGk=;
        b=FfpVYw4f75ZqPaW0ZNMS07IBS2HokW2+axju4IVaZ7Z41Dr+bD45I5VWrwIycshtc+
         IsAL0YmcD7gjI5RzJfqqB0BFhYkL1gFGCKxI/Q78Birx+173UxcO8osIG1CaKwZT090v
         /Tut9qx50e/5K01mGiP7BXoY/Xo7JLoHDR1wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EPtEH+U5+paybNs7xDs3jEW2L/yKJPax6dCQj8w3BKlFSsVkN/UAgFB68YqvKYU8q4
         fYQAUC9aC18st0+OcuufvS6R23UHKaGUYsjaXcnDA01XHgWT7CPqKYPAIe8vKMRlqt5/
         LUMi7OMKP2tGLJyITa3NRiOMvShYaNHfmidZo=
Received: by 10.204.141.16 with SMTP id k16mr106827bku.177.1285165308303;
        Wed, 22 Sep 2010 07:21:48 -0700 (PDT)
Received: from localhost.localdomain (abva250.neoplus.adsl.tpnet.pl [83.8.198.250])
        by mx.google.com with ESMTPS id x13sm8626411bki.12.2010.09.22.07.21.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 07:21:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156806>

The 'test-installed' target in gitweb/Makefile installs and tests
installed gitweb.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
RFC, because I am not 100% sure that 'test-installed' should have
'install' target as a dependency.

Probably should be marked .PHONY, but then there are some other
targets that should be marked such beside 'test-installed'.

The t/Makefile part is fairly uncontroversial, I think.

 gitweb/Makefile |    4 ++++
 t/Makefile      |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 88bcf08..90f7212 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -152,6 +152,10 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
+test-installed: install
+	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
+		$(MAKE) -C ../t gitweb-test
+
 ### Cleaning rules
 
 clean:
diff --git a/t/Makefile b/t/Makefile
index c7baefb..7aa409a 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
+TGITWEB = $(wildcard t95[0-9][0-9]-*.sh)
 
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
@@ -46,6 +47,9 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
+gitweb-test:
+	$(MAKE) $(TGITWEB)
+
 valgrind:
 	GIT_TEST_OPTS=--valgrind $(MAKE)
 
-- 
1.7.2.1
