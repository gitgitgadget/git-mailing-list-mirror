From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-parse: one more fix for "--"
Date: Thu, 20 Oct 2005 21:17:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510202115180.423@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 06:20:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESoLk-0000Bs-IY
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVJUERq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVJUERq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:17:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964863AbVJUERp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 00:17:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L4HfFC011254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 21:17:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L4HeI0022975;
	Thu, 20 Oct 2005 21:17:41 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10417>


My previous "--" fixup case missed one case: it would print any default 
revision after the "--" rather than before.

Trivially fixed.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Gaah. If you haven't applied the previous patch yet, just combine the two 
diffs into one.

diff --git a/rev-parse.c b/rev-parse.c
index 9ae2512..243f89f 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -174,6 +174,7 @@ int main(int argc, char **argv)
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 1;
+				show_default();
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
