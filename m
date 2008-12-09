From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 17:32:36 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812091651360.19665@iabervon.org>
References: <1228815240.18611.48.camel@starfruit.local>  <20081209191704.6117@nanako3.lavabit.com> <1228819087.18611.73.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1969388103-1228861956=:19665"
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAB9Q-0005Td-FF
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 23:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYLIWcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 17:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYLIWcj
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 17:32:39 -0500
Received: from iabervon.org ([66.92.72.58]:53397 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbYLIWci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 17:32:38 -0500
Received: (qmail 1683 invoked by uid 1000); 9 Dec 2008 22:32:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2008 22:32:36 -0000
In-Reply-To: <1228819087.18611.73.camel@starfruit.local>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102656>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1969388103-1228861956=:19665
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 9 Dec 2008, R. Tyler Ballance wrote:

> On Tue, 2008-12-09 at 19:17 +0900, Nanako Shiraishi wrote:
> > Quoting "R. Tyler Ballance" <tyler@slide.com>:
> > 
> > > The most common use-case involves a user merging a project branch into a
> > > stabilization branch (`git checkout stable && git pull . project`) in
> > > such a way that no merge commit is generated. Of course, without
> > > thinking they'll push these changes up to the centralized repository.
> > > Not 15 minutes later they realize "ruh roh! I didn't want to do that"
> > 
> > Why does the user not want to fast-forward, if the merge she wants to do is actually a fast-forward?
> 
> I agree with you, this is more about preventing coworkers who are too
> lazy to understand the entirety of what they're doing from hurting the
> workflow of "the rest of us". It's a technically solution to a people
> problem (I understand technology far more than people ;))
> 
> Consider the following scenarion:
>   % git checkout -b project﻿
> ﻿  % <work>
> ﻿  % git commit -am "A"﻿
> ﻿  % <work>
> ﻿  % git commit -am "B"﻿
> ﻿  % <work>
> ﻿  % git commit -am "C"﻿
> ﻿  % <work>
> ﻿  % git commit -am "D"
> ﻿﻿  % git checkout stable
> ﻿﻿  % git pull . project
> ﻿﻿  % <fast-forward>
> ﻿﻿  % git push origin stable
> ﻿﻿
> At this point, QA is involved and what can happen is that QA realizes
> that this code is *not* stable and *never* should have been brought into
> the stable branch.

How do you prevent the (IMHO more likely) case of:

% git checkout -b project
% git checkout stable
<fix some bug in stable>
% git commit -a
<forget to switch branches back>
<work>
% git commit -am "A"
<work>
% git commit -am "B"
...
% git push origin stable

That is, the developer makes a whole bunch of inappropriate commits on 
their stable branch instead of their project branch and then pushes it out 
(perhaps as part of a push rule, or thinking only the bug fix went there). 
I suspect that "pull" step there isn't the point where things are going 
wrong.

If you've actually got QA in the process, have developers push to a 
per-developer location and send a pull request to QA. QA can reject bad 
changes instead of putting them into the stable branch at all, and then 
they can reply to the pull requests with snide comments instead of having 
to beat up the developers, because the developer doesn't inconvenience 
anybody (except QA, whose job is to be inconvenienced by developers).

> I'm less concerned at this point, the company switched entirely to Git
> two weeks ago, with the history containing possible unwanted merges. I'm
> more concerned however with LazyDeveloper inadvertently polluting stable
> branches as LazyDeveloper does not yet fully grasp the concepts that Git
> offers

I think such developers are more likely to push some bad commits to 
"stable" directly than they are to make their bad commits on a branch, 
merge it (fast-forward or otherwise) and push the result. It's also easy 
to discover:

% git push origin project:stable

And not generate a merge commit simply by virtue of not merging branches.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1969388103-1228861956=:19665--
