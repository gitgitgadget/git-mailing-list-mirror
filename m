From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early
 on errors)
Date: Sat, 28 Jan 2006 00:53:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601280047240.2909@evo.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> 
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>, keithp@keithp.com
X-From: git-owner@vger.kernel.org Sat Jan 28 06:54:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2j2S-0004Fi-Lp
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 06:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWA1Fxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWA1Fxy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 00:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932519AbWA1Fxy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2006 00:53:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0S5rhDZ004511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 Jan 2006 21:53:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0S5rfjV026701;
	Fri, 27 Jan 2006 21:53:42 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15193>



On Sat, 28 Jan 2006, Martin Langhoff wrote:
> 
> BTW, have you still got that patch to git-merge to seed the commit msg
> with conflicted files? ;-)

Nope. But it was something like the appended (totally untested, and 
slightly improved).

The point being that we'd fill in a template that the committer will 
hopefully edit to explain what he did to fix up the merge for each file 
that had conflicts.

		Linus

---
diff --git a/git-merge.sh b/git-merge.sh
index 0a158ef..9f828f3 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -301,5 +301,9 @@ then
 	"Automatic merge went well; stopped before committing as requested"
 	exit 0
 else
+	echo >"$GIT_DIR/MERGE_MSG"
+	echo "Conflicts in" >"$GIT_DIR/MERGE_MSG"
+	git-ls-files --unmerged | cut -f2 | uniq |
+		sed 's/^.*/    \0:/' >"$GIT_DIR/MERGE_MSG"
 	die "Automatic merge failed; fix up by hand"
 fi
