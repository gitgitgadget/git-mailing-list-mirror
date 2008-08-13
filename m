From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 13:57:59 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131352260.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <m363q5t152.fsf@localhost.localdomain> <20080813150425.GC3782@spearce.org>
 <200808131810.19914.johan@herland.net>
 <a6b6acf60808131038s1ae7fb69s2b703c25766a82c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>
To: Ken Pratt <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKcz-0007cn-Vl
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYHMR6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbYHMR6S
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:58:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47432 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYHMR6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:58:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J00HP0WKXBBIB@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 13:58:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <a6b6acf60808131038s1ae7fb69s2b703c25766a82c0@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92252>

On Wed, 13 Aug 2008, Ken Pratt wrote:

> > As for how to estimate entropy, isn't that just a matter of feeding it
> > through zlib and compare the output size to the input size? Especially
> > if we're already about to feed it through zlib anyway... In other
> > words, feed (an initial part of) the data through zlib, and if the
> > compression ratio so far looks good, keep going and write out the
> > compressed object, otherwise abort zlib and write out the original
> > object with compression level 0.
> 
> This is probably off topic now, but as the OP, I'd like to mention
> that I tried setting pack.compression = 0 and it did not solve my
> memory issues.

Yeah, the compression level is a tengential issue which has to do with 
speed.

> So it seems to be that the packing itself that is
> sucking up all the memory -- not the compression.

Initial packing requires enough memory.  And if your repository is not 
packed, then every clone request will act just like a first packing. So 
for git on a server to behave well, repositories have to be well packed.


Nicolas
