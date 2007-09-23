From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Sun, 23 Sep 2007 22:42:08 +0200
Organization: Organization?!?
Message-ID: <85myvdktb3.fsf@lola.goethe.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 22:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZYHS-0001tT-Ik
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 22:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXIWUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXIWUmN
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 16:42:13 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:57711 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751313AbXIWUmL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 16:42:11 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id B1B5D1437F8
	for <git@vger.kernel.org>; Sun, 23 Sep 2007 22:42:09 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id A2A1F2130A7
	for <git@vger.kernel.org>; Sun, 23 Sep 2007 22:42:09 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 730F836E868
	for <git@vger.kernel.org>; Sun, 23 Sep 2007 22:42:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9D0C71C1F3DC; Sun, 23 Sep 2007 22:42:08 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
In-Reply-To: <853ax5mb1j.fsf@lola.goethe.zz>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58984>

A lot of shell scripts contained stuff starting with

	while case "$#" in 0) break ;; esac

and similar.  I consider breaking out of the condition instead of the
body od the loop ugly, and the implied "true" value of the
non-matching case is not really obvious to humans at first glance.  It
happens not to be obvious to some BSD shells, either, but that's
because they are not POSIX-compliant.  In most cases, this has been
replaced by a straight condition using "test".  "case" has the
advantage of being faster than "test" on vintage shells where "test"
is not a builtin.  Since none of them is likely to run the git
scripts, anyway, the added readability should be worth the change.

A few loops have had their termination condition expressed
differently.

Signed-off-by: David Kastrup <dak@gnu.org>
---

Ok, this is not really what we have been talking about except in one
case, but I think it is actually more of an improvement.

 contrib/examples/git-gc.sh         |    2 +-
 contrib/examples/git-reset.sh      |    2 +-
 contrib/examples/git-tag.sh        |    2 +-
 contrib/examples/git-verify-tag.sh |    2 +-
 git-am.sh                          |    2 +-
 git-clean.sh                       |    2 +-
 git-commit.sh                      |    2 +-
 git-fetch.sh                       |    2 +-
 git-filter-branch.sh               |    3 ++-
 git-instaweb.sh                    |    2 +-
 git-ls-remote.sh                   |    2 +-
 git-merge.sh                       |    2 +-
 git-mergetool.sh                   |    2 +-
 git-pull.sh                        |    6 +++---
 git-quiltimport.sh                 |    2 +-
 git-rebase--interactive.sh         |    2 +-
 git-rebase.sh                      |    5 ++---
 git-repack.sh                      |    2 +-
 git-submodule.sh                   |    2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/contrib/examples/git-gc.sh b/contrib/examples/git-gc.sh
index 2ae235b..1597e9f 100755
--- a/contrib/examples/git-gc.sh
+++ b/contrib/examples/git-gc.sh
@@ -9,7 +9,7 @@ SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
 no_prune=:
-while case $# in 0) break ;; esac
+while test $# != 0
 do
 	case "$1" in
 	--prune)
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset.sh
index 1dc606f..bafeb52 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -11,7 +11,7 @@ require_work_tree
 update= reset_type=--mixed
 unset rev
 
-while case $# in 0) break ;; esac
+while test $# != 0
 do
 	case "$1" in
 	--mixed | --soft | --hard)
diff --git a/contrib/examples/git-tag.sh b/contrib/examples/git-tag.sh
index 5ee3f50..7bb7486 100755
--- a/contrib/examples/git-tag.sh
+++ b/contrib/examples/git-tag.sh
@@ -14,7 +14,7 @@ username=
 list=
 verify=
 LINES=0
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
     case "$1" in
     -a)
diff --git a/contrib/examples/git-verify-tag.sh b/contrib/examples/git-verify-tag.sh
index 37b0023..0902a5c 100755
--- a/contrib/examples/git-verify-tag.sh
+++ b/contrib/examples/git-verify-tag.sh
@@ -5,7 +5,7 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 verbose=
-while case $# in 0) break;; esac
+while test $# != 0
 do
 	case "$1" in
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
diff --git a/git-am.sh b/git-am.sh
index 6809aa0..d97b528 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -109,7 +109,7 @@ dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
 git_apply_opt=
 
-while case "$#" in 0) break;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-d=*|--d=*|--do=*|--dot=*|--dote=*|--dotes=*|--dotest=*)
diff --git a/git-clean.sh b/git-clean.sh
index a5cfd9f..e847ae2 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -26,7 +26,7 @@ rmrf="rm -rf --"
 rm_refuse="echo Not removing"
 echo1="echo"
 
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-d)
diff --git a/git-commit.sh b/git-commit.sh
index 3e46dbb..dcdd49b 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -89,7 +89,7 @@ force_author=
 only_include_assumed=
 untracked_files=
 templatefile="`git config commit.template`"
-while case "$#" in 0) break;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-F|--F|-f|--f|--fi|--fil|--file)
diff --git a/git-fetch.sh b/git-fetch.sh
index c3a2001..dc6483f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -27,7 +27,7 @@ shallow_depth=
 no_progress=
 test -t 1 || no_progress=--no-progress
 quiet=
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-a|--a|--ap|--app|--appe|--appen|--append)
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a4b6577..b7b2ef7 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -105,8 +105,9 @@ filter_tag_name=
 filter_subdir=
 orig_namespace=refs/original/
 force=
-while case "$#" in 0) usage;; esac
+while :
 do
+	test "$#" = 0 && usage
 	case "$1" in
 	--)
 		shift
diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..364cf93 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -61,7 +61,7 @@ stop_httpd () {
 	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
 }
 
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	--stop|stop)
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index b7e5d04..e6e9760 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -13,7 +13,7 @@ die () {
 }
 
 exec=
-while case "$#" in 0) break;; esac
+while test "$#" != 0
 do
   case "$1" in
   -h|--h|--he|--hea|--head|--heads)
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..e4116a8 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -122,7 +122,7 @@ merge_name () {
 case "$#" in 0) usage ;; esac
 
 have_message=
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 47a8055..a0e44f7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -268,7 +268,7 @@ merge_file () {
     cleanup_temp_files
 }
 
-while case $# in 0) break ;; esac
+while test $# != 0
 do
     case "$1" in
 	-t|--tool*)
diff --git a/git-pull.sh b/git-pull.sh
index 5e96d1f..c3f05f5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
 strategy_args= no_summary= no_commit= squash=
-while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
+while :
 do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
@@ -46,8 +46,8 @@ do
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
-	-*)
-		# Pass thru anything that is meant for fetch.
+	*)
+		# Pass thru anything that may be meant for fetch.
 		break
 		;;
 	esac
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9de54d1..1ad9291 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -5,7 +5,7 @@ SUBDIRECTORY_ON=Yes
 
 dry_run=""
 quilt_author=""
-while case "$#" in 0) break;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index abc2b1c..2fa53fd 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -317,7 +317,7 @@ do_rest () {
 	done
 }
 
-while case $# in 0) break ;; esac
+while test $# != 0
 do
 	case "$1" in
 	--continue)
diff --git a/git-rebase.sh b/git-rebase.sh
index c9942f2..9779d34 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -122,15 +122,14 @@ finish_rb_merge () {
 
 is_interactive () {
 	test -f "$dotest"/interactive ||
-	while case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
-	do
+	while :; do case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
 		shift
 	done && test -n "$1"
 }
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	--continue)
diff --git a/git-repack.sh b/git-repack.sh
index 156c5e8..77126cd 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -9,7 +9,7 @@ SUBDIRECTORY_OK='Yes'
 
 no_update_info= all_into_one= remove_redundant=
 local= quiet= no_reuse= extra=
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 3320998..a7180ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -251,7 +251,7 @@ modules_list()
 	done
 }
 
-while case "$#" in 0) break ;; esac
+while test "$#" != 0
 do
 	case "$1" in
 	add)
-- 
1.5.3.1.96.g4568
