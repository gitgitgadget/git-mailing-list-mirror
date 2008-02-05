From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] shell scripts: Use POSIX/Susv command substitution instead of backticks
Date: Wed, 06 Feb 2008 01:37:58 +0200
Organization: Private
Message-ID: <63x3x9d5.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 00:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXO9-0001zx-5M
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760504AbYBEXi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760393AbYBEXi5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:38:57 -0500
Received: from main.gmane.org ([80.91.229.2]:46967 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763489AbYBEXiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:38:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMXNJ-0002WL-0K
	for git@vger.kernel.org; Tue, 05 Feb 2008 23:38:49 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 23:38:48 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 23:38:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:RQwaWk7VZg3zsgMz/6s0lw0t4Gg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72722>

Use redable $(<command>) syntax instead of backtics in code.  See The
Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 NOTE: git-rebase.sh has been handled / submitted in earlier patch.

 check-builtins.sh     |    4 ++--
 git-am.sh             |   27 ++++++++++++++-------------
 git-bisect.sh         |    4 ++--
 git-checkout.sh       |    8 ++++----
 git-clone.sh          |   20 ++++++++++----------
 git-help--browse.sh   |    6 +++---
 git-instaweb.sh       |   22 +++++++++++-----------
 git-merge-octopus.sh  |    2 +-
 git-merge-one-file.sh |   12 ++++++------
 git-merge-stupid.sh   |    2 +-
 git-merge.sh          |    9 +++++----
 git-mergetool.sh      |   16 ++++++++--------
 git-parse-remote.sh   |    2 +-
 git-pull.sh           |    2 +-
 git-repack.sh         |    8 ++++----
 git-request-pull.sh   |    6 +++---
 git-submodule.sh      |    2 +-
 test-sha1.sh          |    8 ++++----
 18 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/check-builtins.sh b/check-builtins.sh
index d6fe6cf..07cff69 100755
--- a/check-builtins.sh
+++ b/check-builtins.sh
@@ -14,8 +14,8 @@ sort |
     bad=0
     while read builtin
     do
-	base=`expr "$builtin" : 'git-\(.*\)'`
-	x=`sed -ne 's/.*{ "'$base'", \(cmd_[^, ]*\).*/'$base'	\1/p' git.c`
+	base=$(expr "$builtin" : 'git-\(.*\)')
+	x=$(sed -ne 's/.*{ "'$base'", \(cmd_[^, ]*\).*/'$base'	\1/p' git.c)
 	if test -z "$x"
 	then
 		echo "$base is builtin but not listed in git.c command list"
diff --git a/git-am.sh b/git-am.sh
index 5f0f241..4e41243 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -71,7 +71,7 @@ cannot_fallback () {
 }
 
 fall_back_3way () {
-    O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
+    O_OBJECT=$(cd "$GIT_OBJECT_DIRECTORY" && pwd)
 
     rm -fr "$dotest"/patch-merge-*
     mkdir "$dotest/patch-merge-tmp-dir"
@@ -243,23 +243,23 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-ws=`cat "$dotest/whitespace"`
+ws=$(cat "$dotest/whitespace")
 if test "$(cat "$dotest/sign")" = t
 then
-	SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
+	SIGNOFF=$(git-var GIT_COMMITTER_IDENT | sed -e '
 			s/>.*/>/
 			s/^/Signed-off-by: /'
-		`
+		)
 else
 	SIGNOFF=
 fi
 
-last=`cat "$dotest/last"`
-this=`cat "$dotest/next"`
+last=$(cat "$dotest/last")
+this=$(cat "$dotest/next")
 if test "$skip" = t
 then
 	git rerere clear
-	this=`expr "$this" + 1`
+	this=$(expr "$this" + 1)
 	resume=
 fi
 
@@ -272,8 +272,8 @@ fi
 
 while test "$this" -le "$last"
 do
-	msgnum=`printf "%0${prec}d" $this`
-	next=`expr "$this" + 1`
+	msgnum=$(printf "%0${prec}d" $this)
+	next=$(expr "$this" + 1)
 	test -f "$dotest/$msgnum" || {
 		resume=
 		go_next
@@ -326,16 +326,17 @@ do
 	'')
 	    if test '' != "$SIGNOFF"
 	    then
-		LAST_SIGNED_OFF_BY=`
+		LAST_SIGNED_OFF_BY=$(
 		    sed -ne '/^Signed-off-by: /p' \
 		    "$dotest/msg-clean" |
 		    tail -n 1
-		`
-		ADD_SIGNOFF=`
+		)
+		ADD_SIGNOFF=$(
 		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
 		    test '' = "$LAST_SIGNED_OFF_BY" && echo
 		    echo "$SIGNOFF"
-		}`
+		    }
+		)
 	    else
 		ADD_SIGNOFF=
 	    fi
diff --git a/git-bisect.sh b/git-bisect.sh
index 5385249..a97f2b2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -64,7 +64,7 @@ bisect_start() {
 	case "$head" in
 	refs/heads/bisect)
 		if [ -s "$GIT_DIR/head-name" ]; then
-		    branch=`cat "$GIT_DIR/head-name"`
+		    branch=$(cat "$GIT_DIR/head-name")
 		else
 		    branch=master
 		fi
@@ -350,7 +350,7 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) if [ -s "$GIT_DIR/head-name" ]; then
-	       branch=`cat "$GIT_DIR/head-name"`
+	       branch=$(cat "$GIT_DIR/head-name")
 	   else
 	       branch=master
 	   fi ;;
diff --git a/git-checkout.sh b/git-checkout.sh
index 5621c69..23d3a7d 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -218,7 +218,7 @@ else
 
 	# Match the index to the working tree, and do a three-way.
 	git diff-files --name-only | git update-index --remove --stdin &&
-	work=`git write-tree` &&
+	work=$(git write-tree) &&
 	git read-tree $v --reset -u $new || exit
 
 	eval GITHEAD_$new='${new_name:-${branch:-$new}}' &&
@@ -229,7 +229,7 @@ else
 	# Do not register the cleanly merged paths in the index yet.
 	# this is not a real merge before committing, but just carrying
 	# the working tree changes along.
-	unmerged=`git ls-files -u`
+	unmerged=$(git ls-files -u)
 	git read-tree $v --reset $new
 	case "$unmerged" in
 	'')	;;
@@ -265,7 +265,7 @@ if [ "$?" -eq 0 ]; then
 	fi
 	if test -n "$branch"
 	then
-		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
+		old_branch_name=$(expr "z$oldbranch" : 'zrefs/heads/\(.*\)')
 		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from ${old_branch_name:-$old} to $branch" HEAD "refs/heads/$branch"
 		if test -n "$quiet"
 		then
@@ -278,7 +278,7 @@ if [ "$?" -eq 0 ]; then
 		fi
 	elif test -n "$detached"
 	then
-		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
+		old_branch_name=$(expr "z$oldbranch" : 'zrefs/heads/\(.*\)')
 		git update-ref --no-deref -m "checkout: moving from ${old_branch_name:-$old} to $arg" HEAD "$detached" ||
 			die "Cannot detach HEAD"
 		if test -n "$detach_warn"
diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..97831ab 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -40,7 +40,7 @@ eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)
 
 get_repo_base() {
 	(
-		cd "`/bin/pwd`" &&
+		cd "$(/bin/pwd)" &&
 		cd "$1" || cd "$1.git" &&
 		{
 			cd .git
@@ -50,7 +50,7 @@ get_repo_base() {
 }
 
 if [ -n "$GIT_SSL_NO_VERIFY" -o \
-	"`git config --bool http.sslVerify`" = false ]; then
+	"$(git config --bool http.sslVerify)" = false ]; then
     curl_extra_args="-k"
 fi
 
@@ -70,7 +70,7 @@ clone_dumb_http () {
 	clone_tmp="$GIT_DIR/clone-tmp" &&
 	mkdir -p "$clone_tmp" || exit 1
 	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git config --bool http.noEPSV`" = true ]; then
+		"$(git config --bool http.noEPSV)" = true ]; then
 		curl_extra_args="${curl_extra_args} --disable-epsv"
 	fi
 	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
@@ -79,7 +79,7 @@ Perhaps git-update-server-info needs to be run there?"
 	test "z$quiet" = z && v=-v || v=
 	while read sha1 refname
 	do
-		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
+		name=$(expr "z$refname" : 'zrefs/\(.*\)') &&
 		case "$name" in
 		*^*)	continue;;
 		esac
@@ -88,7 +88,7 @@ Perhaps git-update-server-info needs to be run there?"
 		*)	continue ;;
 		esac
 		if test -n "$use_separate_remote" &&
-		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
+		   branch_name=$(expr "z$name" : 'zheads/\(.*\)')
 		then
 			tname="remotes/$origin/$branch_name"
 		else
@@ -100,7 +100,7 @@ Perhaps git-update-server-info needs to be run there?"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
 	rm -f "$GIT_DIR/REMOTE_HEAD"
 	if test -f "$GIT_DIR/REMOTE_HEAD"; then
-		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+		head_sha1=$(cat "$GIT_DIR/REMOTE_HEAD")
 		case "$head_sha1" in
 		'ref: refs/'*)
 			;;
@@ -413,15 +413,15 @@ if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
 	# a non-bare repository is always in separate-remote layout
 	remote_top="refs/remotes/$origin"
-	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	head_sha1=$(cat "$GIT_DIR/REMOTE_HEAD")
 	case "$head_sha1" in
 	'ref: refs/'*)
 		# Uh-oh, the remote told us (http transport done against
 		# new style repository with a symref HEAD).
 		# Ideally we should skip the guesswork but for now
 		# opt for minimum change.
-		head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
-		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
+		head_sha1=$(expr "z$head_sha1" : 'zref: refs/heads/\(.*\)')
+		head_sha1=$(cat "$GIT_DIR/$remote_top/$head_sha1")
 		;;
 	esac
 
@@ -436,7 +436,7 @@ then
 		while read name
 		do
 			test t = $done && continue
-			branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
+			branch_tip=$(cat "$GIT_DIR/$remote_top/$name")
 			if test "$head_sha1" = "$branch_tip"
 			then
 				echo "$name"
diff --git a/git-help--browse.sh b/git-help--browse.sh
index 10b0a36..85e16c5 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -39,7 +39,7 @@ valid_tool() {
 }
 
 init_browser_path() {
-	browser_path=`git config browser.$1.path`
+	browser_path=$(git config browser.$1.path)
 	test -z "$browser_path" && browser_path=$1
 }
 
@@ -49,7 +49,7 @@ do
 	-b|--browser*|-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-		    browser=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    browser=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 		    ;;
 		1,*)
 		    usage ;;
@@ -75,7 +75,7 @@ if test -z "$browser"
 then
     for opt in "help.browser" "web.browser"
     do
-	browser="`git config $opt`"
+	browser="$(git config $opt)"
 	test -z "$browser" || break
     done
     if test -n "$browser" && ! valid_tool "$browser"; then
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 3e4452b..fb61afe 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -22,12 +22,12 @@ restart        restart the web server
 . git-sh-setup
 
 fqgitdir="$GIT_DIR"
-local="`git config --bool --get instaweb.local`"
-httpd="`git config --get instaweb.httpd`"
-browser="`git config --get instaweb.browser`"
-test -z "$browser" && browser="`git config --get web.browser`"
-port=`git config --get instaweb.port`
-module_path="`git config --get instaweb.modulepath`"
+local="$(git config --bool --get instaweb.local)"
+httpd="$(git config --get instaweb.httpd)"
+browser="$(git config --get instaweb.browser)"
+test -z "$browser" && browser="$(git config --get web.browser)"
+port=$(git config --get instaweb.port)
+module_path="$(git config --get instaweb.modulepath)"
 
 conf="$GIT_DIR/gitweb/httpd.conf"
 
@@ -43,7 +43,7 @@ test -z "$browser" && browser='firefox'
 test -z "$port" && port=1234
 
 start_httpd () {
-	httpd_only="`echo $httpd | cut -f1 -d' '`"
+	httpd_only="$(echo $httpd | cut -f1 -d' ')"
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
 	then
 		$httpd "$fqgitdir/gitweb/httpd.conf"
@@ -73,7 +73,7 @@ start_httpd () {
 }
 
 stop_httpd () {
-	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
+	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
 }
 
 while test $# != 0
@@ -121,7 +121,7 @@ do
 done
 
 mkdir -p "$GIT_DIR/gitweb/tmp"
-GIT_EXEC_PATH="`git --exec-path`"
+GIT_EXEC_PATH="$(git --exec-path)"
 GIT_DIR="$fqgitdir"
 export GIT_EXEC_PATH GIT_DIR
 
@@ -220,7 +220,7 @@ PerlPassEnv GIT_EXEC_DIR
 EOF
 	else
 		# plain-old CGI
-		list_mods=`echo "$httpd" | sed "s/-f$/-l/"`
+		list_mods=$(echo "$httpd" | sed "s/-f$/-l/")
 		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
@@ -275,7 +275,7 @@ webrick)
 esac
 
 init_browser_path() {
-	browser_path="`git config browser.$1.path`"
+	browser_path="$(git config browser.$1.path)"
 	test -z "$browser_path" && browser_path="$1"
 }
 
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 645e114..c3fb628 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -71,7 +71,7 @@ do
 		;;
 	esac
 
-	CNT=`expr $CNT + 1`
+	CNT=$(expr $CNT + 1)
 	PARENT="$PARENT -p $SHA1"
 
 	if test "$common,$NON_FF_MERGE" = "$MRC,0"
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9ee3f80..06146f6 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -86,16 +86,16 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	src2=`git-unpack-file $3`
+	src2=$(git-unpack-file $3)
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
 		# This extracts OUR file in $orig, and uses git apply to
 		# remove lines that are unique to ours.
-		orig=`git-unpack-file $2`
-		sz0=`wc -c <"$orig"`
+		orig=$(git-unpack-file $2)
+		sz0=$(wc -c <"$orig")
 		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
-		sz1=`wc -c <"$orig"`
+		sz1=$(wc -c <"$orig")
 
 		# If we do not have enough common material, it is not
 		# worth trying two-file merge using common subsections.
@@ -103,13 +103,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	*)
 		echo "Auto-merging $4"
-		orig=`git-unpack-file $1`
+		orig=$(git-unpack-file $1)
 		;;
 	esac
 
 	# Be careful for funny filename such as "-L" in "$4", which
 	# would confuse "merge" greatly.
-	src1=`git-unpack-file $2`
+	src1=$(git-unpack-file $2)
 	git merge-file "$src1" "$orig" "$src2"
 	ret=$?
 
diff --git a/git-merge-stupid.sh b/git-merge-stupid.sh
index f612d47..e0239dc 100755
--- a/git-merge-stupid.sh
+++ b/git-merge-stupid.sh
@@ -43,7 +43,7 @@ case "$bases" in
 		GIT_INDEX_FILE=$G git read-tree -m $c $head $remotes \
 			 2>/dev/null ||	continue
 		# Count the paths that are unmerged.
-		cnt=`GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l`
+		cnt=$(GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l)
 		if test $best_cnt -le 0 -o $cnt -le $best_cnt
 		then
 			best=$c
diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..928b99d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -278,7 +278,7 @@ case "$use_strategies" in
 '')
 	case "$#" in
 	1)
-		var="`git config --get pull.twohead`"
+		var="$(git config --get pull.twohead)"
 		if test -n "$var"
 		then
 			use_strategies="$var"
@@ -286,7 +286,7 @@ case "$use_strategies" in
 			use_strategies="$default_twohead_strategies"
 		fi ;;
 	*)
-		var="`git config --get pull.octopus`"
+		var="$(git config --get pull.octopus)"
 		if test -n "$var"
 		then
 			use_strategies="$var"
@@ -455,10 +455,11 @@ do
 
 	if test "$exit" -eq 1
 	then
-	    cnt=`{
+	    cnt=$({
 		git diff-files --name-only
 		git ls-files --unmerged
-	    } | wc -l`
+		} | wc -l
+	    )
 	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
 	    then
 		best_strategy=$strategy
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..11c97d8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -142,7 +142,7 @@ remove_backup () {
 merge_file () {
     path="$1"
 
-    f=`git ls-files -u -- "$path"`
+    f=$(git ls-files -u -- "$path")
     if test -z "$f" ; then
 	if test ! -f "$path" ; then
 	    echo "$path: file not found"
@@ -161,9 +161,9 @@ merge_file () {
     mv -- "$path" "$BACKUP"
     cp -- "$BACKUP" "$path"
 
-    base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+    base_mode=$(git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}')
+    local_mode=$(git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}')
+    remote_mode=$(git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}')
 
     base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
     local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
@@ -287,7 +287,7 @@ do
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-		    merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 		    ;;
 		1,*)
 		    usage ;;
@@ -320,7 +320,7 @@ valid_tool() {
 }
 
 init_merge_tool_path() {
-	merge_tool_path=`git config mergetool.$1.path`
+	merge_tool_path=$(git config mergetool.$1.path)
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
 			emerge)
@@ -335,7 +335,7 @@ init_merge_tool_path() {
 
 
 if test -z "$merge_tool"; then
-    merge_tool=`git config merge.tool`
+    merge_tool=$(git config merge.tool)
     if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
@@ -388,7 +388,7 @@ fi
 
 
 if test $# -eq 0 ; then
-	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
 	if test -z "$files" ; then
 		echo "No files need merging"
 		exit 0
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..0611213 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -231,7 +231,7 @@ get_remote_refs_for_fetch () {
 
 resolve_alternates () {
 	# original URL (xxx.git)
-	top_=`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
+	top_=$(expr "z$1" : 'z\([^:]*:/*[^/]*\)/')
 	while read path
 	do
 		case "$path" in
diff --git a/git-pull.sh b/git-pull.sh
index 46da0f4..4a2b3b6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -46,7 +46,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
diff --git a/git-repack.sh b/git-repack.sh
index e18eb3f..df3b795 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -46,8 +46,8 @@ done
 # Later we will default repack.UseDeltaBaseOffset to true
 default_dbo=false
 
-case "`git config --bool repack.usedeltabaseoffset ||
-       echo $default_dbo`" in
+case "$(git config --bool repack.usedeltabaseoffset ||
+       echo $default_dbo)" in
 true)
 	extra="$extra --delta-base-offset" ;;
 esac
@@ -64,8 +64,8 @@ case ",$all_into_one," in
 	;;
 ,t,)
 	if [ -d "$PACKDIR" ]; then
-		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
-			| sed -e 's/^\.\///' -e 's/\.pack$//'`
+		for e in $(cd "$PACKDIR" && find . -type f -name '*.pack' \
+			| sed -e 's/^\.\///' -e 's/\.pack$//' )
 		do
 			if [ -e "$PACKDIR/$e.keep" ]; then
 				: keep
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 068f5e0..7d74137 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -19,10 +19,10 @@ head=${3-HEAD}
 [ "$base" ] || usage
 [ "$url" ] || usage
 
-baserev=`git rev-parse --verify "$base"^0` &&
-headrev=`git rev-parse --verify "$head"^0` || exit
+baserev=$(git rev-parse --verify "$base"^0) &&
+headrev=$(git rev-parse --verify "$head"^0) || exit
 
-merge_base=`git merge-base $baserev $headrev` ||
+merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
 url=$(get_remote_url "$url")
diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..18d15c2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -28,7 +28,7 @@ say()
 # NEEDSWORK: identical function exists in get_repo_base in clone.sh
 get_repo_base() {
 	(
-		cd "`/bin/pwd`" &&
+		cd "$(/bin/pwd)" &&
 		cd "$1" || cd "$1.git" &&
 		{
 			cd .git
diff --git a/test-sha1.sh b/test-sha1.sh
index bf526c8..7243f1e 100755
--- a/test-sha1.sh
+++ b/test-sha1.sh
@@ -6,13 +6,13 @@ dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
 while read expect cnt pfx
 do
 	case "$expect" in '#'*) continue ;; esac
-	actual=`
+	actual=$(
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
 			tr '\000' 'g'
 		} | ./test-sha1 $cnt
-	`
+	)
 	if test "$expect" = "$actual"
 	then
 		echo "OK: $expect $cnt $pfx"
@@ -51,14 +51,14 @@ exit
 
 while read cnt pfx
 do
-	actual=`
+	actual=$(
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
 			tr '\000' 'g'
 		} | sha1sum |
 		sed -e 's/ .*//'
-	`
+	)
 	echo "$actual $cnt $pfx"
 done <<EOF
 0
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
