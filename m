From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 06/36] Move sequencer to builtin
Date: Sun,  9 Jun 2013 14:24:20 -0500
Message-ID: <1370805890-3453-7-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGq-0003Pb-9L
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab3FIT1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:05 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45191 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3FIT1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:01 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so948113oah.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AVhU+ISAqn3PQXTYAe1Evhzovv6N2pW3JT0An7pezPM=;
        b=BYiIjlrU8uHuAaNEbOoXrIEX/StSmBtwK2ulXv0GrNvJHF4yqO3HnhIWybqSMcI42W
         48xhDtJ4dCOCSOnOEwxpagqjgrH4JpHaYo7Rib8CEULXgXKlMRu9R7zvAt2GgsaWwfPi
         dl4f4J2ME+7tPmyU+4kwDtFFZ92+97RJkqYRAm8tpkBnMZCVMEtIxB+yfJIwzv4+zfo/
         8uRVawQJIzTJ5nyG7hTOt3aBHcLXZvZmgOzWzfXuSfTZZ/Ynvp8LzOyh0h0p414cRgCU
         LmKIH0gO82B2/VL79aAuJEN6ywNAoQTOytu6HF9tSJm4mL/sv8WXPJFtGxoQsi38kdDp
         oQrA==
X-Received: by 10.182.108.230 with SMTP id hn6mr5644987obb.25.1370806020931;
        Sun, 09 Jun 2013 12:27:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm15950057obz.11.2013.06.09.12.26.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227116>

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
