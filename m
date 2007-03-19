From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 12:54:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191248360.18328@xanadu.home>
References: <20070319051437.GA22494@spearce.org>
 <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTL7k-0004k6-3w
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbXCSQyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbXCSQyO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:54:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23533 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030401AbXCSQyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:54:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500EOZTMCSHH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 12:54:12 -0400 (EDT)
In-reply-to: <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42643>

On Mon, 19 Mar 2007, Nicolas Pitre wrote:

> And because we usually walk objects from newest to oldest, and because 
> deltas are usually oriented in the same direction, we only need to tweak 
> the current eviction loop a bit so on average the oldest objects are 
> evicted first so next time around the current base will still be there 
> for the next delta depth.  Given the nature of the hash containing the 
> object's offset that means starting the loop at the next entry index 
> instead of zero which should do the trick pretty well.

OK. Two flaws above: to be clear it is the newest objects in terms of 
absolute age should be evicted first, which means the oldest to have 
been cached.  Then the hash cannot be representative of the object 
ordering because it is reduced to 8 bits and objects are often enough 
more than 256 bytes apart to make this hash based ordering completely 
random.  A simple LRU might be quite effective instead.


Nicolas
