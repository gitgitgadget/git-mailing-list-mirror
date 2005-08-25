From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 13:19:05 -0700
Message-ID: <7vmzn5vkg6.fsf@assigned-by-dhcp.cox.net>
References: <20050824181004.GA18790@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
	<20050824195615.GA693@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241634350.23242@iabervon.org>
	<20050824204736.GA13194@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241651420.23242@iabervon.org>
	<7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
	<20050825024134.GA31886@hpsvcnb.fc.hp.com>
	<7v1x4izjtm.fsf@assigned-by-dhcp.cox.net>
	<20050825163201.GA3944@hpsvcnb.fc.hp.com>
	<20050825195918.GD7461@birddog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:22:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8OBs-00087P-0P
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVHYUTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVHYUTI
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:19:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41159 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932538AbVHYUTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 16:19:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825201907.SVYX3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 16:19:07 -0400
To: "Kirby C. Bohling" <kbohling@birddog.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7759>

"Kirby C. Bohling" <kbohling@birddog.com> writes:

> I guess my final question is what does undo/redo have over saving
> stuff away in a patch assuming that the patch captures all of the
> SCM meta-data (the add/move/remove file type commands).  If git
> doesn't capture all the meta-data in a patch, it would seem better
> to make it do that and get this as a side-affect.

One thing that Carl's undo saves that is not easily available in
the patch form is the "what is this patch based on" information.
If you had it, you could do a three-way merge instead of patch
application.

You were at A (time flows from left to right) when somebody
(maybe your bright idea) interrupted you.  You take a snapshot
of your tree state D as a pair <A, D>, and rewind the tree to
original commit A's state:

 -->A
     \
      D

Then you do the work that interrupted you, maybe making commits
B and then C:

 -->A-->B-->C
     \
      D

At this point, you would want to restart working on whatever you
were doing, which is the difference between A->D applied on top
of C.

You could keep that information as a patch between A->D and
apply it on top of C to get there, which is your approach if I
am reading you correctly.  Carl does a three-way merge between C
and D using A as the pivot point.
