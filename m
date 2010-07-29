From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] filter-branch tests/docs: avoid \t in sed regexes
Date: Thu, 29 Jul 2010 15:24:30 +0200
Message-ID: <0bb511ca2d155ea7e37850a78375da1803032d6c.1280409717.git.trast@student.ethz.ch>
References: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Mercer <ramercer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 15:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeT6I-0006wf-1a
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 15:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0G2NYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 09:24:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28270 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab0G2NYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 09:24:36 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 15:24:35 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul
 2010 15:24:29 +0200
X-Mailer: git-send-email 1.7.2.1.342.g676a4
In-Reply-To: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152175>

Using \t to represent a tab character is not portable beyond GNU sed
(see e.g. GNU sed's info pages).  Use printf to generate the tab
instead.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

 Adam Mercer wrote:
> > What OS is this?
> This was on Mac OS X 10.6. Where sed is BSD sed.

That's very funny however, since it means that nobody should ever have
had a successful test run on OS X with the preinstalled tools.  What
gives?


 Documentation/git-filter-branch.txt |    3 ++-
 t/t7003-filter-branch.sh            |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..7e3ff8e 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -357,8 +357,9 @@ git filter-branch ... D..H --not C
 To move the whole tree into a subdirectory, or remove it from there:
 
 ---------------------------------------------------------------
+export TAB="$(printf '\t')"
 git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
+	'git ls-files -s | sed "s-$TAB\"*-&newsubdir/-" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 0da13a8..e90da6d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -140,10 +140,11 @@ test_expect_success 'more setup' '
 	git merge branch
 '
 
+export TAB="$(printf '\t')"
 test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
 	git filter-branch -f --index-filter \
-		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
+		 "git ls-files -s | sed \"s-$TAB-&newsubdir/-\" |
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
-- 
1.7.2.1.342.g676a4
