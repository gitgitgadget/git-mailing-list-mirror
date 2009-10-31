From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] Provide a build time default-pager setting
Date: Fri, 30 Oct 2009 20:45:34 -0500
Message-ID: <20091031014534.GI5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42sF-0006lX-Nb
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbZJaBfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757591AbZJaBfN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:35:13 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:53543 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbZJaBfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:35:12 -0400
Received: by ywh40 with SMTP id 40so3213967ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gshBFrunPk7jl78GSxnkks9RflT7buBFGM2dEkdPH+g=;
        b=EDFsIvbOwpV9h7NxLaQsztJuAu+G5z42qdfvvWwA+RCap0mxja/ux4pMM7oRJHotDz
         pv3cHqQNsbigO686j5I+spX0IUhy1E4UfuoUz0kUC+CR52pixcW7X8mCKqypc55NvfDy
         3xk/piq6XUl+FyeRQe+VNDNYxAQqYQviHNwwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Qv4B/ejVbffHuXZlrRfvQnOT+LdwtgwIhnIujz2mJTzIWN73aGjaqy+xKYTbNYmYH7
         W9P3pnisyBuch6unM/N8YzK92kYoA+c4OHoFfvN5Il0QwRaXjt+z2if6iSPsnIejcvpx
         RAAxgTmdoDsynE+//PIL+AhAK1iRXqAFs3oV8=
Received: by 10.91.183.4 with SMTP id k4mr6279030agp.41.1256952917373;
        Fri, 30 Oct 2009 18:35:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm1607815yxh.51.2009.10.30.18.35.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:35:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131821>

From: Junio C Hamano <gitster@pobox.com>

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
---
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
