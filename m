From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] Provide a build time default-pager setting
Date: Wed, 11 Nov 2009 18:04:22 -0600
Message-ID: <20091112000422.GJ1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8N0y-0000rs-KU
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbZKKXyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbZKKXyF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:54:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63052 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbZKKXyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:54:04 -0500
Received: by yxe17 with SMTP id 17so1465386yxe.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tRRvDynF6WQz7rgT9YmH+I3rV+I8oKugSKrvLygbI8Y=;
        b=xl//ORRMVCliRHEAh/O2TwF4Uh2ZqowHeL6nxGCgpChNCXem3Dh+2jH3FfE43nauP8
         OLpcM/L2i30XN5A1uY6phmMv9f9jtDlx91lSekE8vMkX7q7JN77ksac0ltabqsVg5Ol+
         hO0Z3uHreVjGayEA7gV11431O3Us+vRNUmNBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wSeS4trrjmaI6oAa/QbVh8CSiJE50gK9z0ri4S07rGpjFLBAxC+Omeh5z3KvS0qtiz
         jkGLIkHTguiNuvNI98XYUNHCJDpANyV5BhXnkMQJwlN6qgZ8kXa9WNLEssnxfsvoyWP8
         EhsY6FAd9aKSk5ZlDV1LoNKxAjQhDmEX7FGK0=
Received: by 10.91.159.22 with SMTP id l22mr3394949ago.9.1257983649426;
        Wed, 11 Nov 2009 15:54:09 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm1032104yxh.33.2009.11.11.15.54.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:54:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132730>

Provide a DEFAULT_PAGER knob so packagers can set the fallback
pager to something appropriate during the build.

Examples:

On (old) solaris systems, /usr/bin/less (typically the first less
found) doesn't understand the default arguments (FXRS), which
forces users to alter their environment (PATH, GIT_PAGER, LESS,
etc) or have a local or global gitconfig before paging works as
expected.

On Debian systems, by policy packages must fall back to the
'pager' command, so that changing the target of the
/usr/bin/pager symlink changes the default pager for all packages
at once.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
As in pu.

 Makefile |   11 +++++++++++
 pager.c  |    6 +++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 625866c..18fc50a 100644
--- a/Makefile
+++ b/Makefile
@@ -201,6 +201,10 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
+# Define DEFAULT_PAGER to a sensible pager command (defaults to "less") if
+# you want to use something different.  The value will be interpreted by the
+# shell at runtime when it is used.
+#
 # Define DEFAULT_EDITOR to a sensible editor command (defaults to "vi") if you
 # want to use something different.  The value will be interpreted by the shell
 # if necessary when it is used.  Examples:
@@ -1380,6 +1384,13 @@ DEFAULT_EDITOR_CQ_SQ = $(subst ','\'',$(DEFAULT_EDITOR_CQ))
 BASIC_CFLAGS += -DDEFAULT_EDITOR='$(DEFAULT_EDITOR_CQ_SQ)'
 endif
 
+ifdef DEFAULT_PAGER
+DEFAULT_PAGER_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_PAGER)))"
+DEFAULT_PAGER_CQ_SQ = $(subst ','\'',$(DEFAULT_PAGER_CQ))
+
+BASIC_CFLAGS += -DDEFAULT_PAGER='$(DEFAULT_PAGER_CQ_SQ)'
+endif
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
diff --git a/pager.c b/pager.c
index 0b63d99..92c03f6 100644
--- a/pager.c
+++ b/pager.c
@@ -2,6 +2,10 @@
 #include "run-command.h"
 #include "sigchain.h"
 
+#ifndef DEFAULT_PAGER
+#define DEFAULT_PAGER "less"
+#endif
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -60,7 +64,7 @@ const char *git_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = DEFAULT_PAGER;
 	else if (!*pager || !strcmp(pager, "cat"))
 		pager = NULL;
 
-- 
1.6.5.2
