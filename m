From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Wed, 17 Feb 2010 23:55:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002172350080.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100218013822.GB15870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 05:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhyQ9-00033b-I0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 05:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab0BREzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 23:55:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39582 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0BREzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 23:55:03 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000LKGTNP5QF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 23:55:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100218013822.GB15870@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140296>

On Wed, 17 Feb 2010, Jeff King wrote:

> On Wed, Feb 17, 2010 at 05:16:23PM -0800, Junio C Hamano wrote:
> 
> > +	if (paranoid) {
> > +		unsigned char stablebuf[262144];
> 
> Is 256K a bit big for allocating on the stack? Modern OS's seem to give
> us at least a couple of megabytes (my Linux boxen all have 8M, and
> even Solaris 8 seems to have that much). But PTHREAD_STACK_MIN is only
> 16K (I don't think it is possible to hit this code path in a thread
> right now, but I'm not sure). And I have no idea what the situation is
> on Windows.
> 
> I dunno if it is worth worrying about, but maybe somebody more clueful
> than me can comment.

It is likely to have better performance if the buffer is small enough to 
fit in the CPU L1 cache.  There are two sequencial passes over the 
buffer: one for the SHA1 computation, and another for the compression, 
and currently they're sure to trash the L1 cache on each pass.

Of course that requires big enough objects to matter.


Nicolas
