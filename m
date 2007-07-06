From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Thu, 05 Jul 2007 18:31:03 -0700
Message-ID: <7v8x9uiai0.fsf@assigned-by-dhcp.cox.net>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:31:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6cf7-00049P-Da
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761496AbXGFBbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761037AbXGFBbF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:31:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33786 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758688AbXGFBbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:31:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706013102.BISV11062.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 21:31:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L1X31X00A1kojtg0000000; Thu, 05 Jul 2007 21:31:03 -0400
In-Reply-To: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
	(Dan McGee's message of "Thu, 5 Jul 2007 20:22:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51712>

"Dan McGee" <dpmcgee@gmail.com> writes:

> In this commit:
> b516968ff62ec153e008d033c153affd7ba9ddc6
>
> I don't know if anyone else has the same way of working as I do, but I
> tend to set the "remote.<name>.skipDefaultUpdate" property to true for
> my publicly visible repository, just so I don't have duplicate branch
> heads lying around in my local repository. Call this peculiar, but I
> like it that way. However, git-push does not respect this property,
> meaning I know have these branches whether I want them or not. In a
> tool such as qgit or even 'git branch -a' output, it starts to get
> awful cluttered.

Actually I do not think git-push nor git-fetch are related to
what that configuration variable tries to control at all.  The
variable controls what "git remote update" does.

Do you fetch from your 'publicly visible repository', and do you
use tracking branches for it when you do "git fetch" from there?

    $ git push my-public

is supposed to pretend that immediately after the push you did
"git fetch my-public" _if_and_only_if_ your "git fetch
my-public" would fetch the branches you pushed, and you have
configured to store them in .git/refs/remotes/my-public/
(i.e. your tracking branches).  So if you do not fetch from your
remote and do not have configuration to use tracking branches
when you fetch from there, and if you still see that your push
updates your tracking branches, then you found a bug.

But if you do have configuration to use tracking branches when
you fetch from there, that is a different story.  I do not think
there currently is a way to disable that "pretend we have
fetched back immediately" behaviour.  There could be valid
reasons that you may _want_ to keep your existing tracking
branches stale after a push, in which case we may want to make
it overridable, but at the time that change was accepted, nobody
had such a convincing use scenario.
