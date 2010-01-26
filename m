From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/12] Makefile: rearrange dependency rules
Date: Tue, 26 Jan 2010 09:49:33 -0600
Message-ID: <20100126154933.GH4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:55:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnlJ-00057y-8c
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab0AZPzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581Ab0AZPzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:55:25 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34825 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab0AZPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:55:24 -0500
Received: by ywh6 with SMTP id 6so4143329ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0ofsdlZyY2MY5tct+Rd0wnzv+BZIDGfbMu5dEv2pkp0=;
        b=oK6nxt1AR+/LC+0HVmxfRHUwR6Xudx5naMiD74HB1mturVGFd4BjIKwu6iAnRUh3Tf
         /57/5qbee/5YfHnVzQUsS1YTzYt6kPfeAxnhMDk8plhxQQ03QLbZFjGR3ZYxcoeQv1ua
         EJXyKCb9DUBWXvy4Wo6fed3CpZxiJSOr6ca3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s+8go1KfN2uvk2JXzRqLmODwTRMa8A43Lqlr7l4sVFbgMsCylxajJlpyveXamRxrZE
         uxWqLtEedT3tFWOneS/cmk/iRlHoNLDiZEfNfK41KPkoifZBmWQZZ5aujj1HE0Q4JvMJ
         PmqvRnuNp1YgHWJRy4TMKSY0gi/XZe46ULIp4=
Received: by 10.150.214.12 with SMTP id m12mr10588711ybg.342.1264520971864;
        Tue, 26 Jan 2010 07:49:31 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2057108yxe.39.2010.01.26.07.49.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:49:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138052>

Put rules listing dependencies of compiled objects (.o files) on
header files (.h files) in one place, to make them easier to
compare and modify all at once.

Add a GIT_OBJS variable listing objects that depend on LIB_H,
for similar reasons.

No change in build-time behavior intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   49 +++++++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 5678991..84ce137 100644
--- a/Makefile
+++ b/Makefile
@@ -1666,6 +1666,12 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS) \
+	git.o http.o http-walker.o remote-curl.o \
+	$(patsubst git-%$X,%.o,$(PROGRAMS))
+XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
+	xdiff/xmerge.o xdiff/xpatience.o
+
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
@@ -1673,6 +1679,25 @@ git.o git.spec \
 %.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+$(GIT_OBJS): $(LIB_H)
+builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o transport.o: branch.h
+builtin-bundle.o bundle.o transport.o: bundle.h
+builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
+builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
+builtin-send-pack.o transport.o: send-pack.h
+builtin-log.o builtin-shortlog.o: shortlog.h
+builtin-prune.o builtin-reflog.o reachable.o: reachable.h
+builtin-commit.o builtin-revert.o wt-status.o: wt-status.h
+builtin-tar-tree.o archive-tar.o: tar.h
+builtin-pack-objects.o: thread-utils.h
+http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
+http.o http-walker.o http-push.o remote-curl.o: http.h
+
+
+xdiff-interface.o $(XDIFF_OBJS): \
+	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
+	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+
 exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
@@ -1696,10 +1721,6 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
-http.o http-walker.o http-push.o remote-curl.o: http.h
-
-http.o http-walker.o remote-curl.o: $(LIB_H)
-
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
@@ -1717,29 +1738,9 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) $(TEST_OBJS) git.o: $(LIB_H)
-builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o transport.o: branch.h
-builtin-bundle.o bundle.o transport.o: bundle.h
-builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
-builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
-builtin-send-pack.o transport.o: send-pack.h
-builtin-log.o builtin-shortlog.o: shortlog.h
-builtin-prune.o builtin-reflog.o reachable.o: reachable.h
-builtin-commit.o builtin-revert.o wt-status.o: wt-status.h
-builtin-tar-tree.o archive-tar.o: tar.h
-builtin-pack-objects.o: thread-utils.h
-http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
-
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
-XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
-	xdiff/xmerge.o xdiff/xpatience.o
-xdiff-interface.o $(XDIFF_OBJS): \
-	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
-	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
-
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
-- 
1.6.6
