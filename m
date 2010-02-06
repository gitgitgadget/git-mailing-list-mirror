From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: Re: [gitolite] repo config for delegated projects
Date: Sat, 6 Feb 2010 12:15:23 +0530
Message-ID: <20100206064523.GA14010@atcmail.atc.tcs.com>
References: <20100203035718.GA30644@lapse.rw.madduck.net> <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com> <20100203202249.GA27125@lapse.rw.madduck.net> <20100204011842.GB497@atcmail.atc.tcs.com> <20100204040812.GC13411@lapse.rw.madduck.net> <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com> <20100206042222.GA7825@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 07:46:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdeQd-0006pu-V4
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 07:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab0BFGp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 01:45:57 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:53272 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab0BFGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 01:45:56 -0500
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id o166jOL3015066;
	Sat, 6 Feb 2010 12:15:24 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id o166jNsw015064;
	Sat, 6 Feb 2010 12:15:23 +0530
Content-Disposition: inline
In-Reply-To: <20100206042222.GA7825@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/10361/Fri Feb  5 22:14:47 2010 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139147>

On Sat, Feb 06, 2010 at 05:22:22PM +1300, martin f krafft wrote:
> also sprach Sitaram Chamarty <sitaramc@gmail.com> [2010.02.06.1350 +1=
300]:
> > OK I've run into a little decision-point here.
> >=20
> > The problem above is of making sure that a delegated admin cannot
> > misuse the gitconfig mechanism to do stuff he's not allowed to do,
> > but it's actually worse than that :(
>=20
> Let me thus challenge the whole delegation mechanism.
>=20
> When I first encountered it, I thought it was a great idea, but it
> seems to promise more than it can do. I understand that the reasons
> for that are security-related, and I tip my hat to you for being so
> conscious about this =E2=80=94 better have a secure system with limit=
ed
> functionality, than an insecure system that can do everything (why
> am I thinking of PHP apps right now???).
>=20
> The wildrepos branch is a definite improvement to proper delegation.
> Without it, the main admin has to change the main configuration file
> every time that a delegated admin wants to add a new repo.
>=20
> However, given the somewhat awkward configuration (you need to add
> delegated admins in multiple places), and the restrictions, I am
> starting to wonder what use-case delegations solve that couldn't be
> addressed easier with multiple accounts and gitolite instances.
> Thoughts?

In theory, none at all.  And if you're not in a corporate
environment, having separate accounts and instances is
probably easier, as I myself suggest to people sometimes
when they need *more* from delegation than what it has now.

What it gives you is *one* central place for all the code,
one set of users/ids and one entity to approve new ones, and
the means to delegate only the most volatile changes (like
at the branch-within-project level), and not the longer term
ones like actually adding a new user or a new project
(assuming you're not using wildrepos).

It turns out that this is closer to what corporate
environments want.  I use it, and a few groups in my $DAYJOB
also use it, afaik.

But I guess my original question was more for Teemu.  As it
stands, I need to redo the ability for even the "main" admin
to add gitconfigs... it allows him to get a shell too
easily.

> > Regardless of how I look at it, I can't think of a cure for this sh=
ort
> > of either:
> >   - putting all the allowed gitconfigs in the RC file, and not in t=
he
> > config (writing the RC file requires shell access, and we presume t=
he
> > "root of trust" person has enough smarts to know what to allow and
> > what not to allow), and allowing repo admins to *refer* to them to =
use
> > whichever they want
> >   - someone coming up with a list of gitconfig's that are "safe", a=
nd
> > specific values for those that are unsafe (like saying "if you use
> > showrev, you can only use this command  as the value", and forcing
> > only those.
>=20
> I think the second path is a red herring. However, I don't
> understand why we would need to go via the RC file instead of the
> main config. Only the main admin can modify that, or appoint others
> to modify it. Plus, it's managed in Git and thus has a history
> attached to it.

That's what I used to think, that it doesn't matter.

But there's a notion (and once I realised it I agreed with
it) that the ability to do "shell" things on the server is a
step higher than the ability to update gitolite's access
list.

Some people needed this, and I agreed.  Nothing prevents any
installation from giving anyone any rights, but I'd like to
prevent them acquiring it via gitolite, even if they can
write to the admin repo.

So right now (coming back to the ability to set gitconfig
from within gitolite) I'm thinking:

    $GL_GITCONFIG_KEYS =3D "core.foo core.baz";
        # actually list of regexes for valid keys

and advising people that these are the choices in terms of
allowing gitconfig from the admin repo (or delegation; no
difference):

  - (ultra paranoid mode): set the variable above to empty;
    no gitconfig allowed from gitolite.conf or delegated
    conf files
  - (just your normal everyday paranoia mode): set the
    variable to stuff that you know will not give shell
    access (example: the aforementioned hooks.mailinglist)
  - ("what, me worry?" mode): set that variable to ".*" and
    allow any damn gitconfig so they won't keep pestering
    you to add a config for them!

In the first 2 cases, someone with shell access must do all
required gitconfigs manually on the server when needed.

> Speaking of shell access, I notice gl-auth-command has the -s
> option. Is there a configuration variable that I overlooked which
> allows me to give shell login rights to specific users?

yes; it's in the RC file.  If you want to give anyone shell
access, add their name to a space-sep list in $SHELL_USERS
and push the config once.

The documentation for this is in a weird place (doc/6);
sorry about that!  Will move it to doc/3 soon.

--=20
Sitaram
