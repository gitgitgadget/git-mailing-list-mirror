From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Thu, 1 Dec 2011 15:30:16 +0100
Message-ID: <20111201143016.GC2386@beez.lab.cmartin.tk>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
 <20111130182230.GC12096@centaur.lab.cmartin.tk>
 <CAEUMa-fhqS-dJUePznZrEsKVSMDiAs=-JX93XTXZEm71Oix-1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Cc: git@vger.kernel.org
To: John Twilley <mathuin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 15:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW7fH-0006z0-0m
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 15:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab1LAObD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 09:31:03 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:45486 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab1LAObC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 09:31:02 -0500
Received: from beez.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 17361461A5;
	Thu,  1 Dec 2011 15:30:18 +0100 (CET)
Received: (nullmailer pid 1415 invoked by uid 1000);
	Thu, 01 Dec 2011 14:30:16 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	John Twilley <mathuin@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAEUMa-fhqS-dJUePznZrEsKVSMDiAs=-JX93XTXZEm71Oix-1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186170>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 11:13:20AM -0800, John Twilley wrote:
> On Wed, Nov 30, 2011 at 10:22, Carlos Mart=EDn Nieto <cmn@elego.de> wrote:
> > On Wed, Nov 30, 2011 at 09:43:08AM -0800, John Twilley wrote:
> >> Today someone asked me if there was a way to run git against a
> >> directory other than the current directory. =A0I looked at the output =
of
> >> --help and ran this:
> >>
> >> $ git --work-tree blah status
> >>
> >> I got the following output:
> >>
> >> fatal: Not a git repository (or any parent up to mount parent /home)
> >> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not s=
et).
> >>
> >> I mistakenly thought the error message meant that blah was not a git
> >> repository. =A0What it meant was that there was no .git in the current
> >> directory or any parent directory up to /home.
> >
> > Yes, git looks at the current directory and .git/ to see if there's a
> > git repository there. This is what happens unless you tell git to look
> > for it somewhere else.
>=20
> This makes perfect sense, because nearly every time I run git
> commands, I am somewhere within the working tree.  The point of my
> post was that I was using --work-tree to tell git to look for the git
> repository somewhere else (the root of the specified working tree)
> which is not what git expected.

And as Junio said, git devs have never considered the case where you
want to run git from a directory, but have git look for the worktree +
repo in a different place. Since what you want to do is solved
trivially by cd'ing in a subshell "(cd blah && git status)" it's not
surprising that this hasn't come up.

>=20
> >> This command worked as expected:
> >>
> >> $ git --work-tree blah --git-dir blah/.git status
> >>
> >> The documentation is somewhat fuzzy about what constitutes a git
> >> repository. =A0The gittutorial describes the git repository as .git wh=
en
> >> talking about "git init" while the Git User's Manual describes the git
> >> repository as the working tree and the special top-level directory
> >> named .git when talking about "git clone".
> >
> > A git repository is what's under .git/ (or in foo.git/ for bare
> > repos). Non-bare repositories have a working tree associated with
> > them, which by default lives just above the repository, because it'd
> > be silly to have it somewhere else by default. Often you can think of
> > both as the repository, as they're both. When you tell git to look for
> > the worktree somewhere else, you're only overriding that particular
> > variable, as git expects to be run from the repository (or just above,
> > in the worktree).
>=20
> And it's exactly this issue -- that sometimes the repository is just
> the git directory, and sometimes the repository is the working tree
> which contains the git directory at its root -- that caused the
> confusion and unexpected behavior.  If I were to use a bare repository
> directly (something I've never done), I guess I might use --git-dir
> since the repository may not be named .git but instead something like
> proj.git.  When I accessed a repository from outside its working tree,
> I expected --work-tree to cover the whole shebang.  Obviously this
> discussion is exposing my relatively limited experience with git, but
> these assumptions do not seem unreasonable on their face.

You hardly ever need to use git directly on a bare repo, but when you
do, you can just it from inside the repo, but most of the time git
expects to be run from the place where the repo+worktree combination
is to be found. Anything else is a low-level configuration and is just
not expected to be used by people who aren't familiar with git's usage
of "worktree".

>=20
> >> It's clear (to me at least) that --work-tree should be used to
> >> identify the root of the working tree when not inside the working
> >> tree. =A0I expected that the git directory would be automatically set =
to
> >> .git in the root of the working tree, as that would match the
> >> documentation. =A0Instead, the current directory and its parents were
> >> checked -- which could provide dangerously misleading information to
> >> the user.
> >
> > What part of the documentation exactly? --work-tree tells git to look
> > for the working tree somewhere else. This option exists in order to
> > support a multiple-workdir workflow.
>=20
> What you mention above was what I was thinking about when I mentioned
> the possibility of this being a critical and significant feature.  If
> it is important to support a workflow with one git directory and
> multiple working trees, and that case is more common/important than
> the one I experienced, then changing the behavior of --git-dir is
> obviously not the right thing to do.

It's not just about it being a critical feature. Yes it would break
many scripts, but what you want to do is meant to be done with a
subshell and I fail to see why git should go out of its way to support
such a usercase.

>=20
> >> I think that one of two things should be done: =A0either the --git-dir
> >> default should be changed when the --work-tree option is set, or the
> >> error message cited above should be changed to explicitly identify the
> >> directory being tested as a potential git repository. =A0I personally
> >
> > Git does tell you explicitly, but only when you specify a gitdir (via
> > GIT_DIR or --git-dir), otherwise it looks at the current directory.
>=20
> This is misleading if you don't know that the specification of a
> working tree does not also implicitly specify a git directory.
> Whether that lack of knowledge is the user's problem or the
> software/documentation's problem is a separate question.

The documentation now thankfully doesn't talk about working copy
anymore, so it should be fairly consistent. The gitglossary definition
of worktree should also explain what a worktree is.

>=20
> >> believe the first option is superior because it fulfills the
> >> expectations of average users (folks who read git's documentation
> >> instead of its source code) while permitting flexibility to those who
> >
> > It's not likely that it will get changed because that would break
> > backwards-compatability in a very big way. If your concern is for
> > "average user", she shouldn't be using that option, but changing to
> > that directory instead. If you want your working tree to be ./foo/ and
> > your gitdir to be ./foo/.git, why don't you just cd to ./foo/?
>=20
> From that perspective, why have --work-tree at all?  Without that
> option, either the git directory is in the root of your current
> working tree, or it's not -- in which case --git-dir is all you need.

The reason for --work-tree (and the earlier GIT_WORKTREE) is to allow
you to temporarily set the worktree somewhere else. It's meant to tell
git to pretend $PWD is something else.

> If you're going to keep the option, it's helpful to provide the
> diagnostic output.  My suggestion would be more compelling if I could
> provide a valid use case, but all I can come up with off the top of my
> head are scripts and something like "(cd $worktree && git status)"
> would probably work fine.

This subshell method is exactly how everyone's always written this
kind of thing, and the way that you're supposed to (and I don't mean
for git, I mean for any tool). Adding the option explicitly to git
would introduce an further potential source of bugs and is unnecessary.

>=20
> >> wish to refer to the current directory or some other directory
for
> >> their --git-dir value. =A0If the current behavior is somehow not a bug
> >> but instead a critical and significant feature which if changed would
> >> cause more harm than good, please consider the second option.
> >
> > You get two different messages depending on how git is looking for the
> > repository. The message you mentioned gets printed when git tries to
> > find it automatically. A "fatal: Not a git repository: '/tmp'" gets
> > printed if you've told git to look for it in a specific place. The
> > information is already there, though I guess you do have to know about
> > the difference. Adding the current directory to the "default" message
> > probably wouldn't hurt, as it's unlikely that a script is parsing
> > that, and might be useful.
>=20
> Fewer scripts would be broken if the additional output is only
> displayed when --work-tree is used, but that might be too special-case
> for this situation.

That would connect unrelated code, I doubt it's reasonable.

   cmn

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO1494AAoJEHKRP1jG7ZzT7doH/010lfxmmuQSH0AeewKHflrW
u9xAdVYSOm8UT9pV6aRHNuAChSH4u+atEJFRJiEEY8fQXalrn7OyJeBh1g3SP9O2
6ukaXlZmlfIzeEne/3lL6DEe70soLw6yb+eJzhMuI4ivFM/zwOWUn4q+eC76b4/5
a+T6/tRkOhRqkhidabuG3+2KyfO8lUFsfgRE/gOwFliyhuHcqWQ/zNGHg0XaNX0B
TSEFrbuYiy65DzXdc8zMsc+kB+gh3NDSDSw0J7YxtAvQq3fZCXgcnb0tyJ39zwJ1
Eyc2V51Wy44Y0/wOltbBZ2DE5whAUdyO90Ze9IR6sfiehHVRBWQhacn6t776zD0=
=wfnx
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
