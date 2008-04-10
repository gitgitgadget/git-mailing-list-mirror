From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 08/10] Don't use the export NAME=value form in the test scripts.
Date: Thu, 10 Apr 2008 02:50:14 -0400
Message-ID: <1207810216-27871-9-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-7-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-8-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqfB-0003Vv-JF
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbYDJGwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbYDJGwP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:52:15 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49135 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYDJGwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:52:14 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wG-OI; Thu, 10 Apr 2008 06:50:20 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbx-0007G5-77; Thu, 10 Apr 2008 02:50:17 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-8-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79181>

This form is not portable across all shells, so replace instances of:

  export FOO=bar

with:

  FOO=bar
  export FOO

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/lib-httpd.sh                         |    3 +-
 t/t1500-rev-parse.sh                   |    9 ++++---
 t/t1501-worktree.sh                    |   34 ++++++++++++++++---------------
 t/t3400-rebase.sh                      |    3 +-
 t/t3500-cherry.sh                      |    3 +-
 t/t5500-fetch-pack.sh                  |    2 +-
 t/t6000lib.sh                          |    9 +++++--
 t/t6010-merge-base.sh                  |    9 ++++---
 t/t7004-tag.sh                         |    3 +-
 t/t9500-gitweb-standalone-no-errors.sh |   16 ++++++++------
 10 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 7f206c5..a5c4436 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -61,7 +61,8 @@ prepare_httpd() {
 			-new -x509 -nodes \
 			-out $HTTPD_ROOT_PATH/httpd.pem \
 			-keyout $HTTPD_ROOT_PATH/httpd.pem
-		export GIT_SSL_NO_VERIFY=t
+		GIT_SSL_NO_VERIFY=t
+		export GIT_SSL_NO_VERIFY
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
 	else
 		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 38a2bf0..85da4ca 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -51,8 +51,9 @@ test_rev_parse 'core.bare undefined' false false true
 
 mkdir work || exit 1
 cd work || exit 1
-export GIT_DIR=../.git
-export GIT_CONFIG="$(pwd)"/../.git/config
+GIT_DIR=../.git
+GIT_CONFIG="$(pwd)"/../.git/config
+export GIT_DIR GIT_CONFIG
 
 git config core.bare false
 test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
@@ -64,8 +65,8 @@ git config --unset core.bare
 test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 mv ../.git ../repo.git || exit 1
-export GIT_DIR=../repo.git
-export GIT_CONFIG="$(pwd)"/../repo.git/config
+GIT_DIR=../repo.git
+GIT_CONFIG="$(pwd)"/../repo.git/config
 
 git config core.bare false
 test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..2ee88d8 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -32,24 +32,25 @@ mkdir -p work/sub/dir || exit 1
 mv .git repo.git || exit 1
 
 say "core.worktree = relative path"
-export GIT_DIR=repo.git
-export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
+GIT_DIR=repo.git
+GIT_CONFIG="$(pwd)"/$GIT_DIR/config
+export GIT_DIR GIT_CONFIG
 unset GIT_WORK_TREE
 git config core.worktree ../work
 test_rev_parse 'outside'      false false false
 cd work || exit 1
-export GIT_DIR=../repo.git
-export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
+GIT_DIR=../repo.git
+GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
-export GIT_DIR=../../../repo.git
-export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
+GIT_DIR=../../../repo.git
+GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 say "core.worktree = absolute path"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
+GIT_DIR=$(pwd)/repo.git
+GIT_CONFIG=$GIT_DIR/config
 git config core.worktree "$(pwd)/work"
 test_rev_parse 'outside'      false false false
 cd work || exit 1
@@ -59,25 +60,26 @@ test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 say "GIT_WORK_TREE=relative path (override core.worktree)"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
+GIT_DIR=$(pwd)/repo.git
+GIT_CONFIG=$GIT_DIR/config
 git config core.worktree non-existent
-export GIT_WORK_TREE=work
+GIT_WORK_TREE=work
+export GIT_WORK_TREE
 test_rev_parse 'outside'      false false false
 cd work || exit 1
-export GIT_WORK_TREE=.
+GIT_WORK_TREE=.
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
-export GIT_WORK_TREE=../..
+GIT_WORK_TREE=../..
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 mv work repo.git/work
 
 say "GIT_WORK_TREE=absolute path, work tree below git dir"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
-export GIT_WORK_TREE=$(pwd)/repo.git/work
+GIT_DIR=$(pwd)/repo.git
+GIT_CONFIG=$GIT_DIR/config
+GIT_WORK_TREE=$(pwd)/repo.git/work
 test_rev_parse 'outside'              false false false
 cd repo.git || exit 1
 test_rev_parse 'in repo.git'              false true  false
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 496f4ec..10d7449 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -9,7 +9,8 @@ This test runs git rebase and checks that the author information is not lost.
 '
 . ./test-lib.sh
 
-export GIT_AUTHOR_EMAIL=bogus_email_address
+GIT_AUTHOR_EMAIL=bogus_email_address
+export GIT_AUTHOR_EMAIL
 
 test_expect_success \
     'prepare repository with topic branches' \
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index d0a440f..4911c48 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -10,7 +10,8 @@ checks that git cherry only returns the second patch in the local branch
 '
 . ./test-lib.sh
 
-export GIT_AUTHOR_EMAIL=bogus_email_address
+GIT_AUTHOR_EMAIL=bogus_email_address
+export GIT_AUTHOR_EMAIL
 
 test_expect_success \
     'prepare repository with topic branch, and check cherry finds the 2 patches from there' \
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 788b4a5..1700d07 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -31,7 +31,7 @@ add () {
 	sec=$(($sec+1))
 	commit=$(echo "$text" | GIT_AUTHOR_DATE=$sec \
 		git commit-tree $tree $parents 2>>log2.txt)
-	export $name=$commit
+	eval "$name=$commit; export $name"
 	echo $commit > .git/refs/heads/$branch
 	eval ${branch}TIP=$commit
 }
diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index c0baaa5..f55627b 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -49,13 +49,15 @@ as_author()
 	shift 1
         _save=$GIT_AUTHOR_EMAIL
 
-	export GIT_AUTHOR_EMAIL="$_author"
+	GIT_AUTHOR_EMAIL="$_author"
+	export GIT_AUTHOR_EMAIL
 	"$@"
 	if test -z "$_save"
 	then
 		unset GIT_AUTHOR_EMAIL
 	else
-		export GIT_AUTHOR_EMAIL="$_save"
+		GIT_AUTHOR_EMAIL="$_save"
+		export GIT_AUTHOR_EMAIL
 	fi
 }
 
@@ -69,7 +71,8 @@ on_committer_date()
 {
     _date=$1
     shift 1
-    export GIT_COMMITTER_DATE="$_date"
+    GIT_COMMITTER_DATE="$_date"
+    export GIT_COMMITTER_DATE
     "$@"
     unset GIT_COMMITTER_DATE
 }
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 96f3d35..b6e57b2 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -13,10 +13,11 @@ T=$(git write-tree)
 M=1130000000
 Z=+0000
 
-export GIT_COMMITTER_EMAIL=git@comm.iter.xz
-export GIT_COMMITTER_NAME='C O Mmiter'
-export GIT_AUTHOR_NAME='A U Thor'
-export GIT_AUTHOR_EMAIL=git@au.thor.xz
+GIT_COMMITTER_EMAIL=git@comm.iter.xz
+GIT_COMMITTER_NAME='C O Mmiter'
+GIT_AUTHOR_NAME='A U Thor'
+GIT_AUTHOR_EMAIL=git@au.thor.xz
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
 doit() {
 	OFFSET=$1; shift
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1a7141e..2dcee7c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -626,7 +626,8 @@ esac
 
 cp -R ../t7004 ./gpghome
 chmod 0700 gpghome
-export GNUPGHOME="$(pwd)/gpghome"
+GNUPGHOME="$(pwd)/gpghome"
+export GNUPGHOME
 
 get_tag_header signed-tag $commit commit $time >expect
 echo 'A signed tag message' >>expect
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 796cd7d..e7b911e 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -39,13 +39,15 @@ EOF
 }
 
 gitweb_run () {
-	export GATEWAY_INTERFACE="CGI/1.1"
-	export HTTP_ACCEPT="*/*"
-	export REQUEST_METHOD="GET"
-	export QUERY_STRING=""$1""
-	export PATH_INFO=""$2""
-
-	export GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+	GATEWAY_INTERFACE="CGI/1.1"
+	HTTP_ACCEPT="*/*"
+	REQUEST_METHOD="GET"
+	QUERY_STRING=""$1""
+	PATH_INFO=""$2""
+	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD QUERY_STRING PATH_INFO
+
+	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+	export GITWEB_CONFIG
 
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
-- 
1.5.5.33.gc0a39.dirty
