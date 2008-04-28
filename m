From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 14:42:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281409030.5399@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> <slrng1bdsf.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-296705463-1209390122=:5399"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:42:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqTcu-0002Z6-PY
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 15:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763455AbYD1Nlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 09:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764994AbYD1Nlx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 09:41:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:60030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763103AbYD1Nlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 09:41:52 -0400
Received: (qmail invoked by alias); 28 Apr 2008 13:41:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 28 Apr 2008 15:41:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fmAVSFSnfOGq/PYuANCmXRY77cYz/4BYPOakxb1
	5AEnZFoq6sWF0q
X-X-Sender: user@eeepc-johanness
In-Reply-To: <slrng1bdsf.25r.joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80533>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-296705463-1209390122=:5399
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

don't cull me from the Cc: list.  This has been mentioned on this list so 
often, it is not even funny any more.

On Mon, 28 Apr 2008, Jörg Sommer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 27 Apr 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > ...  It did not help that I hated the fact that that series changed 
> >> > the original design without even understanding it.
> >> 
> >> Care to elaborate on this point further?  I do not get it.
> >
> > The original implementation of -p was modeled closely after 
> > filter-branch, in that it created a subdirectory (dotest/rewritten) 
> > containing the new commit names for those commits that were rewritten.
> 
> But that wasn't the way rebase -i works.

I know exactly how it works. D'oh.

> You had to jump in before pick_one does anything which clearly shows you 
> did something different from the default way.

That is bullshit.  I did not do anything "different from the default way".  
I carefully designed an interface that was easy to understand, because it 
mimicked how you would do the same _by hand_, but without the hassle to 
actually having to do everything by hand.

In other words, rebase -i is just a cherry-pick in a loop.

And _exactly_ the same should have been done for -p.  Namely, _not_ 
introduce some artificial marks, but use the _commit names_!

> > Now, whenever a commit was picked, the parents would be looked up in 
> > dotest/rewritten, and replaced with the rewritten name (or left 
> > unchanged if they were not rewritten).
> 
> This approach doesn't work when you change the order of commits.
> Take the commit A, B and C in this order and reorder them to A C B:
> 1. pick A, A^ was not rewritten, nothing changed, A stays the same
> 2. pick C, C^ was not rewritten, nothing changed, C stays the same
> 3. pick B, B^ was not rewritten, nothing changed, B stays the same

You carefully ignored how I intended the parents to be used: only for 
merges.

> > Basically, the output of rebase -i -p is ugly now, because you have 
> > _two_ ways of specifying things,
> 
> > I have the feeling that I have to repeat my point again, so that it is not 
> > ignored -- again.  Maybe an example would help:
> >
> > -- snip --
> > pick abcdefg This is the first commit to be picked
> > reset cdefghij
> > pick zyxwvux A commit in a side-branch
> > merge recursive abcdefg
> > -- snap --
> >
> > I am convinced that this syntax does not need much explanation.
> 
> But above you said this syntax + mark is “ugly”. Strange.

You know, I find it strange how you try to make a _point_ in 
misunderstanding me.  Did I not mention that the way to have _two_ ways to 
reference commits was ugly?  You did not even bother to remove that part 
from what you quoted.

> > A patch implementing a syntax like this would have won my unilateral 
> > approval
> 
> I doubt this. You refused any changes to your idea and your code from 
> the beginning. You didn't answer questions and doesn't take part on the 
> discussion [1] about the new syntax.

Well, you carefully ignored (but removed from the quoted text) my 
explanation.  Nevertheless, I did participate in the discussion, and 
mentioned my preferred way of doing things.

Sheesh,
Dscho

--658432-296705463-1209390122=:5399--
