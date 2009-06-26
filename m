From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] git svn: Fix t9138-multiple-branches to use svn_cmd and (cd
 ...) syntax.
Date: Fri, 26 Jun 2009 17:08:19 -0400
Message-ID: <4A4538C3.5060901@xiplink.com>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <4A451F8A.9060501@xiplink.com> <20090626205738.GB25118@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIf4-0000gp-22
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbZFZVIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZFZVIa
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:08:30 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:48326 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZFZVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:08:29 -0400
Received: from relay16.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay16.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 8268C1B4035
	for <git@vger.kernel.org>; Fri, 26 Jun 2009 17:08:32 -0400 (EDT)
Received: by relay16.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2726D1B4025;
	Fri, 26 Jun 2009 17:08:27 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <20090626205738.GB25118@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122320>

---

This is against the master branch of Eric's git://git.bogomips.org/git-svn repo.

Eric, if there's anything else I can do to help this along please let me know!

		M.


 t/t9138-git-svn-multiple-branches.sh |  123 ++++++++++++++++++----------------
 1 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/t/t9138-git-svn-multiple-branches.sh b/t/t9138-git-svn-multiple-branches.sh
index 37ecdb0..cb9a6d2 100755
--- a/t/t9138-git-svn-multiple-branches.sh
+++ b/t/t9138-git-svn-multiple-branches.sh
@@ -14,58 +14,58 @@ test_expect_success 'setup svnrepo' '
 		project/tags_A \
 		project/tags_B &&
 	echo 1 > project/trunk/a.file &&
-	svn import -m "$test_description" project "$svnrepo/project" &&
+	svn_cmd import -m "$test_description" project "$svnrepo/project" &&
 	rm -rf project &&
-	svn cp -m "Branch 1" "$svnrepo/project/trunk" \
-			     "$svnrepo/project/b_one/first" &&
-	svn cp -m "Tag 1" "$svnrepo/project/trunk" \
-			  "$svnrepo/project/tags_A/1.0" &&
-	svn co "$svnrepo/project" svn_project &&
-	cd svn_project &&
+	svn_cmd cp -m "Branch 1" "$svnrepo/project/trunk" \
+				 "$svnrepo/project/b_one/first" &&
+	svn_cmd cp -m "Tag 1" "$svnrepo/project/trunk" \
+			      "$svnrepo/project/tags_A/1.0" &&
+	svn_cmd co "$svnrepo/project" svn_project &&
+	( cd svn_project &&
 		echo 2 > trunk/a.file &&
-		svn ci -m "Change 1" trunk/a.file &&
-		svn cp -m "Branch 2" "$svnrepo/project/trunk" \
-				     "$svnrepo/project/b_one/second" &&
-		svn cp -m "Tag 2" "$svnrepo/project/trunk" \
-				  "$svnrepo/project/tags_A/2.0" &&
+		svn_cmd ci -m "Change 1" trunk/a.file &&
+		svn_cmd cp -m "Branch 2" "$svnrepo/project/trunk" \
+					 "$svnrepo/project/b_one/second" &&
+		svn_cmd cp -m "Tag 2" "$svnrepo/project/trunk" \
+				      "$svnrepo/project/tags_A/2.0" &&
 		echo 3 > trunk/a.file &&
-		svn ci -m "Change 2" trunk/a.file &&
-		svn cp -m "Branch 3" "$svnrepo/project/trunk" \
-				     "$svnrepo/project/b_two/1" &&
-		svn cp -m "Tag 3" "$svnrepo/project/trunk" \
-				  "$svnrepo/project/tags_A/3.0" &&
+		svn_cmd ci -m "Change 2" trunk/a.file &&
+		svn_cmd cp -m "Branch 3" "$svnrepo/project/trunk" \
+					 "$svnrepo/project/b_two/1" &&
+		svn_cmd cp -m "Tag 3" "$svnrepo/project/trunk" \
+				      "$svnrepo/project/tags_A/3.0" &&
 		echo 4 > trunk/a.file &&
-		svn ci -m "Change 3" trunk/a.file &&
-		svn cp -m "Branch 4" "$svnrepo/project/trunk" \
-				     "$svnrepo/project/b_two/2" &&
-		svn cp -m "Tag 4" "$svnrepo/project/trunk" \
-				  "$svnrepo/project/tags_A/4.0" &&
-		svn up &&
+		svn_cmd ci -m "Change 3" trunk/a.file &&
+		svn_cmd cp -m "Branch 4" "$svnrepo/project/trunk" \
+					 "$svnrepo/project/b_two/2" &&
+		svn_cmd cp -m "Tag 4" "$svnrepo/project/trunk" \
+				      "$svnrepo/project/tags_A/4.0" &&
+		svn_cmd up &&
 		echo 5 > b_one/first/a.file &&
-		svn ci -m "Change 4" b_one/first/a.file &&
-		svn cp -m "Tag 5" "$svnrepo/project/b_one/first" \
-				  "$svnrepo/project/tags_B/v5" &&
+		svn_cmd ci -m "Change 4" b_one/first/a.file &&
+		svn_cmd cp -m "Tag 5" "$svnrepo/project/b_one/first" \
+				      "$svnrepo/project/tags_B/v5" &&
 		echo 6 > b_one/second/a.file &&
-		svn ci -m "Change 5" b_one/second/a.file &&
-		svn cp -m "Tag 6" "$svnrepo/project/b_one/second" \
-				  "$svnrepo/project/tags_B/v6" &&
+		svn_cmd ci -m "Change 5" b_one/second/a.file &&
+		svn_cmd cp -m "Tag 6" "$svnrepo/project/b_one/second" \
+				      "$svnrepo/project/tags_B/v6" &&
 		echo 7 > b_two/1/a.file &&
-		svn ci -m "Change 6" b_two/1/a.file &&
-		svn cp -m "Tag 7" "$svnrepo/project/b_two/1" \
-				  "$svnrepo/project/tags_B/v7" &&
+		svn_cmd ci -m "Change 6" b_two/1/a.file &&
+		svn_cmd cp -m "Tag 7" "$svnrepo/project/b_two/1" \
+				      "$svnrepo/project/tags_B/v7" &&
 		echo 8 > b_two/2/a.file &&
-		svn ci -m "Change 7" b_two/2/a.file &&
-		svn cp -m "Tag 8" "$svnrepo/project/b_two/2" \
-				  "$svnrepo/project/tags_B/v8" &&
-	cd ..
-	'
+		svn_cmd ci -m "Change 7" b_two/2/a.file &&
+		svn_cmd cp -m "Tag 8" "$svnrepo/project/b_two/2" \
+				      "$svnrepo/project/tags_B/v8"
+	)
+'
 
 test_expect_success 'clone multiple branch and tag paths' '
 	git svn clone -T trunk \
 		      -b b_one/* --branches b_two/* \
 		      -t tags_A/* --tags tags_B \
 		      "$svnrepo/project" git_project &&
-	cd git_project &&
+	( cd git_project &&
 		git rev-parse refs/remotes/first &&
 		git rev-parse refs/remotes/second &&
 		git rev-parse refs/remotes/1 &&
@@ -77,37 +77,46 @@ test_expect_success 'clone multiple branch and tag paths' '
 		git rev-parse refs/remotes/tags/v5 &&
 		git rev-parse refs/remotes/tags/v6 &&
 		git rev-parse refs/remotes/tags/v7 &&
-		git rev-parse refs/remotes/tags/v8 &&
-	cd ..
-	'
+		git rev-parse refs/remotes/tags/v8
+	)
+'
 
 test_expect_success 'Multiple branch or tag paths require -d' '
-	cd git_project &&
+	( cd git_project &&
 		test_must_fail git svn branch -m "No new branch" Nope &&
 		test_must_fail git svn tag -m "No new tag" Tagless &&
 		test_must_fail git rev-parse refs/remotes/Nope &&
-		test_must_fail git rev-parse refs/remotes/tags/Tagless &&
-	cd ../svn_project &&
-		svn up &&
+		test_must_fail git rev-parse refs/remotes/tags/Tagless
+	) &&
+	( cd svn_project &&
+		svn_cmd up &&
 		test_must_fail test -d b_one/Nope &&
 		test_must_fail test -d b_two/Nope &&
 		test_must_fail test -d tags_A/Tagless &&
-		test_must_fail test -d tags_B/Tagless &&
-	cd ..
-	'
+		test_must_fail test -d tags_B/Tagless
+	)
+'
 
 test_expect_success 'create new branches and tags' '
-	( cd git_project && git svn branch -m "New branch 1" -d project/b_one New1 ) &&
-	( cd svn_project && svn up && test -e b_one/New1/a.file ) &&
+	( cd git_project &&
+		git svn branch -m "New branch 1" -d project/b_one New1 ) &&
+	( cd svn_project &&
+		svn_cmd up && test -e b_one/New1/a.file ) &&
 
-	( cd git_project && git svn branch -m "New branch 2" -d project/b_two New2 ) &&
-	( cd svn_project && svn up && test -e b_two/New2/a.file ) &&
+	( cd git_project &&
+		git svn branch -m "New branch 2" -d project/b_two New2 ) &&
+	( cd svn_project &&
+		svn_cmd up && test -e b_two/New2/a.file ) &&
 
-	( cd git_project && git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
-	( cd svn_project && svn up && test -e tags_A/Tag1/a.file )
+	( cd git_project &&
+		git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
+	( cd svn_project &&
+		svn_cmd up && test -e tags_A/Tag1/a.file ) &&
 
-	( cd git_project && git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
-	( cd svn_project && svn up && test -e tags_B/Tag2/a.file )
-	'
+	( cd git_project &&
+		git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
+	( cd svn_project &&
+		svn_cmd up && test -e tags_B/Tag2/a.file )
+'
 
 test_done
-- 
1.6.3.3
