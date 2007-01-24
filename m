From: Nicolas Pitre <nico@cam.org>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 22:18:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701232206130.3011@xanadu.home>
References: <200701231259.27719.andyparkins@gmail.com>
 <45B6076F.5060503@op5.se> <200701231314.53361.andyparkins@gmail.com>
 <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701231649520.3011@xanadu.home>
 <7vbqkpkxhk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701232103290.3011@xanadu.home> <ep6fre$2i2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 04:19:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Yf6-0003cU-HN
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 04:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbXAXDS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 22:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbXAXDS5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 22:18:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27390 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030188AbXAXDS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 22:18:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCC001LQRVKWVH0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Jan 2007 22:18:56 -0500 (EST)
In-reply-to: <ep6fre$2i2$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[ please CC me when replying, please ]

On Wed, 24 Jan 2007, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> 
> > On Tue, 23 Jan 2007, Junio C Hamano wrote:
> > 
> >> Nicolas Pitre <nico@cam.org> writes:
> >> 
> >>> On Tue, 23 Jan 2007, Junio C Hamano wrote:
> >>>
> >>>> And we might want to allow reflogs on detached HEAD someday,
> >>>> although I personally think it goes against what detached HEAD
> >>>> is -- it is of a very temporary nature.
> >>>
> >>> Didn't we agree already that reflog with detached head was simply 
> >>> insane?
> >> 
> >> Perhaps, perhaps not.
> >> 
> >>      $ git checkout v2.6.14
> >>      $ git checkout v2.6.15
> >>      $ git checkout v2.6.16
> >> 
> >> Ah, which one did I check-out the last time?
> >> 
> >>      $ git describe HEAD@{1}
> > 
> > And what does HEAD@{1} means if not detached?
> > 
> > If there is a reflog for HEAD independently of what branch HEAD is 
> > attached to then it could make sense.  Meaning that if you're on branch 
> > "master" and perform a commit, then both reflogs for "master" and "HEAD" 
> > are updated at the same time.  If you then checkout branch "next" then 
> > only the "HEAD" reflog is updated since no changes to any branch did 
> > occur but just HEAD changed.
> > 
> > Then moving around and/or committing with a detached head would just 
> > update the "HEAD reflog.
> 
> I think it would be best to maintain mixed approach. When we are on some
> branch, the HEAD@{1} would mean <current branch>@{1}. When HEAD is detached
> (is not symlink or symref), HEAD@{1} means it's latest state. Detaching
> a head creates reflog, de-detaching deletes it...

Please no.  I think this is exactly the absolutely worst thing you could 
have.  Better not have any reflog for detached heads at all.

First, if you're not playing with detached heads then you don't care 
since it makes no difference.

But if you do use a detached head then having HEAD@{n} suddenly change 
from one universe to another just because you detached or attached HEAD 
from/to a branch is insane.

Consider HEAD@{1} when you just detached from a branch?  According to 
your suggestion it would point into the void.

And why wouldn't HEAD@{1} refer back to a detached state right after 
checking out a branch?  According to your suggestion the last detached 
position is now lost.  Worse, it will point to a commit which might have 
nothing to do with the previous operation I performed with my repository 
which is IMHO against the spirit of a reflog for "HEAD".


Nicolas
