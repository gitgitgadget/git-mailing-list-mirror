From: Michael <barra_cuda@katamail.com>
Subject: Re: [QGit PATCH] Remove most ASSERT warnings in Git::setStatus
Date: Sun, 20 May 2007 16:08:06 +0200
Message-ID: <200705201608.06486.barra_cuda@katamail.com>
References: <200705201401.35991.barra_cuda@katamail.com> <e5bfff550705200553q757c334el7aa5aed393052616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 16:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpm2X-0003OS-Bz
	for gcvg-git@gmane.org; Sun, 20 May 2007 16:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbXETOFB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 10:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756764AbXETOFB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 10:05:01 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:56493 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620AbXETOFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 10:05:00 -0400
Received: from dial-up-mi-473.lombardiacom.it ([::ffff:212.34.226.219]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.226.219+uqXyyRFgmL; Sun, 20 May 2007 16:04:58 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <e5bfff550705200553q757c334el7aa5aed393052616@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47839>

(sorry, dropped git ml)

"Marco Costalba" <mcostalba@gmail.com>:
> On 5/20/07, Michael <barra_cuda@katamail.com> wrote:
> > Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> > ---
> >
> > ...is this correct?
> >
> >  src/git_startup.cpp |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/src/git_startup.cpp b/src/git_startup.cpp
> > index a99edba..17312f9 100644
> > --- a/src/git_startup.cpp
> > +++ b/src/git_startup.cpp
> > @@ -329,7 +329,7 @@ void Git::parseDiffFormatLine(RevFile& rf, SCRef line, int parNum) {
> >
> >                 // TODO rename/copy is not supported for combined merges
> >                 appendFileName(rf, line.section('\t', -1));
> > -               setStatus(rf, line.section(' ', 6, 6).left(1));
> > +               setStatus(rf, line.section('\t', -2, -2).right(1));
> >                 rf.mergeParent.append(parNum);
> >         } else { // faster parsing in normal case
> >
> > --
> > 1.5.1.2
> >
> 
> Where do you see the ASSERT? could  you link me to the test repository
> when you see that warnings?
> 
> I would like to understand better what causes the warnings.

On the git repo:

rm .git/qgit_cache.dat
qgit origin/pu
then use arrows to go down to the first octopus merge, ie:

    Merge branches 'jc/blame' and 'jc/diff' into pu

qgit prints:

ASSERT in Git::setStatus, unknown status <1>. 'MODIFIED' will be used instead.
ASSERT in Git::setStatus, unknown status <c>. 'MODIFIED' will be used instead.

on stderr.

That's because the lines considered in Git::setStatus are:

:::100644 100644 100644 100644 35864ed3c4afe01680bd5123fc28c35f5cf328e6 29243c6e8b49958ddcb08df0eb4223b14fd3e19f 16a5b9ac49c756492a7fd91fa49b84a3aee1f6b2 77ca8dcdfbcd6667b7f511306347c0d245ee4e2b MMM  Makefile
:::100644 100644 100644 100644 0e6439b0ddaf317a6288ab4dd40ae8b9a41e9884 4204bc168c11fc7f8764e7d92e5935d2dc30c3bd cbab8ebecb4f3f13856b3be21409074dbcd3edda d1ff7f50a31d9647c26c1e2293957a1d719c9373 MMM  cache.h

...which obviously do not have the right information ("M") in

        line.section(' ', 6, 6).left(1)

but in

        line.section('\t', -2, -2).right(1)

I thought this would trigger even with .git/qgit_cache.dat,
but I was wrong. (Anyway, I have a patch that adds an option
to make .git/qgit_cache.dat optional, but I don't think it
could be that useful. What do you think?)

If it still doesn't trigger for you, maybe I should post you
my qgitrc...
