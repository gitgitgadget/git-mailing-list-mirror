From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 17:32:00 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271717080.29426@xanadu.home>
References: <20070227155042.GB3230@spearce.org>
 <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAsA-0007TW-B6
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXB0WcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXB0WcE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:32:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40673 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbXB0WcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:32:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE5000IY7XCIA53@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 17:32:00 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40826>

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 27 Feb 2007, Shawn O. Pearce wrote:
> > 
> > We have thus far reformatted OBJ_TREEs with a new dictionary based
> > compression scheme.  In this scheme we pool the filenames and modes
> > that appear within trees into a single table within the packfile.
> > All trees are then converted to use a 22 byte record format:
> > 
> >   - 2 byte network byte order index into the string pool
> >   - 20 byte SHA-1
> 
> Umm. Am I missing something, or is this totally braindamaged?
> 
> Are you really expecting there to never be more than 64k basenames? Trust 
> me, that's a totally broken assumption. Anything that tracks generated 
> stuff will _easily_ have several tens of thousands of random filenames 
> even in a single tree, much less over the whole history of the repository.

The idea is to deal with only tree objects containing the 64K most 
frequently used base names and fall back to the current tree object 
encoding for objects that couldn't be represented that way.

For reference the GIT tree itself has 585 unique names.

The Linux kernel has 12263 of them.

If we eventually find it is common and performance critical to have more 
bits to represent those indices because the number of unique path 
components far exceeds that limit with an even distribution then we 
might just add another tree encoding with a 3-byte index for those.

In the end everything translates back to the same object.


Nicolas
