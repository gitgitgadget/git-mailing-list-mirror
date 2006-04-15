From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 17:39:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604141737580.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <Pine.LNX.4.64.0604141717280.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 02:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYp7-0006N2-QT
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWDOAjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWDOAjf
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:39:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751451AbWDOAjf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 20:39:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F0dVtH009839
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 17:39:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F0dTeS017850;
	Fri, 14 Apr 2006 17:39:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604141717280.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18715>



On Fri, 14 Apr 2006, Linus Torvalds wrote:
> 
> Gaah. Missed this important part, which causes the thing to ignore the 
> "--pretty=xyzzy" argument, since it would always use its own default 
> format that is no longer ever changed.

And here's one more fixup: get the default format right, and don't prefix 
the "oneline" format.

		Linus

----
diff --git a/git.c b/git.c
index d5a4a24..437e9b5 100644
--- a/git.c
+++ b/git.c
@@ -291,6 +291,8 @@ static int cmd_log(int argc, const char 
 		die("unrecognized argument: %s", argv[1]);
 
 	rev.no_commit_id = 1;
+	if (rev.commit_format == CMIT_FMT_ONELINE)
+		commit_prefix = "";
 
 	prepare_revision_walk(&rev);
 	setup_pager();
diff --git a/revision.c b/revision.c
index 99077af..0f98960 100644
--- a/revision.c
+++ b/revision.c
@@ -493,7 +493,7 @@ void init_revisions(struct rev_info *rev
 	revs->topo_getter = topo_sort_default_getter;
 
 	revs->header_prefix = "";
-	revs->commit_format = CMIT_FMT_RAW;
+	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
 }
