From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] Introduce vcs-svn lib
Date: Thu, 24 Jun 2010 05:52:44 -0500
Message-ID: <20100624105243.GB12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk3H-0001MK-6x
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab0FXKwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:52:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47478 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0FXKwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:52:53 -0400
Received: by iwn41 with SMTP id 41so731370iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vQpMGqw3dePEBTfSM02POrxeU+lclRRwTgSjyU63IyA=;
        b=GKLCXXllxyTZ4FIqlrF3VeNNGS1L6BkKz7rmHWztSxtvk4Ks4y+GRVR4xE2domefJK
         ueOP9Uz78ouA93pF0Mc6mjHHCecS+631q9s1As0H5hp1WFW0uI0Va6V4PeTKhp/zOQsz
         7p/ggFIwJ6u4ksLeFgYXdIqZvWJ8c/pisTZdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=idH/cJWQMwkVBXD8fx2+ee8QJFL+ti/leU1HK9fLzHFSCkHg+Tcp2lylq38esjXr67
         vdKG1SfwXVaomW3R1KL6dICzeh5txn1UhX5CNzEQjILvdX2tJgPehumOsVFH+LKNzJ9h
         pZR7H1T7CJrdwwRo6DH/oqmh0gYFM2nR684ao=
Received: by 10.231.125.213 with SMTP id z21mr9945646ibr.98.1277376773057;
        Thu, 24 Jun 2010 03:52:53 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm38025060ibi.8.2010.06.24.03.52.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149573>

Teach the build system to build a separate library for the
upcoming subversion interop support.

The resulting vcs-svn/lib.a does not contain any code, nor is
it built during a normal build.  This is just scaffolding for
later changes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
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
