From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 18:55:05 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
 <Pine.LNX.4.64.0704031511580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYruD-00049F-0K
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992478AbXDCWzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992474AbXDCWzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:55:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11680 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992470AbXDCWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:55:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFY008ET2BTCW70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 18:55:06 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031511580.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43689>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> I don't care *what* it is conditional on, but your arguments suck. You 
> claim that it's not a normal case to already have the objects, when it 
> *is* a normal case for alternates, etc.
> 
> I don't understand why you argue against hard numbers. You have none of 
> your own.

Are hard numbers like 7% overhead (because right now that's all we have) 
really worth it against bad _perceptions_?

Sure, the SHA1 collision attack is paranoia.  But it is becoming 
increasingly *possible*.

And when we only had unpack-objects on the receiving end of a fetch, you 
yourself bragged about the implied security of GIT in the presence of a 
SHA1 collision attack.  Because let's admit it: when a SHA1 collision 
will happen it is way more probable to come on purpose than from pure 
accident.  But as you said at the time, it is not a problem because GIT 
trusts local objects more than remote ones and incidentally 
unpack-objects doesn't overwrite existing objects.

The keeping of fetched packs broke that presumption of trust towards 
local objects and it opened a real path for potential future attacks.  
Those attacks are still fairly theoretical of course.  But for how 
_long_?  Do we want GIT to be considered backdoor prone in a couple 
years from now just because we were obsessed by a 7% CPU overhead?

I think we have much more to gain by playing it safe and being more 
secure and paranoid than trying to squeeze some CPU cycles out of an 
operation that is likely to ever be bounded by network speed for most 
people.

And we _know_ that the operation can be optimized further anyway.

So IMHO in this case hard numbers alone aren't the end of it.  Not as 
long as they're reasonably low.  And especially not for a command which 
is 1) rather infrequent and 2) not really interactive like git-log might 
be.


Nicolas
