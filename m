From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Cogito chicken-and-egg problem
Date: Tue, 26 Apr 2005 12:06:10 -0400
Message-ID: <1114531570.19478.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 18:07:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQSZb-0007Vi-CO
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDZQKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDZQH2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:07:28 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:25494
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261618AbVDZQG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:06:29 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id DEA8BEFF3B; Tue, 26 Apr 2005 12:06:10 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

My patch for Makefile was misapplied, so installed commit-id is still
needed for "make" to succeed.

Shell commands are processed by make before being passed to the shell,
and $(...) is expanded by make before new PATH is set, as it is done in
the current Makefile.

Also, the dependency on commit-id was dropped from my patch for some
reason.  I believe it's still needed.  Also, we need a dependency on
cat-file, which is used by commit-id internally.

Signed-off-by: Pavel Roskin <proski@gnu.org>

Index: Makefile
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/Makefile  (mode:100644 sha1:4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92)
+++ uncommitted/Makefile  (mode:100644)
@@ -87,11 +87,11 @@
 http-pull: LIBS += -lcurl
 
 
-cg-version: $(VERSION)
+cg-version: $(VERSION) commit-id cat-file
 	@echo Generating cg-version...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@PATH=.:$(PATH) echo "echo \"$(shell cat $(VERSION)) ($(shell commit-id))\"" >> $@
+	@echo "echo \"$(shell cat $(VERSION)) ($(shell PATH=.:$(PATH) ./commit-id))\"" >> $@
 	@chmod +x $@
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)


-- 
Regards,
Pavel Roskin

