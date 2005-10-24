From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 09:02:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
References: <867jc336f4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:02:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU4m8-0005ER-Ho
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 18:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJXQCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJXQCL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 12:02:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751129AbVJXQCK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 12:02:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OG25FC031139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 09:02:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OG24YF029061;
	Mon, 24 Oct 2005 09:02:05 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <867jc336f4.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10544>



On Sun, 23 Oct 2005, Randal L. Schwartz wrote:
> 
> If that rings a bell, help me out here.  I'm guessing "isalnum" is getting
> defined (wrongly).  Yeah, looks like in cache.h.  Why is this getting
> defined?

We're doing our own ctype.h.

The fix is to make sure that "cache.h" is included _after_ system 
includes.

iow, this should fix it, methinks.

		Linus
---
diff --git a/daemon.c b/daemon.c
index 0c6182f..6e5de11 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,5 +1,3 @@
-#include "cache.h"
-#include "pkt-line.h"
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
@@ -10,6 +8,9 @@
 #include <arpa/inet.h>
 #include <syslog.h>
 
+#include "cache.h"
+#include "pkt-line.h"
+
 static int log_syslog;
 static int verbose;
 
