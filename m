From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] perl bindings fix compilation errors
Date: Mon, 25 Sep 2006 11:03:20 +0100
Message-ID: <20060925100319.GA1655@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 12:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRnJS-00018V-Cb
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 12:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWIYKDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 06:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIYKDn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 06:03:43 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:1670
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750926AbWIYKDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 06:03:43 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GRnJ2-0000Qm-5k; Mon, 25 Sep 2006 11:03:20 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27730>

perl bindings: fix compilation errors

With the introduction of Makefile.PL to the perl bindings we no
longer seem to pass in either the definition of SHA1_HEADER or
GIT_VERSION.  It seems we no longer pass over the BASIC_FLAGS into
the compilation.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/Makefile b/Makefile
index d705e06..d32f4c4 100644
--- a/Makefile
+++ b/Makefile
@@ -603,7 +603,7 @@ all: $(ALL_PROGRAMS) $(BUILT_INS) git$X 
 	git-merge-recur$X
 
 all: perl/Makefile
-	$(MAKE) -C perl
+	$(MAKE) -C perl GIT_VERSION='$(GIT_VERSION)' BASIC_CFLAGS="$(BASIC_CFLAGS)"
 	$(MAKE) -C templates
 
 strip: $(PROGRAMS) git$X
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index de73235..00fc779 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -5,6 +5,8 @@ sub MY::postamble {
 instlibdir:
 	@echo '$(INSTALLSITELIB)'
 
+CCFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' $(BASIC_CFLAGS)
+
 MAKE_FRAG
 }
 
