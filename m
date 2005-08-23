From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-parse question.
Date: Tue, 23 Aug 2005 10:07:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231004180.3317@g5.osdl.org>
References: <7v7jedulli.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 19:09:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7cFQ-0006z5-HF
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 19:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVHWRHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 13:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVHWRHh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 13:07:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932229AbVHWRHh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 13:07:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7NH7WjA014701
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 10:07:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7NH7V3C025536;
	Tue, 23 Aug 2005 10:07:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jedulli.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7658>



On Tue, 23 Aug 2005, Junio C Hamano wrote:
>
> I have been looking at what git-rev-parse does and could not
> figure out a way to convince it to give me only arguments with
> a '-' prefix.

Gaah. Understandable. It got broken during some cleanup.

Try this trivial patch, it should work better.

NOTE! The behaviour of "--" for git-rev-parse is somewhat unclear. Right 
now it prints it out with "--flags", which is probably wrong.

		Linus
---
Subject: Fix git-rev-parse --default and --flags handling

This makes the argument to --default and any --flags arguments should up 
correctly.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -107,7 +107,7 @@ static void show_arg(char *arg)
 	if (do_rev_argument && is_rev_argument(arg))
 		show_rev_arg(arg);
 	else
-		show_norev(arg);
+		show(arg);
 }
 
 static void show_default(void)
@@ -122,7 +122,7 @@ static void show_default(void)
 			show_rev(NORMAL, sha1, s);
 			return;
 		}
-		show_arg(s);
+		show(s);
 	}
 }
 
