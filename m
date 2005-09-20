From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "gitk" work with time-based arguments
Date: Tue, 20 Sep 2005 14:16:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201413300.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Sep 20 23:18:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHpTg-0000aH-L0
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 23:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVITVQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVITVQd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 17:16:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965125AbVITVQd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 17:16:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KLGQBo014766
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 14:16:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KLGNIv006676;
	Tue, 20 Sep 2005 14:16:25 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9023>


gitk wasn't able to take to take advantage of the new date parsing of 
git-rev-parse, because it didn't pass on arguments that needed quoting 
properly.

This is the black magic incantation necessary to make tcl do this right.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -33,8 +33,8 @@ proc getcommits {rargs} {
     set nextupdate [expr $startmsecs + 100]
     set ncmupdate 1
     if [catch {
-	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
+	set parse_cmd [concat git-rev-parse --default HEAD $rargs]
+	set parsed_args [split [eval exec $parse_cmd] "\n"]
     }] {
 	# if git-rev-parse failed for some reason...
 	if {$rargs == {}} {
