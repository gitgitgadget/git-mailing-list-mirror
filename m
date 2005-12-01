From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 01 Dec 2005 03:32:01 +0200
Message-ID: <20051201033201.02b47071.tihirvon@gmail.com>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 01 02:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhdJ4-0007kI-7B
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 02:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbVLABcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbVLABcI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 20:32:08 -0500
Received: from marski.suomi.net ([212.50.131.142]:63693 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S1751608AbVLABcF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 20:32:05 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IQS00I9OPLFKN40@marski.suomi.net> for git@vger.kernel.org;
 Thu, 01 Dec 2005 03:32:04 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IQS004KBPQYAVB0@mailstore.suomi.net>; Thu,
 01 Dec 2005 03:35:22 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id D898A11B541; Thu,
 01 Dec 2005 03:32:00 +0200 (EET)
In-reply-to: <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.05,	required 5,
 autolearn=not spam, AWL 0.52, BAYES_00 -2.60,	UPPERCASE_25_50 0.03)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13034>


This makes it possible to define WITH_SEND_EMAIL etc. in config.mak.

Also remove GIT_LIST_TWEAK because it isn't used anymore.

---

 Makefile |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

f877acdc3f8c888dd82a1e81ce20c8715e3108e4
diff --git a/Makefile b/Makefile
index 984d167..00521fe 100644
--- a/Makefile
+++ b/Makefile
@@ -138,8 +138,6 @@ ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROG
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
 
-GIT_LIST_TWEAK =
-
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
@@ -154,20 +152,6 @@ endif
 PYMODULES = \
 	gitMergeCommon.py
 
-ifdef WITH_OWN_SUBPROCESS_PY
-	PYMODULES += compat/subprocess.py
-else
-	ifneq ($(shell $(PYTHON_PATH) -c 'import subprocess;print"OK"' 2>/dev/null),OK)
-		PYMODULES += compat/subprocess.py
-	endif
-endif
-
-ifdef WITH_SEND_EMAIL
-	SCRIPT_PERL += git-send-email.perl
-else
-	GIT_LIST_TWEAK += -e '/^send-email$$/d'
-endif
-
 LIB_FILE=libgit.a
 
 LIB_H = \
@@ -256,6 +240,18 @@ endif
 
 -include config.mak
 
+ifdef WITH_OWN_SUBPROCESS_PY
+	PYMODULES += compat/subprocess.py
+else
+	ifneq ($(shell $(PYTHON_PATH) -c 'import subprocess;print"OK"' 2>/dev/null),OK)
+		PYMODULES += compat/subprocess.py
+	endif
+endif
+
+ifdef WITH_SEND_EMAIL
+	SCRIPT_PERL += git-send-email.perl
+endif
+
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not always want -R.
-- 
0.99.9.GIT
