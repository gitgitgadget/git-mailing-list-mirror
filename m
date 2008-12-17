From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 07:44:07 -0800
Message-ID: <20081217154407.GZ32487@spearce.org>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org> <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 16:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCyaX-0003WY-Am
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 16:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbYLQPoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 10:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYLQPoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 10:44:09 -0500
Received: from george.spearce.org ([209.20.77.23]:47889 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYLQPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 10:44:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DE90838200; Wed, 17 Dec 2008 15:44:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103355>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 16 Dec 2008, Jean-Luc Herren wrote:
> > jidanni@jidanni.org wrote:
> > > JH> So maybe what you really want is an ETA display during the cloning
> > > JH> process?  Sounds like a good idea to me.
> 
> And then you'll end up being the unlucky bastard to be the first to 
> clones the new latest revision of a repository, and ETA won't be 
> available, and you'll complain about the fact that sometimes it is there 
> and sometimes it is not.
> 
> The fact is, fundamentally, we don't know how many bytes to push when 
> generating a pack to answer the clone request.  Sometimes we _could_ but 
> not always.  It is therefore better to be consistent and let people know 
> that there is simply no ETA.

Hmm.

What if on an initial clone (no "have" lines received) we sum up
the sizes of the *.pack and all of the loose objects and sent
that as an initial size estimate.  Its going to be the upper bound
of the final pack that we send.  At worst it over-estimates on the
size and download finishes faster.

I'm willing to bet that most of the "big" repositories out there
don't have a lot of garbage in them.  Linus' kernel repository
doesn't rewind, so he has 0 garbage.  Anyone cloning from him would
get a reasonable estimate.  Likewise with a Gentoo/KDE/WebKit/gcc
sort of giant tree most of that is in a huge historical pack.
That one pack file alone is completely reachable and dominates the
transfer size.

On smaller trees where people may have a lot of rebase garbage or
everything is loose the estimate will be quite a bit above what we
transfer, but how much so that it matters?

Yea, a single stray binary of some *.mpg or *.iso accidentally
added and then removed (and now unreachable) will vastly inflate
the numbers.  In which case the repository owner will be encouraged
to prune when people won't clone his estimated 8 GiB download,
which is actually only 1 MiB.

-- 
Shawn.
