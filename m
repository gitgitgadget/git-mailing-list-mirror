From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 15:02:56 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0703311459000.28181@xanadu.home>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org>
 <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
 <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
 <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 21:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXiqq-0002ON-T2
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 21:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXCaTC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbXCaTC5
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 15:02:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34073 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbXCaTC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 15:02:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFS00GDT7KWOK70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 31 Mar 2007 15:02:56 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43566>

On Sat, 31 Mar 2007, Linus Torvalds wrote:

> The thing is, I think the index-pack could be improved, but I think we can 
> get a bigger improvement from just being more intelligent about searching 
> than from actually needing to re-organize the pack.
> 
> Here's a few clues:
>  - one of the fundamental rules about cryptographic hashes is that they 
>    are *evenly*distributed*

I was thinking about that too.

> So here's a suggestion:
> 
>  - start finding a range using the 256-entry fan-out, exactly the way we 
>    did for the binary search. It's cheap. We could probably avoid EVEN 
>    THIS, and just do one more newton-raphson iteration more. But since we 
>    have the data, we migth as well use it. After all, it really *is* just 
>    a first approximation of newton-raphson, and while it uses only 8 bits 
>    (and we could do better), at least it's an *exact* one.
> 
>  - use newton-raphson to iterate closer. It should be a much faster way to 
>    find the rough area for the entry we're searching for than binary 
>    search. Two or three iterations should get us there, easily.
> 
>  - do a linear search once you're close enough.

I like that.


Nicolas
