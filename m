From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: enable "svn.pathnameencoding" on dcommit
Date: Mon, 15 Feb 2016 00:30:09 +0000
Message-ID: <20160215003009.GA19400@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <56B8B23F.2020901@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
X-From: git-owner@vger.kernel.org Mon Feb 15 01:30:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV73s-00033D-1D
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 01:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbcBOAai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 19:30:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53661 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbcBOAaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 19:30:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AF620276;
	Mon, 15 Feb 2016 00:30:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56B8B23F.2020901@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286164>

Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
> Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

Thanks, it took me some time to figure out the test
case which I will amend:

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 6a48e40..82222fd 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -77,11 +77,21 @@ test_expect_success 'make a commit to test rebase' '
 	'
 
 test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
-	cd test-rebase &&
+	(
+		cd test-rebase &&
 		git svn rebase &&
 		test -e test-rebase-main &&
 		test -e test-rebase
-	'
+	)'
+
+test_expect_success 'svn.pathnameencoding=cp932 new file on dcommit' '
+	neq=$(printf "\201\202") &&
+	git config svn.pathnameencoding cp932 &&
+	echo neq >"$neq" &&
+	git add "$neq" &&
+	git commit -m "neq" &&
+	git svn dcommit
+'
 
 stop_httpd
 
-- 
EW
