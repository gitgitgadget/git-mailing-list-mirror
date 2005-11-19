From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 15:04:05 +0100
Message-ID: <20051119140404.GD3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 19 15:04:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdTIs-0006EP-HZ
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 15:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVKSOCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 09:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVKSOCj
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 09:02:39 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:30861 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751118AbVKSOCi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 09:02:38 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E6C059602;
	Sat, 19 Nov 2005 15:02:36 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdTK1-0007Bx-An; Sat, 19 Nov 2005 15:04:05 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12340>

On Fri, Nov 18, 2005 at 12:28:56AM +0100, Johannes Schindelin wrote:
> On Fri, 18 Nov 2005, Yann Dirson wrote:
> 
> > Current commit objects refer to a child tree, but to parent _commits_.
> > Whereas it seems necessary to walk through the history line, and
> > easily get a changelog, it is semantically quite not right:
> 
> Yes, it is. You base *your* work on *some* work. So, even if the trees may 
> be equal, the base isn't.

Hm, I'm not sure I get your point here.

> > Indeed that emphasizes that the history lines are on living on a
> > higher level of abstraction that commits.  Now what if we used
> > trees->tree commits, instead of the current commits->tree ones ?
> 
> Now, how exactly would that be more abstract? Trees are just that: 
> collections of files. Noone tells you what the idea was, which led from 
> the last tree(s) to this one. That is not abstract.

Trees have an existence outside any consideration of what changes led
to them, as shown by the fact that git trees do not reference anything
outside them.  And it is right that, at that level, noone tells you
how you got there - not less nor more than when you fetch a
linux-x.y.z.tar.gz2 from kernel.org.

Then at a bit higher level, you can consider changes from a tree to a
tree.  What you usually do when you commit a change is explaining what
you change to the tree.  Then changes themselves are just derived from
the trees (iow, "abstracted from" the trees), and you augment this
information with a message explaining what you did.

Then at a still higher level, you can derive history lines from the
individual trees and changes, and augment this information, eg. by
signing them.


The fact is, currently git does not distinguish much between those 2nd
and 3rd levels.  It is my understanding that one of the most basic
design decisions of git was precisely to make the tool "aware" of the
1st level, and that it played an important part of why git works so
well: it maps to the reality closer than any other tool.

I was not convinced at all by the ideas when git appeared, but that
was probably because I was too much influenced by previous tools, all
focussing either on the history line (most of them), or on the changes
(darcs).

I think that if we can formalize into git the disctinction between
those two higher levels (and possibly other levels in the future), we
could get to an even more powerful and usable tool, even if, like git,
the basic ideas may look weird and possibly even counter-productive at
first sight.


As an example, here is an idea I had while formalizing the above 3rd
level: we also work at this level when rolling back a previous change,
since we take the history line into account.  We could add, at that
History level, the possiblity to record this information, by linking
to that previous commit.

Now maybe I was mistaken in thinking the objects at the History level
should be only "cached" and temporary objects - that, and loop
prevention, and signed history lines, make too many reasons for them
to be permanent already :).

But their existence as such should not prevent to work at a lower
level.  I'll have to reconsider the way I intended to design my
ArcheoloGIT toolkit, but I'm afraid it would need a new generation of
GIT ;)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
