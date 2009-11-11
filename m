From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 20:34:12 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1257968052.26362.155.camel@heerbeest>
References: <1257945756.26362.79.camel@heerbeest>
	 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	 <1257965806.26362.132.camel@heerbeest>
	 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8IxW-0001NC-4f
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651AbZKKTeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 14:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758622AbZKKTeO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:34:14 -0500
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:57932 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758594AbZKKTeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:34:14 -0500
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 4C37D67C59;
	Wed, 11 Nov 2009 20:34:18 +0100 (CET)
Received: from [127.0.0.1] (heerbeest [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id D1D9ADC1AC;
	Wed, 11 Nov 2009 20:34:12 +0100 (CET)
In-Reply-To: <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132690>

Op woensdag 11-11-2009 om 20:10 uur [tijdzone +0100], schreef Tomas
Carnecky:
> On Nov 11, 2009, at 7:56 PM, Jan Nieuwenhuizen wrote:

Hi Tomas,

> You used this:
> $ git config branch.master.remote =3D <something>
> Do you see the difference between that and what I posted?

Sure, I now know what syntax you and the advise mean.  However,
I'm just pointing out that the git pull advise makes no sense,
however way you try to interpret it?

> > I think it might be more helpful if this text said
> > configuration file and gave a usable configuration file
> > snippet, or alternatively said git config, and gave usable
> > git config commands.
>=20
> Feel free to send a patch ;)

[just maybe, if my uninstall patch goes in easily, but]

=46irst I need to know what the new advise should be.  As you
can see below, I'm still confused.

I was hoping someone would say: Ah blast!  That was me,
stupid: Fixed in master :-)  And everything would make
sense and work.

> branch.master.remote has two different values, git doesn't know which=
 =20
> remote to use.

Well, it can see that there already is a value for branch.master.remote
defined, and it /still/ advises to add one.  It also uses <nickname>,
which suggests there could be multiple values?

=46or all I know, pull can only handle one nickname and it shouldn't
give this advise at all?

> Do you want to pull from origin or eddy?

I'm publishing on origin -- that's what the original clone was
from.  Also, I use it to update from most often, when I work
from different locations.  All fine.

Now this Eddy guy says: pull from here.  I try it and get
this advise.  So, I'd like to have

   git pull  # use origin by default
   git pull eddy # pull from eddy's url

> I would =20
> recommend only keeping one [branch "master"] section and edit it =20
> appropriately.

Yes, I tried that and came up with

    [branch "master"]
	    remote =3D origin
	    merge =3D refs/heads/master
    [remote "origin"]
	    url =3D git@github.com:janneke/gub.git
	    fetch =3D +refs/heads/*:refs/remotes/origin/*
    # advise from git pull, using <nickname> =3D eddy
    #        branch.master.remote =3D <nickname>
    #        branch.master.merge =3D <remote-ref>
    #        remote.<nickname>.url =3D <url>
    #        remote.<nickname>.fetch =3D <refspec>
    #[branch "master"]
    #	remote =3D eddy # ignore branch.master.remote advise
    #	merge =3D refs/heads/master
    [remote "eddy"]
	    url =3D http://github.com/epronk/gub.git
	    fetch =3D +refs/heads/*:refs/remotes/origin/*

This /seems/ to work.  However, I still get this

    $ git pull -r
    From git@github.com:janneke/gub
     + 7bb5905...8ff38da master     -> origin/master  (forced update)
    First, rewinding head to replay your work on top of it...
    Fast-forwarded master to 8ff38da0a7013a891de18a0b7bec12b9d1fa6637.
    20:25:55 janneke@peder:~/vc/gub

[looks okay]

    $ git pull -r eddy
    From http://github.com/epronk/gub
     + 8ff38da...7bb5905 master     -> origin/master  (forced update)
[looks fine too, but still continues with]
    You asked me to pull without telling me which branch you
    want to merge with, and 'branch.master.merge' in
    your configuration file does not tell me either.	Please
    specify which branch you want to merge on the command line and
    try again (e.g. 'git pull <repository> <refspec>').
    See git-pull(1) for details.

    If you often merge with the same branch, you may want to
    configure the following variables in your configuration
    file:

	branch.master.remote =3D <nickname>
	branch.master.merge =3D <remote-ref>
	remote.<nickname>.url =3D <url>
	remote.<nickname>.fetch =3D <refspec>

    See git-config(1) for details.
    [1]20:26:01 janneke@peder:~/vc/gub
    $=20

so I'm still missing something?

> Is 'git pull -r' not short enough for you?

It's more of a usability thing.  It annoys me that the most
used functionality needs a command line option.  Worse however,
is that people [myself included] tend to forget that "-r",
and our logs have lots of these ugly, unnecessary

    c377994 Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/l=
ilypond

Also, we need to explain this to all newcomers.

Jan.

--=20
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesett=
er
Avatar=C2=AE: http://AvatarAcademy.nl    | http://lilypond.org
