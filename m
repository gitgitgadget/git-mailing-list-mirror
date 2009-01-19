From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] contrib: add 'git bpush' to push to bundles
Date: Tue, 20 Jan 2009 00:46:31 +0100
Message-ID: <1232408791-16834-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 00:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3qv-0006jj-Qo
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbZASXqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 18:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZASXqy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:46:54 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:59339 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbZASXqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:46:52 -0500
Received: by bwz14 with SMTP id 14so9657629bwz.13
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 15:46:50 -0800 (PST)
Received: by 10.103.248.17 with SMTP id a17mr552589mus.97.1232408809994;
        Mon, 19 Jan 2009 15:46:49 -0800 (PST)
Received: from localhost (p5B0D718A.dip.t-dialin.net [91.13.113.138])
        by mx.google.com with ESMTPS id 14sm7313494muo.39.2009.01.19.15.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 15:46:48 -0800 (PST)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106411>

'git bpush' updates the branches in a bundle, while adding the objects
necessary to complete the given branches. Basically, it is a 'git push'
for bundles.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 contrib/bpush/git-bpush            |  195 ++++++++++++++++++++++++++++=
++++++++
 contrib/bpush/git-bpush.txt        |   68 +++++++++++++
 contrib/bpush/t5519-bundle-push.sh |  193 ++++++++++++++++++++++++++++=
+++++++
 contrib/bpush/t5519/expect.10      |    4 +
 contrib/bpush/t5519/expect.11      |    4 +
 contrib/bpush/t5519/expect.12      |    7 ++
 contrib/bpush/t5519/expect.13      |    4 +
 contrib/bpush/t5519/expect.14      |    4 +
 contrib/bpush/t5519/expect.15      |    4 +
 contrib/bpush/t5519/expect.16      |    4 +
 contrib/bpush/t5519/expect.17      |    5 +
 contrib/bpush/t5519/expect.18      |    6 +
 contrib/bpush/t5519/expect.19      |    6 +
 contrib/bpush/t5519/expect.2       |    4 +
 contrib/bpush/t5519/expect.3       |    3 +
 contrib/bpush/t5519/expect.4       |    4 +
 contrib/bpush/t5519/expect.5       |    5 +
 contrib/bpush/t5519/expect.6       |    5 +
 contrib/bpush/t5519/expect.7       |    5 +
 contrib/bpush/t5519/expect.8       |    5 +
 contrib/bpush/t5519/expect.9       |    4 +
 21 files changed, 539 insertions(+), 0 deletions(-)
 create mode 100755 contrib/bpush/git-bpush
 create mode 100644 contrib/bpush/git-bpush.txt
 create mode 100755 contrib/bpush/t5519-bundle-push.sh
 create mode 100644 contrib/bpush/t5519/expect.10
 create mode 100644 contrib/bpush/t5519/expect.11
 create mode 100644 contrib/bpush/t5519/expect.12
 create mode 100644 contrib/bpush/t5519/expect.13
 create mode 100644 contrib/bpush/t5519/expect.14
 create mode 100644 contrib/bpush/t5519/expect.15
 create mode 100644 contrib/bpush/t5519/expect.16
 create mode 100644 contrib/bpush/t5519/expect.17
 create mode 100644 contrib/bpush/t5519/expect.18
 create mode 100644 contrib/bpush/t5519/expect.19
 create mode 100644 contrib/bpush/t5519/expect.2
 create mode 100644 contrib/bpush/t5519/expect.3
 create mode 100644 contrib/bpush/t5519/expect.4
 create mode 100644 contrib/bpush/t5519/expect.5
 create mode 100644 contrib/bpush/t5519/expect.6
 create mode 100644 contrib/bpush/t5519/expect.7
 create mode 100644 contrib/bpush/t5519/expect.8
 create mode 100644 contrib/bpush/t5519/expect.9

diff --git a/contrib/bpush/git-bpush b/contrib/bpush/git-bpush
new file mode 100755
index 0000000..a004c42
--- /dev/null
+++ b/contrib/bpush/git-bpush
@@ -0,0 +1,195 @@
+#!/bin/sh
+
+OPTIONS_KEEPDASHDASH=3D
+OPTIONS_SPEC=3D"\
+git bpush [options] [<remote> [<refs>...]]
+--
+f,force   force updates
+full      create a full bundle
+v         be verbose
+"
+SUBDIRECTORY_OK=3DYes
+. git-sh-setup
+. git-parse-remote
+
+cd_to_toplevel
+
+LF=3D'
+'
+IFS=3D"$LF"
+
+bases=3D
+bbases=3D
+changed=3D
+force=3D
+nonff=3D
+remote=3D
+refs=3D
+while :
+do
+	case "$1" in
+	-v)
+		verbose=3Dt ;;
+	--full)
+		full=3Dt ;;
+	-f|--force)
+		force=3Dt ;;
+	--)
+		shift
+		break ;;
+	*)
+		usage ;;
+	esac
+	shift
+done
+
+test -n "$1" && remote=3D$1 && shift
+refs=3D"$*"
+
+test -z "$remote" && remote=3D$(get_default_remote)
+remoteurl=3D$(git config remote.${remote}.url)
+test -z "$remoteurl" && remoteurl=3D$remote
+test -d "$remoteurl" && die "$remoteurl is a directory"
+
+# Default bases in bundle.base
+# Default {refs,base} can be specified in remote.<remote>.{push,bundle=
base}
+if test "$remote" !=3D "$remoteurl"
+then
+	test -z "$refs" &&
+	refs=3D$(git config --get-all remote.${remote}.push)
+	bases=3D$(git config --get-all remote.${remote}.bundlebase ||
+		git config --get-all bundle.base)
+else
+	bases=3D$(git config --get-all bundle.base)
+fi
+
+# git rev-parse --symbolic-full-name resolves symlinks
+# Keep at least HEAD
+head=3D
+for ref in $refs ; do
+	test "$ref" =3D HEAD && head=3Dt && break
+done
+
+test -n "$bases" && bases=3D$(git rev-parse --revs-only $bases | sort =
-u)
+
+# Full symbolic refs need to be uniq
+test -n "$refs" &&
+refs=3D$(git-rev-parse --symbolic-full-name --revs-only $refs | sort -=
u)
+
+test -n "$head" && refs=3D"HEAD$LF$refs"
+
+if test -e "$remoteurl"
+then
+	blines=3D$(git bundle verify "$remoteurl" 2>/dev/null) ||
+	die "Verification of \"$remoteurl\" failed"
+	# Find the bundle's bases
+	refs=3D"$refs$LF$(git bundle list-heads $remoteurl | cut -d " " -f 2)=
"
+	requires=3D
+	for line in $blines
+	do
+		case "$requires,$line" in
+		",The bundle requires"*)
+			requires=3Dt ;;
+		t,) ;;
+		t,*)
+			bbase=3D$(echo $line | cut -d " " -f 1)
+			bbases=3D"$bbases$LF$bbase"
+			;;
+		esac
+	done
+	bases=3D"$bases$LF$bbases"
+elif test -z "$refs" ; then
+	# Push current branch
+	refs=3D"HEAD$LF$(git symbolic-ref -q HEAD)"
+fi
+
+test -z "$refs" && die "No refs to push"
+
+refs=3D$(echo "$refs" | sort -u)
+
+for ref in $bases $refs
+do
+	test "$(git cat-file -t $ref^{})" !=3D commit &&
+	die "$(basename $0): $ref is not a commit"
+done
+
+header=3D"To $remoteurl"
+test -n "$verbose" && echo "Pushing to $remoteurl" && echo $header && =
header=3D
+
+# Find what is/is not a fast-forward, up to date or new
+# As "git bundle" does not support refspecs we must push all matching =
branches
+for ref in $refs ; do
+	text=3D
+	bchanged=3D
+	case $ref in
+	refs/tags/*)
+		bshort=3D$(echo $ref | sed -e "s|^refs/tags/||")
+		newtext=3D"new tag";;
+	refs/heads/*|HEAD)
+		bshort=3D$(echo $ref | sed -e "s|^refs/heads/||")
+		newtext=3D"new branch" ;;
+	esac
+	newhash=3D$(git rev-parse $ref) || die "Ref $ref not valid"
+	newshort=3D$(git rev-parse --short $ref)
+	bheads=3D
+	test -e "$remoteurl" && bheads=3D"$(git bundle list-heads $remoteurl)=
"
+	for bhead in $bheads
+	do
+		bhash=3D$(echo $bhead | cut -d " " -f 1)
+		bref=3D$(echo $bhead | cut -d " " -f 2)
+		# Find the matching ref in the bundle
+		test "$bref" !=3D "$ref" && continue
+		oldshort=3D$(git rev-parse --short $bhash)
+		mergebase=3D
+		case $ref in
+		refs/tags/*)
+			# Only test if it is different
+			mergebase=3D$newhash;;
+		refs/heads/*|HEAD)
+			mergebase=3D$(git merge-base $bref $bhash);;
+		esac
+		case $newhash,$bhash,$mergebase,$force in
+		$bhash,$newhash,*)
+			# No changes
+			text=3D" =3D [up to date] $bshort -> $bshort"
+			;;
+		*,*,$bhash,*)
+			# Fast-forward
+			bchanged=3Dt
+			text=3D"   $oldshort..$newshort $bshort -> $bshort"
+			;;
+		*,t)
+			# Forced non fast-forward
+			bchanged=3Dt
+			text=3D" + $oldshort...$newshort $bshort -> $bshort (forced update)=
"
+			;;
+		*)
+			bchanged=3Dt
+			nonff=3Dt
+			text=3D" ! [rejected] $bshort -> $bshort (non-fast forward)"
+		esac
+		break
+	done
+	test -z "$text" && text=3D" * [$newtext] $bshort -> $bshort" && bchan=
ged=3Dt
+	if test -n "$bchanged" || test -n "$verbose"
+	then
+		test -n "$header" && echo $header && header=3D
+		echo $text
+	fi
+	test -n "$bchanged" && changed=3Dt
+done
+
+# Recreate the bundle if --full and the current bundle is not full
+test -n "$full" && bases=3D && test -n "$bbases" && changed=3Dt
+
+test -n "$nonff" && die "error: failed to push some refs to $remoteurl=
"
+test -z "$changed" && die "Everything up-to-date"
+test -n "$bases" && bases=3D"--not$LF$bases"
+
+git bundle create $remoteurl $refs $bases ||
+die "Cannot create bundle \"$remoteurl\""
+
+test "$remote" !=3D "$remoteurl" && { git fetch -q "$remote" ||
+	die "Error fetch from bundle \"$remoteurl\"" ; }
+
+exit 0
diff --git a/contrib/bpush/git-bpush.txt b/contrib/bpush/git-bpush.txt
new file mode 100644
index 0000000..a045c91
--- /dev/null
+++ b/contrib/bpush/git-bpush.txt
@@ -0,0 +1,68 @@
+git-bpush(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-bpush - Update bundles along with associated objects
+
+SYNOPSIS
+--------
+[verse]
+'git bpush' [--full] [--force] [<bundle> <refs>...]
+
+DESCRIPTION
+-----------
+
+'git bpush' updates the branches in a bundle, while adding the objects
+necessary to complete the given branches. Basically, it is a 'git push=
'
+for bundles.
+
+By default, if the bundle does not exist a full bundle is create with =
the
+current branch, and if it does exist it updates all the branches in it
+appending all the needed objects.
+
+OPTIONS
+-------
+<bundle>::
+	Equal to the <repository> parameter of 'git push' but pointing
+	to a local path.
+
+<refs>::
+	A list of branches to push
+
+--full::
+	Create a bundle with all the needed object even if the existing
+	bundle is not full.
+
+--force::
+	Equivalent to the '--force' flag to 'git push'.
+
+CONFIG VARIABLES
+----------------
+branch.<name>.remote::
+remote.<name>.url::
+remote.<name>.push::
+	With the same meaning but the URL should be a local path and the
+	'push' config should list only branches, not refspecs.
+
+remote.<name>.bundlebase::
+bundle.base::
+	Default base to create a new bundle (per remote or global).
+
+SEE ALSO
+--------
+linkgit:git-diff[1]
+
+linkgit:git-config[1]
+
+AUTHOR
+------
+Written by Santi B=C3=A9jar <santi@agolina.net>.
+
+Documentation
+--------------
+Documentation by Santi B=C3=A9jar.
+
+GIT
+---
+Part of the contrib section of the linkgit:git[1] suite
diff --git a/contrib/bpush/t5519-bundle-push.sh b/contrib/bpush/t5519-b=
undle-push.sh
new file mode 100755
index 0000000..464f32f
--- /dev/null
+++ b/contrib/bpush/t5519-bundle-push.sh
@@ -0,0 +1,193 @@
+#!/bin/sh
+
+test_description=3D'Bundle pushing'
+
+. ./test-lib.sh
+
+other=3D
+
+mk_test () {
+	num=3D$(( $num + 1 )) &&
+	actual=3Dactual.$num &&
+	expect=3D"$TEST_DIRECTORY"/t5519/expect.$num &&
+	expect_other=3D"$TEST_DIRECTORY"/t5519/expect.$other &&
+	git bundle verify b.bundle > "$actual" &&
+	if test -f "$expect"
+	then
+		if [ -n "$other" ] ; then
+			test_cmp "$expect_other" "$actual"
+		else
+			true
+		fi &&
+		test_cmp "$expect" "$actual" &&
+		rm -f "$actual"
+	else
+		# this is to help developing new tests.
+		cp "$actual" "$expect"
+		false
+	fi
+}
+
+test_expect_success setup '
+
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -a -m repo &&
+	the_first_commit=3D$(git show-ref -s --verify refs/heads/master) &&
+	git branch b1 &&
+	git tag t1 &&
+
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -a -m second &&
+	the_second_commit=3D$(git show-ref -s --verify refs/heads/master) &&
+	git branch b2 &&
+	git tag t2 &&
+
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -a -m third &&
+	the_third_commit=3D$(git show-ref -s --verify refs/heads/master) &&
+	git branch b3 &&
+	git tag t3 &&
+
+	git reset --hard b2 &&
+	: >path4 &&
+	git add path4 &&
+	test_tick &&
+	git commit -a -m fourth &&
+	the_fourth_commit=3D$(git show-ref -s --verify refs/heads/master) &&
+	git branch b4 &&
+	git tag t4 &&
+
+	num=3D1
+'
+
+test_expect_success 'full bundle' '
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'full bundle with 1 branch' '
+	rm b.bundle &&
+	git bpush b.bundle b2 &&
+	mk_test
+'
+
+test_expect_success 'full bundle with 2 branches' '
+	rm b.bundle &&
+	git bpush b.bundle b2 master &&
+	mk_test
+'
+
+test_expect_success 'bundle with 1 commit as base' '
+	rm b.bundle &&
+	git config bundle.base $the_first_commit
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'bundle with 1 branch as base' '
+	rm b.bundle &&
+	other=3D$num &&
+	git config bundle.base b1
+	git bpush b.bundle &&
+	mk_test
+'
+test_expect_success 'bundle with 1 tag as base' '
+	rm b.bundle &&
+	git config bundle.base t1
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'bundle with 1 sha1 expression as base' '
+	rm b.bundle &&
+	git config bundle.base t2^
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'Force a full bundle' '
+	git bpush --full b.bundle &&
+	other=3D2 &&
+	mk_test
+
+'
+unset other
+git config --unset bundle.base
+
+test_expect_success 'updating bundle: initial' '
+	rm b.bundle &&
+	git reset --hard b1 &&
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'updating bundle: update' '
+	git reset --hard b2 &&
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'updating bundle with extra branches' '
+	git bpush b.bundle b2 b3 b4 &&
+	mk_test
+'
+
+test_expect_success 'Deny non fast forward: initial' '
+	rm b.bundle &&
+	git reset --hard b3 &&
+	git bpush b.bundle &&
+	mk_test
+'
+
+test_expect_success 'Deny non fast-fordard: denied' '
+	git reset --hard b4 &&
+	test_must_fail git bpush b.bundle &&
+	other=3D$num &&
+	mk_test
+'
+
+test_expect_success 'Deny non fast-fordard: force' '
+	git bpush --force b.bundle &&
+	other=3D2
+	mk_test
+'
+
+git config remote.b.url b.bundle
+
+test_expect_success 'pushing to a <remote>' '
+	rm b.bundle &&
+	git bpush b &&
+	other=3D2
+	mk_test
+'
+
+unset other
+
+test_expect_success 'remote with remote.<remote>.push' '
+	git config remote.b.push b4 &&
+	git bpush b &&
+	mk_test
+'
+
+test_expect_success 'remote with multiple remote.<remote>.push' '
+	git config --add remote.b.push b3 &&
+	git bpush b &&
+	mk_test
+'
+
+test_expect_success 'cancel bases in remote.<remote>.bundlebase' '
+	rm b.bundle &&
+	git config --add remote.b.push HEAD &&
+	git config remote.b.bundlebase "" &&
+	git config bundle.base t1 &&
+	git bpush b &&
+	mk_test
+'
+
+test_done
diff --git a/contrib/bpush/t5519/expect.10 b/contrib/bpush/t5519/expect=
=2E10
new file mode 100644
index 0000000..f16f35f
--- /dev/null
+++ b/contrib/bpush/t5519/expect.10
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+b9c09d6cc74d3857142fb7c082dca65b88254c6d HEAD
+b9c09d6cc74d3857142fb7c082dca65b88254c6d refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.11 b/contrib/bpush/t5519/expect=
=2E11
new file mode 100644
index 0000000..23b288f
--- /dev/null
+++ b/contrib/bpush/t5519/expect.11
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f HEAD
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.12 b/contrib/bpush/t5519/expect=
=2E12
new file mode 100644
index 0000000..583c759
--- /dev/null
+++ b/contrib/bpush/t5519/expect.12
@@ -0,0 +1,7 @@
+The bundle contains 5 refs
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f HEAD
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f refs/heads/b2
+0c61b881205ba69f6b78d3fdd45db054d236eea8 refs/heads/b3
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/b4
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.13 b/contrib/bpush/t5519/expect=
=2E13
new file mode 100644
index 0000000..fb1c2a7
--- /dev/null
+++ b/contrib/bpush/t5519/expect.13
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+0c61b881205ba69f6b78d3fdd45db054d236eea8 HEAD
+0c61b881205ba69f6b78d3fdd45db054d236eea8 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.14 b/contrib/bpush/t5519/expect=
=2E14
new file mode 100644
index 0000000..fb1c2a7
--- /dev/null
+++ b/contrib/bpush/t5519/expect.14
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+0c61b881205ba69f6b78d3fdd45db054d236eea8 HEAD
+0c61b881205ba69f6b78d3fdd45db054d236eea8 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.15 b/contrib/bpush/t5519/expect=
=2E15
new file mode 100644
index 0000000..9047296
--- /dev/null
+++ b/contrib/bpush/t5519/expect.15
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.16 b/contrib/bpush/t5519/expect=
=2E16
new file mode 100644
index 0000000..9047296
--- /dev/null
+++ b/contrib/bpush/t5519/expect.16
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.17 b/contrib/bpush/t5519/expect=
=2E17
new file mode 100644
index 0000000..14c8713
--- /dev/null
+++ b/contrib/bpush/t5519/expect.17
@@ -0,0 +1,5 @@
+The bundle contains 3 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/b4
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.18 b/contrib/bpush/t5519/expect=
=2E18
new file mode 100644
index 0000000..dd8682b
--- /dev/null
+++ b/contrib/bpush/t5519/expect.18
@@ -0,0 +1,6 @@
+The bundle contains 4 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+0c61b881205ba69f6b78d3fdd45db054d236eea8 refs/heads/b3
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/b4
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.19 b/contrib/bpush/t5519/expect=
=2E19
new file mode 100644
index 0000000..dd8682b
--- /dev/null
+++ b/contrib/bpush/t5519/expect.19
@@ -0,0 +1,6 @@
+The bundle contains 4 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+0c61b881205ba69f6b78d3fdd45db054d236eea8 refs/heads/b3
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/b4
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.2 b/contrib/bpush/t5519/expect.=
2
new file mode 100644
index 0000000..9047296
--- /dev/null
+++ b/contrib/bpush/t5519/expect.2
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.3 b/contrib/bpush/t5519/expect.=
3
new file mode 100644
index 0000000..3b476c7
--- /dev/null
+++ b/contrib/bpush/t5519/expect.3
@@ -0,0 +1,3 @@
+The bundle contains 1 ref
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f refs/heads/b2
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.4 b/contrib/bpush/t5519/expect.=
4
new file mode 100644
index 0000000..59c144c
--- /dev/null
+++ b/contrib/bpush/t5519/expect.4
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f refs/heads/b2
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
diff --git a/contrib/bpush/t5519/expect.5 b/contrib/bpush/t5519/expect.=
5
new file mode 100644
index 0000000..ba77351
--- /dev/null
+++ b/contrib/bpush/t5519/expect.5
@@ -0,0 +1,5 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 1 ref
+b9c09d6cc74d3857142fb7c082dca65b88254c6d repo
diff --git a/contrib/bpush/t5519/expect.6 b/contrib/bpush/t5519/expect.=
6
new file mode 100644
index 0000000..ba77351
--- /dev/null
+++ b/contrib/bpush/t5519/expect.6
@@ -0,0 +1,5 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 1 ref
+b9c09d6cc74d3857142fb7c082dca65b88254c6d repo
diff --git a/contrib/bpush/t5519/expect.7 b/contrib/bpush/t5519/expect.=
7
new file mode 100644
index 0000000..ba77351
--- /dev/null
+++ b/contrib/bpush/t5519/expect.7
@@ -0,0 +1,5 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 1 ref
+b9c09d6cc74d3857142fb7c082dca65b88254c6d repo
diff --git a/contrib/bpush/t5519/expect.8 b/contrib/bpush/t5519/expect.=
8
new file mode 100644
index 0000000..ba77351
--- /dev/null
+++ b/contrib/bpush/t5519/expect.8
@@ -0,0 +1,5 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 1 ref
+b9c09d6cc74d3857142fb7c082dca65b88254c6d repo
diff --git a/contrib/bpush/t5519/expect.9 b/contrib/bpush/t5519/expect.=
9
new file mode 100644
index 0000000..9047296
--- /dev/null
+++ b/contrib/bpush/t5519/expect.9
@@ -0,0 +1,4 @@
+The bundle contains 2 refs
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 HEAD
+2d4a0f4bd0a1c33802f2f3417f5a999dff37f9d7 refs/heads/master
+The bundle requires these 0 ref
--=20
1.6.1.258.g7ff14
