From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] Introduce vcs-svn lib
Date: Thu, 15 Jul 2010 18:22:58 +0200
Message-ID: <1279210984-31604-3-git-send-email-artagnon@gmail.com>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZRCK-0006nr-OB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678Ab0GOQV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:21:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56031 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933673Ab0GOQVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:21:24 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so213063eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=428qLYP1ivtobhV0f23zobzLoU2Cd2ZeL4t9i6yLn8k=;
        b=MmwfNUyazHF61nlUgYzRB3NOIXAKXNtST794ixRqKPy+t6aCrUlp6AOv0VDz53OFYO
         RlfERn6OJDbmsHvpAvPw3SxianEpU4fCHWlxwbPSGdT5Cebb/EtC9ZPLfYiDK9pb4pyn
         80WS3Pdo5rjG4qvMddT4LfdFG26cOCNv6sJnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h8sv/rKsOatnsYaTItR2+RsJ/IhRCLhDdyvbEZNneMaXX97annaw1T9z3fj4VUXALS
         /2PUjKGOd38AiQvNB93QUnDAjPl+nPYTIsm/2d5rL1hSfWF77zHCT5MBT61aI7hOPHmq
         gDmNlb4YNOb5ZWyRX4LXmNk3d4MBgoMtsR+Mc=
Received: by 10.213.8.69 with SMTP id g5mr6731601ebg.65.1279210883608;
        Thu, 15 Jul 2010 09:21:23 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm9342007eeh.23.2010.07.15.09.21.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:21:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151091>

From: Jonathan Nieder <jrnieder@gmail.com>

Teach the build system to build a separate library for the
upcoming subversion interop support.

The resulting vcs-svn/lib.a does not contain any code, nor is
it built during a normal build.  This is just scaffolding for
later changes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9aca8a1..6441dcb 100644
--- a/Makefile
+++ b/Makefile
@@ -468,6 +468,7 @@ export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
+VCSSVN_LIB=vcs-svn/lib.a
 
 LIB_H += advice.h
 LIB_H += archive.h
@@ -1739,7 +1740,8 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
+VCSSVN_OBJS =
+OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
@@ -1860,6 +1862,8 @@ http.o http-walker.o http-push.o remote-curl.o: http.h
 xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+
+$(VCSSVN_OBJS):
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -1908,6 +1912,8 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
+$(VCSSVN_LIB): $(VCSSVN_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
 doc:
 	$(MAKE) -C Documentation all
-- 
1.7.1
