From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Mon, 12 Jan 2009 05:51:56 +0100
Message-ID: <200901120551.56791.chriscool@tuxfamily.org>
References: <200901111602.53082.borntraeger@de.ibm.com> <f19298770901111147t625a2161t779bfcfc0317225c@mail.gmail.com> <20090111230240.GA27489@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 05:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMEn7-0000Ny-TZ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 05:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbZALEvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 23:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZALEvW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 23:51:22 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:50408 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbZALEvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 23:51:21 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D190994003E;
	Mon, 12 Jan 2009 05:51:09 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DE835940045;
	Mon, 12 Jan 2009 05:51:04 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090111230240.GA27489@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105289>

Le lundi 12 janvier 2009, Pierre Habouzit a =E9crit :
> On Sun, Jan 11, 2009 at 07:47:18PM +0000, Alexey Zaytsev wrote:
> > On Sun, Jan 11, 2009 at 22:42, Sam Ravnborg <sam@ravnborg.org> wrot=
e:
> > >> For bisect, it's indeed somewhat annoying, and we could have per=
haps
> > >> done some things a bit differently, but it's about the closest y=
ou
> > >> can get to "real history" without making the first btrfs merge-p=
oint
> > >> a _total_ disaster.
> > >>
> > >> For bisect purposes, if you know you're not chasing down a btrfs
> > >> issue, you can do
> > >>
> > >>       git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8
> > >>
> > >> where that commit 34353029 is the last one which has _just_ the
> > >> btrfs files. The next commit is when it does "Merge Btrfs into
> > >> fs/btrfs", and that one has the whole kernel tree again.
> > >
> > > The cost of moving this piece of history from one git tree to ano=
ther
> > > git tree is that we make it harder to debug the kernel for the
> > > advanced user that knows how to do bisect.
> >
> > And wasn't is trivial to avoid? Just exporting the commits as
> > patches and importing them into the kernel tree would preserve
> > the history, and not break bisection.
>
> And would have brought a whole history of totally irrelevant stuff th=
at
> never exited for real, with probably a lot of non-compiling sub-steps
> which would be even worse.
>
> No, the two possible choices were to squash the whole stuff at once, =
or
> do what has been done IMNSHO.  People have to grok how to take shortc=
uts
> with git-bisect.  I know that git-bisect puts people on the brainless
> course of actions where they git-bisect; configure; compile; boot; te=
st;
> mark as good/bad and retry.  And that's what I sometimes don't like w=
ith
> it.  Because people trust git-bisect too much and forget how to think
> right.

Well "git bisect" can be more usefull if it can be fully automated (wit=
h git=20
bisect run) because then you can make the computer do all the boring wo=
rk.=20
So I think putting people on the "brainless course of actions" can ofte=
n be=20
a good thing.

Anyway it looks to me that this kind of problem could be avoided if one=
=20
could "replace" some commits only when bisecting. In this case what cou=
ld=20
be done is that one could "replace" the commit where btrfs is merged wi=
th=20
one commit that cuts off the btrfs history. If the merge commit is only=
=20
replaced when bisecting, then you get the best of both worlds:

_ when you bisect, you don't see the btrfs history that breaks the kern=
el=20
build,
_ when you don't bisect, you see the full real history.

Of course if the bisection process finds out that the "replaced" commit=
 is=20
the culprit, then you need to understand what this means...

Regards,
Christian.
