From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 3/5] Add automatic git-mergetool invocation to the new infrastructure
Date: Tue, 17 Mar 2009 08:12:46 +0100
Message-ID: <20090317071246.GB3716@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120907.2992.81035.stgit@pc1117.cambridge.arm.com> <20090313021751.GC15393@diana.vm.bytemark.co.uk> <b0943d9e0903160803y25eb3f45y96d68e734b22e5f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTVC-0007JD-NU
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbZCQHMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 03:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZCQHMu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:12:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:34902 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZCQHMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:12:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjTTi-00014N-00; Tue, 17 Mar 2009 07:12:46 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903160803y25eb3f45y96d68e734b22e5f9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113428>

On 2009-03-16 15:03:09 +0000, Catalin Marinas wrote:

> 2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-12 12:09:07 +0000, Catalin Marinas wrote:
> >
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# There were conflicts
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conflicts =3D [l for l in output=
 if l.startswith('CONFLICT')]
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictException(con=
flicts)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if interactive:
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.mergetool()
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conflicts =3D [l for l i=
n output if l.startswith('CONFLICT')]
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictExcep=
tion(conflicts)
> >
> > Does the merge tool always resolve all conflicts? If it doesn't,
> > the two lines in the "else" branch should probably be run
> > unconditionally.
> [...]
> > > + =A0 =A0 =A0 =A0# check for unmerged entries (prepend 'CONFLICT =
' for consistency with
> > > + =A0 =A0 =A0 =A0# merge())
> > > + =A0 =A0 =A0 =A0conflicts =3D ['CONFLICT ' + f for f in self.ind=
ex.conflicts()]
> > > + =A0 =A0 =A0 =A0if conflicts:
> > > + =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictException(conflicts)
> > > + =A0 =A0 =A0 =A0elif err:
> > > + =A0 =A0 =A0 =A0 =A0 =A0raise MergeException('"git mergetool" fa=
iled, exit code: %d' % err)
> >
> > Ah, you take care of conflicts here too. Hmm. I guess that's fine
> > too, though there is some code duplication. Maybe a helper
> > function that takes output as a parameter, and raises
> > MergeConflictException if necessary?
>
> The non-interactive path assumes that there are conflicts if "git
> merge-recursive" returned an error and it simply splits the output
> if this command. The mergetool path has to run "git ls-files
> --unmerged" to check if there were any left conflicts. I wouldn't
> call "git ls-files" in the first case as we already have the
> information.

I was thinking of a function you'd call with either the output of the
merge operation or ls-files depending on the code path. But maybe it's
not worth it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
