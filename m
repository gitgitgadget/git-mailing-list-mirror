From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Thu, 07 Feb 2008 23:48:05 -0800
Message-ID: <7vwspfkhxm.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNz2-00062B-R5
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759568AbYBHHs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbYBHHs2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:48:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759354AbYBHHs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 02:48:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C55AA6C63;
	Fri,  8 Feb 2008 02:48:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3018D6C62;
	Fri,  8 Feb 2008 02:48:23 -0500 (EST)
In-Reply-To: <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 8 Feb 2008 17:50:36 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73051>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Feb 8, 2008 5:44 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>>  None of these "rejected" branches have anything _new_, they
>> are just stale. Nothing new to say.
>
> And I guess the natural follow up question is: would it make sense to
> tell git pull to do a "merge" for not-checked-out branches where we
> can safely tell that the resulting "merge" will actually be a
> fast-forward?
>
> Would that be unsafe in any way?

Not "unsafe" in the sense that you would not be losing commit
objects, but I'd feel uneasy about that.  The fact that the
branch tip was pointing at an older commit gets lost, and in
your workflow that information is useless, but that does not
necessarily mean it is useless for everybody.

> Because when I "git checkout bla-stale-branch" to help a fellow
> developer again, I have to remember to "git merge
> origin/bla-stale-branch" to get a much needed fast-forward before
> starting to work.

Perhaps it might make sense to have a checkout hook that notices
the branch that is being checked out is meant to build on top of
a corresponding remote tracking branch, and performs the
necessary fast-forward when that is the case.

> [ Or we could be more proactive at deleting unused local heads. But
> that's a bit of silly maintenance just to keep things tidy, that git
> could keep tidy ;-) ... ]

Well, git couldn't, unless you tell it "I've pushed out my work,
and I am done with helping with this client branch for now", and
the way for you to do so is "git branch -d".

Perhaps "git branch -d" should be taught to check if the tip of
the deleted branch is part of the corresponding remote tracking
branch, when "one local branch to track one remote branch" model
is used.  Its safety to forbid deleting the branch unless it is
an ancestor of the "current" branch would not make sense in such
a workflow.
