From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 17:34:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
 <20070403210319.GH27706@spearce.org>
 <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
 <20070403211709.GJ27706@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqeN-0003XD-PK
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945943AbXDCVen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945982AbXDCVen
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:34:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40664 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945943AbXDCVem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:34:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00JFHYLTD8A0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 17:34:41 -0400 (EDT)
In-reply-to: <20070403211709.GJ27706@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43673>

On Tue, 3 Apr 2007, Shawn O. Pearce wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> > > If its the missing-object lookup that is expensive, maybe we should
> > > try to optimize that.  We do it enough already in other parts of
> > > the code...
> > 
> > Well, for all other cases it's really the "object found" case that is 
> > worth optimizing for, so I think optimizing for "no object" is actually 
> > wrong, unless it also speeds up (or at least doesn't make it worse) the 
> > "real" normal case.
> 
> Right.  But maybe we shouldn't be scanning for packfiles every
> time we don't find a loose object.  Especially if the caller is in
> a context where we actually *expect* to not find said object like
> half of the time... say in git-add/update-index.  ;-)

First, I truly believe we should have a 64-bit pack index and fewer 
larger packs than many small packs.

Which leaves us with the actual pack index lookup.  At that point the 
cost of finding an existing object and finding that a given object 
doesn't exist is about the same thing, isn't it?

Optimizing that lookup is going to benefit both cases.


Nicolas
