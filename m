From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 04/36] build: add builtin lib
Date: Sun,  9 Jun 2013 14:24:18 -0500
Message-ID: <1370805890-3453-5-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGc-0003FB-8K
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab3FIT05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:26:57 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:60509 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3FIT0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:26:55 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so5022940oag.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zaMQcVLVxIo/AYeWLzFLCHgnV0WDJ7ARoQqFTSBNPSs=;
        b=WOmrn2JPAVL++2kSteP4sae5v6Mwb5rp+wKkLeeoOJJw5R1Gb7jEG9ngqSNtopciDH
         t+9AjQCUQT1A6B+O9ITfTt7wO0bAs7IAy1jDuuzS7lzpRxFHjDVPmPawOgndx4LYjHoS
         JAxTQB+szQF23yNpUskqC/SxubvbS+CB4X2Lod2gu0IS1prYI2z1URjMGUuguE7HUbBB
         impY9vv3pCFGBcs6vT8M7yiQjTUgwRrOMubVamCDiAk1DznIPWtGllAO/6BUXtfYyN7h
         Rfkmlm9kkHDQDM5qi06eIrKBHsNNoFGIiokQpex2MefV9adOdctmXC9T9DZ6E44sFYDp
         WslA==
X-Received: by 10.60.102.230 with SMTP id fr6mr5499130oeb.141.1370806014838;
        Sun, 09 Jun 2013 12:26:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm15932629obb.13.2013.06.09.12.26.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:26:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227115>

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
