From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 12:31:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705291227010.11491@xanadu.home>
References: <20070529071622.GA8905@spearce.org>
 <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
 <465C52D3.3010605@qumranet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Dana How <danahow@gmail.com>
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Tue May 29 18:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht4cM-0003n7-8E
	for gcvg-git@gmane.org; Tue, 29 May 2007 18:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbXE2Qb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbXE2Qb6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 12:31:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45272 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbXE2Qb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 12:31:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIT00CLK9X6C1H0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 May 2007 12:31:55 -0400 (EDT)
In-reply-to: <465C52D3.3010605@qumranet.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48701>

On Tue, 29 May 2007, Avi Kivity wrote:

> Jon Smirl wrote:
> > 
> > My work with databases leads me to believe that figuring out how to
> > pack everything into a smaller space always beats efforts put into
> > incrementally improving the indexing scheme. Packing into a smaller
> > space reduces the total IO needs and that's always a winner.
> > 
> 
> Another way to achieve that is to place objects that are accessed together
> nearby, and issue a larger read so as to bring them into cache.  I imagine
> that placing commit objects and associated tree and blobs in history order
> should help here (but maybe git already does that, I'm not familiar with the
> internals).

GIT already does that indeed, except for commit objects which are all 
together for better performances on history traversal operations.

After a fresh repack, the checkout of the latest revision should produce 
a nearly perfect linear and contigous access into the early portion of 
the same pack.  Things will get more random with access to objects 
further back in history of course, but those objects are less likely to 
be accessed as often.


Nicolas
