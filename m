From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 issue
Date: Sat, 16 Apr 2011 12:01:09 -0400
Message-ID: <20110416160109.GA19557@arf.padd.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
 <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
 <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB7w6-0003Eg-0A
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab1DPQBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 12:01:21 -0400
Received: from honk.padd.com ([74.3.171.149]:41987 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab1DPQBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 12:01:20 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id C738220FD;
	Sat, 16 Apr 2011 09:01:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4B0E43206F; Sat, 16 Apr 2011 12:01:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171675>

michael.horowitz@ieee.org wrote on Fri, 15 Apr 2011 16:39 -0400:
> I am sure that is a common mistake people make, but not in this case.
> I have been using it successfully for a while now, it just suddenly
> stopped working, not sure what changed.  I am not seeing anything on
> remotes/p4/master either, and I was originally doing rebase and went
> back to sync so I could run "--verbose" and see if it was even
> downloading those changes.  I can clearly see it says it is
> downloading them, but then they just don't end up in git.
>=20
> Since I don't see an error message about it failing to sync, I am at =
a
> loss to figure out why it says it succeeded, but it didn't.  Could
> there be one step in the code that is not catching an error condition=
?
>  I am not all that familiar with Python, but if someone could point m=
e
> where to put some debug messages, I can do some testing.

It would say something if it failed.  If git-p4 says it brought
in changes, they would appear at the top of p4/master, or another
branch in remotes/p4 if you use git-p4's auto-branch feature.

Do "git branch -av".  You should see remotes/p4/master with the
latest p4 change.

It is possible to create a branch "p4/master" that is not
remotes/p4/master and possibly cause confusion.  "tree -a
=2Egit/refs" to see all your branches.

You can try "git fsck" to see if something is terribly wrong.
Or nose around .git, see if there are some recently-created
objects and use "git cat-file -p" to look at them.

If you are willing to tar up your .git and leave it somewhere,
I can take a look too.

		-- Pete

> Thanks,
>=20
> Mike
>=20
>=20
>=20
> On Fri, Apr 15, 2011 at 4:22 PM, Tor Arvid Lund <torarvid@gmail.com> =
wrote:
> >
> > On Fri, Apr 15, 2011 at 5:00 AM, Michael Horowitz
> > <michael.horowitz@ieee.org> wrote:
> > > Pete,
> > >
> > > I was hoping you could help me out again.=A0 After using git-p4 f=
or a
> > > while without a problem, it has suddenly stopped working for me.=A0=
 I am
> > > using the latest master.=A0 I haven't seen any recent changes tha=
t I
> > > think could have caused this, but maybe you'll have some insight.
> > >
> > > The issue is that when I do a git-p4 sync on my existing reposito=
ry,
> > > it reports success, but seems to do nothing.=A0 It does not downl=
oad the
> > > latest changes from p4.=A0 If I delete my repository and start ov=
er, it
> > > will download all the latest changes, even the ones it was not
> > > downloading previously, but if I try to sync again later, it does=
 not
> > > do anything.=A0 I tried running it with the "--verbose" mode, and=
 I see
> > > it says it is loading each of the changes, but they are not endin=
g up
> > > in the git repository, and it is not reporting any errors.
> >
> > Hi, Michael.
> >
> > Is it possible that you expect that 'git p4 sync' should update you=
r
> > working branch and/or working tree? Assuming a simple clone with a
> > local master branch, running 'git-p4 sync' will update the branch
> > remotes/p4/master, but it won't do anything on my working master
> > branch...
> >
> > Maybe you want to call 'git rebase p4/master' afterwards, or use th=
e
> > shorthand 'git p4 rebase' to do a sync+rebase.
> >
> > Regards,
> > Tor Arvid.
> >
> > > Any ideas of what this could be?=A0 Is there anything else I can =
run to
> > > help debug this?
> > >
> > > Thanks,
> > >
> > > Mike
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe git" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
> > >
>=20
