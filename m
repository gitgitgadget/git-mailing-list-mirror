From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/45] build: add builtin lib
Date: Sun,  9 Jun 2013 11:40:16 -0500
Message-ID: <1370796057-25312-5-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulii6-0006RE-GF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab3FIQnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:09 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:36701 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:03 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so864542oah.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zaMQcVLVxIo/AYeWLzFLCHgnV0WDJ7ARoQqFTSBNPSs=;
        b=kNE/HSUuMvYZ2VDLOQq0LgJ2EHb9Z1gNKQFqkbhaS5Qb/RyWacrQC4Romh4P9ynspJ
         71M8JghIZoXwPyhb2dSbvamICkEZCF4Af5XLgUK7q7N3wDIk67N6LgHM+iDTOpe9nHFV
         lB5BM90oa7Ntz6NL3rILI/814zLrrmX8vgMVrvLP02s2qFK5u32nWB5+zW5tqK2LlWHE
         Gx44aqQhhZXmgbV0KEXRsGnRbM3L4aaNgVT+N6ZBxmqQoRrG7uCr+eEVFaldQfU1tTqG
         PpzsGKbxAB28EWY2XpifX30V3m1dytJXlCLermrkkNec69vu62sKwJCKE99ez1tBdQXa
         HOVA==
X-Received: by 10.60.131.143 with SMTP id om15mr5209057oeb.19.1370796182327;
        Sun, 09 Jun 2013 09:43:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm14859029oby.12.2013.06.09.09.43.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226975>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3b6cd5a..d2af207 100644
--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,7 @@ export PERL_PATH
 export PYTHON_PATH
 
 LIB_FILE = libgit.a
+BUILTIN_LIB = builtin/lib.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
@@ -1713,9 +1714,9 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_LIB) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(ALL_LDFLAGS) $(BUILTIN_LIB) $(LIBS)
 
 help.sp help.s help.o: common-cmds.h
 
@@ -2070,6 +2071,9 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
+$(BUILTIN_LIB): $(BUILTIN_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
@@ -2482,7 +2486,7 @@ profile-clean:
 
 clean: profile-clean coverage-clean
 	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+		builtin/*.o $(LIB_FILE) $(BUILTIN_LIB) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
-- 
1.8.3.698.g079b096
