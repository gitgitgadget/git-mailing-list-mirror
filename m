From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 12:25:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604211223561.3701@g5.osdl.org>
References: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
 <Pine.LNX.4.64.0604211214560.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 21:25:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX1Fx-000245-CV
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDUTZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWDUTZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 15:25:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932271AbWDUTZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 15:25:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LJPDtH012727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 12:25:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LJPD6F010907;
	Fri, 21 Apr 2006 12:25:13 -0700
To: Bob Portmann <bportmann@yahoo.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604211214560.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19028>



On Fri, 21 Apr 2006, Linus Torvalds wrote:
> 
> This patch would have made things a lot more obvious.

Actually, scratch that one, and use this one instead. Much better, and 
actually allows Bob's crazy PAGER environment variable to work, rather 
than just reporting an error about it.

		Linus
---
diff --git a/pager.c b/pager.c
index b063353..9a30939 100644
--- a/pager.c
+++ b/pager.c
@@ -8,6 +8,7 @@ #include "cache.h"
 static void run_pager(const char *pager)
 {
 	execlp(pager, pager, NULL);
+	execl("/bin/sh", "sh", "-c", pager, NULL);
 }
 
 void setup_pager(void)
@@ -47,5 +48,6 @@ void setup_pager(void)
 
 	setenv("LESS", "-S", 0);
 	run_pager(pager);
+	die("unable to execute pager '%s'", pager);
 	exit(255);
 }
