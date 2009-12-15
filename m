From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 22:44:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912142228121.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
 <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
 <1260843111.9379.86.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKOKc-0000z4-VU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbZLODoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbZLODoH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:44:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46589 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbZLODoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 22:44:05 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUO007LCD1CK501@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Dec 2009 22:44:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1260843111.9379.86.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135265>

On Mon, 14 Dec 2009, Eric Paris wrote:

> On Mon, 2009-12-14 at 19:26 -0500, Nicolas Pitre wrote:
> > On Mon, 14 Dec 2009, Eric Paris wrote:
> > 
> > > Maybe having a .git directory that large is the problem?
> > 
> > Shouldn't be, unless your repo is really badly packed.
> > 
> > What's the output of 'git count-objects -v' ?
> 
> count: 87065
> size: 866744
> in-pack: 1203497
> packs: 148
> size-pack: 976474

So basically 87K loose objects occupying 846 MB and 1.2M packed objects 
occupying 954 MB across 148 packs.  That's an horrible repository 
layout which would definitely gain by being repacked.

> I noticed just blindly poking at sizes in my .git/object/pack that the
> largest pack is a lot larger than the second and third largest....

That's expected.

> And all total there is almost 1G of data in .git/object/pack
> 
> If the answer really is that I just have too much data and it can't be
> handled,

Nope.  git should handle that kind of data set perfectly fine.  And once 
repacked, you should end up with a single pack containing everything and 
the total size of your .git/objects directory will probably shrink by 
50% or more.

But to be able to repack, your 'git reflog' needs to work correctly, and 
the problem is unlikely to be related to the repository size.


Nicolas
