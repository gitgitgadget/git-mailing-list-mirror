From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Tue, 03 Apr 2007 23:24:09 -0700
Message-ID: <7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYyuq-0003Ri-MW
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992693AbXDDGYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992697AbXDDGYM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:24:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62275 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992693AbXDDGYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:24:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404062410.PVFC28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 02:24:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iuQ91W0081kojtg0000000; Wed, 04 Apr 2007 02:24:10 -0400
In-Reply-To: <20070404060213.GB31984@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 4 Apr 2007 09:02:13 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43712>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
>
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>> 
>> >> > 3. if I want to have some text coming *before* the commit
>> >> >    message ignored, there's no way to do this
>> >> > 4. there's no way to override the subject from within the message
>> >> >    (like there is with author/From line)
>> >> 
>> >> How about this?
>> >
>> > Looks good. What about 3?
>> 
>> When e-mailed message has garbage at the beginning (e.g. "Hi!"),
>> git users can either run "commit --amend" immiediately after
>> "git am",
>
> This one would overwrite the authorship information though,
> would it not? I actually wished several times for an --amend-message
> commit flag that would only edit the message, preserving the author
> (and possibly date?) metadata.
> Of course, I simply copy the author and pass it in --author,
> but it's somewhat awkward to do. Do others notice this?
>
> *Maybe* git can be even smarter, and notice that only
> commit message has changed, and preserve the author automatically
> in this case? I haven't looked at how hard that would be to do.
>
> <rant>
> I actually find it awkward that author/summary information is never
> shown during git commit - sometimes one does git commit
> on a machine where GIT_AUTHOR_EMAIL has not been setup
> correctly, and the result often is mst@mst-desktop.(none).
> Or people sometimes forget that the first line will show up
> in the pretty=short summary and the result is that what
> ends up being there is just 2 first lines of the long description.
>
> One has to remember to always do git log --pretty=short
> after commit to verify that one did get these details right.
>
> Ideas:
> - Maybe have git-commit display shortlog summary for commit just created?
> - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
>   commit message, and let the user edit them?
> </rant>
>
>> or edit the mbox with editor before running
>> "applymbox", so the need has not been felt much us, and that is
>> the primary reason why it is not there.  Additionally we do not
>> think it is particularly a good practice to have "cover letters"
>> at the top (cf. $gmane/5418), so it was never high priority for
>> us to add that feature to encourage such a practice.
>> 
>> Having said that, on top of the recent work by Don Zickus on
>> mailinfo, you _could_ add support for scissors "^-- >8 --$" if
>> you want.
>
> OK, I thought about this a bit - if the message includes a
> cover letter, I think it's also likely to have an incorrect
> subject too. So how about simply ignoring text before
> Subject:/From: lines? This makes more sense, for me, than
> inventing yet another git-specific convention. Does this for you?

People sometimes say something like:

    From: Quim K Holland <qkholland@cox.net>
    Date: Wed, 4 Apr 2007 09:02:13 +0300
    Subject: [PATCH] Fix frobnitz while nitfol is in use
    Message-Id: <20070404060213.GB31984@filfre.cox.net>

    Earlier Sloof Lirpa reported that frobnitz feature has problems
    when nitfol is running background in this message:

    From: Sloof Lirpa <sitemaster@cox.net>
    Subject: [BUG] frobnitz garbles its output
    Message-Id: <20070403060213.GB31984@frotz.cox.net>

    Upon closer inspection, the problem is caused by filfre
    function firing up prematurely because nitfol process grabs
    semaphore and never releases it.  Here is a patch to fix
    this issue...

    Signed-off-by: Quim K Holland <qkholland@cox.net>
    ---
    diff --git a/... b/...

And that is why we do not even pick up the From: and stuff in
the middle of the message.

We might be able to convince people to adopt a convention to use
an explicit mark to signal the end of cover letter (or maybe
make it an option in .git/config), but one thing we do not
absolutely want to do is to pick up "^(From|Date|Subject): "
from any random place in the middle of message, let alone
discarding what comes before them.

That is, something like the following might be acceptable
instead:

    From: Sloof Lirpa <sitemaster@cox.net>
    Subject: [BUG] frobnitz garbles its output
    Message-Id: <20070403060213.GB31984@frotz.cox.net>

    Quim K Holland's patch fixes the problem I reported earlier,
    so I am forwarding his patch.  Please apply.

    -- >8 --
    From: Quim K Holland <qkholland@cox.net>
    Date: Wed, 4 Apr 2007 09:02:13 +0300
    Subject: [PATCH] Fix frobnitz while nitfol is in use
    Message-Id: <20070404060213.GB31984@filfre.cox.net>

    Earlier Sloof Lirpa reported that frobnitz feature has problems
    when nitfol is running background in this message:

    Upon closer inspection, the problem is caused by filfre
    function firing up prematurely because nitfol process grabs
    semaphore and never releases it.  Here is a patch to fix
    this issue...

    Signed-off-by: Quim K Holland <qkholland@cox.net>
    ---
    diff --git a/... b/...
