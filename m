From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach "git checkout" to use git-show-ref
Date: Fri, 15 Sep 2006 14:56:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609151455150.4388@g5.osdl.org>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 15 23:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOLgL-0000et-TU
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 23:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWIOV5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWIOV5E
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 17:57:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932303AbWIOV5B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 17:57:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8FLuunW012570
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Sep 2006 14:56:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8FLuuXs018050;
	Fri, 15 Sep 2006 14:56:56 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
X-Spam-Status: No, hits=-0.51 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27103>


That way, it doesn't care how the refs are stored any more

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Just as an example of how to use git-show-ref rather than knowing about 
"$GIT_DIR/refs/..." paths.

This basically replaces my much hackier version that is in the "lt/refs" 
branch, but can go into the master branch independently of the 
refs-packing work.

diff --git a/git-checkout.sh b/git-checkout.sh
index 580a9e8..6e4c535 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -22,7 +22,7 @@ while [ "$#" != "0" ]; do
 		shift
 		[ -z "$newbranch" ] &&
 			die "git checkout: -b needs a branch name"
-		[ -e "$GIT_DIR/refs/heads/$newbranch" ] &&
+		git-show-ref --verify --quiet -- "refs/heads/$newbranch" &&
 			die "git checkout: branch $newbranch already exists"
 		git-check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
@@ -51,7 +51,7 @@ while [ "$#" != "0" ]; do
 			fi
 			new="$rev"
 			new_name="$arg^0"
-			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
+			if git-show-ref --verify --quiet -- "refs/heads/$arg" ]; then
 				branch="$arg"
 			fi
 		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
