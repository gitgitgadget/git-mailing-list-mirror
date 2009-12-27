From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH] Don't pass CFLAGS to the linker
Date: Sun, 27 Dec 2009 07:55:18 +0100
Message-ID: <1261896918-1953-1-git-send-email-tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 06:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOm6v-0002PC-Nh
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 06:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbZL0Fzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 00:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbZL0Fzm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 00:55:42 -0500
Received: from office.neopsis.com ([78.46.209.98]:39996 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZL0Fzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 00:55:42 -0500
Received: from susie ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	for git@vger.kernel.org;
	Sun, 27 Dec 2009 06:55:40 +0100
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135701>

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---

I don't remember exactly which tool had problems with CFLAGS being passed
to the linker. Maybe it was the clang static analyzer, or some other
tool that I let run on git.git. Anyway, I don't think there's any
reason to pass CFLAGS to the linker.

 Makefile |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index c11719c..d9cd189 100644
--- a/Makefile
+++ b/Makefile
@@ -1473,8 +1473,7 @@ git.o: git.c common-cmds.h GIT-CFLAGS
 		$(ALL_CFLAGS) -o $@ -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+	$(QUIET_LINK)$(CC) -o $@ git.o $(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
@@ -1660,10 +1659,10 @@ http-walker.o: http-walker.c http.h GIT-CFLAGS
 endif
 
 git-%$X: %.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-imap-send$X: imap-send.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 http.o http-walker.o http-push.o: http.h
@@ -1671,14 +1670,14 @@ http.o http-walker.o http-push.o: http.h
 http.o http-walker.o: $(LIB_H)
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
@@ -1798,7 +1797,7 @@ test-parse-options.o: parse-options.h
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
-- 
1.6.6
