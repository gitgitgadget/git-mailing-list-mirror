From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 13:59:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <20120501171640.GA16623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHM3-00005j-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382Ab2EAR7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:59:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28428 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924Ab2EAR7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:59:09 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3C0072WVAKS550@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2012 13:59:08 -0400 (EDT)
In-reply-to: <20120501171640.GA16623@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196717>

On Tue, 1 May 2012, Jeff King wrote:

> On Tue, May 01, 2012 at 12:28:06PM -0400, Jeff King wrote:
> 
> > >  You could test this theory by commenting out the size comparisons in 
> > > type_size_sort() and re-run the test.
> > 
> > I'll try this next.
> 
> Wow, it behaves horribly. I didn't even let the bigger tests run to
> completion. Here is the output for git.git (the first line is from the
> original, unmodified version of git with --window=10):
> 
>   orig | 31.4M (100%) |   54s (100%)
>     10 | 44.0M (140%) |  169s (310%)
>     20 | 37.7M (120%) |  232s (428%)
>     40 | 33.6M (107%) |  331s (608%)
>     80 | 30.9M ( 99%) |  473s (868%)
>    160 | 29.4M ( 94%) |  696s (1279%)
> 
> Unless the window is increased a lot, the packs end up quite a bit
> larger (and even still we spend a lot more CPU time).

Bleh.  Allright.

One final quick test if you feel like it: I've never been sure that 
the last comparison in type_size_sort() is correct.  Maybe it should be 
the other way around.  Currently it reads:

	return a < b ? -1 : (a > b);

While keeping the size comparison commented out, you could try to 
replace this line with:

	return b < a ? -1 : (b > a);

If this doesn't improve things then it would be clear that this avenue 
should be abandoned.


Nicolas
