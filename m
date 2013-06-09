From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/45] Move sequencer to builtin
Date: Sun,  9 Jun 2013 11:40:18 -0500
Message-ID: <1370796057-25312-7-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlikQ-00087f-Ro
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab3FIQpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:45:39 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40231 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3FIQnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:08 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so3468019oag.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AVhU+ISAqn3PQXTYAe1Evhzovv6N2pW3JT0An7pezPM=;
        b=jNUsrvgp6XwMgDsieTU922lzyu8fCDI8yoQufQW65mvLwCwBOlosUkMmRfdOy7JB8m
         ZdNDMThm2N6S8riJVndEPYwVp1mbTtEvGz95kJ2OYsWjPq4wGQvNk3OjDMn56PJL0WFS
         cX6OPLGTBtANQrJ9muyH3/ab0LcE932IyWvL6cmcyhCR5DZNoG9NzcQfa6PK02rzzR08
         TViSeCJBOfQxBw2lYhG1WJd3iZgvNm6nDeFlvuQIklaWY/wuwVicHC0oGfkt7z3YJdgy
         PZFrPDUI9YJMgGXBJH6M21caUOcsAMz1KrCZZR1Mqc3BfKGhxAjAHwbjy8rUW47bB3kP
         KEsg==
X-Received: by 10.60.62.162 with SMTP id z2mr5169076oer.140.1370796188192;
        Sun, 09 Jun 2013 09:43:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm213383oed.5.2013.06.09.09.43.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227018>

This code is only useful for cherry-pick and revert built-ins, nothing
else, so let's make it a builtin object.

The first source file that doesn't generate a git-foo builtin, but does
go into the builtin library. Hopefully the first of many to clean
libgit.a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                           | 10 ++++++----
 sequencer.c => builtin/sequencer.c |  0
 sequencer.h => builtin/sequencer.h |  0
 3 files changed, 6 insertions(+), 4 deletions(-)
 rename sequencer.c => builtin/sequencer.c (100%)
 rename sequencer.h => builtin/sequencer.h (100%)

diff --git a/Makefile b/Makefile
index d2af207..4c7bb88 100644
--- a/Makefile
+++ b/Makefile
@@ -716,7 +716,6 @@ LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += send-pack.h
-LIB_H += sequencer.h
 LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
 LIB_H += shortlog.h
@@ -858,7 +857,6 @@ LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
-LIB_OBJS += sequencer.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
@@ -992,6 +990,9 @@ BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+BUILTIN_LIB_OBJS += builtin/sequencer.o
+BUILTIN_LIB_OBJS += $(BUILTIN_OBJS)
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
@@ -1894,7 +1895,8 @@ VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
-OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+OBJECTS := $(LIB_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+	$(BUILTIN_LIB_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
 	git.o
@@ -2071,7 +2073,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
-$(BUILTIN_LIB): $(BUILTIN_OBJS)
+$(BUILTIN_LIB): $(BUILTIN_LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
diff --git a/sequencer.c b/builtin/sequencer.c
similarity index 100%
rename from sequencer.c
rename to builtin/sequencer.c
diff --git a/sequencer.h b/builtin/sequencer.h
similarity index 100%
rename from sequencer.h
rename to builtin/sequencer.h
-- 
1.8.3.698.g079b096
