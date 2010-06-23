From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Wed, 23 Jun 2010 20:48:48 +0100
Message-ID: <4C226520.5080009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVyx-000081-RI
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0FWTva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:51:30 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:52100 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753405Ab0FWTv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:51:28 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1ORVyp-0004r8-mz; Wed, 23 Jun 2010 19:51:27 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149543>


The msvc debug build (make MSVC=1 DEBUG=1) issues a warning
on every invocation of the linker:

    LINK : warning LNK4044: unrecognized option '/Zi'; ignored

In order to suppress the warning, we refrain from passing the
$(ALL_CFLAGS) macro to the linker.

Note that, should it be necessary in the future, an option
intended for both the (front-end) compiler and the linker can
be included in both CFLAGS and LDFLAGS.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index b979fb7..2730199 100644
--- a/Makefile
+++ b/Makefile
@@ -1515,7 +1515,7 @@ git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
+	$(QUIET_LINK)$(CC) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin/help.o: common-cmds.h
@@ -1810,17 +1810,17 @@ http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
 
 git-%$X: %.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-imap-send$X: imap-send.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
@@ -1830,7 +1830,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	cp $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_FILE): $(LIB_OBJS)
@@ -1934,7 +1934,7 @@ test-parse-options$X: parse-options.o
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
-- 
1.7.1
