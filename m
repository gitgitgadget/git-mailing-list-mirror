From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Link git-shell only to a subset of libgit.a
Date: Fri, 18 Jul 2008 03:04:30 +0200
Message-ID: <1216343070-20237-1-git-send-email-s-beyer@gmx.net>
References: <20080718005814.GA4155@spearce.org>
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJePf-0005qA-DV
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866AbYGRBEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756367AbYGRBEg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:04:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:37488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754661AbYGRBEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:04:36 -0400
Received: (qmail invoked by alias); 18 Jul 2008 01:04:34 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp030) with SMTP; 18 Jul 2008 03:04:34 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX195k2dL6RN5J8FwXSqM4IXgzFVS0s1hxwjS0yEviZ
	ACSigkqKJF/czH
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJeOc-0005Gn-Dg; Fri, 18 Jul 2008 03:04:30 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <20080718005814.GA4155@spearce.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88943>

Commit 5b8e6f85 introduced stubs for three functions that make no sense
for git-shell. But those stubs defined libgit.a functions a second time
so that a linker can complain.

Now git-shell is only linked to a subset of libgit.a.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi Shawn,

does this compile on Solaris?


For Dmitry: this is even smaller, but not significant ;-)

Before:
  text    data     bss     dec     hex filename
 24798    1304    8232   34334    861e git-shell

After:
   text    data     bss     dec     hex filename
  24504    1264    8248   34016    84e0 git-shell

*hide&run*
Stephan.

 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4bec4b3..a5626dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1204,6 +1204,9 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
-- 
1.5.6.3.390.g7b30
