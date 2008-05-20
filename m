From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Tue, 20 May 2008 23:02:49 +0200
Message-ID: <20080520210249.GA19465@diana.vm.bytemark.co.uk>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk> <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com> <20080520070441.GB7324@diana.vm.bytemark.co.uk> <b0943d9e0805201019x10bf87ecr1c11c8ee474f6138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYzt-0001KY-AP
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 23:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460AbYETVC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 17:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760194AbYETVC6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:02:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3395 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277AbYETVC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:02:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JyYyv-00058M-00; Tue, 20 May 2008 22:02:49 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0805201019x10bf87ecr1c11c8ee474f6138@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82504>

On 2008-05-20 18:19:02 +0100, Catalin Marinas wrote:

> 2008/5/20 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > The system I built works like this at install time:
> >
> >  i1. Create stgit/builtin_version.py, populated with git-describe
> >      output.
> >
> >  i2. Install as usual.
>
> Fine (with some notes for releases, see below).
>
> > And at runtime:
> >
> >  r1. If we have a .git directory, ask git what version we are.
> >      (Actually, we just try to run git describe and see if it
> >      succeeds.)
> >
> >  r2. Otherwise, go with the built-in version (only works if
> >      stgit/builtin_version.py exists).
>
> OK.
>
> > Now, as to released versions, you could simply plop a suitably
> > prepared stgit/builtin_version.py in the tarball, and it'll all
> > work. i1 should fail silently when run from an unpacked tarball,
> > so i2 will pick up the builtin_version.py from the tarball. And at
> > runtime, r1 will fail and we'll fall back to r2.
>
> I build release tarball from the directory under Git control and I
> always get a builtin_version.py generated. In my initial patch I had
> a check in setup.py for a .release file. I could add a check in
> write_builtin_version to ignore the extra .git stuff if I am making
> a release (only keep the tag name).

Nah, easier to just change the order of the checks (try r2 before r1)
as I outlined. I'll whip up a patch.

> Another alternative is to check for the number of commits from the
> latest tag and, if this is 0, simply ignore the Git id.

If you're exactly on a tagged commit, git-describe will return just
the name of that tag, so you don't need to do anything extra.

> BTW, Git seems to use 6 characters for the current commit id and
> StGIT 5. Should we change this for consistency?

Both git and we call git-describe with --abbrev=3D4, which I think mean=
s
"describe the commit uniquely with as few digits as possible, but no
less than four". So we'll get upgraded automatically when it becomes
necessary.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
