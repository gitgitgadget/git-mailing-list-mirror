From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Makefile: rearrange dependency rules
Date: Thu, 7 Jan 2010 01:16:06 -0600
Message-ID: <20100107071605.GB11777@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
 <20100107071305.GA11777@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:16:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmbU-0007CJ-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab0AGHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366Ab0AGHQH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:16:07 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55549 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0AGHQE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:16:04 -0500
Received: by ywh6 with SMTP id 6so18232209ywh.4
        for <multiple recipients>; Wed, 06 Jan 2010 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9zWLDnB0C/td8y37VcaCk5GiIy61ykAd7Zn/U4i+WAA=;
        b=XVyTknMmuwcjlmmpD8G3GarYjmi1tJQ1F6x/sPz4Ut5psLzf7UEEHKJqFmq9kUr3jq
         c/h+TFmocKOk+v9B6FRQylJLPD5agYkp02+I3LP0BRzH0hBUYIjE63mp/AoWsdHO7/pF
         dwlSu4nVXuJcTb+1e5n1GIuAJ1WMSCKcpZDPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EZFSJNjbLZqlLrrOoSfH8GCmDlAcTnt4/5zMZnws8PMar8u/Jrp5pTz+DYMlDCvg2v
         +fnBelr7LMotwG9xAskT932fmBCv32X81R9Cv/Tu217JXU9DWmS4b4T111JbY3xHRi4K
         +khG7cELOTOvveTqok6tfvCPF3FkjPK7I3cJU=
Received: by 10.101.132.11 with SMTP id j11mr20897103ann.107.1262848563619;
        Wed, 06 Jan 2010 23:16:03 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm615259iwn.12.2010.01.06.23.16.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:16:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100107071305.GA11777@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136328>

Collect header dependency rules after the pattern rules to make
it easier to modify them all at once.  No change in behavior is
intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 8ce6fd7..fa08535 100644
--- a/Makefile
+++ b/Makefile
@@ -1630,6 +1630,11 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) git.o http.o http-walker.o \
+	$(patsubst git-%$X,%.o,$(PROGRAMS))
+XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
+	xdiff/xmerge.o xdiff/xpatience.o
+
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
@@ -1637,6 +1642,14 @@ git.o git.spec \
 %.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+$(GIT_OBJS): $(LIB_H)
+http.o http-walker.o http-push.o: http.h
+$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(wildcard */*.h)
+builtin-revert.o wt-status.o: wt-status.h
+
+$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
+	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+
 exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
@@ -1661,10 +1674,6 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
-http.o http-walker.o http-push.o: http.h
-
-http.o http-walker.o: $(LIB_H)
-
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
@@ -1676,18 +1685,9 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
-
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
-XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
-	xdiff/xmerge.o xdiff/xpatience.o
-$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
-	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
-
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
-- 
1.6.6.rc2
