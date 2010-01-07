From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Makefile: add OBJECTS variable listing object files
Date: Thu, 7 Jan 2010 01:19:43 -0600
Message-ID: <20100107071943.GD11777@progeny.tock>
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
X-From: git-owner@vger.kernel.org Thu Jan 07 08:19:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmex-0008DV-Ge
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab0AGHTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139Ab0AGHTt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:19:49 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55859 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0AGHTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:19:42 -0500
Received: by ywh6 with SMTP id 6so18233857ywh.4
        for <multiple recipients>; Wed, 06 Jan 2010 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qezjyeHAs+yXQSQ5Gt8/kKVRgTA2K8gEEyzHJMkCCUk=;
        b=BgzMMVnZEHDFGu/JSo4CXt0djnFGk1MJEN8RhmeBZz1FWg8rEfXP5SAtF225cUkcwj
         qI8ZncvBOgQutkgwXUWte23+8/7iworrn6rcxlrqUB2uI5oxb44SG32fFWtRG0OJilfm
         u8Em0m6jVQv1jVaGqwulL6a5PqkGKV3ZxOdcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tRYJWYKvEa2+6BpHtSNQ/Qpa3plR9n1qzLRhqepMGo3JWbs94Qz7vF6yard7XFb3l1
         x12TO8gka+9yzr5c9v89ETl4K55zn785hR7m24CxHqASRMSaSb9ky1vHIcqBN57K6mK5
         a3b3/KwexJ4MbKI7Pgo8QbW7UE+Kw9lfiXr9Q=
Received: by 10.150.47.32 with SMTP id u32mr35906084ybu.125.1262848781225;
        Wed, 06 Jan 2010 23:19:41 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm20155687iwn.14.2010.01.06.23.19.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:19:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100107071305.GA11777@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136330>

To find the generated dependencies to include, we will need a
comprehensive list of all object file targets.  To make sure it
is truly comprehensive, restrict the scope of the
%.o pattern rule to only generate objects in that list.

Attempts to build other object files will fail loudly:

	$ touch foo.c
	$ make foo.o
	make: *** No rule to make target `foo.o'.  Stop.

providing a reminder to add the new object to the OBJECTS list.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 9a5d897..87de3c3 100644
--- a/Makefile
+++ b/Makefile
@@ -388,6 +388,18 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 # Empty...
 EXTRA_PROGRAMS =
 
+TEST_PROGRAMS += test-chmtime$X
+TEST_PROGRAMS += test-ctype$X
+TEST_PROGRAMS += test-date$X
+TEST_PROGRAMS += test-delta$X
+TEST_PROGRAMS += test-dump-cache-tree$X
+TEST_PROGRAMS += test-genrandom$X
+TEST_PROGRAMS += test-match-trees$X
+TEST_PROGRAMS += test-parse-options$X
+TEST_PROGRAMS += test-path-utils$X
+TEST_PROGRAMS += test-sha1$X
+TEST_PROGRAMS += test-sigchain$X
+
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
@@ -1634,14 +1646,20 @@ GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) git.o http.o http-walker.o \
 	$(patsubst git-%$X,%.o,$(PROGRAMS))
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
+TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(TEST_OBJS)
+
+ASM_SRC := $(wildcard $(OBJECTS:o=S))
+ASM_OBJ := $(ASM_SRC:S=o)
+C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
 .SUFFIXES:
 
-%.o: %.c GIT-CFLAGS
+$(C_OBJ): %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-%.o: %.S GIT-CFLAGS
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 $(GIT_OBJS): $(LIB_H)
@@ -1757,18 +1775,6 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS += test-chmtime$X
-TEST_PROGRAMS += test-ctype$X
-TEST_PROGRAMS += test-date$X
-TEST_PROGRAMS += test-delta$X
-TEST_PROGRAMS += test-dump-cache-tree$X
-TEST_PROGRAMS += test-genrandom$X
-TEST_PROGRAMS += test-match-trees$X
-TEST_PROGRAMS += test-parse-options$X
-TEST_PROGRAMS += test-path-utils$X
-TEST_PROGRAMS += test-sha1$X
-TEST_PROGRAMS += test-sigchain$X
-
 all:: $(TEST_PROGRAMS)
 
 # GNU make supports exporting all variables by "export" without parameters.
-- 
1.6.6.rc2
