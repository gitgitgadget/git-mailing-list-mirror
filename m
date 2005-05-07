From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sat, 7 May 2005 11:05:43 +0200
Message-ID: <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 07 10:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUL9V-0001o3-BN
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVEGJGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVEGJGB
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 05:06:01 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:62143 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262846AbVEGJFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 05:05:49 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4795hS8003247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 May 2005 09:05:43 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4795hmU003246;
	Sat, 7 May 2005 11:05:43 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

* Junio C Hamano <junkio@cox.net> [050507 10:54]:
> A quick question.  Which construct in this bashism?
> Not using backtick but saying $(command)?

Exactly:

	(faui04a) [~/work/git/git-solaris] git pull
	head => 46dd99f970d283dc0de440c06fca8f4586b70548
	remote => e7d3dd248f50501f98b29c917e70bddcf3ea925a
	base => 74c7cfa875448c71a18d21a0cc7c973afe759fa5
	Documentation/core-git.txt: unmerged (8bd893197e6e769b6e03ca1206e355214e16d56a)
	local-pull.c: unmerged (4f52bca48c390e8113b3695a53ce62e0c23278a8)
	local-pull.c: unmerged (a8af725467cde6653160511e468a1fda4e004503)
	local-pull.c: unmerged (1eec8927dbfa3af934651b25ded738d192706286)
	sha1_file.c: unmerged (e6ce455ae90bd430f2128f454bdb6e0575412486)
	sha1_file.c: unmerged (7887b6481ae5c9368a24bf053f79dbbc1f039300)
	sha1_file.c: unmerged (f1c1c70d784aa0587cd4c7143c3d464fd8e5ddc6)
	fatal: write-tree: not able to write tree

This is it:
	/home/cip/adm/sithglan/work/git/bin/git-SunOS/bin/git-merge-one-file-script: syntax error at line 55: `orig=$' unexpected
	fatal: merge program failed
	git-merge-cache failed: child exit value: 1 at /home/cip/adm/sithglan/work/git/yagf/git line 1015.

The attached patch at the end of this eMail fixes it for me *without*
touching /bin/sh in the bang:

	(faui04a) [~/work/git/git-solaris] git pull
	head => 46dd99f970d283dc0de440c06fca8f4586b70548
	remote => e7d3dd248f50501f98b29c917e70bddcf3ea925a
	base => 74c7cfa875448c71a18d21a0cc7c973afe759fa5
	Documentation/core-git.txt: unmerged (8bd893197e6e769b6e03ca1206e355214e16d56a)
	local-pull.c: unmerged (4f52bca48c390e8113b3695a53ce62e0c23278a8)
	local-pull.c: unmerged (a8af725467cde6653160511e468a1fda4e004503)
	local-pull.c: unmerged (1eec8927dbfa3af934651b25ded738d192706286)
	sha1_file.c: unmerged (e6ce455ae90bd430f2128f454bdb6e0575412486)
	sha1_file.c: unmerged (7887b6481ae5c9368a24bf053f79dbbc1f039300)
	sha1_file.c: unmerged (f1c1c70d784aa0587cd4c7143c3d464fd8e5ddc6)
	fatal: write-tree: not able to write tree
	Threewaydiff invloved.

[PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -52,9 +52,9 @@
 #
 "$1$2$3")
 	echo "Auto-merging $4."
-	orig=$(git-unpack-file $1)
-	src1=$(git-unpack-file $2)
-	src2=$(git-unpack-file $3)
+	orig=`git-unpack-file $1`
+	src1=`git-unpack-file $2`
+	src2=`git-unpack-file $3`
 	merge "$src2" "$orig" "$src1"
 	ret=$?
 	if [ "$6" != "$7" ]; then
@@ -64,7 +64,7 @@
 		echo "ERROR: Leaving conflict merge in $src2."
 		exit 1
 	fi
-	sha1=$(git-write-blob "$src2") || {
+	sha1=`git-write-blob "$src2"` || {
 		echo "ERROR: Leaving conflict merge in $src2."
 	}
 	exec git-update-cache --add --cacheinfo "$6" $sha1 "$4" ;;
