From: "Kirby C. Bohling" <kbohling@birddog.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 15:49:30 -0500
Message-ID: <20050825204930.GE7461@birddog.com>
References: <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com> <20050825195918.GD7461@birddog.com> <7vmzn5vkg6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:58:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Olh-0003TN-Js
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVHYU4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVHYU4K
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:56:10 -0400
Received: from hermes.birddog.com ([216.81.238.129]:50642 "EHLO
	hermes.birddog.com") by vger.kernel.org with ESMTP id S1751220AbVHYU4J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 16:56:09 -0400
Received: from hawk.birddog.com (hawk.birddog.com [10.15.4.100])
	by hermes.birddog.com (8.12.10/8.12.10) with ESMTP id j7PKnbtn011363;
	Thu, 25 Aug 2005 15:49:37 -0500
Received: from hawk.birddog.com (localhost.localdomain [127.0.0.1])
	by hawk.birddog.com (8.12.11/8.12.11) with ESMTP id j7PKnWvN011865;
	Thu, 25 Aug 2005 15:49:32 -0500
Received: (from kbohling@localhost)
	by hawk.birddog.com (8.12.11/8.12.11/Submit) id j7PKnUdj011863;
	Thu, 25 Aug 2005 15:49:30 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzn5vkg6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.15 (www dot roaringpenguin dot com slash mimedefang)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7763>

On Thu, Aug 25, 2005 at 01:19:05PM -0700, Junio C Hamano wrote:
> "Kirby C. Bohling" <kbohling@birddog.com> writes:
> 
> > I guess my final question is what does undo/redo have over saving
> > stuff away in a patch assuming that the patch captures all of the
> > SCM meta-data (the add/move/remove file type commands).  If git
> > doesn't capture all the meta-data in a patch, it would seem better
> > to make it do that and get this as a side-affect.
> 
> One thing that Carl's undo saves that is not easily available in
> the patch form is the "what is this patch based on" information.
> If you had it, you could do a three-way merge instead of patch
> application.

> You were at A (time flows from left to right) when somebody
> (maybe your bright idea) interrupted you.  You take a snapshot
> of your tree state D as a pair <A, D>, and rewind the tree to
> original commit A's state:
> 
>  -->A
>      \
>       D
> 
> Then you do the work that interrupted you, maybe making commits
> B and then C:
> 
>  -->A-->B-->C
>      \
>       D
> 
> At this point, you would want to restart working on whatever you
> were doing, which is the difference between A->D applied on top
> of C.
> 
> You could keep that information as a patch between A->D and
> apply it on top of C to get there, which is your approach if I
> am reading you correctly.  Carl does a three-way merge between C
> and D using A as the pivot point.

    Just out of curiosity, why isn't the SHA1 of 'A' part of the
diff or patch format?  I mean it can't be that hard to add it as a
single line of data that git can parse to extract that piece of
information.  Then a patch would enable you to do the 3-way merge
you describe.  If added properly "regular" patch would just ignore
that line.  The patch would then record that it is relative to 'A'.

    Assuming git could be taught "git-merge-patch" and then take use
the patch that's saved during the "undo" step and has the anchor for
the patch to use as the pivot point (as described above).  Life
should be good.  There are probably corner cases I don't understand,
but it sure looks like if you have the pivot or anchor point for the
patch embedded in the patch, you have all the needed information to
pull this off.

    I would think this would be generally useful outside of the
context of "undo/redo" also.

    Kirby
