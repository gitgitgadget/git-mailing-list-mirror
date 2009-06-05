From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 3/3] git-parse-remote: remove unused functions
Date: Fri,  5 Jun 2009 21:53:37 +0200
Message-ID: <1244231617-17754-3-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 21:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfUG-0004Xx-DZ
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbZFETxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 15:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbZFETxl
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:53:41 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:40210 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZFETxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 15:53:40 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so1734854bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 12:53:42 -0700 (PDT)
Received: by 10.103.220.18 with SMTP id x18mr2441752muq.6.1244231621962;
        Fri, 05 Jun 2009 12:53:41 -0700 (PDT)
Received: from localhost (p5B0D54CB.dip.t-dialin.net [91.13.84.203])
        by mx.google.com with ESMTPS id i7sm1468243mue.18.2009.06.05.12.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 12:53:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120824>


Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 .gitignore                         |    1 -
 Documentation/git-parse-remote.txt |   50 ---------
 git-parse-remote.sh                |  204 ----------------------------=
--------
 3 files changed, 0 insertions(+), 255 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt

diff --git a/.gitignore b/.gitignore
index 41c0b20..163998c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -89,7 +89,6 @@ git-mv
 git-pack-redundant
 git-pack-objects
 git-pack-refs
-git-parse-remote
 git-patch-id
 git-peek-remote
 git-prune
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-par=
se-remote.txt
deleted file mode 100644
index cd43069..0000000
--- a/Documentation/git-parse-remote.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-git-parse-remote(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-NAME
-----
-git-parse-remote - Routines to help parsing remote repository access p=
arameters
-
-
-SYNOPSIS
---------
-'. "$(git --exec-path)/git-parse-remote"'
-
-DESCRIPTION
------------
-This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
-
-The primary entry points are:
-
-get_remote_refs_for_fetch::
-	Given the list of user-supplied `<repo> <refspec>...`,
-	return the list of refs to fetch after canonicalizing
-	them into `$GIT_DIR` relative paths
-	(e.g. `refs/heads/foo`).  When `<refspec>...` is empty
-	the returned list of refs consists of the defaults
-	for the given `<repo>`, if specified in
-	`$GIT_DIR/remotes/`, `$GIT_DIR/branches/`, or `remote.*.fetch`
-	configuration.
-
-get_remote_refs_for_push::
-	Given the list of user-supplied `<repo> <refspec>...`,
-	return the list of refs to push in a form suitable to be
-	fed to the 'git-send-pack' command.  When `<refspec>...`
-	is empty the returned list of refs consists of the
-	defaults for the given `<repo>`, if specified in
-	`$GIT_DIR/remotes/`.
-
-Author
-------
-Written by Junio C Hamano.
-
-Documentation
---------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>=
=2E
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5df5689..34f4b36 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -60,175 +60,6 @@ get_default_remote () {
 	echo ${origin:-origin}
 }
=20
-get_remote_default_refs_for_push () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	'' | branches | self)
-		;; # no default push mapping, just send matching refs.
-	config)
-		git config --get-all "remote.$1.push" ;;
-	remotes)
-		sed -ne '/^Push: */{
-			s///p
-		}' "$GIT_DIR/remotes/$1" ;;
-	*)
-		die "internal error: get-remote-default-ref-for-push $1" ;;
-	esac
-}
-
-# Called from canon_refs_list_for_fetch -d "$remote", which
-# is called from get_remote_default_refs_for_fetch to grok
-# refspecs that are retrieved from the configuration, but not
-# from get_remote_refs_for_fetch when it deals with refspecs
-# supplied on the command line.  $ls_remote_result has the list
-# of refs available at remote.
-#
-# The first token returned is either "explicit" or "glob"; this
-# is to help prevent randomly "globbed" ref from being chosen as
-# a merge candidate
-expand_refs_wildcard () {
-	echo "$ls_remote_result" |
-	git fetch--tool expand-refs-wildcard "-" "$@"
-}
-
-# Subroutine to canonicalize remote:local notation.
-canon_refs_list_for_fetch () {
-	# If called from get_remote_default_refs_for_fetch
-	# leave the branches in branch.${curr_branch}.merge alone,
-	# or the first one otherwise; add prefix . to the rest
-	# to prevent the secondary branches to be merged by default.
-	merge_branches=3D
-	curr_branch=3D
-	if test "$1" =3D "-d"
-	then
-		shift ; remote=3D"$1" ; shift
-		set $(expand_refs_wildcard "$remote" "$@")
-		is_explicit=3D"$1"
-		shift
-		if test "$remote" =3D "$(get_default_remote)"
-		then
-			curr_branch=3D$(git symbolic-ref -q HEAD | \
-			    sed -e 's|^refs/heads/||')
-			merge_branches=3D$(git config \
-			    --get-all "branch.${curr_branch}.merge")
-		fi
-		if test -z "$merge_branches" && test $is_explicit !=3D explicit
-		then
-			merge_branches=3D..this.will.never.match.any.ref..
-		fi
-	fi
-	for ref
-	do
-		force=3D
-		case "$ref" in
-		+*)
-			ref=3D$(expr "z$ref" : 'z+\(.*\)')
-			force=3D+
-			;;
-		esac
-		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
-		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
-		local=3D$(expr "z$ref" : 'z[^:]*:\(.*\)')
-		dot_prefix=3D.
-		if test -z "$merge_branches"
-		then
-			merge_branches=3D$remote
-			dot_prefix=3D
-		else
-			for merge_branch in $merge_branches
-			do
-			    [ "$remote" =3D "$merge_branch" ] &&
-			    dot_prefix=3D && break
-			done
-		fi
-		case "$remote" in
-		'' | HEAD ) remote=3DHEAD ;;
-		refs/*) ;;
-		heads/* | tags/* | remotes/* ) remote=3D"refs/$remote" ;;
-		*) remote=3D"refs/heads/$remote" ;;
-		esac
-		case "$local" in
-		'') local=3D ;;
-		refs/*) ;;
-		heads/* | tags/* | remotes/* ) local=3D"refs/$local" ;;
-		*) local=3D"refs/heads/$local" ;;
-		esac
-
-		if local_ref_name=3D$(expr "z$local" : 'zrefs/\(.*\)')
-		then
-		   git check-ref-format "$local_ref_name" ||
-		   die "* refusing to create funny ref '$local_ref_name' locally"
-		fi
-		echo "${dot_prefix}${force}${remote}:${local}"
-	done
-}
-
-# Returns list of src: (no store), or src:dst (store)
-get_remote_default_refs_for_fetch () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	'')
-		echo "HEAD:" ;;
-	self)
-	        canon_refs_list_for_fetch -d "$1" \
-			$(git for-each-ref --format=3D'%(refname):')
-		;;
-	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git config --get-all "remote.$1.fetch") ;;
-	branches)
-		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
-		case "$remote_branch" in '') remote_branch=3Dmaster ;; esac
-		echo "refs/heads/${remote_branch}:refs/heads/$1"
-		;;
-	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
-						s///p
-					}' "$GIT_DIR/remotes/$1")
-		;;
-	*)
-		die "internal error: get-remote-default-ref-for-fetch $1" ;;
-	esac
-}
-
-get_remote_refs_for_push () {
-	case "$#" in
-	0) die "internal error: get-remote-refs-for-push." ;;
-	1) get_remote_default_refs_for_push "$@" ;;
-	*) shift; echo "$@" ;;
-	esac
-}
-
-get_remote_refs_for_fetch () {
-	case "$#" in
-	0)
-	    die "internal error: get-remote-refs-for-fetch." ;;
-	1)
-	    get_remote_default_refs_for_fetch "$@" ;;
-	*)
-	    shift
-	    tag_just_seen=3D
-	    for ref
-	    do
-		if test "$tag_just_seen"
-		then
-		    echo "refs/tags/${ref}:refs/tags/${ref}"
-		    tag_just_seen=3D
-		    continue
-		else
-		    case "$ref" in
-		    tag)
-			tag_just_seen=3Dyes
-			continue
-			;;
-		    esac
-		fi
-		canon_refs_list_for_fetch "$ref"
-	    done
-	    ;;
-	esac
-}
-
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
@@ -266,38 +97,3 @@ get_remote_merge_branch () {
 	    ;;
 	esac
 }
-
-resolve_alternates () {
-	# original URL (xxx.git)
-	top_=3D`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
-	while read path
-	do
-		case "$path" in
-		\#* | '')
-			continue ;;
-		/*)
-			echo "$top_$path/" ;;
-		../*)
-			# relative -- ugly but seems to work.
-			echo "$1/objects/$path/" ;;
-		*)
-			# exit code may not be caught by the reader.
-			echo "bad alternate: $path"
-			exit 1 ;;
-		esac
-	done
-}
-
-get_uploadpack () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	config)
-		uplp=3D$(git config --get "remote.$1.uploadpack")
-		echo ${uplp:-git-upload-pack}
-		;;
-	*)
-		echo "git-upload-pack"
-		;;
-	esac
-}
-
--=20
1.6.3.1.308.g426b5
