From: Nicolas Pitre <nico@cam.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 21:12:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703252102520.3041@xanadu.home>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
 <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org>
 <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org>
 <20070325203141.GA12376@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVdlP-0005pp-F4
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 03:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473AbXCZBMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 21:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933471AbXCZBMo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 21:12:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60440 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933482AbXCZBMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 21:12:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFH00HSQKP5O970@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 25 Mar 2007 21:12:42 -0400 (EDT)
In-reply-to: <20070325203141.GA12376@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43101>

On Sun, 25 Mar 2007, Shawn O. Pearce wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Sun, 25 Mar 2007, Shawn O. Pearce wrote:
> > > >
> > > > What happens to the paths, that do not have a correponding entry in the
> > > > path name table, because they are not among the 65535 most frequent
> > > > paths in the pack?
> > > 
> > > They don't appear in the table.  And any tree that uses them is
> > > forced to use the "legacy" OBJ_TREE encoding.  Which is what we
> > > have now in pack v2, and in loose objects.
> > 
> > Would it hurt too much to just make it four bytes, and avoid that issue?
> > 
> > Special cases - and *especially* special cases that are hard to trigger in 
> > the first place - equal bugs. And bugs are much much worse than trying to 
> > save a little bit of space.
> 
> Worth exploring.  When I get back to rebasing that topic onto
> Junio's tree I'll try a 4 byte index and see what kind of damage
> it does on space on large projects (Mozilla, linux-2.6, Eclipse).
> You may be right, an 8 byte record may just be worth the cost.

Maybe simply 3 bytes might be a good compromise too.  I doubt a single 
pack is ever to contain 4G paths since it is limited to 4G _objects_ in 
the first place.

Another approach is to have the path index field width as the first item 
in such an object.  This way it can be scalled as needed.

BTW Shawn there is no need to store the number of tree records at the 
beginning of the tree object since that can be deduced directly from the 
object size stored in the object header.


Nicolas
