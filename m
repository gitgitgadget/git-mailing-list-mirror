From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Fix git-shell build error when NO_SETENV is defined
Date: Mon, 21 Jul 2008 02:43:37 +0200
Message-ID: <1216601017-7871-1-git-send-email-s-beyer@gmx.net>
References: <g60la4$diu$1@ger.gmane.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: SungHyun Nam <namsh@posdata.co.kr>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjW5-00057r-O5
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbYGUAnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbYGUAnn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:43:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:50961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753653AbYGUAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:43:42 -0400
Received: (qmail invoked by alias); 21 Jul 2008 00:43:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp065) with SMTP; 21 Jul 2008 02:43:40 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19oYARIy5NoDNPW1vKlgglCPrc7e59DEfjUaCWqd4
	gfPdrmpZ3Hv7cX
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KKjV3-00023L-Aj; Mon, 21 Jul 2008 02:43:37 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <g60la4$diu$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89281>

If NO_SETENV is defined, git-shell could not be built.

Thanks to SungHyun Nam for the hint.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

This was my mistake. I haven't tested with several build options.
Now I've tested with
	NO_SETENV=1 NO_EXPAT=1 NO_MEMMEM=1 NO_STRTOUMAX=1 NO_MKDTEMP=1
	NO_SYS_SELECT_H=1 NO_SYMLINK_HEAD=1
and compat/setenv.o seems to be the only one that was missing.

Regards.

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 2b670d7..b650ee6 100644
--- a/Makefile
+++ b/Makefile
@@ -1203,7 +1203,8 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o
+git-shell$X: compat/strlcpy.o compat/setenv.o abspath.o ctype.o exec_cmd.o \
+	     quote.o strbuf.o usage.o wrapper.o shell.o
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-- 
1.5.6.3.390.g7b30
