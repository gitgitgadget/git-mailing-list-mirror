From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 02 Jan 2007 14:44:31 -0800
Message-ID: <7virfprquo.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1sN3-0007pc-8s
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXABWoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbXABWoe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:44:34 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37400 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964913AbXABWod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:44:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102224433.SZYM19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 17:44:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6Njl1W0071kojtg0000000; Tue, 02 Jan 2007 17:43:46 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ps9xgkjo.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	02 Jan 2007 13:56:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35835>

Carl Worth <cworth@cworth.org> writes:

> On Mon, 01 Jan 2007 23:45:08 -0800, Junio C Hamano wrote:
>> This allows "git checkout -d v1.4.3" to detach the HEAD from any
>> branch but point directly at the named commit.
>
> Being able to perform "checkout" with a tag like this, (and no
> specific branch), is something I've been wanting git to acquire for
> some time. So, thanks for coding this up!
>
>> This is still experimental.  While I think it makes sense to
>> allow commits on top of detached HEAD, it is rather dangerous
>> unless you are careful and know what you are doing.
>
> This part I don't understand. I don't see why it's useful to introduce
> new danger to "git checkout"...

I am not saying being risky is useful.  That's why I said it is
experimental.

We could do two things, and I think disallowing commits is not
necessarily a better option of the two.  We could allow commits
and prevent the user from switching out of the detached HEAD
state without an explicit action instead.  If we go the first
route, you need to also prevent merges into the detached HEAD.
If we go the latter I think you only need to add a check in
"git-checkout" but there may be other cases.  In either way, we
need a safety valve, which the experimental code does not have.

And being able to merge into the detached HEAD turns out to be
somewhat useful.  I checked out the v1.4.4.3 and tried to see if
a topic is applicable by merging into that detached HEAD and
running testsuite.  Of course, without any safety valve, I can
easily lose the merge result by switching out of the detached
HEAD state (say, "git checkout master"), but on the other hand,
creating a new branch at that point with "git checkout -b
v1.4.4.3-maint" would let me continue from that point without
losing anything.

But this is only "somewhat" -- I do not have strong opinion
either way, other than that we need a safety valve (which we
agree).

In any case, I did this because I got tired of waiting for it to
happen (I thought you wanted to hack on this over the long
week^W yearend, so I deliberately stayed away from doing this)
and I was bored.  This will not be in 'next' in the current
shape.

You've thought about the issue long enough to write your
commentary and I agree to most of your points (including
favoring "no commit allowed in this state" over "allow commits
and merges to help advanced usage" for its simplicity), so if
you code it up with a clean patch, I would not reject it on the
basis of its design.
