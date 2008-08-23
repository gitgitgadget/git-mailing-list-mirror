From: Robert Schiele <rschiele@gmail.com>
Subject: Re: complex cvs import
Date: Sat, 23 Aug 2008 11:12:16 +0200
Message-ID: <20080823091215.GJ11842@schiele.dyndns.org>
References: <48AEBB72.6060209@xmos.com>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfjLu832HdL/xSp1"
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpBV-0007U2-Mz
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYHWJMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYHWJMV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:12:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:62684 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYHWJMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:12:20 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1007520mue.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=60PR2cihmEXgiC8o+BLHQ35zvhPA2/pRR8q/d2LZiwg=;
        b=AtmDxm34+8Ikv+A1NtVjEmK9ErxZRdTJ8XQ3cPynlGVqAF3PEb7+/XjDKedbTDQOQq
         yPQ0TyMu1KiHf6+OIitgymTH+GE/9c96lJDEhFOhFcMFsmWn2fooLRIODUGN3ncdBWyw
         H+RQVHmoG6ggkQGXKce7Dlpl79ITJ7dsR4Mfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=KHMrA0LNU0yd7FA2rDfNGFI7n7iIljPaI1psj+YMcb5Skd/hDRIjFxyoqmxUJmk9Xv
         NLiBWwzhf1FP/8yIlArSRuHlIAu8EDGS8/soVw+HET5Zp9qijHjokhtKgRhU1HaA0HWl
         D6ckMPFyQtNvBXnWl9zlcKftSZ6n/P0rU+mFc=
Received: by 10.103.217.7 with SMTP id u7mr1299995muq.102.1219482738539;
        Sat, 23 Aug 2008 02:12:18 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.169])
        by mx.google.com with ESMTPS id j9sm12710664mue.3.2008.08.23.02.12.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 02:12:17 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 6B44216052; Sat, 23 Aug 2008 11:12:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48AEBB72.6060209@xmos.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93448>


--IfjLu832HdL/xSp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2008 at 02:13:22PM +0100, Luis Gutierrez wrote:
> Hi All,
>
> During the past year or so we have been using a bastardized version of CV=
S=20
> in which branches were not 'true' cvs branches, but just a copy of the=20
> original data in a different folder. For instance, we would have somethin=
g=20
> like this:
>
> ProjectX
>   \---- dev01
>   |       \... normal cvs data
>   \---- dev02
>   |       \... normal cvs data
>   \---- release01
>   |       \... normal cvs data
>   \---- release02
>           \... normal cvs data
>
> While a timeline of the branches looks like this:
>
>                /---release01
> ----dev01------+                /---release02
>                \---dev02------+--
>
> Now that we are trying to move to git, and I'm having problems importing=
=20
> the projects with their full history.

I solved a similar situation about one year ago with the following script:

------
#!/bin/bash

set -eux

CVSREPOS=3D/path/to/cvs
REPOSDIR=3D~/gitmigration
export TMPDIR=3D$(TMPDIR=3D/dev/shm mktemp -d)

cvsimport()
{
    if [ "$2" ]; then
    GBR=3D$1_tmp
    cd $TMPDIR/checkout
    git branch $1_tmp $2
    else
    GBR=3Dmaster
    fi
    git cvsimport -a -k -d $CVSREPOS -C $TMPDIR/checkout -i -A <(
    cat <<EOF
user1=3DOne User <user.one@example.com>
user2=3DTwo User <user.two@example.com>
EOF
    ) -o $GBR $1
    cd $TMPDIR/checkout
    git tag -d $3
    git branch -D $4
    git branch -m $GBR $1
}

rm -rf ~/.cvsps
cvs -d $CVSREPOS rtag -D '2002-06-07 20:41:34 +0000' rel1fork mainbranch
cvs -d $CVSREPOS rtag -D '2004-09-22 18:11:45 +0000' rel2fork rel1branch
cvs -d $CVSREPOS rtag -D '2003-10-22 20:44:21 +0000' rel3fork rel1branch
cvs -d $CVSREPOS rtag -D '2006-03-27 21:07:23 +0000' rel4fork rel3branch
cvs -d $CVSREPOS rtag -D '2005-10-28 22:00:18 +0000' rel5fork rel3branch
cvsimport mainbranch ''       fooxtag fooxbranch
cvsimport rel1branch rel1fork fooytag fooybranch
cvsimport rel2branch rel2fork fooztag foozbranch
cvsimport rel3branch rel3fork sometag somebranch
cvsimport rel4branch rel4fork inittag initbranch
cvsimport rel5branch rel5fork bartag  barbranch
cd $TMPDIR/checkout
git branch -m rel3branch master
rm -rf $REPOSDIR
git clone --bare $TMPDIR/checkout $REPOSDIR
touch $REPOSDIR/git-daemon-export-ok
echo 'My description' > $REPOSDIR/description
cat <<EOF >> $REPOSDIR/config
        sharedrepository =3D 2
[receive]
        denyNonFastforwards =3D true
EOF
find $REPOSDIR -type f -print0 | xargs -0 chmod g+u
find $REPOSDIR -type d -print0 | xargs -0 chmod g+u,g+s
cd /
rm -rf $TMPDIR
------

Some explanations:

1. If people start a new repository in cvs they often do so with cvs import
   (since this is the way it is documented) but don't use the created branch
   and tag at all.  Because of that cvsimport (the one from the script)
   removes them after importing.

2. The script requires the points in the tree to be tagged where you branch=
ed
   of one of your "special" cvs branches.  If you already have tags for that
   you are fine, otherwise you need to "reverse engineer" that place and tag
   this in cvs with something like

   cvs -d $CVSREPOS rtag -D '2004-09-22 18:11:45 +0000' rel2fork rel1branch

   which means rel2branch was forked off from rel1branch at point rel2fork

3. Now you import all the "special" branches with commands like

   cvsimport mainbranch ''       fooxtag fooxbranch
   cvsimport rel1branch rel1fork fooytag fooybranch

   The imports need to be in topological order of the branch dependencies.
   Thus you start with the oldest branch that exists in your cvs (mainbranc=
h).

   Parameters are:

   - Branch to import.

   - Tag where this branch was forked off (or empty for main branch).

   - Tag that was created by cvs import and will be deleted after import.

   - Branch that was created by cvs import and will be deleted after import.

4. There is a line

   git branch -m rel3branch master

   in the script that is supposed to rename your "main" branch to master
   (since this a convention in git).  This is technically not required and
   might make no sense depending on your workflow.

I hope this is useful for you.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--IfjLu832HdL/xSp1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIr9RvxcDFxyGNGNcRAqrCAKDUpwMrE55xBO6aLZtbK14C4JIiTACgqe7L
23UZn/tuEy7MfMM5p+UmPb8=
=4HWM
-----END PGP SIGNATURE-----

--IfjLu832HdL/xSp1--
