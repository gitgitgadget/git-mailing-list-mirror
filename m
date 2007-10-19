From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 14:51:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191431450.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org> <4718D25A.7040109@midwinter.com>
 <alpine.LFD.0.9999.0710191211210.19446@xanadu.home>
 <20071019172610.GE30825@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 20:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiwwk-00008m-NT
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 20:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbXJSSvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758801AbXJSSvf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 14:51:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58321 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757456AbXJSSve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 14:51:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ600LN09PUYQ00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 14:51:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019172610.GE30825@uranus.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61740>

On Fri, 19 Oct 2007, Sam Ravnborg wrote:

> On Fri, Oct 19, 2007 at 12:12:41PM -0400, Nicolas Pitre wrote:
> > This is even more wrong.
> > 
> > Agreed, indexing objects might not be the best description.  It probably 
> > will become "receiving objects" along with a bandwitth meter.
> 
> The term 'objects' here always confuses me. What is often my first
> thing to check the number of individual commits being added after
> a git pull. Wether a commit touches one or several files is less
> important (to my way of using git).

Let me unconfuse you.

Git storage is made of, well, objects.  You might think that objects are 
related to the number of files concerned by a set of commits during a 
pull, but this is not the case.  It is well possible to have a commit 
touching 100 files and have much fewer new objects created than that.  
Reverting a patch, for example, would only restore a reference to older 
objects in the database.  The same is true if you move an entire 
directory around.

The opposite is also true: you can have more new objects than modified 
files for a single commit, depending on the directory depth.

So the number of objects has no exact relationship what so ever with the 
number of objects.  However the number of objects has a much more direct 
influence on the time to perform a fetch, and that is what we're 
displaying here.  After all when you issue a pull and wait for it to 
complete, you wait for X amount of objects to be transferred and not Y 
amount of commits.

The important metric is therefore measured in "objects".  But you're 
free to ignore it and only look at the percentage if you prefer.


Nicolas
