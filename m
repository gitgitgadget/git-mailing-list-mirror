From: Linus Torvalds <torvalds@osdl.org>
Subject: git log: don't do merge diffs by default
Date: Wed, 19 Apr 2006 10:20:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604191015150.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 19 19:21:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWGMO-000860-Sr
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 19:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWDSRU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 13:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWDSRU6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 13:20:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751118AbWDSRU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 13:20:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JHKotH031506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 10:20:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JHKnIc027702;
	Wed, 19 Apr 2006 10:20:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18932>


I personally prefer "ignore_merges" to be on by default, because quite 
often the merge diff is distracting and not interesting. That's true both 
with "-p" and with "--stat" output.

If you want output from merges, you can trivially use the "-m", "-c" or 
"--cc" flags to tell that you're interested in merges, which also tells 
the diff generator what kind of diff to do (for --stat, any of the three 
will do, of course, but they differ for plain patches or for 
--patch-with-stat).

This trivial patch just removes the two lines that tells "git log" not to 
ignore merges. It will still show the commit log message, of course, due 
to the "always_show_header" part.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git.c b/git.c
index 0be14bb..40b7e42 100644
--- a/git.c
+++ b/git.c
@@ -331,8 +331,6 @@ static int cmd_log(int argc, const char 
 	init_revisions(&rev);
 	rev.always_show_header = 1;
 	rev.diffopt.recursive = 1;
-	rev.combine_merges = 1;
-	rev.ignore_merges = 0;
 	return cmd_log_wc(argc, argv, envp, &rev);
 }
 
