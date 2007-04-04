From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 4 Apr 2007 09:02:13 +0300
Message-ID: <20070404060213.GB31984@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYyZn-0007dQ-8z
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992669AbXDDGCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992674AbXDDGCR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:02:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16949 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992669AbXDDGCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:02:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so546951uga
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 23:02:14 -0700 (PDT)
Received: by 10.66.248.5 with SMTP id v5mr1190885ugh.1175666534344;
        Tue, 03 Apr 2007 23:02:14 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id 13sm1584374ugb.2007.04.03.23.02.12;
        Tue, 03 Apr 2007 23:02:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43708>

Quoting Junio C Hamano <junkio@cox.net>:
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message

> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> > 3. if I want to have some text coming *before* the commit
> >> >    message ignored, there's no way to do this
> >> > 4. there's no way to override the subject from within the message
> >> >    (like there is with author/From line)
> >> 
> >> How about this?
> >
> > Looks good. What about 3?
> 
> When e-mailed message has garbage at the beginning (e.g. "Hi!"),
> git users can either run "commit --amend" immiediately after
> "git am",

This one would overwrite the authorship information though,
would it not? I actually wished several times for an --amend-message
commit flag that would only edit the message, preserving the author
(and possibly date?) metadata.
Of course, I simply copy the author and pass it in --author,
but it's somewhat awkward to do. Do others notice this?

*Maybe* git can be even smarter, and notice that only
commit message has changed, and preserve the author automatically
in this case? I haven't looked at how hard that would be to do.

<rant>
I actually find it awkward that author/summary information is never
shown during git commit - sometimes one does git commit
on a machine where GIT_AUTHOR_EMAIL has not been setup
correctly, and the result often is mst@mst-desktop.(none).
Or people sometimes forget that the first line will show up
in the pretty=short summary and the result is that what
ends up being there is just 2 first lines of the long description.

One has to remember to always do git log --pretty=short
after commit to verify that one did get these details right.

Ideas:
- Maybe have git-commit display shortlog summary for commit just created?
- Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
  commit message, and let the user edit them?
</rant>

> or edit the mbox with editor before running
> "applymbox", so the need has not been felt much us, and that is
> the primary reason why it is not there.  Additionally we do not
> think it is particularly a good practice to have "cover letters"
> at the top (cf. $gmane/5418), so it was never high priority for
> us to add that feature to encourage such a practice.
> 
> Having said that, on top of the recent work by Don Zickus on
> mailinfo, you _could_ add support for scissors "^-- >8 --$" if
> you want.

OK, I thought about this a bit - if the message includes a
cover letter, I think it's also likely to have an incorrect
subject too. So how about simply ignoring text before
Subject:/From: lines? This makes more sense, for me, than
inventing yet another git-specific convention. Does this for you?


-- 
MST
