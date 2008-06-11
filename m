From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
Date: Thu, 12 Jun 2008 01:03:55 +0200
Message-ID: <20080611230355.GE16439@artemis.madism.org>
References: <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806111030580.3101@woody.linux-foundation.org> <20080611222534.GC16439@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RE3pQJLXZi4fr8Xo";
	protocol="application/pgp-signature"; micalg=SHA1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZN7-00088R-Kt
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYFKXD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYFKXD6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:03:58 -0400
Received: from pan.madism.org ([88.191.52.104]:55770 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbYFKXD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:03:57 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1E9C3354B1;
	Thu, 12 Jun 2008 01:03:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 15AD616260; Thu, 12 Jun 2008 01:03:55 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
Content-Disposition: inline
In-Reply-To: <20080611222534.GC16439@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84680>


--RE3pQJLXZi4fr8Xo
Content-Type: multipart/mixed; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 10:25:34PM +0000, Pierre Habouzit wrote:
> On Wed, Jun 11, 2008 at 05:34:53PM +0000, Linus Torvalds wrote:
> >=20
> >=20
> > > > >   Quite often, when people commit, they have corrupt repositories=
=2E The
> > > > > symptom is a `cannot read <sha1>` error message (or many at times=
).
> >=20
> > Btw, do you have exact error messages?
>=20
>   Well, like said I don't have had the problem myself, and it's hard to
> reproduce, people have it like once a week average, for people that
> perform around 50 to 100 commits a week.

  I should say that the problem happens more often when people use the scri=
pt I
inlined in the end (this scripts does what git pull --rebase nowadays
does, with a dirty workdir, roughly, I'm not its author, the goal isn't
to discuss its lack of beauty or whatever, just to point out some
possible things that leads to the NFS issue).

  Next time something breaks, I'll be able to give you a log.

-------------------------------------
#!/bin/bash

OPTIONS_SPEC=3D
SUBDIRECTORY_OK=3Dt
=2E git-sh-setup
require_work_tree

case $# in
    0)
        branch=3Dorigin/$(git symbolic-ref HEAD|sed -e 's!refs/heads/!!')
        ;;
    1)
        branch=3D"$1"
        ;;
    *)
        echo 1>&2 "$(basename $0) [<branch>]"
        exit 1
        ;;
esac

if git rev-parse --verify HEAD > /dev/null &&
    git update-index --refresh &&
    git diff-files --quiet &&
    git diff-index --cached --quiet HEAD --
then
    NEED_TEMPO=3D
else
    NEED_TEMPO=3Dt
fi

git fetch
test -z "$NEED_TEMPO" || git commit -a -s -m'tempo'
git rebase "$branch"

if test -n "$NEED_TEMPO"; then
    if test  -d "$(dirname "$(git rev-parse --git-dir)")/.dotest"; then
        echo ""
echo "run 'git reset HEAD~1' when rebase is finished"
    else
        git reset HEAD~1
    fi
fi
-------------------------------------

  Also note that now people use an enhanced version of that script (the
one in attachment). It still breaks, but less often. I'm not sure it's
valuable information at all, but one never knows.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=git-up

#!/bin/sh

OPTIONS_SPEC="\
$(basename $0) [options] [<remote> [<branch>]]
--
k,gitk      visualize unmerged differences
r,rebase    perform a rebase
m,merge     perform a merge
"
SUBDIRECTORY_OK=t
. git-sh-setup
require_work_tree

lbranch=$(git symbolic-ref HEAD | sed -e s~refs/heads/~~)
remote=$(git config --get "branch.$lbranch.remote" || echo origin)
branch=$(git config --get "branch.$lbranch.merge" || echo "refs/heads/$lbranch")

case "$(git config --bool --get madcoder.up-gitk)" in
    true) gitk=gitk;;
    *)    gitk=:
esac
case "$(git config --bool --get "branch.$lbranch.rebase")" in
    true) action=rebase;;
    *)    action=;;
esac

while test $# != 0; do
    case "$1" in
        -k|--gitk)
            shift; gitk=gitk;;
        --no-gitk)
            shift; gitk=:;;
        -r|--rebase)
            shift; action=rebase;;
        --no-rebase)
            shift; rebase=${rebase#rebase};;
        -m|--merge)
            shift; action=merge;;
        --no-merge)
            shift; rebase=${rebase#merge};;
        --)
            shift; break;;
        *)
            usage;;
    esac
done

case $# in
    0) ;;
    1) remote="$1";;
    2) remote="$1"; branch="$2";;
    *) usage;;
esac

git fetch "${remote}"
if test `git rev-list .."${remote}/${branch#refs/heads/}" -- | wc -l` = 0; then
    echo "Current branch $lbranch is up to date."
    exit 0
fi

$gitk .."${remote}/${branch#refs/heads/}" --
if test -z "$action"; then
    echo -n "(r)ebase/(m)erge/(q)uit ? "
    read ans
    case "$ans" in
        r*) action=rebase;;
        m*) action=merge;;
        *)  exit 0;;
    esac
fi

unclean=
git rev-parse --verify HEAD > /dev/null && \
    git update-index --refresh && \
    git diff-files --quiet && \
    git diff-index --cached --quiet HEAD -- || unclean=t

case "$action" in
    rebase)
        test -z "$unclean" || git stash save "git-up stash"
        git rebase "${remote}/${branch#refs/heads/}"
        ;;
    merge)
        test -z "$unclean" || git stash save "git-up stash"
        git merge "${remote}/${branch#refs/heads/}"
        ;;
    *)
        echo 1>&2 "no action specified"
        exit 1
        ;;
esac

if test -n "$unclean"; then
    if test  -d "$(git rev-parse --git-dir)/../.dotest"; then
        echo ""
        echo "run 'git stash apply' when rebase is finished"
    else
        git stash apply
    fi
fi

--tMbDGjvJuJijemkf--

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhQWdsACgkQvGr7W6Hudhx9HgCeKqrKcG26YDAJXPKyuTCspLrN
1rAAn0uVmH/AjunAf0IVCqUHig/sNK2J
=YvL5
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
