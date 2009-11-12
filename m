From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Thu, 12 Nov 2009 15:17:29 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1258035449.26362.273.camel@heerbeest>
References: <1257945756.26362.79.camel@heerbeest>
	 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	 <1257965806.26362.132.camel@heerbeest>
	 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
	 <1257968052.26362.155.camel@heerbeest>
	 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 15:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8aUR-0000dS-U4
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 15:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbZKLOR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 09:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbZKLOR1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 09:17:27 -0500
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:58459 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbZKLOR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 09:17:26 -0500
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id D282A1220F7;
	Thu, 12 Nov 2009 15:17:30 +0100 (CET)
Received: from [127.0.0.1] (heerbeest [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 59F2CDC1AC;
	Thu, 12 Nov 2009 15:17:30 +0100 (CET)
In-Reply-To: <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132767>

Op woensdag 11-11-2009 om 21:32 uur [tijdzone +0100], schreef Tomas
Carnecky:

Hi Tomas,

> It didn't tell you to copy'n'paste the whole lines to a git-config(1)=
 =20
> commandline. But I do see that the output can be confusing for someon=
e =20
> not familiar with the git configuration files/git-config.

Once I get this to work, I'll send a patch for it.

> I don't know the relationship between you and eddy, but usually you =20
> shouldn't rebase (=3Drewrite) eddies commits. That also means you'd h=
ave =20
> to live with the merge commits.

Hmm, okay.

> I see your mistake. Both the origin and eddy remote write to the same=
 =20
> namespace (refs/remotes/origin/*), and that's also why you get (force=
 =20
> update) below

Ah, that makes sense.

> . Change the fetch line of remote.eddy.fetch to +refs/heads/*:refs/=20
> remotes/eddy/*. After that both command (pull -r / pull -r eddy) =20
> should work (I hope).

Okay, so now I have

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
    #	remote =3D eddy
    #	merge =3D refs/heads/master
    [remote "eddy"]
	    url =3D http://github.com/epronk/gub.git
    #use remote.eddy.fetch to +refs/heads/*:refs/remotes/eddy/*.
	    fetch =3D +refs/heads/*:refs/remotes/eddy/*

It looked promising, but still get

    15:00:20 janneke@peder:~/vc/gub
    $ git pull -r --verbose
    From git@github.com:janneke/gub
     =3D [up to date]      lilypond-release-branch -> origin/lilypond-r=
elease-branch
     =3D [up to date]      master     -> origin/master
    Current branch master is up to date.
    15:00:26 janneke@peder:~/vc/gub
    $ git pull -r --verbose eddy
    From http://github.com/epronk/gub
     =3D [up to date]      lilypond-release-branch -> eddy/lilypond-rel=
ease-branch
     =3D [up to date]      master     -> eddy/master
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
    [1]15:00:33 janneke@peder:~/vc/gub
    $=20

After this I started to re-read git-config's man page
again.  There is something strange that I do not understand

    branch.<name>.merge
        Defines, together with branch.<name>.remote, the upstream
        branch for the given branch.  It tells git-fetch/git-pull
        which branch to merge and can also affect git-push (see
        push.default).

this seems to imply that the merge variable here

   [branch "master"]
       remote =3D FOOBAR
       merge =3D refs/heads/master

is somehow tied to the remote nick FOOBAR.  That would
mean it is actually taken as

     branch.<name>.<nickname>.merge

and also that it's impossible to specify more than one
<nickname>.  That would be make nicknames unusable and
thus silly, so I cannot be right?

Thanks a lot for your continued support!

Greetings,
Jan.


--=20
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesett=
er
Avatar=C2=AE: http://AvatarAcademy.nl    | http://lilypond.org
