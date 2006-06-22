From: Yakov Lerner <iler.ml@gmail.com>
Subject: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 04:47 +0300
Message-ID: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 22 03:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtEGe-00036o-Ec
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 03:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWFVBp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 21:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWFVBp5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 21:45:57 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:50422 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S1030489AbWFVBp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 21:45:56 -0400
Received: from main ([84.108.4.5]) by mxout2.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0J1800MBZNKJD2C0@mxout2.netvision.net.il> for
 git@vger.kernel.org; Thu, 22 Jun 2006 04:45:55 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008008-linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22294>

Before this patch, -DDEFAULT_GIT_TEMPLATE_DIR was passed on compilation
command line to all and every %c compiled. In fact the macro
is used by only one .c file, and unused by all other .c files.
Remove -DDEFAULT_GIT_TEMPLATE_DIR where unused. Follow the examlpe of 
exec_cmd.o. Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used. 

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c602099..7af0937 100644
--- a/Makefile
+++ b/Makefile
@@ -472,7 +472,6 @@ PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON
 GIT_PYTHON_DIR_SQ = $(subst ','\'',$(GIT_PYTHON_DIR))
 
 ALL_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
-ALL_CFLAGS += -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
@@ -548,6 +547,8 @@ git$X git.spec \
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
+	$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
 http.o: http.c GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
-- 
1.4.0.ga40a
