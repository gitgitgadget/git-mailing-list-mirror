From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Mon, 14 Oct 2013 22:13:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310142200380.1873@syhkavp.arg>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
 <20131015001926.GC10415@sigill.intra.peff.net>
 <alpine.LFD.2.03.1310142141200.1873@syhkavp.arg>
 <20131015015113.GA17486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 04:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVu8L-0003TH-38
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 04:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab3JOCNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 22:13:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24217 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab3JOCNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 22:13:11 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUO00J7OU5Z3VE0@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Oct 2013 22:13:11 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 25B542DA03FE; Mon, 14 Oct 2013 22:13:10 -0400 (EDT)
In-reply-to: <20131015015113.GA17486@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236162>

On Mon, 14 Oct 2013, Jeff King wrote:

> By the way, I'm sorry I haven't looked more carefully at the packv4
> patches yet. I am excited about it, but I've just got a long queue of
> other things (and because it's big and challenging, it's easy to put
> off).

;-)

While I consider the format pretty much established at this point, it 
still has some way to go on the algorithmic side of things.  So there is 
certainly room for more people toying with the code.

> One of the things that makes me most nervous about switching to it on
> the server side is that we'll have packv2-only clients for a while, and
> I worry that converting to v2 on the fly is going to end up costing a
> lot (even with clever tricks like this, you still have to pay the cost
> to zlib deflate each item). But even if it is slow, the sooner we have
> packv4 readers, the sooner the clocks start ticking for it being a
> reasonable decision for a big server provider to switch.

Well... of course this depends.  What pack v4 brings is super fast tree 
walking and object enumeration.  We're not there yet with the current 
code, but in theory this is conceptually cheaper with pack v4.  
Therefore operations such as partial clones or updates are meant to be 
much faster in the preparation phase which should compensate for the 
deflate cost.

Yet a big server could store both v2 and v4 in parallel if disk space is 
not an issue, and a modified git could lookup the alternate version of 
an object before transcoding it.


Nicolas
