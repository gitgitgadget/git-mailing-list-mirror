From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/12] Makefile: list standalone program object files in
 PROGRAM_OBJS
Date: Tue, 26 Jan 2010 09:54:23 -0600
Message-ID: <20100126155423.GL4895@progeny.tock>
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
X-From: git-owner@vger.kernel.org Tue Jan 26 16:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnkL-0004hq-6R
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0AZPyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358Ab0AZPyY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:54:24 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44037 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0AZPyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:54:22 -0500
Received: by yxe17 with SMTP id 17so3741449yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LXz9zj0UEsnLu3EJgQ9aIS3NS5F8+d3181UsCgAYQc4=;
        b=cUf+80zXRNDuX6XeIMTOgfKZ+VLX85PD17F9Yodh3RcCYNnaKHNpOwlE2EaeE7vgq9
         fvkqcVvv4EYvqVzPZhly9FCDwKt7AJl80rfsQZEpVLWhlzfz6lsPFsm6To//JiUPUQOS
         H3v6+41mzICXOvnFfOmqwliYSxUYaSHfxlfCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ri69TIarq/cGlHB+fVUMcTi7W0bCzDU3/uauRRtTJ005Pt1UvBKajuvRTsJl6Pl0gz
         jW38dmJk5qV1injllRZlXXCpikmEtQ2Tfu/CIE4b2betmk80rxIuqYLusOKZ9YcA4IRC
         noJ9HmfgfbqtmP+QJuruK6M2uHZDmEaejCJ/E=
Received: by 10.151.59.13 with SMTP id m13mr10607359ybk.291.1264521261159;
        Tue, 26 Jan 2010 07:54:21 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6176110iwn.15.2010.01.26.07.54.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:54:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138051>

Because of new commands like git-remote-http, the OBJECTS list
contains fictitious objects such as remote-http.o.  Thus any
out-of-tree rules that require all $(OBJECTS) to be buildable
are broken.  Add a list of real program objects to avoid this
problem.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Preparing for patch 12.

 Makefile |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 2e75f05..ceaae1c 100644
--- a/Makefile
+++ b/Makefile
@@ -341,6 +341,7 @@ COMPAT_CFLAGS =
 COMPAT_OBJS =
 LIB_H =
 LIB_OBJS =
+PROGRAM_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
@@ -390,12 +391,15 @@ EXTRA_PROGRAMS =
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
-PROGRAMS += git-fast-import$X
-PROGRAMS += git-imap-send$X
-PROGRAMS += git-shell$X
-PROGRAMS += git-show-index$X
-PROGRAMS += git-upload-pack$X
-PROGRAMS += git-http-backend$X
+
+PROGRAM_OBJS += fast-import.o
+PROGRAM_OBJS += imap-send.o
+PROGRAM_OBJS += shell.o
+PROGRAM_OBJS += show-index.o
+PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += http-backend.o
+
+PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
@@ -1139,10 +1143,12 @@ else
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
+	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES) git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
+			PROGRAM_OBJS += http-push.o
 			PROGRAMS += git-http-push$X
 		endif
 	endif
@@ -1163,6 +1169,7 @@ endif
 EXTLIBS += -lz
 
 ifndef NO_POSIX_ONLY_PROGRAMS
+	PROGRAM_OBJS += daemon.o
 	PROGRAMS += git-daemon$X
 endif
 ifndef NO_OPENSSL
@@ -1670,9 +1677,8 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
-GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS) \
-	git.o http.o http-walker.o remote-curl.o \
-	$(patsubst git-%$X,%.o,$(PROGRAMS))
+GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+	git.o http.o http-walker.o remote-curl.o
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
-- 
1.6.6
