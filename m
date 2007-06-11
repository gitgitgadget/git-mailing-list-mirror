From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Avoid double-slash in path names that depend on $(sharedir).
Date: Mon, 11 Jun 2007 11:10:47 +0200
Organization: eudaptics software gmbh
Message-ID: <466D1197.FAA7B7EE@eudaptics.com>
References: <11815489372169-git-send-email-johannes.sixt@telecom.at> <7v645usy4c.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 11:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxfuG-0003Jy-8t
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 11:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbXFKJJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 05:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXFKJJl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 05:09:41 -0400
Received: from main.gmane.org ([80.91.229.2]:59231 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbXFKJJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 05:09:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hxftz-0002ux-NU
	for git@vger.kernel.org; Mon, 11 Jun 2007 11:09:31 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 11:09:31 +0200
Received: from johannes.sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 11:09:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49837>

Junio C Hamano wrote:
> 
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index af84af9..c23031c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -144,7 +144,7 @@ STRIP ?= strip
> >  prefix = $(HOME)
> >  bindir = $(prefix)/bin
> >  gitexecdir = $(bindir)
> > -sharedir = $(prefix)/share/
> > +sharedir = $(prefix)/share
> >  template_dir = $(sharedir)/git-core/templates/
> >  ifeq ($(prefix),/usr)
> >  sysconfdir = /etc
> 
> This suggests that we would also want to drop the trailing slash
> from template_dir, doesn't it?
> 
> I took a brief look at builtin-init-db.c but it seems that the
> code is safe with or without the trailing slash there.

It amounts to this on top of my other patch. It's not worth it,
if you ask me.

--- 8< ---
From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Remove trailing slash from $(template_dir).

This is just a consistency cleanup. sharedir is defined a line above
template_dir and doesn't have the trailing slash, either.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile           |    2 +-
 builtin-init-db.c  |    2 +-
 templates/Makefile |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c23031c..7091a4b 100644
--- a/Makefile
+++ b/Makefile
@@ -145,7 +145,7 @@ prefix = $(HOME)
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
-template_dir = $(sharedir)/git-core/templates/
+template_dir = $(sharedir)/git-core/templates
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 else
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..0be2d2e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -7,7 +7,7 @@
 #include "builtin.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
-#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
+#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
 #endif
 
 #ifdef NO_TRUSTABLE_FILEMODE
diff --git a/templates/Makefile b/templates/Makefile
index b8352e7..aaa39d3 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -7,7 +7,7 @@ endif
 INSTALL ?= install
 TAR ?= tar
 prefix ?= $(HOME)
-template_dir ?= $(prefix)/share/git-core/templates/
+template_dir ?= $(prefix)/share/git-core/templates
 # DESTDIR=
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
-- 
1.5.2.1.176.g7084-dirty
