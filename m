From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 11:26:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 27 17:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsKdJ-0000nK-SW
	for gcvg-git@gmane.org; Sun, 27 May 2007 17:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbXE0P0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXE0P0K
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 11:26:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbXE0P0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 11:26:09 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIP007P4HJIVOB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 11:26:07 -0400 (EDT)
In-reply-to: <20070527033429.GY28023@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48560>

On Sat, 26 May 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
> > Shawn:  When I first saw the index-loading code,  my first
> > thought was that all the index tables should be
> > merged (easy since sorted) so callers only need to do one search.
> 
> Yes; in fact this has been raised on the list before.  The general
> idea was to create some sort of "super index" that had a list of
> all objects and which packfile they could be found in.  This way the
> running process doesn't have to search multiple indexes, and the
> process doesn't have to be responsible for the merging itself.
> 
> See the thing is, if you read all of every .idx file on a simple
> `git-log` operation you've already lost.  The number of trees and
> blobs tends to far outweigh the number of commits and they really
> outweigh the number of commits the average user looks at in a
> `git-log` session before they abort their pager.  So sorting all
> of the available .idx files before we produce even the first commit
> is a horrible thing to do.

There is also the question of memory footprint.  If you have a global 
index, then for each object you need to have a tupple containing SHA1 + 
pack offset + reference to corresponding pack.  Right now we only need 
SHA1 + pack offset.

BTW I think the Newton-Raphson based index lookup approach should be 
revived at some point.


Nicolas
