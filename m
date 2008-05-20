From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Tue, 20 May 2008 09:04:41 +0200
Message-ID: <20080520070441.GB7324@diana.vm.bytemark.co.uk>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk> <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 09:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLum-0004Ex-Hz
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 09:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYETHEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 03:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbYETHEt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 03:04:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2643 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYETHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 03:04:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JyLtp-00020W-00; Tue, 20 May 2008 08:04:41 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82469>

On 2008-05-19 22:21:17 +0100, Catalin Marinas wrote:

> On 14/05/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > kha/safe has improved version handling: "stg --version" will now
> > present a detailed version number just like git does:
> >
> >   $ stg --version
> >   Stacked GIT 0.14.2.152.g77bd
>
> Thanks, I merged this patch. I create a similar patch some weeks ago
> (just some naming differences and only use the id of the HEAD) but
> went on holiday + a conference and forgot about it. Anyway, yours
> looks fine but I'll modify it slightly to use just 0.14.2 if a file
> named ".release" exists in the working directory. I did this with my
> patch to allow building of release tarballs without the git
> information. Do you have any better suggestion?

The system I built works like this at install time:

  i1. Create stgit/builtin_version.py, populated with git-describe
      output.

  i2. Install as usual.

And at runtime:

  r1. If we have a .git directory, ask git what version we are.
      (Actually, we just try to run git describe and see if it
      succeeds.)

  r2. Otherwise, go with the built-in version (only works if
      stgit/builtin_version.py exists).

Now, as to released versions, you could simply plop a suitably
prepared stgit/builtin_version.py in the tarball, and it'll all work.
i1 should fail silently when run from an unpacked tarball, so i2 will
pick up the builtin_version.py from the tarball. And at runtime, r1
will fail and we'll fall back to r2.

Oh, and please consider making annotated release tags in the future.
As is, I had to ask git-describe to look at unannotated tags as well,
which won't be so good in case a developer uses those as a scratch pad
while developing.

( The reason to do r1 before r2 is that otherwise an StGit tree will
  "stick" with the version it had at the time the last installation
  was run from that tree. We might fix that if we make sure to delete
  builtin_version.py immediately after the installation. That's
  desirable since any installed version of StGit currently runs
  git-describe unnecessarily. )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
