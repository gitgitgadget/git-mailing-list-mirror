From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 01 May 2007 13:48:08 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0705011318000.6574@xanadu.home>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org>
 <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
 <20070501060340.GD5942@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 19:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiwSr-0008G3-Kk
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbXEARsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbXEARsa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:48:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27449 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbXEARsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:48:11 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHD00LCGIS865Q0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2007 13:48:09 -0400 (EDT)
In-reply-to: <20070501060340.GD5942@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45963>

On Tue, 1 May 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
> > On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >Why not
> > >refactor both to use the same implementation and stuff it away in
> > >say pack-check.c (for lack of a better place), or start a new file
> > >(pack-write.c)?
> > Actually I didn't just copy it, I tried to rewrite it for my use
> > as well as the fast-import.c use (note there is a 3rd copy
> > in some *index*.c file which I didn't try to merge in yet).
> > However I didn't yet put it in a new file or change fast-import.c
> > to call it since I wanted to change as little as possible.
> ...
> > I agree with all your arguments.  I had several reasons
> > to avoid extra rearrangements/refactorings:
> > (a) First patch to git, not previously known to me;
> > (b) I prefer to separate new functionality from "clean-up" work;
> 
> A really good reason.  ;-)
> 
> But I'd still rather see it done right the first time, then done
> partially (copied) and wait for someone to clean it up later.
> Sometimes that cleanup doesn't happen.

Well I intended to do more cleanups in the pack code eventually.  That 
included the index writing and pack header fixing.  But I was expecting 
for the pack splitting changes to go in first as it is likely to impose 
some requirements of its own. It is then easier to have a proper 
interface common to all users after everything is in place.

> > (d) Apparently you and Nicolas Pitre have a lot of pending changes
> >    affecting the packing code.
> 
> Yes, but Nico's work has also destroyed in pack v4 topic.  Nico has
> promised to start working on porting some of that work over, but I
> don't know if he has been able to start doing so yet.

It shouldn't be too hard to port the existing code.  Most of it is new 
code that hooks into the existing code in a limited way.

> I personally have been too busy this past month and a half to really 
> work on packv4, but I'm hoping to circle back to it before the end of 
> May (if Nico doesn't beat me to it!).

While the current pack v4 branch is certainly valuable, I consider it 
more as a proof of concept and a test bench.  In practice it isn't 
really efficient and it won't be able to show its full potential until 
core code like tree walking is better abstracted seamless processing of 
parallel tree representations.

But we're getting there slowly.  My work on index v2 will make the pack 
v4 changes much smaller in that area.  My progress display rework was a 
direct "huh!" reaction to the extra progress reporting the current pack 
v4 code added.  And the general pack-objects.c refactoring was made with 
a look on better and easier pack v4 integration in the future.

So in my mind pack v4 already started to make its way in the main code 
in subtle ways.  ;-)  But since I may do Git work only when I'm bored 
progress doesn't happen as fast as one would have expected.

> > I'd have no problem submitting a follow-on patch later containing
> > some clean-up work if you & NP clear it, so I know I won't have
> > problems from (d).  Note I had to completely rewrite this patch
> > when NP submitted some of his pending stuff.
> 
> Yea, hazard of working in this part of the code when Nico is
> also active.  My own sliding mmap stuff was written twice too,
> for the same reason - Nico doing much needed improvements right in
> the same spot as I was working, at the same time.

Well well.  OK I'm used to be considered as the bad guy anyway.  ;-)


Nicolas
