Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A745041C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497935; cv=none; b=hYT3e4tGFeXmufyaEz5hyBws6/C9hmIc0CMTEtdwLneYOJOJgoHPqtu6g7R+RwJol6h/aW26c3DzQziM9HmsmoiBxnj6BYHHxsdvf1+/d6t2MjRfTuk4DRm6WVnbpnlaF70iFVK/wW2cyoYhoC7I4OaHDROnaxg93QITV36QmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497935; c=relaxed/simple;
	bh=s9DGJeVupMR5rZDetKxugxA/bmoynQl91vb3R2cZxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thLROGeVaigQOWXZCjZLFbxgXV0S8WhwzMHmpMsqLTrzJ/b97/XMUMXp1zD9ueX7C3Vj5FfpT0bYr4AqmwMmDZZmPTwyuJSYmeAUFAthyMvSYL4SatB+c4YUgBj6CD5/lEI4oJc9wokLT1ik1Gmcv3BkxZ/YNaBxWS/A0s5tAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R59QrNxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R59QrNxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CCC1F000FF;
	Thu,  8 Oct 2026 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497934;
	bh=BNFi/RdmQLQS9BVPGmlv2NW4HIf6DHVpT7GyMCfItGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R59QrNxCyj50yHo0a2nhStuwSTQxBtaovX3xwRIAn3yKIJUxuNPeQvyBPZ8PBOo8N
	 4kOHGrSoUb149Fe20RJyI1cGGi5T+MuUjohxf4HXJVnBCML5afdxqyr7qY1eww1PZr
	 EGtJON4A0dO0+T9IMd6YZqEPRTPLjTUw3hAWbpQg28Cha+z42g/wLt2IcJA52+yevj
	 r4KnQVH2PFBDlAaLrHl0oX04sMekkQhB7bDTSWGGDWsevIaoBNUN4OO3zfwDSmy6R9
	 d3HeBeVteVNKI7fBf/Vrd8chGabelP0UOEQaQs6vHLjXHHv4poIsLyAo14F18GFGna
	 SY5taPm2aoPxA==
Date: Fri, 9 Oct 2026 00:18:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: [RFC v3] git-bisect-rebase
Message-ID: <asgU5dr0Z3x5jN_f@debian>
References: <asFRVdMTpshsazgM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gd67gmeek7vp2yaz"
Content-Disposition: inline
In-Reply-To: <asFRVdMTpshsazgM@debian>


--gd67gmeek7vp2yaz
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="tnk4o2pmah4rn7p3"
Content-Disposition: inline
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: [RFC v3] git-bisect-rebase
Message-ID: <asgU5dr0Z3x5jN_f@debian>
References: <asFRVdMTpshsazgM@debian>
MIME-Version: 1.0
In-Reply-To: <asFRVdMTpshsazgM@debian>


--tnk4o2pmah4rn7p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've improved the usability of the script, thinking about two different
use cases:

-  Moving a single branch.
-  Moving a tree of branches.

For that, I've implemented --abort/--continue/--quit options, which are
similar to the options in git-rebase(1), but different in that they act
on the bisect-rebase operation, and not on a single rebase.

The --continue flag is useful for the case of rebasing a single tree,
not having to specify the target and flags each time.

The --quit flag is useful to maintain the ability to terminate the
bisect-rebase at the current point, having advanced the branch by some
distance.  This allows changing to other branches (descendants) that
will be moved together with the parent, to minimize conflict resolution.

I wrote in a different subthread the algorithms that would be used for
each of these two cases, but I'll paste them again here:

So, the usual algorithm for moving a tree would be (assuming A is
a branch with two descendants, B and C):

        $ git bisect-rebase master A;
        $ git rebase --abort;
        $ git bisect-rebase --quit;
        $ git bisect-rebase A B;
        ## ... until success
        $ git bisect-rebase A C;
        ## ... until success
        $ git tag tmpA;
        $ git bisect-rebase master A;
        ## resolve conflicts here
        $ git rebase --continue;
        $ git bisect-rebase --quit;
        $ git rebase --onto A tmpA B;
        $ git rebase --onto A tmpA C;
        $ git tag -d tmpA;
        ## ... rinse and repeat (goto first command, until no conflicts)

And the algorithm for moving a single branch would be simpler:

        $ git bisect-rebase master X;
        ## resolve conflicts here
        $ git rebase --continue;
        $ git bisect-rebase --continue;
        ## ... rinse and repeat (goto first command, until no conflicts)


The script has been split into 3 smaller scripts.  They are all
attached, but can be also found in the Linux man-pages repository
(alongside their history, which might clarify some design decisions):

<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/src/bin/g=
it-bisect-rebase>
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/src/bin/g=
it-bisect-rebase--callback>
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/src/bin/g=
it-bisect-rebase--continue>

Of course, the entry point is git-bisect-rebase, with the other two
being internal helpers.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--tnk4o2pmah4rn7p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=git-bisect-rebase

#!/bin/bash
# Copyright 2026, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

set -Eeufo pipefail;
shopt -s lastpipe;

err()
{
	>&2 printf '%s\n' "$(basename "$0"): error: $*";
	exit 1;
}

git rev-parse --git-dir | read -r git_dir;
git rev-parse --git-path bisect-rebase | read -r dir;

while test $# -ge 1; do
	case "$1" in
	--abort)
		test -d "$dir/" || err 'Not in a bisect-rebase operation?';
		set +e;
		git rebase --abort >/dev/null 2>/dev/null;
		git bisect reset >/dev/null 2>/dev/null;
		xargs git checkout <"$dir/head-name";
		xargs git reset --hard <"$dir/orig-head";
		rm -rf "$dir";
		exit 0;
		;;
	--continue)
		test -d "$dir/" || err 'Not in a bisect-rebase operation?';
		if test -d "$git_dir/rebase-merge"; then
			err 'You must finish the current rebase operation.';
		fi;
		git-bisect-rebase--continue;
		exit 0;
		;;
	--quit)
		test -d "$dir/" || err 'Not in a bisect-rebase operation?';
		if test -d "$git_dir/rebase-merge"; then
			err 'You must finish the current rebase operation.';
		fi;
		rm -rf "$dir";
		exit 0;
		;;
	*)
		break;
		;;
	esac;
done;

mkdir "$dir";
# shellcheck disable=SC2064  # we want expansion now
trap "rm -rf '$dir'" EXIT;

# shellcheck disable=SC2312  # False positive: <https://github.com/koalaman/shellcheck/issues/3554>
cat <<-'__EOF__' |
	git bisect-rebase [<option> ...] [<upstream> [<branch>]]

	Rebase <branch> on top of the first conflicting commit from <upstream>.
	--
	 Mode options
	abort!		Abort the bisect-rebase operation and reset HEAD to the original <branch>.
	continue!	Restart the bisect-rebase process after having resolved a particular rebase.
	quit!		Abort the bisect-rebase operation but HEAD is not reset.

	 Options
	pre-exec!=cmd	Run <cmd> before every git-rebase(1) operation.
	post-exec!=cmd	Run <cmd> after every git-rebase(1) operation.

	 git-rebase(1) options
	x,exec=cmd		See git-rebase(1).
	r,rebase-merges?	^
	apply!*			^
	empty!*=		^
	keep-empty*		^
	reapply-cherry-picks*	^
	allow-empty-message*	^
	m,merge!*		^
	s,strategy!*=		^
	X,strategy-option!*=	^
	rerere-autoupdate*	^
	S,gpg-sign*?		^
	q,quiet!*		^
	v,verbose!*		^
	stat!*			^
	n,no-stat!*		^
	verify*			^
	C!*=			^
	no-ff!*			^
	f,force-rebase!*	^
	ignore-whitespace*	^
	update-refs*		^

	 git-bisect(1) options
	first-parent!		See git-bisect(1).
__EOF__
eval "$(git rev-parse --parseopt --stuck-long --keep-dashdash -- "$@" || echo exit $?)";

touch "$dir/git-bisect-options";
touch "$dir/git-rebase-options";
while test $# -ge 1; do
	case "$1" in
	--abort | --continue | --quit)
		err "$1 is incompatible with other arguments.";
		;;
	--)
		shift;
		break;
		;;
	--pre-exec=*)
		echo "$1" | sed 's/--pre-exec=//' >"$dir/pre-exec";
		;;
	--post-exec=*)
		echo "$1" | sed 's/--post-exec=//' >"$dir/post-exec";
		;;
	--first-parent)
		echo "$1" >>"$dir/git-bisect-options";
		;;
	-*)
		echo "$1" >>"$dir/git-rebase-options";
		;;
	*)
		exit 1;  # Unreachable
		;;
	esac;
	shift;
done;

if test $# -lt 1; then
	git rev-parse '@{u}';
else
	git rev-parse --verify "$1";
fi >"$dir/onto";
test $# -lt 1 || shift;

if test $# -lt 1; then
	git rev-parse --abbrev-ref HEAD;
	git rev-parse HEAD;
else
	git rev-parse --verify --symbolic "$1";
	git rev-parse --verify "$1";
fi \
| sed '/^HEAD$/d' \
| sed '1!d' \
>"$dir/head-name";
test $# -lt 1 || shift;

if test $# -gt 0; then
	err 'Too many arguments.';
fi;

git rev-parse HEAD >"$dir/orig-head";

trap - EXIT;

git-bisect-rebase--continue;
exit 0;

--tnk4o2pmah4rn7p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=git-bisect-rebase--callback

#!/bin/bash
# Copyright 2026, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

set -Eeufo pipefail;
shopt -s lastpipe;

git rev-parse --git-dir | sed 's,$,/bisect-rebase,' | read -r dir;
# shellcheck disable=SC2064  # we want expansion now
trap "xargs git checkout --detach <'$dir/bisect-head' 2>/dev/null" EXIT;
git rev-parse HEAD >"$dir/bisect-head";

if test -e "$dir/pre-exec"; then
	printf '%s' 'Pre-rebase exec: ';
	if
		bash "$dir/pre-exec";
		x="$?";
		true;
	then
		echo "exit status: $x";
		if test "$x" -ne 0; then
			exit "$x";
		fi;
	fi;
fi;

xargs git checkout <"$dir/head-name" >/dev/null 2>/dev/null;
git rev-parse HEAD >"$dir/good-head";
printf '%s' 'Rebase: ';
cat "$dir/git-rebase-options" "$dir/bisect-head" \
| if xargs git rebase >/dev/null 2>/dev/null; then
	echo 'success';
else
	echo 'conflict';
	git rebase --abort >/dev/null;
	exit 1;
fi;

if test -e "$dir/post-exec"; then
	printf '%s' 'Post-rebase exec: ';
	if
		bash "$dir/post-exec";
		x="$?";
		true;
	then
		echo "exit status: $x";
		if test "$x" -ne 0; then
			xargs git reset --hard <"$dir/good-head";
			exit "$x";
		fi;
	fi;
fi;

{
	git rev-parse --abbrev-ref HEAD;
	git rev-parse HEAD;
} \
| sed '/^HEAD$/d' \
| sed '1!d' \
>"$dir/head-name";
exit 0;

--tnk4o2pmah4rn7p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=git-bisect-rebase--continue

#!/bin/bash
# Copyright 2026, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

set -Eeufo pipefail;
shopt -s lastpipe;

err()
{
	>&2 printf '%s\n' "$(basename "$0"): error: $*";
	exit 1;
}

git rev-parse --git-path bisect-rebase | read -r dir;

# Try the target first.
xargs git checkout --detach <"$dir/onto" 2>/dev/null;
if git-bisect-rebase--callback; then
	xargs git checkout <"$dir/head-name" >/dev/null 2>/dev/null;
	rm -rf "$dir";
	exit 0;
fi;

# Bisect.
xargs git bisect start <"$dir/git-bisect-options" >/dev/null;
xargs git bisect bad <"$dir/onto" >/dev/null;
cat "$dir/head-name" "$dir/onto" | xargs git merge-base | xargs git bisect good;
git bisect run git-bisect-rebase--callback;
git rev-parse bisect/bad >"$dir/bisect-bad";
git bisect reset >/dev/null 2>/dev/null;

# Perform the conflicting rebase
xargs git checkout <"$dir/head-name" >/dev/null 2>/dev/null;
cat "$dir/git-rebase-options" "$dir/bisect-bad" | xargs git rebase;
if test -e "$dir/post-exec"; then
	echo 'Running post-rebase exec.';
	bash "$dir/post-exec";
fi;

--tnk4o2pmah4rn7p3--

--gd67gmeek7vp2yaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrIFsIACgkQ64mZXMKQ
wqk0vRAAkAe7iB1yMqKmLvFMvB3wx8CgV/MboXS1iWDI4E7s2kltHFBNS8ieqOpU
a9VmRH4oaJq+VVY50gQJOxsUOk0iNmKx0WYT7i6TWQrjowJJhDWweuFOjppu6gSW
QAklFMaglFwkaenItGvCW9U230YK5Uom181/mwmQwtkdaBAXDfdwXnPDIyPeKV+U
ZDgI6t6vHYHgavXpDIXqfG2qlpEKnPxv9HefKX6Zi1BVh66DD/bPKp/pe2mToAJG
n/OOTrN4kJY/n3pANIzZnNbhjPZ9Rf+O1sVk1TGOEW+gn+umFNhw1OHufMrZGHIb
REAIDs7SzVgJmLsRrgMar8b25CxDvfcbMdMibbTaLyT/iBUyC2Hp/megsd5IawAt
ppBqUX1Jv/rNO4+3gEi6O2Y1o5Ckj/fdpXfXS2wUlvsbjppdJbJdjBVrTCSG1D6g
8Nu49cEsJVrktw3dvUgerDow76Xh7uAklmsTwlxqKAv+pcAU1kCpa0S3GZ8fEEFX
826Tke5HozMl3ZnsvEwUEfKjDlX9OgtDtES5UIsihPsLPULGHrllP7pv9nhdY1G3
QD3wNzO5v8QGuhGUi8vJjLHxHZsh+UHlRePZx/TPJsh0PrCh775DhjReQ8iYPVI/
N7r29ia6jI5eooapmYVlJmaTWm16ksztIWI0MeWi6PyExqnwG/s=
=Ypar
-----END PGP SIGNATURE-----

--gd67gmeek7vp2yaz--
