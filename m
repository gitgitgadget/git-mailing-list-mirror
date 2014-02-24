From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: `git stash pop` UX Problem
Date: Mon, 24 Feb 2014 11:04:25 -0500
Message-ID: <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
References: <530B0395.5030407@booking.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Omar Othman <omar.othman@booking.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHy1T-0000r7-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaBXQEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:04:47 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51008 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbaBXQEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:04:46 -0500
Received: by mail-wi0-f171.google.com with SMTP id cc10so3264242wib.4
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l/EbS+PPLCzYwNOanmXsthKU7N+QTBtlMNkQOf/5j+4=;
        b=l5dyz5S46qfxS+aIeSTIjuyeF8UDVArkZY1Sda8KBiH3mZ7bTLAsRSomVRXt5Lh1ZD
         k/t0lexgUBcX8ux3qVe7we4HHt/fY/6tK3cVbLaVSDlnmQR3sEKPUl1Lv/unqscfdHqc
         T8NsdCtGrRsOqGsQJ5YmIUWKlO55/g+WEj5mQeS3Y/VBtUBCSuOxlG8PG+XQcxdn4mja
         606K+5BFi/z1h6q+GOY6zeTvFycG87uhXRz5QqOotbHIlluokpNw1kd1/d3yz9zBezXr
         LLzudcgU6hftS0VBOaj0oY1wkl93ZWEZ63afT1iaTaQmVcZSNifS7oUi2Z4HsFPU07OJ
         ws8w==
X-Received: by 10.180.105.65 with SMTP id gk1mr15319956wib.12.1393257885260;
 Mon, 24 Feb 2014 08:04:45 -0800 (PST)
Received: by 10.216.176.65 with HTTP; Mon, 24 Feb 2014 08:04:25 -0800 (PST)
In-Reply-To: <530B0395.5030407@booking.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242588>

Omar:

On Mon, Feb 24, 2014 at 3:32 AM, Omar Othman <omar.othman@booking.com> wrote:
> In general, whenever something a user "should" do, git always tells. So, for
> example, when things go wrong with a merge, you have the option to abort.
> When you are doing a rebase, git tells you to do git commit --amend, and
> then git rebase --continue... and so on.
>
> The point is: Because of this, git is expected to always instruct you on
> what to do next in a multilevel operation, or instructing you what to do
> when an operation has gone wrong.
>
> Now comes the problem. When you do a git stash pop, and a merge conflict
> happens, git correctly tells you to fix the problems and then git add to
> resolve the conflict. But once that happens, and the internal status of git
> tells you that there are no more problems (I have a prompt that tells me
> git's internal status), the operation is not culminated by dropping the
> stash reference, which what normally happens automatically after a git stash
> pop. This has actually confused me for a lot of time, till I ran into a git
> committer and asked him, and only then were I 100% confident that I did
> nothing wrong and it is indeed a UX problem. I wasted a lot of time to know
> why the operation is not completed as expected (since I trusted that git
> just does the right thing), and it turned out that it is git's fault.
>
> If this is accepted, please reply to this email and tell me to start working
> on it. I've read the Documenation/SubmittingPatches guidelines, but I'll
> appreciate also telling me where to base my change. My guess is maint, since
> it's a "bug" in the sense of UX.

Unlike a merge, when you pop a stash that history is lost. If you
screw up the merge and the stash is dropped then there's generally no
reliable way to get it back. I think that it's correct behavior for
the stash to not be dropped if the merge conflicts. The user is
expected to manually drop the stash when they're done with it. It's
been a while since I've relied much on the stash (commits and branches
are more powerful to work with) so I'm not really familiar with what
help the UI gives when a conflict occurs now. Git's UI never really
expects the user to be negligent. It does help to hint to you what is
needed, but for the most part it still expects you to know what you're
doing and does what you say, not what you mean.

If there's any change that should be made it should be purely
providing more detailed instructions to the user about how to deal
with it. Either resolve the merge conflicts and git-add the
conflicting files, or use git-reset to either reset the index
(unstaging files nad clear) or reset index and working tree back to
HEAD. In general, I almost always git-reset after a git-stash pop
because I'm probably not ready to commit those changes yet and
generally want to still see those changes with git diff (without
--staged). Or perhaps just direct them to the appropriate sections of
the man pages.

I'm not really in favor of "dumbing down" Git in any way and I think
that any step in that direction would be for the worst... Software
should do what you say, not what you mean, because it's impossible to
reliably guess what you meant. When a git-stash pop operation fails
that might make the user rethink popping that stash. That's why it
becomes a manual operation to drop it if still desired. And unlike
git-reset --continue, which is explicitly the user saying "it is fixed
and I accept the consequences, let's move on", there is no such option
to git-stash to acknowledge that the merge conflicts have been
resolved and you no longer need that stash (aside from git-stash drop,
of course). It's not a UI problem. It's maybe a documentation problem,
but again I'm not familiar with the current state of that.

/not a git dev...yet

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
