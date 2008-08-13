From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 10:19:21 -0700
Message-ID: <20080813171921.GF3782@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Bosch <bosch@adacore.com>, Andi Kleen <andi@firstfloor.org>,
	Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTK1L-0000N5-O2
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbYHMRTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYHMRTW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:19:22 -0400
Received: from george.spearce.org ([209.20.77.23]:50730 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYHMRTV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:19:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 543D738375; Wed, 13 Aug 2008 17:19:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92245>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 13 Aug 2008, Shawn O. Pearce wrote:
> > Doing the object
> > enumeration is pointless as a security measure.
> 
> It is good for network bandwidth efficiency as I mentioned.

The network bandwidth efficiency is the most valid argument for
the enumeration.

> > I'm too busy to write a pack concat implementation proposal
> 
> A much better solution would consist of finding just _why_ object 
> enumeration is so slow.  This is indeed my biggest grip with git 
> performance at the moment.
...
> |nico@xanadu:gcc> time git rev-list --objects --all > /dev/null
> |
> |real    1m51.591s
> |user    1m50.757s
> |sys     0m0.810s
> 
> That's for 1267993 objects, or about 11400 objects/sec.
> 
> Clearly something is not scaling here.

Yikes.  Last time I was looking at this sort of thing I think we
spent around 60% of our time dealing with inflating, patching and
parsing commit and tree objects.  pack v4's formatting spawned
out of that particular point, but we never really finished that.
Its been years so I can't trust my memory enough to say pack v4 is
the solution to this, without redoing the profiling.  But I think
that is what one would find.

Though the decreasing objects/sec rate with increased total number
of objects suggets the object hash isn't scaling.

-- 
Shawn.
