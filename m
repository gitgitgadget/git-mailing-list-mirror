From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 12:35:39 -0400
Message-ID: <45FAC75B.3030902@garzik.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFQP-0007df-Mg
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965508AbXCPQfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965571AbXCPQfr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:35:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60179 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965508AbXCPQfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:35:43 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HSFP2-0006Ue-7V; Fri, 16 Mar 2007 16:35:40 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42376>

Linus Torvalds wrote:
> The normal size for the performance-critical git objects are in the couple 
> of *hundred* bytes. Not kilobytes, and not megabytes.
> 
> The most performance-critical objects for uncompression are commits and 
> trees. At least for the kernel, the average size of a tree object is 678
> bytes. And that's ignoring the fact that most of them are then deltified, 
> so about 80% of them are likely just a ~60-byte delta.


Ahhh.  At least for me, that explains a lot.  Rather than spending all 
its time in inflate_fast(), git is dealing with lots of zlib 
startup/shutdown overhead.

Although it sounds like zlib could indeed be optimized to reduce its 
startup and shutdown overhead, I wonder if switching compression 
algorithms to a pure Huffman or even RLE compression (with associated 
lower startup/shutdown costs) would perform better in the face of all 
those small objects.

And another random thought, though it may be useless in this thread:  I 
bet using a pre-built (compiled into git) static zlib dictionary for git 
commit and tree objects might improve things a bit.

	Jeff
