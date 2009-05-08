From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [RESEND PATCH] git-svn testsuite: use standard configuration for
	Subversion tools
Date: Fri, 8 May 2009 12:06:16 +0400
Message-ID: <toS3g/caDjln1k7lKlVDYehlCbQ@psUvbB26hX94GoQd3C5ThNBxOp8>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7vfxfowugm.fsf@gitster.siamese.dyndns.org> <Z0zFdWIzyQzuBQjCf+Jk/nJtvIw@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7viqkkv43t.fsf@gitster.siamese.dyndns.org> <GzXVCxlG1vigUEGxhNBLVXNYljM@AnOk+mYbmYVORDu5SWQWxomMUcc> <7vtz437m6r.fsf@alter.siamese.dyndns.org> <Lpio3mDQDlK3iIczVIH3OPF7/N0@psUvbB26hX94GoQd3C5ThNBxOp8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normaperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 10:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2L6M-0003JN-E0
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbZEHIG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZEHIG1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:06:27 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:50056 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450AbZEHIGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:06:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender;
	b=dvUP+K9v95gjRyC4ZznwCup9iicD2HZdJGwbXglIv4lp0pTehdAilkEw0tb8j/NcJo3A3lnEkMBQ557NbLIMlxjiYtTSIP5kOFI9kiaRDLfvRFfGTKuSjsJZB8zw0uC/uPNOitu2rZ2hmG1AUilBz9QHc3Ug8nZQmqd2XxfNOMI=;
Received: from amnesiac.at.no.dns ([144.206.182.38])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1M2L60-000Had-Jh; Fri, 08 May 2009 12:06:17 +0400
Content-Disposition: inline
In-Reply-To: <Lpio3mDQDlK3iIczVIH3OPF7/N0@psUvbB26hX94GoQd3C5ThNBxOp8>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118583>

I have tweaked configuration in my ~/.subversion directory, namely I am
running auto-properties and automatically adding '$Id$' expansion to
every file.  This choke the last test named 'proplist' from
t9101-git-svn-props.sh, because one more property, svn:keywords is
automatically added.

I had just wrapped svn invocation with the svn_cmd that specifies empty
directory via --config-dir argument.  Since the latter is the global
option, it should be recognized by all svn subcommands, so no
regressions will be introduced.

Now svn_cmd is used everywhere, not just in the failed test module: this
should guard us from the future clashes with user-defined configuration
tweaks.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 t/lib-git-svn.sh                              |   15 ++++++++
 t/t9100-git-svn-basic.sh                      |   14 ++++----
 t/t9101-git-svn-props.sh                      |   38 +++++++++++-----------
 t/t9102-git-svn-deep-rmdir.sh                 |    4 +-
 t/t9103-git-svn-tracked-directory-removed.sh  |    8 ++--
 t/t9104-git-svn-follow-parent.sh              |   40 +++++++++++-----------
 t/t9105-git-svn-commit-diff.sh                |    8 ++--
 t/t9106-git-svn-commit-diff-clobber.sh        |   14 ++++----
 t/t9107-git-svn-migrate.sh                    |    2 +-
 t/t9108-git-svn-glob.sh                       |   26 +++++++-------
 t/t9109-git-svn-multi-glob.sh                 |   44 ++++++++++++------------
 t/t9113-git-svn-dcommit-new-file.sh           |    2 +-
 t/t9114-git-svn-dcommit-merge.sh              |    6 ++--
 t/t9116-git-svn-log.sh                        |    2 +-
 t/t9117-git-svn-init-clone.sh                 |    2 +-
 t/t9118-git-svn-funky-branch-names.sh         |    8 ++--
 t/t9119-git-svn-info.sh                       |   30 ++++++++--------
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9122-git-svn-author.sh                     |   12 +++---
 t/t9123-git-svn-rebuild-with-rewriteroot.sh   |    2 +-
 t/t9124-git-svn-dcommit-auto-props.sh         |   30 ++++++++--------
 t/t9125-git-svn-multi-glob-branch-names.sh    |    6 ++--
 t/t9127-git-svn-partial-rebuild.sh            |   14 ++++----
 t/t9128-git-svn-cmd-branch.sh                 |   18 +++++-----
 t/t9129-git-svn-i18n-commitencoding.sh        |    2 +-
 t/t9130-git-svn-authors-file.sh               |    6 ++--
 t/t9133-git-svn-nested-git-repo.sh            |   32 +++++++++---------
 t/t9134-git-svn-ignore-paths.sh               |   32 +++++++++---------
 t/t9137-git-svn-dcommit-clobber-series.sh     |    8 ++--
 29 files changed, 221 insertions(+), 206 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 773d47c..5654962 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -26,6 +26,8 @@ fi
 
 svnrepo=$PWD/svnrepo
 export svnrepo
+svnconf=$PWD/svnconf
+export svnconf
 
 perl -w -e "
 use SVN::Core;
@@ -54,6 +56,19 @@ poke() {
 	test-chmtime +1 "$1"
 }
 
+# We need this, because we should pass empty configuration directory to
+# the 'svn commit' to avoid automated property changes and other stuff
+# that could be set from user's configuration files in ~/.subversion.
+svn_cmd () {
+	[ -d "$svnconf" ] || mkdir "$svnconf"
+	orig_svncmd="$1"; shift
+	if [ -z "$orig_svncmd" ]; then
+		svn
+		return
+	fi
+	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
+}
+
 for d in \
 	"$SVN_HTTPD_PATH" \
 	/usr/sbin/apache2 \
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4eee2e9..64aa7e2 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -31,7 +31,7 @@ test_expect_success \
 	echo "zzz" > bar/zzz &&
 	echo "#!/bin/sh" > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m "import for git svn" . "$svnrepo" >/dev/null &&
+	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null &&
 	cd .. &&
 	rm -rf import &&
 	git svn init "$svnrepo"'
@@ -51,7 +51,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test -d "$SVN_TREE"/dir && test ! -d "$SVN_TREE"/dir/a'
 
 
@@ -118,7 +118,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test ! -x "$SVN_TREE"/exec.sh'
 
 
@@ -129,7 +129,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test -x "$SVN_TREE"/exec.sh'
 
 
@@ -141,7 +141,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test -L "$SVN_TREE"/exec.sh'
 
 name='new symlink is added to a file that was also just made executable'
@@ -153,7 +153,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test -x "$SVN_TREE"/bar/zzz &&
 	test -L "$SVN_TREE"/exec-2.sh'
 
@@ -166,7 +166,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn up "$SVN_TREE" &&
+	svn_cmd up "$SVN_TREE" &&
 	test -f "$SVN_TREE"/exec-2.sh &&
 	test ! -L "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 1e31d6e..9da4178 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -48,7 +48,7 @@ EOF
 	printf "\r\n" > empty_crlf
 	a_empty_crlf=`git hash-object -w empty_crlf`
 
-	svn import --no-auto-props -m 'import for git svn' . "$svnrepo" >/dev/null
+	svn_cmd import --no-auto-props -m 'import for git svn' . "$svnrepo" >/dev/null
 cd ..
 
 rm -rf import
@@ -57,13 +57,13 @@ test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
 		poke kw.c &&
-		svn commit -m "Not yet an Id" &&
+		svn_cmd commit -m "Not yet an Id" &&
 		echo Hello world >> kw.c &&
 		poke kw.c &&
-		svn commit -m "Modified file, but still not yet an Id" &&
-		svn propset svn:keywords Id kw.c &&
+		svn_cmd commit -m "Modified file, but still not yet an Id" &&
+		svn_cmd propset svn:keywords Id kw.c &&
 		poke kw.c &&
-		svn commit -m "Propset Id" &&
+		svn_cmd commit -m "Propset Id" &&
 	cd ..'
 
 test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
@@ -83,16 +83,16 @@ test_expect_success 'raw $Id$ found in kw.c' "test '$expect' = '$got'"
 
 test_expect_success "propset CR on crlf files" \
 	'cd test_wc &&
-		svn propset svn:eol-style CR empty &&
-		svn propset svn:eol-style CR crlf &&
-		svn propset svn:eol-style CR ne_crlf &&
-		svn commit -m "propset CR on crlf files" &&
+		svn_cmd propset svn:eol-style CR empty &&
+		svn_cmd propset svn:eol-style CR crlf &&
+		svn_cmd propset svn:eol-style CR ne_crlf &&
+		svn_cmd commit -m "propset CR on crlf files" &&
 	 cd ..'
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git svn fetch &&
 	 git pull . ${remotes_git_svn} &&
-	 svn co "$svnrepo" new_wc'
+	 svn_cmd co "$svnrepo" new_wc'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
@@ -106,11 +106,11 @@ cd test_wc
 	a_cr=`printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin`
 	a_ne_cr=`printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin`
 	test_expect_success 'Set CRLF on cr files' \
-	'svn propset svn:eol-style CRLF cr &&
-	 svn propset svn:eol-style CRLF ne_cr &&
-	 svn propset svn:keywords Id cr &&
-	 svn propset svn:keywords Id ne_cr &&
-	 svn commit -m "propset CRLF on cr files"'
+	'svn_cmd propset svn:eol-style CRLF cr &&
+	 svn_cmd propset svn:eol-style CRLF ne_cr &&
+	 svn_cmd propset svn:keywords Id cr &&
+	 svn_cmd propset svn:keywords Id ne_cr &&
+	 svn_cmd commit -m "propset CRLF on cr files"'
 cd ..
 test_expect_success 'fetch and pull latest from svn' \
 	'git svn fetch && git pull . ${remotes_git_svn}'
@@ -140,10 +140,10 @@ test_expect_success 'test show-ignore' "
 	cd test_wc &&
 	mkdir -p deeply/nested/directory &&
 	touch deeply/nested/directory/.keep &&
-	svn add deeply &&
-	svn up &&
-	svn propset -R svn:ignore 'no-such-file*' .
-	svn commit -m 'propset svn:ignore'
+	svn_cmd add deeply &&
+	svn_cmd up &&
+	svn_cmd propset -R svn:ignore 'no-such-file*' .
+	svn_cmd commit -m 'propset svn:ignore'
 	cd .. &&
 	git svn show-ignore > show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index e223218..028fb19 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,7 +9,7 @@ test_expect_success 'initialize repo' '
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m "import for git svn" . "$svnrepo" &&
+	svn_cmd import -m "import for git svn" . "$svnrepo" &&
 	cd ..
 	'
 
@@ -23,7 +23,7 @@ test_expect_success 'Try a commit on rmdir' '
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m "remove another" &&
 	git svn set-tree --rmdir HEAD &&
-	svn ls -R "$svnrepo" | grep ^deeply/nested/directory/number/1
+	svn_cmd ls -R "$svnrepo" | grep ^deeply/nested/directory/number/1
 	'
 
 
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index 963dd95..3413164 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -10,15 +10,15 @@ test_expect_success 'make history for tracking' '
 	mkdir import &&
 	mkdir import/trunk &&
 	echo hello >> import/trunk/README &&
-	svn import -m initial import "$svnrepo" &&
+	svn_cmd import -m initial import "$svnrepo" &&
 	rm -rf import &&
-	svn co "$svnrepo"/trunk trunk &&
+	svn_cmd co "$svnrepo"/trunk trunk &&
 	echo bye bye >> trunk/README &&
-	svn rm -m "gone" "$svnrepo"/trunk &&
+	svn_cmd rm -m "gone" "$svnrepo"/trunk &&
 	rm -rf trunk &&
 	mkdir trunk &&
 	echo "new" > trunk/FOLLOWME &&
-	svn import -m "new trunk" trunk "$svnrepo"/trunk
+	svn_cmd import -m "new trunk" trunk "$svnrepo"/trunk
 '
 
 test_expect_success 'clone repo with git' '
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index ab9fa32..78610b6 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -11,18 +11,18 @@ test_expect_success 'initialize repo' '
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m "initial" . "$svnrepo" &&
+	svn_cmd import -m "initial" . "$svnrepo" &&
 	cd .. &&
-	svn co "$svnrepo" wc &&
+	svn_cmd co "$svnrepo" wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
-	svn commit -m "another commit" &&
-	svn up &&
-	svn mv trunk thunk &&
+	svn_cmd commit -m "another commit" &&
+	svn_cmd up &&
+	svn_cmd mv trunk thunk &&
 	echo goodbye >> thunk/readme &&
 	poke thunk/readme &&
-	svn commit -m "bye now" &&
+	svn_cmd commit -m "bye now" &&
 	cd ..
 	'
 
@@ -51,7 +51,7 @@ test_expect_success 'init and fetch from one svn-remote' '
         '
 
 test_expect_success 'follow deleted parent' '
-        (svn cp -m "resurrecting trunk as junk" \
+        (svn_cmd cp -m "resurrecting trunk as junk" \
                "$svnrepo"/trunk@2 "$svnrepo"/junk ||
          svn cp -m "resurrecting trunk as junk" \
                -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
@@ -97,8 +97,8 @@ test_expect_success 'follow higher-level parent' '
         '
 
 test_expect_success 'follow deleted directory' '
-	svn mv -m "bye!" "$svnrepo"/glob/blob/hi "$svnrepo"/glob/blob/bye &&
-	svn rm -m "remove glob" "$svnrepo"/glob &&
+	svn_cmd mv -m "bye!" "$svnrepo"/glob/blob/hi "$svnrepo"/glob/blob/bye &&
+	svn_cmd rm -m "remove glob" "$svnrepo"/glob &&
 	git svn init --minimize-url -i glob "$svnrepo"/glob &&
 	git svn fetch -i glob &&
 	test "`git cat-file blob refs/remotes/glob:blob/bye`" = hi &&
@@ -120,7 +120,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 	cd import &&
 	  svn import -m "r9270 test" . "$svnrepo"/r9270 &&
 	cd .. &&
-	svn co "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
+	svn_cmd co "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
@@ -138,7 +138,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 	'
 
 test_expect_success "track initial change if it was only made to parent" '
-	svn cp -m "wheee!" "$svnrepo"/r9270/trunk "$svnrepo"/r9270/drunk &&
+	svn_cmd cp -m "wheee!" "$svnrepo"/r9270/trunk "$svnrepo"/r9270/drunk &&
 	git svn init --minimize-url -i r9270-d \
 	  "$svnrepo"/r9270/drunk/subversion/bindings/swig/perl/native/t &&
 	git svn fetch -i r9270-d &&
@@ -152,20 +152,20 @@ test_expect_success "track initial change if it was only made to parent" '
 test_expect_success "follow-parent is atomic" '
 	(
 		cd wc &&
-		svn up &&
-		svn mkdir stunk &&
+		svn_cmd up &&
+		svn_cmd mkdir stunk &&
 		echo "trunk stunk" > stunk/readme &&
-		svn add stunk/readme &&
-		svn ci -m "trunk stunk" &&
+		svn_cmd add stunk/readme &&
+		svn_cmd ci -m "trunk stunk" &&
 		echo "stunk like junk" >> stunk/readme &&
-		svn ci -m "really stunk" &&
+		svn_cmd ci -m "really stunk" &&
 		echo "stink stank stunk" >> stunk/readme &&
-		svn ci -m "even the grinch agrees"
+		svn_cmd ci -m "even the grinch agrees"
 	) &&
-	svn copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&
+	svn_cmd copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&
 	{ svn cp -m "early stunk flunked too" \
 		"$svnrepo"/stunk@17 "$svnrepo"/flunked ||
-	svn cp -m "early stunk flunked too" \
+	svn_cmd cp -m "early stunk flunked too" \
 		-r17 "$svnrepo"/stunk "$svnrepo"/flunked; } &&
 	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
 	git svn fetch -i stunk &&
@@ -192,7 +192,7 @@ test_expect_success "follow-parent is atomic" '
 	'
 
 test_expect_success "track multi-parent paths" '
-	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
+	svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git svn multi-fetch &&
 	test `git cat-file commit refs/remotes/glob | \
 	       grep "^parent " | wc -l` -eq 2
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index ba99abb..dd48e9c 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m "initial" . "$svnrepo" &&
+	svn_cmd import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
@@ -27,16 +27,16 @@ prev=`git rev-parse --verify HEAD^1`
 test_expect_success 'test the commit-diff command' '
 	test -n "$prev" && test -n "$head" &&
 	git svn commit-diff -r1 "$prev" "$head" "$svnrepo" &&
-	svn co "$svnrepo" wc &&
+	svn_cmd co "$svnrepo" wc &&
 	cmp readme wc/readme
 	'
 
 test_expect_success 'commit-diff to a sub-directory (with git svn config)' '
-	svn import -m "sub-directory" import "$svnrepo"/subdir &&
+	svn_cmd import -m "sub-directory" import "$svnrepo"/subdir &&
 	git svn init --minimize-url "$svnrepo"/subdir &&
 	git svn fetch &&
 	git svn commit-diff -r3 "$prev" "$head" &&
-	svn cat "$svnrepo"/subdir/readme > readme.2 &&
+	svn_cmd cat "$svnrepo"/subdir/readme > readme.2 &&
 	cmp readme readme.2
 	'
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 6eb0fd8..12f21b7 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -8,18 +8,18 @@ test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m "initial" . "$svnrepo" &&
+	svn_cmd import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m "initial"
 	'
 test_expect_success 'commit change from svn side' '
-	svn co "$svnrepo" t.svn &&
+	svn_cmd co "$svnrepo" t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
-	svn commit -m "second line from svn" &&
+	svn_cmd commit -m "second line from svn" &&
 	cd .. &&
 	rm -rf t.svn
 	'
@@ -43,11 +43,11 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	git reset --hard refs/${remotes_git_svn} &&
-	svn co "$svnrepo" t.svn &&
+	svn_cmd co "$svnrepo" t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
-	svn commit -m "fourth line from svn" &&
+	svn_cmd commit -m "fourth line from svn" &&
 	cd .. &&
 	rm -rf t.svn &&
 	echo "fourth line from git" >> file &&
@@ -67,11 +67,11 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	"
 
 test_expect_success 'commit another change from svn side' '
-	svn co "$svnrepo" t.svn &&
+	svn_cmd co "$svnrepo" t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
-		svn commit -m "third line from svn" &&
+		svn_cmd commit -m "third line from svn" &&
 	cd .. &&
 	rm -rf t.svn
 	'
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index acad16a..3a9e077 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup old-looking metadata' '
 			mkdir -p $i && \
 			echo hello >> $i/README || exit 1
 		done && \
-		svn import -m test . "$svnrepo"
+		svn_cmd import -m test . "$svnrepo"
 		cd .. &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d8582b1..d732d31 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -14,30 +14,30 @@ test_expect_success 'test refspec globbing' '
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo "hello world" > trunk/src/a/readme &&
 	echo "goodbye world" > trunk/src/b/readme &&
-	svn import -m "initial" trunk "$svnrepo"/trunk &&
-	svn co "$svnrepo" tmp &&
+	svn_cmd import -m "initial" trunk "$svnrepo"/trunk &&
+	svn_cmd co "$svnrepo" tmp &&
 	(
 		cd tmp &&
 		mkdir branches tags &&
-		svn add branches tags &&
-		svn cp trunk branches/start &&
-		svn commit -m "start a new branch" &&
-		svn up &&
+		svn_cmd add branches tags &&
+		svn_cmd cp trunk branches/start &&
+		svn_cmd commit -m "start a new branch" &&
+		svn_cmd up &&
 		echo "hi" >> branches/start/src/b/readme &&
 		poke branches/start/src/b/readme &&
 		echo "hey" >> branches/start/src/a/readme &&
 		poke branches/start/src/a/readme &&
-		svn commit -m "hi" &&
-		svn up &&
-		svn cp branches/start tags/end &&
+		svn_cmd commit -m "hi" &&
+		svn_cmd up &&
+		svn_cmd cp branches/start tags/end &&
 		echo "bye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
 		echo "aye" >> tags/end/src/a/readme &&
 		poke tags/end/src/a/readme &&
-		svn commit -m "the end" &&
+		svn_cmd commit -m "the end" &&
 		echo "byebye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "nothing to see here"
+		svn_cmd commit -m "nothing to see here"
 	) &&
 	git config --add svn-remote.svn.url "$svnrepo" &&
 	git config --add svn-remote.svn.fetch \
@@ -72,7 +72,7 @@ test_expect_success 'test left-hand-side only globbing' '
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "try to try"
+		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
 	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
@@ -102,7 +102,7 @@ test_expect_success 'test disallow multi-globs' '
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "try to try"
+		svn_cmd commit -m "try to try"
 	) &&
 	test_must_fail git svn fetch three 2> stderr.three &&
 	test_cmp expect.three stderr.three
diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index 8f79c3f..c318f9f 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -14,30 +14,30 @@ test_expect_success 'test refspec globbing' '
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo "hello world" > trunk/src/a/readme &&
 	echo "goodbye world" > trunk/src/b/readme &&
-	svn import -m "initial" trunk "$svnrepo"/trunk &&
-	svn co "$svnrepo" tmp &&
+	svn_cmd import -m "initial" trunk "$svnrepo"/trunk &&
+	svn_cmd co "$svnrepo" tmp &&
 	(
 		cd tmp &&
 		mkdir branches branches/v1 tags &&
-		svn add branches tags &&
-		svn cp trunk branches/v1/start &&
-		svn commit -m "start a new branch" &&
-		svn up &&
+		svn_cmd add branches tags &&
+		svn_cmd cp trunk branches/v1/start &&
+		svn_cmd commit -m "start a new branch" &&
+		svn_cmd up &&
 		echo "hi" >> branches/v1/start/src/b/readme &&
 		poke branches/v1/start/src/b/readme &&
 		echo "hey" >> branches/v1/start/src/a/readme &&
 		poke branches/v1/start/src/a/readme &&
-		svn commit -m "hi" &&
-		svn up &&
-		svn cp branches/v1/start tags/end &&
+		svn_cmd commit -m "hi" &&
+		svn_cmd up &&
+		svn_cmd cp branches/v1/start tags/end &&
 		echo "bye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
 		echo "aye" >> tags/end/src/a/readme &&
 		poke tags/end/src/a/readme &&
-		svn commit -m "the end" &&
+		svn_cmd commit -m "the end" &&
 		echo "byebye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "nothing to see here"
+		svn_cmd commit -m "nothing to see here"
 	) &&
 	git config --add svn-remote.svn.url "$svnrepo" &&
 	git config --add svn-remote.svn.fetch \
@@ -72,7 +72,7 @@ test_expect_success 'test left-hand-side only globbing' '
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "try to try"
+		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
 	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
@@ -97,25 +97,25 @@ test_expect_success 'test another branch' '
 	(
 		cd tmp &&
 		mkdir branches/v2 &&
-		svn add branches/v2 &&
-		svn cp trunk branches/v2/start &&
-		svn commit -m "Another versioned branch" &&
-		svn up &&
+		svn_cmd add branches/v2 &&
+		svn_cmd cp trunk branches/v2/start &&
+		svn_cmd commit -m "Another versioned branch" &&
+		svn_cmd up &&
 		echo "hello" >> branches/v2/start/src/b/readme &&
 		poke branches/v2/start/src/b/readme &&
 		echo "howdy" >> branches/v2/start/src/a/readme &&
 		poke branches/v2/start/src/a/readme &&
-		svn commit -m "Changed 2 in v2/start" &&
-		svn up &&
-		svn cp branches/v2/start tags/next &&
+		svn_cmd commit -m "Changed 2 in v2/start" &&
+		svn_cmd up &&
+		svn_cmd cp branches/v2/start tags/next &&
 		echo "bye" >> tags/next/src/b/readme &&
 		poke tags/next/src/b/readme &&
 		echo "aye" >> tags/next/src/a/readme &&
 		poke tags/next/src/a/readme &&
-		svn commit -m "adding more" &&
+		svn_cmd commit -m "adding more" &&
 		echo "byebye" >> tags/next/src/b/readme &&
 		poke tags/next/src/b/readme &&
-		svn commit -m "adios"
+		svn_cmd commit -m "adios"
 	) &&
 	git config --add svn-remote.four.url "$svnrepo" &&
 	git config --add svn-remote.four.fetch trunk:refs/remotes/four/trunk &&
@@ -151,7 +151,7 @@ test_expect_success 'test disallow multiple globs' '
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m "try to try"
+		svn_cmd commit -m "try to try"
 	) &&
 	test_must_fail git svn fetch three 2> stderr.three &&
 	test_cmp expect.three stderr.three
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index e9b6128..e8479ce 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -15,7 +15,7 @@ test_description='git svn dcommit new files over svn:// test'
 require_svnserve
 
 test_expect_success 'start tracking an empty repo' '
-	svn mkdir -m "empty dir" "$svnrepo"/empty-dir &&
+	svn_cmd mkdir -m "empty dir" "$svnrepo"/empty-dir &&
 	echo "[general]" > "$rawsvnrepo"/conf/svnserve.conf &&
 	echo anon-access = write >> "$rawsvnrepo"/conf/svnserve.conf &&
 	start_svnserve &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 17b2855..84f7c9b 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -35,12 +35,12 @@ EOF
 }
 
 test_expect_success 'setup svn repository' '
-	svn co "$svnrepo" mysvnwork &&
+	svn_cmd co "$svnrepo" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
-		svn add trunk &&
-		svn ci -m "first commit" trunk &&
+		svn_cmd add trunk &&
+		svn_cmd ci -m "first commit" trunk &&
 		cd ..
 	'
 
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index fd6d1d2..0374a74 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup repository and import' '
 			mkdir -p $i && \
 			echo hello >> $i/README || exit 1
 		done && \
-		svn import -m test . "$svnrepo"
+		svn_cmd import -m test . "$svnrepo"
 		cd .. &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index dde46cd..b7ef9e2 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -16,7 +16,7 @@ cd tmp
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m "$test_description" project "$svnrepo"/project &&
+	svn_cmd import -m "$test_description" project "$svnrepo"/project &&
 	rm -rf project
 	'
 
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 7a7c128..ac52bff 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -13,13 +13,13 @@ scary_ref='Abo-Uebernahme%20(Bug%20#994)'
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m "$test_description" project "$svnrepo/pr ject" &&
+	svn_cmd import -m "$test_description" project "$svnrepo/pr ject" &&
 	rm -rf project &&
-	svn cp -m "fun" "$svnrepo/pr ject/trunk" \
+	svn_cmd cp -m "fun" "$svnrepo/pr ject/trunk" \
 	                "$svnrepo/pr ject/branches/fun plugin" &&
-	svn cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
+	svn_cmd cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
 	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
-	svn cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
+	svn_cmd cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
 	              "$svnrepo/pr ject/branches/$scary_uri" &&
 	start_httpd
 	'
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 27dd7c2..95741cb 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -7,7 +7,7 @@ test_description='git svn info'
 . ./lib-git-svn.sh
 
 # Tested with: svn, version 1.4.4 (r25188)
-v=`svn --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
+v=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
 case $v in
 1.[45].*)
 	;;
@@ -31,7 +31,7 @@ ptouch() {
 			my $atime = $mtime;
 			utime $atime, $mtime, $git_file;
 		}
-	' "`svn info $2 | grep '^Text Last Updated:'`" "$1"
+	' "`svn_cmd info $2 | grep '^Text Last Updated:'`" "$1"
 }
 
 quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
@@ -45,14 +45,14 @@ test_expect_success 'setup repository and import' '
 		mkdir directory &&
 		touch directory/.placeholder &&
 		ln -s directory symlink-directory &&
-		svn import -m "initial" . "$svnrepo" &&
+		svn_cmd import -m "initial" . "$svnrepo" &&
 	cd .. &&
-	svn co "$svnrepo" svnwc &&
+	svn_cmd co "$svnrepo" svnwc &&
 	cd svnwc &&
 		echo foo > foo &&
-		svn add foo &&
-		svn commit -m "change outside directory" &&
-		svn update &&
+		svn_cmd add foo &&
+		svn_cmd commit -m "change outside directory" &&
+		svn_cmd update &&
 	cd .. &&
 	mkdir gitwc &&
 	cd gitwc &&
@@ -143,7 +143,7 @@ test_expect_success 'info added-file' "
 	cp gitwc/added-file svnwc/added-file &&
 	ptouch gitwc/added-file svnwc/added-file &&
 	cd svnwc &&
-		svn add added-file > /dev/null &&
+		svn_cmd add added-file > /dev/null &&
 	cd .. &&
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
 	(cd gitwc; git svn info added-file) > actual.info-added-file &&
@@ -160,7 +160,7 @@ test_expect_success 'info added-directory' "
 	ptouch gitwc/added-directory svnwc/added-directory &&
 	touch gitwc/added-directory/.placeholder &&
 	cd svnwc &&
-		svn add added-directory > /dev/null &&
+		svn_cmd add added-directory > /dev/null &&
 	cd .. &&
 	cd gitwc &&
 		git add added-directory &&
@@ -184,7 +184,7 @@ test_expect_success 'info added-symlink-file' "
 	cd .. &&
 	cd svnwc &&
 		ln -s added-file added-symlink-file &&
-		svn add added-symlink-file > /dev/null &&
+		svn_cmd add added-symlink-file > /dev/null &&
 	cd .. &&
 	ptouch gitwc/added-symlink-file svnwc/added-symlink-file &&
 	(cd svnwc; svn info added-symlink-file) \
@@ -207,7 +207,7 @@ test_expect_success 'info added-symlink-directory' "
 	cd .. &&
 	cd svnwc &&
 		ln -s added-directory added-symlink-directory &&
-		svn add added-symlink-directory > /dev/null &&
+		svn_cmd add added-symlink-directory > /dev/null &&
 	cd .. &&
 	ptouch gitwc/added-symlink-directory svnwc/added-symlink-directory &&
 	(cd svnwc; svn info added-symlink-directory) \
@@ -233,7 +233,7 @@ test_expect_success 'info deleted-file' "
 		git rm -f file > /dev/null &&
 	cd .. &&
 	cd svnwc &&
-		svn rm --force file > /dev/null &&
+		svn_cmd rm --force file > /dev/null &&
 	cd .. &&
 	(cd svnwc; svn info file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -254,7 +254,7 @@ test_expect_success 'info deleted-directory' "
 		git rm -r -f directory > /dev/null &&
 	cd .. &&
 	cd svnwc &&
-		svn rm --force directory > /dev/null &&
+		svn_cmd rm --force directory > /dev/null &&
 	cd .. &&
 	(cd svnwc; svn info directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -275,7 +275,7 @@ test_expect_success 'info deleted-symlink-file' "
 		git rm -f symlink-file > /dev/null &&
 	cd .. &&
 	cd svnwc &&
-		svn rm --force symlink-file > /dev/null &&
+		svn_cmd rm --force symlink-file > /dev/null &&
 	cd .. &&
 	(cd svnwc; svn info symlink-file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -297,7 +297,7 @@ test_expect_success 'info deleted-symlink-directory' "
 		git rm -f symlink-directory > /dev/null &&
 	cd .. &&
 	cd svnwc &&
-		svn rm --force symlink-directory > /dev/null &&
+		svn_cmd rm --force symlink-directory > /dev/null &&
 	cd .. &&
 	(cd svnwc; svn info symlink-directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index ef2c052..555a018 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -9,7 +9,7 @@ test_description='git svn clone with percent escapes'
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m "$test_description" project "$svnrepo/pr ject" &&
+	svn_cmd import -m "$test_description" project "$svnrepo/pr ject" &&
 	rm -rf project &&
 	start_httpd
 '
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 1b1cf47..30013b7 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -4,12 +4,12 @@ test_description='git svn authorship'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repository' '
-	svn checkout "$svnrepo" work.svn &&
+	svn_cmd checkout "$svnrepo" work.svn &&
 	(
 		cd work.svn &&
 		echo >file
-		svn add file
-		svn commit -m "first commit" file
+		svn_cmd add file
+		svn_cmd commit -m "first commit" file
 	)
 '
 
@@ -74,10 +74,10 @@ test_expect_success 'interact with it via git svn' '
 	# Make sure there are no svn commit messages with excess blank lines
 	(
 		cd work.svn &&
-		svn up &&
+		svn_cmd up &&
 		
-		test $(svn log -r2:2 | wc -l) = 5 &&
-		test $(svn log -r4:4 | wc -l) = 7
+		test $(svn_cmd log -r2:2 | wc -l) = 5 &&
+		test $(svn_cmd log -r4:4 | wc -l) = 7
 	)
 '
 
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index cf04152..0455216 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -10,7 +10,7 @@ test_description='git svn respects rewriteRoot during rebuild'
 mkdir import
 cd import
 	touch foo
-	svn import -m 'import for git svn' . "$svnrepo" >/dev/null
+	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
 cd ..
 rm -rf import
 
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
index 263dbf5..d6b076f 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -21,7 +21,7 @@ test_expect_success 'initialize git svn' '
 	(
 		cd import &&
 		echo foo >foo &&
-		svn import -m "import for git svn" . "$svnrepo"
+		svn_cmd import -m "import for git svn" . "$svnrepo"
 	) &&
 	rm -rf import &&
 	git svn init "$svnrepo"
@@ -61,23 +61,23 @@ test_expect_success 'check resulting svn repository' '
 (
 	mkdir work &&
 	cd work &&
-	svn co "$svnrepo" &&
+	svn_cmd co "$svnrepo" &&
 	cd svnrepo &&
 
 	# Check properties from first commit.
-	test "x$(svn propget svn:executable exec1.sh)" = "x*" &&
-	test "x$(svn propget svn:mime-type exec1.sh)" = \
+	test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
+	test "x$(svn_cmd propget svn:mime-type exec1.sh)" = \
 	     "xapplication/x-shellscript" &&
-	test "x$(svn propget svn:mime-type hello.txt)" = "xtext/plain" &&
-	test "x$(svn propget svn:eol-style hello.txt)" = "xnative" &&
-	test "x$(svn propget svn:mime-type bar)" = "x" &&
+	test "x$(svn_cmd propget svn:mime-type hello.txt)" = "xtext/plain" &&
+	test "x$(svn_cmd propget svn:eol-style hello.txt)" = "xnative" &&
+	test "x$(svn_cmd propget svn:mime-type bar)" = "x" &&
 
 	# Check properties from second commit.
-	test "x$(svn propget svn:executable exec2.sh)" = "x*" &&
-	test "x$(svn propget svn:mime-type exec2.sh)" = "x" &&
-	test "x$(svn propget svn:mime-type world.txt)" = "x" &&
-	test "x$(svn propget svn:eol-style world.txt)" = "x" &&
-	test "x$(svn propget svn:mime-type zot)" = "x"
+	test "x$(svn_cmd propget svn:executable exec2.sh)" = "x*" &&
+	test "x$(svn_cmd propget svn:mime-type exec2.sh)" = "x" &&
+	test "x$(svn_cmd propget svn:mime-type world.txt)" = "x" &&
+	test "x$(svn_cmd propget svn:eol-style world.txt)" = "x" &&
+	test "x$(svn_cmd propget svn:mime-type zot)" = "x"
 )
 '
 
@@ -89,12 +89,12 @@ test_expect_success 'check renamed file' '
 	git svn dcommit --config-dir=user &&
 	(
 		cd work/svnrepo &&
-		svn up &&
+		svn_cmd up &&
 		test ! -e foo &&
 		test -e foo.sh &&
-		test "x$(svn propget svn:mime-type foo.sh)" = \
+		test "x$(svn_cmd propget svn:mime-type foo.sh)" = \
 		     "xapplication/x-shellscript" &&
-		test "x$(svn propget svn:eol-style foo.sh)" = "xLF"
+		test "x$(svn_cmd propget svn:eol-style foo.sh)" = "xLF"
 	)
 '
 
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
index 475c751..c194186 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -8,11 +8,11 @@ test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches \
 			project/branches/v14.1 project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m "$test_description" project "$svnrepo/project" &&
+	svn_cmd import -m "$test_description" project "$svnrepo/project" &&
 	rm -rf project &&
-	svn cp -m "fun" "$svnrepo/project/trunk" \
+	svn_cmd cp -m "fun" "$svnrepo/project/trunk" \
 	                "$svnrepo/project/branches/v14.1/beta" &&
-	svn cp -m "more fun!" "$svnrepo/project/branches/v14.1/beta" \
+	svn_cmd cp -m "more fun!" "$svnrepo/project/branches/v14.1/beta" \
 	                      "$svnrepo/project/branches/v14.1/gold"
 	'
 
diff --git a/t/t9127-git-svn-partial-rebuild.sh b/t/t9127-git-svn-partial-rebuild.sh
index 87696a9..4aab8ec 100755
--- a/t/t9127-git-svn-partial-rebuild.sh
+++ b/t/t9127-git-svn-partial-rebuild.sh
@@ -14,21 +14,21 @@ test_expect_success 'initialize svnrepo' '
 		cd trunk &&
 		echo foo > foo &&
 		cd .. &&
-		svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
-		svn copy "$svnrepo"/trunk "$svnrepo"/branches/a \
+		svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null &&
+		svn_cmd copy "$svnrepo"/trunk "$svnrepo"/branches/a \
 			-m "created branch a" &&
 		cd .. &&
 		rm -rf import &&
-		svn co "$svnrepo"/trunk trunk &&
+		svn_cmd co "$svnrepo"/trunk trunk &&
 		cd trunk &&
 		echo bar >> foo &&
-		svn ci -m "updated trunk" &&
+		svn_cmd ci -m "updated trunk" &&
 		cd .. &&
-		svn co "$svnrepo"/branches/a a &&
+		svn_cmd co "$svnrepo"/branches/a a &&
 		cd a &&
 		echo baz >> a &&
-		svn add a &&
-		svn ci -m "updated a" &&
+		svn_cmd add a &&
+		svn_cmd ci -m "updated a" &&
 		cd .. &&
 		git svn init --stdlayout "$svnrepo"
 	)
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 252daa7..807e494 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -14,13 +14,13 @@ test_expect_success 'initialize svnrepo' '
 		cd trunk &&
 		echo foo > foo &&
 		cd .. &&
-		svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
+		svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null &&
 		cd .. &&
 		rm -rf import &&
-		svn co "$svnrepo"/trunk trunk &&
+		svn_cmd co "$svnrepo"/trunk trunk &&
 		cd trunk &&
 		echo bar >> foo &&
-		svn ci -m "updated trunk" &&
+		svn_cmd ci -m "updated trunk" &&
 		cd .. &&
 		rm -rf trunk
 	)
@@ -57,14 +57,14 @@ test_expect_success 'git svn branch tests' '
 '
 
 test_expect_success 'branch uses correct svn-remote' '
-	(svn co "$svnrepo" svn &&
+	(svn_cmd co "$svnrepo" svn &&
 	cd svn &&
 	mkdir mirror &&
-	svn add mirror &&
-	svn copy trunk mirror/ &&
-	svn copy tags mirror/ &&
-	svn copy branches mirror/ &&
-	svn ci -m "made mirror" ) &&
+	svn_cmd add mirror &&
+	svn_cmd copy trunk mirror/ &&
+	svn_cmd copy tags mirror/ &&
+	svn_cmd copy branches mirror/ &&
+	svn_cmd ci -m "made mirror" ) &&
 	rm -rf svn &&
 	git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
 	git svn fetch -R mirror &&
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 3200ab3..d45fb73 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -33,7 +33,7 @@ for H in ISO-8859-1 EUCJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
 		mkdir $H &&
-		svn import -m "$H test" $H "$svnrepo"/$H &&
+		svn_cmd import -m "$H test" $H "$svnrepo"/$H &&
 		git svn clone "$svnrepo"/$H $H
 	'
 done
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index b8fb277..f5abdb3 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -15,7 +15,7 @@ EOF
 test_expect_success 'setup svnrepo' '
 	for i in aa bb cc dd
 	do
-		svn mkdir -m $i --username $i "$svnrepo"/$i
+		svn_cmd mkdir -m $i --username $i "$svnrepo"/$i
 	done
 	'
 
@@ -52,13 +52,13 @@ test_expect_success 'continues to import once authors have been added' '
 	'
 
 test_expect_success 'authors-file against globs' '
-	svn mkdir -m globs --username aa \
+	svn_cmd mkdir -m globs --username aa \
 	  "$svnrepo"/aa/trunk "$svnrepo"/aa/branches "$svnrepo"/aa/tags &&
 	git svn clone --authors-file=svn-authors -s "$svnrepo"/aa aa-work &&
 	for i in bb ee cc
 	do
 		branch="aa/branches/$i"
-		svn mkdir -m "$branch" --username $i "$svnrepo/$branch"
+		svn_cmd mkdir -m "$branch" --username $i "$svnrepo/$branch"
 	done
 	'
 
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
index 893f57e..f3c30e6 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -7,19 +7,19 @@ test_description='git svn property tests'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup repo with a git repo inside it' '
-	svn co "$svnrepo" s &&
+	svn_cmd co "$svnrepo" s &&
 	(
 		cd s &&
 		git init &&
 		test -f .git/HEAD &&
 		> .git/a &&
 		echo a > a &&
-		svn add .git a &&
-		svn commit -m "create a nested git repo" &&
-		svn up &&
+		svn_cmd add .git a &&
+		svn_cmd commit -m "create a nested git repo" &&
+		svn_cmd up &&
 		echo hi >> .git/a &&
-		svn commit -m "modify .git/a" &&
-		svn up
+		svn_cmd commit -m "modify .git/a" &&
+		svn_cmd up
 	)
 '
 
@@ -33,9 +33,9 @@ test_expect_success 'SVN-side change outside of .git' '
 	(
 		cd s &&
 		echo b >> a &&
-		svn commit -m "SVN-side change outside of .git" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change outside of .git"
+		svn_cmd commit -m "SVN-side change outside of .git" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change outside of .git"
 	)
 '
 
@@ -56,10 +56,10 @@ test_expect_success 'SVN-side change inside of .git' '
 		git add a &&
 		git commit -m "add a inside an SVN repo" &&
 		git log &&
-		svn add --force .git &&
-		svn commit -m "SVN-side change inside of .git" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change inside of .git"
+		svn_cmd add --force .git &&
+		svn_cmd commit -m "SVN-side change inside of .git" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change inside of .git"
 	)
 '
 
@@ -80,9 +80,9 @@ test_expect_success 'SVN-side change in and out of .git' '
 		echo c >> a &&
 		git add a &&
 		git commit -m "add a inside an SVN repo" &&
-		svn commit -m "SVN-side change in and out of .git" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change in and out of .git"
+		svn_cmd commit -m "SVN-side change in and out of .git" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change in and out of .git"
 	)
 '
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index 71fdc4a..09ff10c 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -8,19 +8,19 @@ test_description='git svn property tests'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup test repository' '
-	svn co "$svnrepo" s &&
+	svn_cmd co "$svnrepo" s &&
 	(
 		cd s &&
 		mkdir qqq www &&
 		echo test_qqq > qqq/test_qqq.txt &&
 		echo test_www > www/test_www.txt &&
-		svn add qqq &&
-		svn add www &&
-		svn commit -m "create some files" &&
-		svn up &&
+		svn_cmd add qqq &&
+		svn_cmd add www &&
+		svn_cmd commit -m "create some files" &&
+		svn_cmd up &&
 		echo hi >> www/test_www.txt &&
-		svn commit -m "modify www/test_www.txt" &&
-		svn up
+		svn_cmd commit -m "modify www/test_www.txt" &&
+		svn_cmd up
 	)
 '
 
@@ -51,9 +51,9 @@ test_expect_success 'SVN-side change outside of www' '
 	(
 		cd s &&
 		echo b >> qqq/test_qqq.txt &&
-		svn commit -m "SVN-side change outside of www" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change outside of www"
+		svn_cmd commit -m "SVN-side change outside of www" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change outside of www"
 	)
 '
 
@@ -83,9 +83,9 @@ test_expect_success 'SVN-side change inside of ignored www' '
 	(
 		cd s &&
 		echo zaq >> www/test_www.txt
-		svn commit -m "SVN-side change inside of www/test_www.txt" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -116,9 +116,9 @@ test_expect_success 'SVN-side change in and out of ignored www' '
 		cd s &&
 		echo cvf >> www/test_www.txt
 		echo ygg >> qqq/test_qqq.txt
-		svn commit -m "SVN-side change in and out of ignored www" &&
-		svn up &&
-		svn log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
 	)
 '
 
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index fd18501..636ca0a 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file
-	svn import -m "initial" . "$svnrepo" &&
+	svn_cmd import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
@@ -18,14 +18,14 @@ test_expect_success 'initialize repo' '
 test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"`sed -n -e 58p < file`" = x58 &&
 	test x"`sed -n -e 61p < file`" = x61 &&
-	svn co "$svnrepo" tmp &&
+	svn_cmd co "$svnrepo" tmp &&
 	cd tmp &&
 		perl -i.bak -p -e "s/^58$/5588/" file &&
 		perl -i.bak -p -e "s/^61$/6611/" file &&
 		poke file &&
 		test x"`sed -n -e 58p < file`" = x5588 &&
 		test x"`sed -n -e 61p < file`" = x6611 &&
-		svn commit -m "58 => 5588, 61 => 6611" &&
+		svn_cmd commit -m "58 => 5588, 61 => 6611" &&
 		cd ..
 	'
 
@@ -46,7 +46,7 @@ test_expect_success 'change file but in unrelated area' "
 	test x\"\`sed -n -e 7p < file\`\" = x7777 &&
 	git commit -m '4 => 4444, 7 => 7777' file &&
 	git svn dcommit &&
-	svn up tmp &&
+	svn_cmd up tmp &&
 	cd tmp &&
 		test x\"\`sed -n -e 4p < file\`\" = x4444 &&
 		test x\"\`sed -n -e 7p < file\`\" = x7777 &&
-- 
1.6.2.4
-- 
Eygene
