From: Nicolas Pitre <nico@cam.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sun, 06 Apr 2008 20:36:19 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0804062028260.2947@xanadu.home>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
 <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
 <1207351858.13123.52.camel@work.sfbay.sun.com>
 <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
 <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com>
 <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org>
 <20080406161003.GA24358@coredump.intra.peff.net>
 <alpine.LFD.1.00.0804062000240.2947@xanadu.home>
 <20080407001833.GA16558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@sun.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 02:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JifM5-0001h4-Jl
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 02:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbYDGAgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 20:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbYDGAgV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 20:36:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58962 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbYDGAgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 20:36:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JYX00B3SJ0JK2C0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Apr 2008 20:36:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080407001833.GA16558@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78944>

On Sun, 6 Apr 2008, Jeff King wrote:

> On Sun, Apr 06, 2008 at 08:13:10PM -0400, Nicolas Pitre wrote:
> 
> > Well, in your example, the large image part should already be common to 
> > many objects due to deltas if they're really the same: different objects 
> > will only have different EXIF data plus a delta reference to the same 
> > base image object. So in a way the split is already there.  Needs only 
> > that some applications exploit this information at runtime.
> 
> Yes, the resulting packfiles find the deltas and are pretty efficient
> (although it is quite slow to pack).  However, the delta information is
> not used at all for inexact rename detection. Are you proposing to make
> that information available to the rename detector?

In practice I don't know how well that would work since the 
current heuristic groups deltas and their 
base according to the name under which those objects are known.  So it 
is possible that some inexact renames end up creating objects that 
currently never delta against each other even if that would be the right 
thing to do.

But in some cases, that might be beneficial to look at the delta object 
themselves when diffing files as the delta might already contain the 
information telling the upper layer that file A and B are in fact 90% 
the same and that they differ from offset X to Y only.


Nicolas
