From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC] war on echo in scripts
Date: Thu, 8 Jul 2010 12:14:18 -0500
Message-ID: <20100708171418.GA18229@burratino>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
 <20100708103552.GF31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 19:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWugw-0005UC-W2
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 19:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab0GHRPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 13:15:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43467 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab0GHRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 13:15:03 -0400
Received: by iwn7 with SMTP id 7so1087046iwn.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DvPJmlaFheT1NmL9N+IxysbLD/YHwZsX6Z7JOMuDD0I=;
        b=trAOcM2nQtIA7EAcxH27PhthUUZ+9xkuYp6GmWF82djsBFO7OL6TibpISbpr3XKxAd
         sCeD8ejaFDJdjr0Kwaoq1FHD+Qdgups/wuIJD7ZpEOHaR+ERtp5Oa12EZKqSWhzg8R2e
         GdyEm0v0UXs4WPRbt0NSVFQzlFRfn25vVrrLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pIlMqJ2nr03bM8X2xkSUaQ3vMYbGJkH2evNrTnPmPkD1jZG8EQR6/QheIUKjMq3gJV
         ctgJZvtNEiadoYJBbck1+Z4BjgCxKcDewHUNXEgEBbQsCW+lnk/6YH5Uuc2suARVUHba
         Pbqq0b0TMlmPv4r+E4eKU5QhbJEXhLWHpe+WQ=
Received: by 10.231.35.70 with SMTP id o6mr8157758ibd.92.1278609302828;
        Thu, 08 Jul 2010 10:15:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm32603085ibb.14.2010.07.08.10.15.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 10:15:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100708103552.GF31048@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150587>

Some Posix-style shells (e.g., ash and dash) always interpret
escape sequences with echo, even when not asked with -e.  This
can cause problems when printing arbitrary user-specified strings
(e.g., commit messages with '\n' in them); it is much safer to
use printf "%s\n".

This patch changes uses of echo to use printf where they seem
likely to cause a problem.  Safe uses of echo are left un-converted
to avoid unnecessary code churn.

A few hyphens in git command names snuck away in the process.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Miklos Vajna wrote:
> On Wed, Jul 07, 2010 at 05:29:29PM -0700, Junio C Hamano <gitster@pob=
ox.com> wrote:

>> If I recall, the script had
>> liberal use of "echo $var"; some implementations of echo interprets
>> backslash sequence without being asked with an explicit "-e".
>
> Possibly, I just have the bash builtin and the coreutils echo here, b=
oth
> are writing \t properly without -e.

=E2=80=98dash=E2=80=99 might be good for testing.

Speaking of testing, the following is just a demonstration, not even
tested as far as "sh -n".

Patch applies to maint.  A series meant for application would probably
consist of more than one patch: first fix die() in git-sh-setup, then
the known problem in rebase --interactive, then the rest which is
harder to test.

Thoughts?

 contrib/ciabot/ciabot.sh                   |    8 +++---
 contrib/examples/git-clone.sh              |   14 ++++++------
 contrib/examples/git-fetch.sh              |   12 +++++-----
 contrib/examples/git-merge.sh              |    7 +----
 contrib/examples/git-notes.sh              |    2 +-
 contrib/examples/git-resolve.sh            |    2 +-
 contrib/examples/git-revert.sh             |   10 ++++----
 contrib/fast-import/git-import.sh          |    4 +-
 contrib/git-resurrect.sh                   |    4 +-
 contrib/hooks/post-receive-email           |    4 +-
 contrib/remotes2config.sh                  |    2 +-
 contrib/thunderbird-patch-inline/appp.sh   |   24 ++++++++++----------
 contrib/workdir/git-new-workdir            |    4 +-
 git-am.sh                                  |   10 ++++----
 git-bisect.sh                              |    8 +++---
 git-filter-branch.sh                       |   15 ++++++-------
 git-instaweb.sh                            |   26 ++++++++++++--------=
--
 git-merge-octopus.sh                       |   10 ++++----
 git-merge-one-file.sh                      |   24 ++++++++++----------
 git-mergetool--lib.sh                      |   31 ++++++++++++++------=
-------
 git-mergetool.sh                           |   16 +++++++-------
 git-parse-remote.sh                        |    4 +-
 git-quiltimport.sh                         |   26 ++++++++++++++------=
---
 git-rebase--interactive.sh                 |   22 ++++++++++----------
 git-rebase.sh                              |   24 ++++++++++----------
 git-repack.sh                              |    2 +-
 git-request-pull.sh                        |    9 ++-----
 git-sh-setup.sh                            |   10 ++++----
 git-stash.sh                               |    6 ++--
 git-submodule.sh                           |   24 ++++++++++++--------=
-
 git-web--browse.sh                         |    6 ++--
 templates/hooks--commit-msg.sample         |    2 +-
 templates/hooks--prepare-commit-msg.sample |    2 +-
 test-sha1.sh                               |   14 ++++++------
 34 files changed, 197 insertions(+), 191 deletions(-)

diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index eb87bba..25961fd 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -144,10 +144,10 @@ rev=3D$(git describe ${merged} 2>/dev/null)
 # for spammers' address harvesters - getting this wrong
 # would make the freenode #commits channel into harvester heaven.
 rawcommit=3D$(git cat-file commit ${merged})
-author=3D$(echo "$rawcommit" | sed -n -e '/^author .*<\([^@]*\).*$/s--=
\1-p')
-logmessage=3D$(echo "$rawcommit" | sed -e '1,/^$/d' | head -n 1)
-logmessage=3D$(echo "$logmessage" | sed 's/\&/&amp\;/g; s/</&lt\;/g; s=
/>/&gt\;/g')
-ts=3D$(echo "$rawcommit" | sed -n -e '/^author .*> \([0-9]\+\).*$/s--\=
1-p')
+author=3D$(printf "%s\n" "$rawcommit" | sed -n -e '/^author .*<\([^@]*=
\).*$/s--\1-p')
+logmessage=3D$(printf "%s\n" "$rawcommit" | sed -e '1,/^$/d' | head -n=
 1)
+logmessage=3D$(printf "%s\n" "$logmessage" | sed 's/\&/&amp\;/g; s/</&=
lt\;/g; s/>/&gt\;/g')
+ts=3D$(printf "%s\n" "$rawcommit" | sed -n -e '/^author .*> \([0-9]\+\=
).*$/s--\1-p')
 files=3D$(git diff-tree -r --name-only ${merged} | sed -e '1d' -e 's-.=
*-<file>&</file>-')
=20
 out=3D"
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone=
=2Esh
index 547228e..e85ccda 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -28,7 +28,7 @@ use-separate-remote  compatibility, do not use
 no-separate-remote   compatibility, do not use"
=20
 die() {
-	echo >&2 "$@"
+	printf >&2 '%s\n' "$@"
 	exit 1
 }
=20
@@ -226,9 +226,9 @@ else
 	if test -f "$repo"
 	then
 		# Cloning from a bundle
-		dir=3D$(echo "$repo" | sed -e 's|/*\.bundle$||' -e 's|.*/||g')
+		dir=3D$(printf '%s\n' "$repo" | sed -e 's|/*\.bundle$||' -e 's|.*/||=
g')
 	else
-		dir=3D$(echo "$repo" |
+		dir=3D$(printf '%s\n' "$repo" |
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
 fi
@@ -280,7 +280,7 @@ then
 	if test -n "$ref_git"
 	then
 		ref_git=3D$(cd "$ref_git" && pwd)
-		echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
+		printf '%s/objects\n' "$ref_git" >"$GIT_DIR/objects/info/alternates"
 		(
 			GIT_DIR=3D"$ref_git" git for-each-ref \
 				--format=3D'%(objectname) %(*objectname)'
@@ -308,7 +308,7 @@ yes)
 	if test "$local_shared" =3D yes
 	then
 		mkdir -p "$GIT_DIR/objects/info"
-		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
+		printf '%s/objects\n' "$repo" >>"$GIT_DIR/objects/info/alternates"
 	else
 		cpio_quiet_flag=3D""
 		cpio --help 2>&1 | grep -- --quiet >/dev/null && \
@@ -329,7 +329,7 @@ yes)
 				l=3Dl
 			elif test -n "$local_explicitly_asked_for"
 			then
-				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
+				printf >&2 'Warning: -l asked but cannot hardlink to %s\n' "$repo"
 			fi
 		fi &&
 		cd "$repo" &&
@@ -366,7 +366,7 @@ yes)
 		    do
 			case "$alt" in 'bad alternate: '*) die "$alt";; esac
 			case "$quiet" in
-			'')	echo >&2 "Getting alternate: $alt" ;;
+			'')	printf >&2 'Getting alternate: %s\n' "$alt" ;;
 			esac
 			rsync $quiet -av --ignore-existing  \
 			    --exclude info "$alt" "$GIT_DIR/objects" || exit
diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch=
=2Esh
index e44af2c..4b61edf 100755
--- a/contrib/examples/git-fetch.sh
+++ b/contrib/examples/git-fetch.sh
@@ -163,19 +163,19 @@ fi
=20
 fetch_all_at_once () {
=20
-  eval=3D$(echo "$1" | git fetch--tool parse-reflist "-")
+  eval=3D$(printf '%s\n' "$1" | git fetch--tool parse-reflist "-")
   eval "$eval"
=20
     ( : subshell because we muck with IFS
       IFS=3D" 	$LF"
       (
 	if test "$remote" =3D . ; then
-	    git show-ref $rref || echo failed "$remote"
+	    git show-ref $rref || printf 'failed %s\n' "$remote"
 	elif test -f "$remote" ; then
 	    test -n "$shallow_depth" &&
 		die "shallow clone with bundle is not supported"
 	    git bundle unbundle "$remote" $rref ||
-	    echo failed "$remote"
+	    printf 'failed %s\n' "$remote"
 	else
 		if	test -d "$remote" &&
=20
@@ -207,9 +207,9 @@ fetch_all_at_once () {
 			    flags=3D"-v"
 			    ;;
 			esac
-			git-fetch-pack --thin $exec $keep $shallow_depth \
+			git fetch-pack --thin $exec $keep $shallow_depth \
 				$quiet $no_progress $flags "$remote" $rref ||
-			echo failed "$remote"
+			printf 'failed %s\n' "$remote"
 		fi
 	fi
       ) |
@@ -274,7 +274,7 @@ fetch_per_ref () {
 		git fetch--tool -s pick-rref "$remote_name" "-")
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		die "No such ref $remote_name at $remote"
-	  echo >&2 "Fetching $remote_name from $remote using $proto"
+	  printf >&2 '%s\n' "Fetching $remote_name from $remote using $proto"
 	  case "$quiet" in '') v=3D-v ;; *) v=3D ;; esac
 	  git-http-fetch $v -a "$head" "$remote" || exit
 	  ;;
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge=
=2Esh
index 8f617fc..16a86ca 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -144,7 +144,7 @@ merge_name () {
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
 	else
-		echo "$rh		commit '$remote'"
+		printf '%s\n' "$rh		commit '$remote'"
 	fi
 }
=20
@@ -529,10 +529,7 @@ if test "$squash" =3D t
 then
 	finish
 else
-	for remote
-	do
-		echo $remote
-	done >"$GIT_DIR/MERGE_HEAD"
+	printf '%s\n' "$@" >"$GIT_DIR/MERGE_HEAD"
 	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG"
 fi
=20
diff --git a/contrib/examples/git-notes.sh b/contrib/examples/git-notes=
=2Esh
index e642e47..a2725c2 100755
--- a/contrib/examples/git-notes.sh
+++ b/contrib/examples/git-notes.sh
@@ -88,7 +88,7 @@ edit)
 		core_editor=3D"$(git config core.editor)"
 		${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
 	else
-		echo "$MESSAGE" > "$MSG_FILE"
+		printf '%s\n' "$MESSAGE" >"$MSG_FILE"
 	fi
=20
 	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-res=
olve.sh
index 8f98142..89c675b 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -104,7 +104,7 @@ if [ $? -ne 0 ]; then
 	fi
 	result_tree=3D$(git write-tree) || exit 1
 fi
-result_commit=3D$(echo "$merge_msg" | git commit-tree $result_tree -p =
$head -p $merge)
+result_commit=3D$(printf '%s\n' "$merge_msg" | git commit-tree $result=
_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
 git update-ref -m "resolve $merge_name: In-index merge" \
 	HEAD "$result_commit" "$head"
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-reve=
rt.sh
index 49f0032..4ed5e23 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -100,7 +100,7 @@ revert)
 	echo
 	echo "This reverts commit $commit."
 	test "$rev" =3D "$commit" ||
-	echo "(original 'git revert' arguments: $@)"
+	printf '(original 'git revert' arguments: %s)\n' "$*"
 	base=3D$commit next=3D$prev
 	;;
=20
@@ -127,20 +127,20 @@ cherry-pick)
 	}'
=20
 	logmsg=3D`git show -s --pretty=3Draw --encoding=3D"$encoding" "$commi=
t"`
-	set_author_env=3D`echo "$logmsg" |
+	set_author_env=3D`printf '%s\n' "$logmsg" |
 	LANG=3DC LC_ALL=3DC sed -ne "$pick_author_script"`
 	eval "$set_author_env"
 	export GIT_AUTHOR_NAME
 	export GIT_AUTHOR_EMAIL
 	export GIT_AUTHOR_DATE
=20
-	echo "$logmsg" |
+	printf '%s\n' "$logmsg" |
 	sed -e '1,/^$/d' -e 's/^    //'
 	case "$replay" in
 	'')
 		echo "(cherry picked from commit $commit)"
 		test "$rev" =3D "$commit" ||
-		echo "(original 'git cherry-pick' arguments: $@)"
+		printf '(original 'git cherry-pick' arguments: %s)\n' "$*"
 		;;
 	esac
 	base=3D$prev next=3D$commit
@@ -177,7 +177,7 @@ Conflicts:
 	cherry-pick)
 		echo >&2 "You may choose to use the following when making"
 		echo >&2 "the commit:"
-		echo >&2 "$set_author_env"
+		printf >&2 '%s\n' "$set_author_env"
 	esac
 	exit 1
 }
diff --git a/contrib/fast-import/git-import.sh b/contrib/fast-import/gi=
t-import.sh
index 0ca7718..80b9ecf 100755
--- a/contrib/fast-import/git-import.sh
+++ b/contrib/fast-import/git-import.sh
@@ -28,8 +28,8 @@ $2
 MSGEOF
=20
 EOF
-	find * -type f|while read i;do
-		echo "M 100644 inline $i"
+	find * -type f|while read -r i;do
+		printf 'M 100644 inline %s\n' "$i"
 		echo data $(stat -c '%s' "$i")
 		cat "$i"
 		echo
diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index c364dda..b3179a8 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -159,7 +159,7 @@ if test -z "$candidates"; then
 	die "no candidates for $branch found$hint"
 fi
=20
-echo "** Candidates for $branch **"
+printf '%s\n' "** Candidates for $branch **"
 for cmt in $candidates; do
 	git --no-pager log --pretty=3Dtformat:"%ct:%h [%cr] %s" --abbrev-comm=
it -1 $cmt
 done \
@@ -176,5 +176,5 @@ elif ! git rev-parse --verify --quiet $new_name >/d=
ev/null; then
 else
 	printf "Most recent: "
 	git --no-pager log -1 --pretty=3Dtformat:"%h %s" $newest
-	echo "** $new_name already exists, doing nothing"
+	printf '%s\n' "** $new_name already exists, doing nothing"
 fi
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-rece=
ive-email
index 30ae63d..85abd23 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -491,8 +491,8 @@ generate_atag_email()
 		echo "    length  $(git cat-file -s $tagobject) bytes"
 		;;
 	esac
-	echo " tagged by  $tagger"
-	echo "        on  $tagged"
+	printf '%s\n' " tagged by  $tagger"
+	printf '%s\n' "        on  $tagged"
=20
 	echo ""
 	echo $LOGBEGIN
diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
index 1cda19f..42f2cd3 100755
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -26,7 +26,7 @@ if [ -d "$GIT_DIR"/remotes ]; then
 				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
 			fi ;;
 		*)
-			echo "git config $key "$value" $regex"
+			printf '%s\n' "git config $key "$value" $regex"
 			git config $key "$value" $regex || error=3D1 ;;
 		esac
 	done
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunder=
bird-patch-inline/appp.sh
index cc518f3..da70fb9 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -31,25 +31,25 @@ BODY=3D`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=3D`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=3D`sed -e '1,/^---$/d' "${PATCH}"`
=20
-CCS=3D`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp=
' \
+CCS=3D`printf '%s\n%s' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\=
)$/\1,/gp' \
 	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
=20
-echo "$SUBJECT" > $1
-echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
-echo "$SEP" >> $1
+printf '%s\n' "$SUBJECT" > $1
+printf 'Cc: %s\n' "$CCS" >> $1
+printf '%s\n' "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
+printf '%s\n' "$SEP" >> $1
=20
-echo "$CMT_MSG" >> $1
-echo "---" >> $1
+printf '%s\n' "$CMT_MSG" >> $1
+printf '---\n' >> $1
 if [ "x${BODY}x" !=3D "xx" ] ; then
-	echo >> $1
-	echo "$BODY" >> $1
-	echo >> $1
+	printf '\n' >> $1
+	printf '%s\n' "$BODY" >> $1
+	printf '\n' >> $1
 fi
-echo "$DIFF" >> $1
+printf '%s\n' "$DIFF" >> $1
=20
 LAST_DIR=3D`dirname "${PATCH}"`
=20
 grep -v "^LAST_DIR=3D" "${CONFFILE}" > "${CONFFILE}_"
-echo "LAST_DIR=3D${LAST_DIR}" >> "${CONFFILE}_"
+printf "LAST_DIR=3D%s\n' "${LAST_DIR}" >> "${CONFFILE}_"
 mv "${CONFFILE}_" "${CONFFILE}"
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-=
workdir
index 993cacf..3ebe688 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -1,12 +1,12 @@
 #!/bin/sh
=20
 usage () {
-	echo "usage:" $@
+	printf '%s\n' "$*"
 	exit 127
 }
=20
 die () {
-	echo $@
+	printf '%s\n' "$*"
 	exit 128
 }
=20
diff --git a/git-am.sh b/git-am.sh
index 1df5b04..b711e0e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -147,7 +147,7 @@ It does not apply to blobs recorded in its index."
 }
=20
 clean_abort () {
-	test $# =3D 0 || echo >&2 "$@"
+	test $# =3D 0 || printf >&2 '%s\n' "$*"
 	rm -fr "$dotest"
 	exit 1
 }
@@ -459,7 +459,7 @@ else
=20
 	# -i can and must be given when resuming; everything
 	# else is kept
-	echo " $git_apply_opt" >"$dotest/apply-opt"
+	printf ' %s\n' "$git_apply_opt" >"$dotest/apply-opt"
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
@@ -467,7 +467,7 @@ else
 	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
-	echo "$GIT_QUIET" >"$dotest/quiet"
+	printf '%s\n' "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
 	then
@@ -643,7 +643,7 @@ do
 		ADD_SIGNOFF=3D`
 		    test "$LAST_SIGNED_OFF_BY" =3D "$SIGNOFF" || {
 		    test '' =3D "$LAST_SIGNED_OFF_BY" && echo
-		    echo "$SIGNOFF"
+		    printf '%s\n' "$SIGNOFF"
 		}`
 	    else
 		ADD_SIGNOFF=3D
@@ -655,7 +655,7 @@ do
 		fi
 		if test '' !=3D "$ADD_SIGNOFF"
 		then
-			echo "$ADD_SIGNOFF"
+			printf '%s\n' "$ADD_SIGNOFF"
 		fi
 	    } >"$dotest/final-commit"
 	    ;;
diff --git a/git-bisect.sh b/git-bisect.sh
index 6e2acb8..26001c1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -139,7 +139,7 @@ bisect_start() {
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval" &&
-	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	printf 'git bisect start%s\n' "$orig_args" >>"$GIT_DIR/BISECT_LOG" ||=
 exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
@@ -158,7 +158,7 @@ bisect_write() {
 		*)		die "Bad bisect_write argument: $state" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
-	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
+	printf '%s\n' "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_=
LOG"
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_=
LOG"
 }
=20
@@ -365,14 +365,14 @@ bisect_run () {
=20
     while true
     do
-      echo "running $@"
+      printf 'running %s\n' "$*"
       "$@"
       res=3D$?
=20
       # Check for really bad run error.
       if [ $res -lt 0 -o $res -ge 128 ]; then
 	  echo >&2 "bisect run failed:"
-	  echo >&2 "exit code $res from '$@' is < 0 or >=3D 128"
+	  printf >&2 "exit code %d from '%s' is < 0 or >=3D 128\n" "$res" "$*=
"
 	  exit $res
       fi
=20
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 88fb0f0..34bca06 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -12,7 +12,7 @@
=20
 functions=3D$(cat << \EOF
 warn () {
-        echo "$*" >&2
+        printf '%s\n' "$*" >&2
 }
=20
 map()
@@ -22,7 +22,7 @@ map()
 	then
 		cat "$workdir/../map/$1"
 	else
-		echo "$1"
+		printf '%s\n' "$1"
 	fi
 }
=20
@@ -55,8 +55,7 @@ git_commit_non_empty_tree()
=20
 die()
 {
-	echo >&2
-	echo "$*" >&2
+	printf '\n%s\n' "$*" >&2
 	exit 1
 }
 EOF
@@ -303,7 +302,7 @@ while read commit parents; do
 			then
 				rm -f "$GIT_INDEX_FILE"
 			else
-				echo >&2 "$err"
+				printf >&2 '%s\n' "$err"
 				false
 			fi
 		}
@@ -373,7 +372,7 @@ then
 		sha1=3D$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
 		ancestor=3D$(git rev-list --simplify-merges -1 "$ref" "$@")
-		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
+		test "$ancestor" && map $ancestor >> "$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
=20
@@ -396,12 +395,12 @@ do
=20
 	case "$rewritten" in
 	'')
-		echo "Ref '$ref' was deleted"
+		printf "Ref '%s' was deleted\n" "$ref"
 		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
 			die "Could not delete $ref"
 	;;
 	$_x40)
-		echo "Ref '$ref' was rewritten"
+		printf "Ref '%s' was rewritten\n" "$ref"
 		if ! git update-ref -m "filter-branch: rewrite" \
 					"$ref" $rewritten $sha1 2>/dev/null; then
 			if test $(git cat-file -t "$ref") =3D tag; then
diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..abbd2bc 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -41,14 +41,14 @@ resolve_full_httpd () {
 	case "$httpd" in
 	*apache2*|*lighttpd*)
 		# ensure that the apache2/lighttpd command ends with "-f"
-		if ! echo "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
+		if ! printf '%s\n' "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
 		then
 			httpd=3D"$httpd -f"
 		fi
 		;;
 	esac
=20
-	httpd_only=3D"$(echo $httpd | cut -f1 -d' ')"
+	httpd_only=3D"$(printf '%s\n' $httpd | cut -f1 -d' ')"
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null 2>&=
1;; esac
 	then
 		full_httpd=3D$httpd
@@ -66,7 +66,8 @@ resolve_full_httpd () {
 			fi
 		done
=20
-		echo >&2 "$httpd_only not found. Install $httpd_only or use" \
+		printf >&2 '%s\n' \
+		     "$httpd_only not found. Install $httpd_only or use" \
 		     "--httpd to specify another httpd daemon."
 		exit 1
 	fi
@@ -90,7 +91,7 @@ start_httpd () {
 		pid=3D$!
=20
 		if test $? !=3D 0; then
-			echo "Could not execute http daemon $httpd."
+			printf 'Could not execute http daemon %s.\n' "$httpd"
 			exit 1
 		fi
=20
@@ -101,7 +102,7 @@ EOF
 	*)
 		$full_httpd "$fqgitdir/gitweb/httpd.conf"
 		if test $? !=3D 0; then
-			echo "Could not execute http daemon $httpd."
+			printf 'Could not execute http daemon %s.\n' "$httpd"
 			exit 1
 		fi
 		;;
@@ -291,8 +292,8 @@ EOF
=20
 	for mod in mime dir; do
 		if test -e $module_path/mod_${mod}.so; then
-			echo "LoadModule ${mod}_module " \
-			     "$module_path/mod_${mod}.so" >> "$conf"
+			printf 'LoadModule %s_module %s/mod_%s.so\n' \
+				"$mod" "$module_path" "$mod" >> "$conf"
 		fi
 	done
 	cat >> "$conf" <<EOF
@@ -320,17 +321,18 @@ EOF
 	else
 		# plain-old CGI
 		resolve_full_httpd
-		list_mods=3D$(echo "$full_httpd" | sed 's/-f$/-l/')
+		list_mods=3D$(printf '%s\n' "$full_httpd" | sed 's/-f$/-l/')
 		$list_mods | sane_grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		if test -f "$module_path/mod_cgi.so"
 		then
-			echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
+			printf 'LoadModule cgi_module %s/mod_cgi.so\n' \
+				"$module_path" >> "$conf"
 		else
 			$list_mods | grep 'mod_cgid\.c' >/dev/null 2>&1 || \
 			if test -f "$module_path/mod_cgid.so"
 			then
-				echo "LoadModule cgid_module $module_path/mod_cgid.so" \
-					>> "$conf"
+				printf 'LoadModule cgid_module %s/mod_cgid.so\n' \
+					"$module_path" >> "$conf"
 			else
 				echo "You have no CGI support!"
 				exit 2
@@ -420,7 +422,7 @@ webrick)
 	mongoose_conf
 	;;
 *)
-	echo "Unknown httpd specified: $httpd"
+	printf 'Unknown httpd specified: %s\n' "$httpd"
 	exit 1
 	;;
 esac
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 615753c..22aa379 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -9,7 +9,7 @@ LF=3D'
 '
=20
 die () {
-    echo >&2 "$*"
+    printf >&2 '%s\n' "$*"
     exit 1
 }
=20
@@ -66,7 +66,7 @@ do
=20
 	case "$LF$common$LF" in
 	*"$LF$SHA1$LF"*)
-		echo "Already up-to-date with $pretty_name"
+		printf 'Already up-to-date with %s\n' "$pretty_name"
 		continue
 		;;
 	esac
@@ -78,7 +78,7 @@ do
 		# tree as the intermediate result of the merge.
 		# We still need to count this as part of the parent set.
=20
-		echo "Fast-forwarding to: $pretty_name"
+		printf 'Fast-forwarding to: %s\n' "$pretty_name"
 		git read-tree -u -m $head $SHA1 || exit
 		MRC=3D$SHA1 MRT=3D$(git write-tree)
 		continue
@@ -86,13 +86,13 @@ do
=20
 	NON_FF_MERGE=3D1
=20
-	echo "Trying simple merge with $pretty_name"
+	printf 'Trying simple merge with %s\n' "$pretty_name"
 	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
 	next=3D$(git write-tree 2>/dev/null)
 	if test $? -ne 0
 	then
 		echo "Simple merge did not work, trying automatic merge."
-		git-merge-index -o git-merge-one-file -a ||
+		git merge-index -o git-merge-one-file -a ||
 		OCTOPUS_FAILURE=3D1
 		next=3D$(git write-tree 2>/dev/null)
 	fi
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index d067894..0d449c6 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -34,7 +34,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 "$1.." | "$1.$1" | "$1$1.")
 	if [ "$2" ]; then
-		echo "Removing $4"
+		printf 'Removing %s\n' "$4"
 	else
 		# read-tree checked that index matches HEAD already,
 		# so we know we do not have this path tracked.
@@ -59,10 +59,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	exec git update-index --add --cacheinfo "$6" "$2" "$4"
 	;;
 "..$3")
-	echo "Adding $4"
+	printf 'Adding %s\n' "$4"
 	if test -f "$4"
 	then
-		echo "ERROR: untracked $4 is overwritten by the merge."
+		printf 'ERROR: untracked %s is overwritten by the merge.\n' "$4"
 		exit 1
 	fi
 	git update-index --add --cacheinfo "$7" "$3" "$4" &&
@@ -74,11 +74,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 ".$3$2")
 	if [ "$6" !=3D "$7" ]; then
-		echo "ERROR: File $4 added identically in both branches,"
-		echo "ERROR: but permissions conflict $6->$7."
+		printf 'ERROR: File %s added identically in both branches.\n' "$4"
+		printf 'ERROR: but permissions conflict %s->%s.\n' "$6" "$7"
 		exit 1
 	fi
-	echo "Adding $4"
+	printf 'Adding %s\n' "$4"
 	git update-index --add --cacheinfo "$6" "$2" "$4" &&
 		exec git checkout-index -u -f -- "$4"
 	;;
@@ -90,11 +90,11 @@ case "${1:-.}${2:-.}${3:-.}" in
=20
 	case ",$6,$7," in
 	*,120000,*)
-		echo "ERROR: $4: Not merging symbolic link changes."
+		printf 'ERROR: %s: Not merging symbolic link changes.\n' "$4"
 		exit 1
 		;;
 	*,160000,*)
-		echo "ERROR: $4: Not merging conflicting submodule changes."
+		printf 'ERROR: %s: Not merging conflicting submodule changes.\n' "$4=
"
 		exit 1
 		;;
 	esac
@@ -102,7 +102,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	src2=3D`git-unpack-file $3`
 	case "$1" in
 	'')
-		echo "Added $4 in both, but differently."
+		printf 'Added %s in both, but differently.\n' "$4"
 		# This extracts OUR file in $orig, and uses git apply to
 		# remove lines that are unique to ours.
 		orig=3D`git-unpack-file $2`
@@ -115,7 +115,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		expr "$sz0" \< "$sz1" \* 2 >/dev/null || : >$orig
 		;;
 	*)
-		echo "Auto-merging $4"
+		printf 'Auto-merging %s\n' "$4"
 		orig=3D`git-unpack-file $1`
 		;;
 	esac
@@ -147,14 +147,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
=20
 	if [ $ret -ne 0 ]; then
-		echo "ERROR: $msg in $4"
+		printf 'ERROR: %s in %s\n' "$msg" "$4"
 		exit 1
 	fi
 	exec git update-index -- "$4"
 	;;
=20
 *)
-	echo "ERROR: $4: Not handling case $1 -> $2 -> $3"
+	printf 'ERROR: %s: Not handling case %s -> %s -> %s\n' "$4" "$1" "$2"=
 "$3"
 	;;
 esac
 exit 1
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 51dd0d6..a960595 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -23,7 +23,7 @@ translate_merge_tool_path () {
 		echo compare
 		;;
 	*)
-		echo "$1"
+		printf '%s\n' "$1"
 		;;
 	esac
 }
@@ -33,7 +33,7 @@ check_unchanged () {
 		status=3D0
 	else
 		while true; do
-			echo "$MERGED seems unchanged."
+			printf '%s seems unchanged.\n' "$MERGED"
 			printf "Was the merge successful? [y/n] "
 			read answer < /dev/tty
 			case "$answer" in
@@ -75,10 +75,10 @@ get_merge_tool_cmd () {
 		merge_tool=3D"$(get_merge_tool)"
 	fi
 	if diff_mode; then
-		echo "$(git config difftool.$merge_tool.cmd ||
-		        git config mergetool.$merge_tool.cmd)"
+		git config difftool.$merge_tool.cmd ||
+		        git config mergetool.$merge_tool.cmd
 	else
-		echo "$(git config mergetool.$merge_tool.cmd)"
+		git config mergetool.$merge_tool.cmd
 	fi
 }
=20
@@ -347,14 +347,14 @@ guess_merge_tool () {
 		tools=3D"$tools emerge vimdiff"
 		;;
 	esac
-	echo >&2 "merge tool candidates: $tools"
+	printf >&2 'merge tool candidates: %s\n' "$tools"
=20
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $tools
 	do
 		merge_tool_path=3D"$(translate_merge_tool_path "$i")"
 		if type "$merge_tool_path" > /dev/null 2>&1; then
-			echo "$i"
+			printf '%s\n' "$i"
 			return 0
 		fi
 	done
@@ -372,11 +372,12 @@ get_configured_merge_tool () {
 		merge_tool=3D$(git config merge.tool)
 	fi
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
-		echo >&2 "git config option $TOOL_MODE.tool set to unknown tool: $me=
rge_tool"
-		echo >&2 "Resetting to default..."
+		printf >&2 'git config option %s.tool set to unknown tool: %s\n' \
+			"$TOOL_MODE" "$merge_tool"
+		printf >&2 'Resetting to default...\n'
 		return 1
 	fi
-	echo "$merge_tool"
+	printf '%s\n' "$merge_tool"
 }
=20
 get_merge_tool_path () {
@@ -387,7 +388,7 @@ get_merge_tool_path () {
 		merge_tool=3D"$(get_merge_tool)"
 	fi
 	if ! valid_tool "$merge_tool"; then
-		echo >&2 "Unknown merge tool $merge_tool"
+		printf >&2 'Unknown merge tool %s\n' "$merge_tool"
 		exit 1
 	fi
 	if diff_mode; then
@@ -401,11 +402,11 @@ get_merge_tool_path () {
 	fi
 	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
 	! type "$merge_tool_path" > /dev/null 2>&1; then
-		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
-		         "'$merge_tool_path'"
+		printf >&2 "The %s tool %s is not available as '%s'\n" \
+			"$TOOL_MODE" "$merge_tool" "$merge_tool_path"
 		exit 1
 	fi
-	echo "$merge_tool_path"
+	printf '%s\n' "$merge_tool_path"
 }
=20
 get_merge_tool () {
@@ -415,5 +416,5 @@ get_merge_tool () {
 	if test -z "$merge_tool"; then
 		merge_tool=3D"$(guess_merge_tool)" || exit
 	fi
-	echo "$merge_tool"
+	printf '%s\n' "$merge_tool"
 }
diff --git a/git-mergetool.sh b/git-mergetool.sh
index b52a741..97442ce 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -51,7 +51,7 @@ describe_file () {
     if test -z "$mode"; then
 	echo "deleted"
     elif is_symlink "$mode" ; then
-	echo "a symbolic link -> '$(cat "$file")'"
+	printf "a symbolic link -> '%s'\n" "$(cat "$file")"
     else
 	if base_present; then
 	    echo "modified"
@@ -126,9 +126,9 @@ merge_file () {
     f=3D$(git ls-files -u -- "$MERGED")
     if test -z "$f" ; then
 	if test ! -f "$MERGED" ; then
-	    echo "$MERGED: file not found"
+	    printf '%s: file not found\n' "$MERGED"
 	else
-	    echo "$MERGED: file does not need merging"
+	    printf '%s: file does not need merging\n' "$MERGED"
 	fi
 	return 1
     fi
@@ -151,7 +151,7 @@ merge_file () {
     remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
=20
     if test -z "$local_mode" -o -z "$remote_mode"; then
-	echo "Deleted merge conflict for '$MERGED':"
+	printf "Deleted merge conflict for '%s':\n" "$MERGED"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_deleted_merge
@@ -159,14 +159,14 @@ merge_file () {
     fi
=20
     if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symbolic link merge conflict for '$MERGED':"
+	printf "Symbolic link merge conflict for '%s':\n" "$MERGED"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_symlink_merge
 	return
     fi
=20
-    echo "Normal merge conflict for '$MERGED':"
+    printf "Normal merge conflict for '%s':\n" "$MERGED"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" =3D true; then
@@ -181,7 +181,7 @@ merge_file () {
     fi
=20
     if ! run_merge_tool "$merge_tool" "$present"; then
-	echo "merge of $MERGED failed" 1>&2
+	printf "merge of %s failed\n" "MERGED" 1>&2
 	mv -- "$BACKUP" "$MERGED"
=20
 	if test "$merge_keep_temporaries" =3D "false"; then
@@ -271,7 +271,7 @@ if test $# -eq 0 ; then
 	echo "No files need merging"
 	exit 0
     fi
-    echo Merging the files: "$files"
+    printf 'Merging the files: %s\n' "$files"
     git ls-files -u |
     sed -e 's/^[^	]*	//' |
     sort -u |
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..357392a 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -32,10 +32,10 @@ get_remote_url () {
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "$1"
+		printf '%s\n' "$1"
 		;;
 	self)
-		echo "$1"
+		printf '%s\n' "$1"
 		;;
 	config)
 		git config --get "remote.$1.url"
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..a4754d3 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -48,7 +48,7 @@ fi
 # Quilt patch directory
 : ${QUILT_PATCHES:=3Dpatches}
 if ! [ -d "$QUILT_PATCHES" ] ; then
-	echo "The \"$QUILT_PATCHES\" directory does not exist."
+	printf 'The "%s" directory does not exist.\n' "$QUILT_PATCHES"
 	exit 1
 fi
=20
@@ -77,14 +77,14 @@ do
 	case "$garbage" in
 	''|'#'*);;
 	*)
-		echo "trailing garbage found in series file: $garbage"
+		printf 'trailing garbage found in series file: %s\n' "$garbage"
 		exit 1;;
 	esac
 	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
-		echo "$patch_name doesn't exist. Skipping."
+		printf '%s doesn't exist. Skipping.\n' "$patch_name"
 		continue
 	fi
-	echo $patch_name
+	printf '%s\n' "$patch_name"
 	git mailinfo "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
 	test -s "$tmp_patch" || {
@@ -101,17 +101,17 @@ do
 			GIT_AUTHOR_NAME=3D"$quilt_author_name";
 			GIT_AUTHOR_EMAIL=3D"$quilt_author_email";
 		elif [ -n "$dry_run" ]; then
-			echo "No author found in $patch_name" >&2;
+			printf 'No author found in %s\n' "$patch_name" >&2;
 			GIT_AUTHOR_NAME=3D"dry-run-not-found";
 			GIT_AUTHOR_EMAIL=3D"dry-run-not-found";
 		else
-			echo "No author found in $patch_name" >&2;
+			printf 'No author found in %s\n' "$patch_name" >&2;
 			echo "---"
 			cat $tmp_msg
 			printf "Author: ";
-			read patch_author
+			read -r patch_author
=20
-			echo "$patch_author"
+			printf '%s\n' "$patch_author"
=20
 			patch_author_name=3D$(expr "z$patch_author" : 'z\(.*[^ ]\) *<.*') &=
&
 			patch_author_email=3D$(expr "z$patch_author" : '.*<\([^>]*\)') &&
@@ -125,13 +125,19 @@ do
 	SUBJECT=3D$(sed -ne 's/Subject: //p' "$tmp_info")
 	export GIT_AUTHOR_DATE SUBJECT
 	if [ -z "$SUBJECT" ] ; then
-		SUBJECT=3D$(echo $patch_name | sed -e 's/.patch$//')
+		SUBJECT=3D$(printf '%s\n' "$patch_name" | sed -e 's/.patch$//')
 	fi
=20
 	if [ -z "$dry_run" ] ; then
 		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
 		tree=3D$(git write-tree) &&
-		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tre=
e $tree -p $commit) &&
+		commit=3D$(
+				{
+					printf '%s\n\n' "$SUBJECT"
+					cat "$tmp_msg"
+				} |
+				git commit-tree $tree -p $commit
+			) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done 3<"$QUILT_PATCHES/series"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..67bbce9 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -119,7 +119,7 @@ run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
=20
 warn () {
-	echo "$*" >&2
+	printf '%s\n' "$*" >&2
 }
=20
 output () {
@@ -509,7 +509,7 @@ do_next () {
 		mark_action_done
 		update_squash_messages $squash_style $sha1
 		author_script=3D$(get_author_ident_from_commit HEAD)
-		echo "$author_script" > "$AUTHOR_SCRIPT"
+		printf '%s\n' "$author_script" > "$AUTHOR_SCRIPT"
 		eval "$author_script"
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
@@ -606,7 +606,7 @@ skip_unnecessary_picks () {
 			fd=3D1
 			;;
 		esac
-		echo "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
+		printf '%s\n' "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
@@ -649,12 +649,12 @@ rearrange_squash () {
 		case " $used" in
 		*" $sha1 "*) continue ;;
 		esac
-		echo "$pick $sha1 $message"
+		printf '%s %s %s\n' "$pick" "$sha1" "$message"
 		while read squash action msg
 		do
 			case "$message" in
 			"$msg"*)
-				echo "$action $squash $action! $msg"
+				printf '%s\n' "$action $squash $action! $msg"
 				used=3D"$used$squash "
 				;;
 			esac
@@ -676,7 +676,7 @@ parse_onto () {
 			?*"$LF"?* | '')
 				exit 1 ;;
 			esac
-			echo "$onto"
+			printf '%s\n' "$onto"
 			exit 0
 		fi
 	esac
@@ -848,7 +848,7 @@ first and then run 'git rebase --continue' again."
 		*)
 			: >"$DOTEST"/rebase-root ;;
 		esac
-		echo $ONTO > "$DOTEST"/onto
+		printf '%s\n' "$ONTO" > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t =3D "$VERBOSE" && : > "$DOTEST"/verbose
 		if test t =3D "$PRESERVE_MERGES"
@@ -858,12 +858,12 @@ first and then run 'git rebase --continue' again.=
"
 				mkdir "$REWRITTEN" &&
 				for c in $(git merge-base --all $HEAD $UPSTREAM)
 				do
-					echo $ONTO > "$REWRITTEN"/$c ||
+					printf '%s\n' "$ONTO" > "$REWRITTEN"/$c ||
 						die "Could not init rewritten commits"
 				done
 			else
 				mkdir "$REWRITTEN" &&
-				echo $ONTO > "$REWRITTEN"/root ||
+				printf '%s\n' "$ONTO" > "$REWRITTEN"/root ||
 					die "Could not init rewritten commits"
 			fi
 			# No cherry-pick because our first pass is to determine
@@ -894,7 +894,7 @@ first and then run 'git rebase --continue' again."
 		do
 			if test t !=3D "$PRESERVE_MERGES"
 			then
-				echo "pick $shortsha1 $rest" >> "$TODO"
+				printf 'pick %s %s\n' "$shortsha1" "$rest" >> "$TODO"
 			else
 				sha1=3D$(git rev-parse $shortsha1)
 				if test -z "$REBASE_ROOT"
@@ -913,7 +913,7 @@ first and then run 'git rebase --continue' again."
 				if test f =3D "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
-					echo "pick $shortsha1 $rest" >> "$TODO"
+					printf 'pick %s %s\n' "$shortsha1" "$rest" >> "$TODO"
 				fi
 			fi
 		done
diff --git a/git-rebase.sh b/git-rebase.sh
index 44f5c65..5867866 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -403,7 +403,7 @@ fi
 diff=3D$(git diff-index --cached --name-status -r --ignore-submodules =
HEAD --)
 case "$diff" in
 ?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
-	echo >&2 "$diff"
+	printf >&2 '%s\n' "$diff"
 	exit 1
 	;;
 esac
@@ -519,7 +519,7 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "Changes from $mb to $onto:"
+		printf 'Changes from %s to %s:\n' "$mb" "$onto"
 	fi
 	# We want color (if set), but no pager
 	GIT_PAGER=3D'' git diff --stat --summary "$mb" "$onto"
@@ -549,10 +549,10 @@ then
 	move_to_original_branch
 	ret=3D$?
 	test 0 !=3D $ret -a -d "$GIT_DIR"/rebase-apply &&
-		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
-		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head &&
-		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
+		printf '%s\n' "$head_name" > "$GIT_DIR"/rebase-apply/head-name &&
+		printf '%s\n' "$onto" > "$GIT_DIR"/rebase-apply/onto &&
+		printf '%s\n' "$orig_head" > "$GIT_DIR"/rebase-apply/orig-head &&
+		printf '%s\n' "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
 	exit $ret
 fi
=20
@@ -560,13 +560,13 @@ fi
 # this is rename-aware if the recursive (default) strategy is used
=20
 mkdir -p "$dotest"
-echo "$onto" > "$dotest/onto"
-echo "$onto_name" > "$dotest/onto_name"
+printf '%s\n' "$onto" > "$dotest/onto"
+printf '%s\n' "$onto_name" > "$dotest/onto_name"
 prev_head=3D$orig_head
-echo "$prev_head" > "$dotest/prev_head"
-echo "$orig_head" > "$dotest/orig-head"
-echo "$head_name" > "$dotest/head-name"
-echo "$GIT_QUIET" > "$dotest/quiet"
+printf '%s\n' "$prev_head" > "$dotest/prev_head"
+printf '%s\n' "$orig_head" > "$dotest/orig-head"
+printf '%s\n' "$head_name" > "$dotest/head-name"
+printf '%s\n' "$GIT_QUIET" > "$dotest/quiet"
=20
 msgnum=3D0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..f1fb309 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -132,7 +132,7 @@ then
 		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
 		for file in $rollback_failure
 		do
-			echo >&2 "WARNING:   old-$file -> $file"
+			printf >&2 'WARNING:   old-%s -> %s\n' "$file"
 		done
 	fi
 	exit 1
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 8fd15f6..fd1fb31 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -56,11 +56,9 @@ branch=3D$(git ls-remote "$url" \
 	}")
 url=3D$(get_remote_url "$url")
 if [ -z "$branch" ]; then
-	echo "warn: No branch of $url is at:" >&2
+	printf 'warn: No branch of %s is at:\n' "$url" >&2
 	git log --max-count=3D1 --pretty=3D'tformat:warn:   %h: %s' $headrev =
>&2
-	echo "warn: Are you sure you pushed $head there?" >&2
-	echo >&2
-	echo >&2
+	printf 'warn: Are you sure you pushed %s there?\n\n\n' "$head" >&2
 	branch=3D..BRANCH.NOT.VERIFIED..
 	status=3D1
 fi
@@ -70,8 +68,7 @@ git show -s --format=3D'The following changes since c=
ommit %H:
   %s (%ci)
=20
 are available in the git repository at:' $baserev
-echo "  $url $branch"
-echo
+printf '  %s %s\n\n' "$url" "$branch"
=20
 git shortlog ^$baserev $headrev
 git diff -M --stat --summary $patch $merge_base..$headrev
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..97e08cd 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -31,7 +31,7 @@ git_broken_path_fix () {
 				path=3D"$path$sep$elem"
 				sep=3D:
 			done
-			echo "$path"
+			printf '%s\n' "$path"
 		)
 		;;
 	esac
@@ -40,7 +40,7 @@ git_broken_path_fix () {
 # @@BROKEN_PATH_FIX@@
=20
 die() {
-	echo >&2 "$@"
+	printf >&2 '%s\n' "$*"
 	exit 1
 }
=20
@@ -64,7 +64,7 @@ if test -n "$OPTIONS_SPEC"; then
 		parseopt_extra=3D"--keep-dashdash"
=20
 	eval "$(
-		echo "$OPTIONS_SPEC" |
+		printf '%s\n' "$OPTIONS_SPEC" |
 			git rev-parse --parseopt $parseopt_extra -- "$@" ||
 		echo exit $?
 	)"
@@ -85,7 +85,7 @@ $LONG_USAGE"
=20
 	case "$1" in
 		-h|--h|--he|--hel|--help)
-		echo "$LONG_USAGE"
+		printf '%s\n' "$LONG_USAGE"
 		exit
 	esac
 fi
@@ -135,7 +135,7 @@ is_bare_repository () {
 cd_to_toplevel () {
 	cdup=3D$(git rev-parse --show-toplevel) &&
 	cd "$cdup" || {
-		echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+		printf >&2 'Cannot chdir to %s, the toplevel of the working tree\n" =
"$cdup"
 		exit 1
 	}
 }
diff --git a/git-stash.sh b/git-stash.sh
index 0f858d3..afe6351 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -150,8 +150,8 @@ save_stash () {
 			break
 			;;
 		-*)
-			echo "error: unknown option for 'stash save': $1"
-			echo "       To provide a message, use git stash save -- '$1'"
+			printf "error: unknown option for 'stash save': %s\n" "$1"
+			printf "       To provide a message, use git stash save -- '%s'\n" =
"$1"
 			usage
 			;;
 		*)
@@ -414,7 +414,7 @@ create)
 	then
 		shift
 	fi
-	create_stash "$*" && echo "$w_commit"
+	create_stash "$*" && printf '%s\n' "$w_commit"
 	;;
 drop)
 	shift
diff --git a/git-submodule.sh b/git-submodule.sh
index 3319b83..8efbc9b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,7 +50,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl/${url%/}"
+	printf '%s\n' "$remoteurl/${url%/}"
 }
=20
 #
@@ -75,7 +75,7 @@ module_name()
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'=
"
-       echo "$name"
+       printf '%s\n' "$name"
 }
=20
 #
@@ -163,7 +163,7 @@ cmd_add()
 	path=3D$2
=20
 	if test -z "$path"; then
-		path=3D$(echo "$repo" |
+		path=3D$(printf '%s\n' "$repo" |
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
=20
@@ -206,7 +206,8 @@ cmd_add()
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			echo "Adding existing repo at '$path' to the index"
+			printf "Adding existing repo at '%s' to the index\n" \
+				"$path"
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
@@ -583,10 +584,10 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status name
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status =3D D -o $status =3D T && echo "$name" && continue
+			test $status =3D D -o $status =3D T && printf '%s\n' "$name" && con=
tinue
 			# Also show added or modified modules which are checked out
 			GIT_DIR=3D"$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
-			echo "$name"
+			printf '%s\n' "$name"
 		done
 	)
=20
@@ -662,18 +663,21 @@ cmd_summary() {
 		then
 			if test $mod_dst =3D 160000
 			then
-				echo "* $name $sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$tota=
l_commits:"
+				printf '* %s %s(blob)->%s(submodule)%d:\n' \
+					"$name" "$sha1_abbr_src" "$sha1_abbr_dst" "$total_commits"
 			else
-				echo "* $name $sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$tota=
l_commits:"
+				printf '* %s %s(submodule)->%s(blob)%d:\n' \
+					"$name" "$sha1_abbr_src" "$sha1_abbr_dst" "$total_commits"
 			fi
 		else
-			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
+			printf '* %s %s->%s%d:\n' \
+				"$name" "$sha1_abbr_src" "$sha1_abbr_dst" "$total_commits"
 		fi
 		if test -n "$errmsg"
 		then
 			# Don't give error msg for modification whose dst is not submodule
 			# i.e. deleted or changed to blob
-			test $mod_dst =3D 160000 && echo "$errmsg"
+			test $mod_dst =3D 160000 && printf '%s\n' "$errmsg"
 		else
 			if test $mod_src =3D 160000 -a $mod_dst =3D 160000
 			then
diff --git a/git-web--browse.sh b/git-web--browse.sh
index a578c3a..72b11db 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -95,8 +95,8 @@ then
 	test -z "$browser" || break
     done
     if test -n "$browser" && ! valid_tool "$browser"; then
-	echo >&2 "git config option $opt set to unknown browser: $browser"
-	echo >&2 "Resetting to default..."
+	printf >&2 'git config option %s set to unknown browser: %s\n' "$opt"=
 "$browser"
+	printf >&2 'Resetting to default...\n'
 	unset browser
     fi
 fi
@@ -150,7 +150,7 @@ case "$browser" in
 	case "$(basename "$browser_path")" in
 	    konqueror)
 		# It's simpler to use kfmclient to open a new tab in konqueror.
-		browser_path=3D"$(echo "$browser_path" | sed -e 's/konqueror$/kfmcli=
ent/')"
+		browser_path=3D"$(printf '%s\n' "$browser_path" | sed -e 's/konquero=
r$/kfmclient/')"
 		type "$browser_path" > /dev/null 2>&1 || die "No '$browser_path' fou=
nd."
 		eval "$browser_path" newTab "$@"
 		;;
diff --git a/templates/hooks--commit-msg.sample b/templates/hooks--comm=
it-msg.sample
index b58d118..b462353 100755
--- a/templates/hooks--commit-msg.sample
+++ b/templates/hooks--commit-msg.sample
@@ -13,7 +13,7 @@
 # hook is more suited to it.
 #
 # SOB=3D$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-=
by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# grep -qs "^$SOB" "$1" || printf '%s\n' "$SOB" >> "$1"
=20
 # This example catches duplicate Signed-off-by lines.
=20
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hoo=
ks--prepare-commit-msg.sample
index 86b8f22..9a79995 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -33,4 +33,4 @@ case "$2,$3" in
 esac
=20
 # SOB=3D$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-=
by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# grep -qs "^$SOB" "$1" || printf '%s\n' "$SOB" >> "$1"
diff --git a/test-sha1.sh b/test-sha1.sh
index 0f0bc5d..4843d77 100755
--- a/test-sha1.sh
+++ b/test-sha1.sh
@@ -8,18 +8,18 @@ do
 	case "$expect" in '#'*) continue ;; esac
 	actual=3D`
 		{
-			test -z "$pfx" || echo "$pfx"
+			test -z "$pfx" || printf '%s\n' "$pfx"
 			dd if=3D/dev/zero bs=3D1048576 count=3D$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
 		} | ./test-sha1 $cnt
 	`
 	if test "$expect" =3D "$actual"
 	then
-		echo "OK: $expect $cnt $pfx"
+		printf 'OK: %s %d %s\n' "$expect" "$cnt" "$pfx"
 	else
-		echo >&2 "OOPS: $cnt"
-		echo >&2 "expect: $expect"
-		echo >&2 "actual: $actual"
+		printf >&2 'OOPS: %d\n' "$cnt"
+		printf >&2 'expect: %s\n' "$expect"
+		printf >&2 'actual: %s\n' "$actual"
 		exit 1
 	fi
 done <<EOF
@@ -53,13 +53,13 @@ while read cnt pfx
 do
 	actual=3D`
 		{
-			test -z "$pfx" || echo "$pfx"
+			test -z "$pfx" || printf '%s\n' "$pfx"
 			dd if=3D/dev/zero bs=3D1048576 count=3D$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
 		} | sha1sum |
 		sed -e 's/ .*//'
 	`
-	echo "$actual $cnt $pfx"
+	printf '%s %d %s\n' "$actual $cnt $pfx"
 done <<EOF
 0
 0 a
