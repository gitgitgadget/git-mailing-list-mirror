From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02.5/11] Makefile: fold XDIFF_H and VCSSVN_H into LIB_H
Date: Fri, 6 Jul 2012 22:39:18 -0500
Message-ID: <20120707033918.GB3574@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
 <20120620210730.GB6142@burratino>
 <20120620221125.GA3302@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 05:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnLsL-0005AO-Hs
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 05:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073Ab2GGDjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 23:39:24 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52005 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab2GGDjX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 23:39:23 -0400
Received: by ghrr11 with SMTP id r11so9184108ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 20:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CcrCcvHnJwg+t3oCnxDDhDgwcTSmNZEbKyrQH6aRX2k=;
        b=SlYFpo9U0h44xmhtGS9FVa6fdIuEeUiOEGN4j9TFtYkI5cerCgTlDDKmA10/ZmNq21
         DsvculNs/7K6FIUDZDxcWVzN3o1+71EeqBTPPrCOVeEf3Zd4GMQs9btWUsxosZxkQhfP
         43EMQmy+G6v1awCCTisPIyxEXkchIgsrVt6keq2SnDxR4hhpO6CLCRTycbn4ZSq2y9FD
         5Ar/Rceid6NqC3fqcCqweO47QVTmC3u1xE64ykaLUW5pbk4QltsgWiZkOZfMgS54f6Gi
         moVl1g/LA6hDFyJrkisEG9VAIkDVmbkolE4TlSfhMAJSpdlaJmZ2keBVEFRRJrx9coQI
         XjaQ==
Received: by 10.43.85.69 with SMTP id an5mr16667814icc.37.1341632362547;
        Fri, 06 Jul 2012 20:39:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z7sm3915609igb.3.2012.07.06.20.39.21
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 20:39:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620221125.GA3302@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201155>

Just like MISC_H (see previous commit), there is no reason to track
xdiff and vcs-svn headers separately from the rest of the headers.
The only purpose of these variables is to keep track of recompilation
dependencies.

As a pleasant side effect, folding these into LIB_H lets us stop
tracking GIT_OBJS and VCSSVN_TEST_OBJS separately from the list of all
OBJECTS.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:
> On Wed, Jun 20, 2012 at 04:07:30PM -0500, Jonathan Nieder wrote:

>> Should XDIFF_H and VCSSVN_H be folded into STATIC_HEADERS, too?
>
> I stopped short of that, but I'd be tempted to do so.

Here goes.

 Makefile |   60 ++++++++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index 500966b1..b24ca20d 100644
--- a/Makefile
+++ b/Makefile
@@ -392,11 +392,8 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
-XDIFF_H =
 XDIFF_OBJS =
-VCSSVN_H =
 VCSSVN_OBJS =
-VCSSVN_TEST_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
 LIB_H =
@@ -558,21 +555,21 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 VCSSVN_LIB=vcs-svn/lib.a
 
-XDIFF_H += xdiff/xinclude.h
-XDIFF_H += xdiff/xmacros.h
-XDIFF_H += xdiff/xdiff.h
-XDIFF_H += xdiff/xtypes.h
-XDIFF_H += xdiff/xutils.h
-XDIFF_H += xdiff/xprepare.h
-XDIFF_H += xdiff/xdiffi.h
-XDIFF_H += xdiff/xemit.h
+LIB_H += xdiff/xinclude.h
+LIB_H += xdiff/xmacros.h
+LIB_H += xdiff/xdiff.h
+LIB_H += xdiff/xtypes.h
+LIB_H += xdiff/xutils.h
+LIB_H += xdiff/xprepare.h
+LIB_H += xdiff/xdiffi.h
+LIB_H += xdiff/xemit.h
 
-VCSSVN_H += vcs-svn/line_buffer.h
-VCSSVN_H += vcs-svn/sliding_window.h
-VCSSVN_H += vcs-svn/repo_tree.h
-VCSSVN_H += vcs-svn/fast_export.h
-VCSSVN_H += vcs-svn/svndiff.h
-VCSSVN_H += vcs-svn/svndump.h
+LIB_H += vcs-svn/line_buffer.h
+LIB_H += vcs-svn/sliding_window.h
+LIB_H += vcs-svn/repo_tree.h
+LIB_H += vcs-svn/fast_export.h
+LIB_H += vcs-svn/svndiff.h
+LIB_H += vcs-svn/svndump.h
 
 GENERATED_H += common-cmds.h
 
@@ -2110,13 +2107,6 @@ version.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
-TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
-GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
-	git.o
-ifndef NO_CURL
-	GIT_OBJS += http.o http-walker.o remote-curl.o
-endif
-
 XDIFF_OBJS += xdiff/xdiffi.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
@@ -2132,9 +2122,14 @@ VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
-VCSSVN_TEST_OBJS += test-line-buffer.o
-
-OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
+TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+	$(XDIFF_OBJS) \
+	$(VCSSVN_OBJS) \
+	git.o
+ifndef NO_CURL
+	OBJECTS += http.o http-walker.o remote-curl.o
+endif
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
@@ -2233,15 +2228,8 @@ else
 # Dependencies on automatically generated headers such as common-cmds.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
-#
-# XXX. Please check occasionally that these include all dependencies
-# gcc detects!
 
-$(GIT_OBJS): $(LIB_H)
-
-xdiff-interface.o $(XDIFF_OBJS): $(XDIFF_H)
-
-$(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) $(VCSSVN_H)
+$(OBJECTS): $(LIB_H)
 endif
 
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -2334,7 +2322,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
-LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(GENERATED_H)
+LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH := $(SCRIPT_SH)
 LOCALIZED_PERL := $(SCRIPT_PERL)
 
-- 
1.7.10.4
