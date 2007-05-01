From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 01 May 2007 02:10:33 -0700
Message-ID: <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
References: <463678B7.70409@gmail.com>
	<7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
	<200705010926.35265.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 11:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HioNc-00014J-18
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031611AbXEAJKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 05:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031613AbXEAJKg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:10:36 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41284 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031611AbXEAJKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 05:10:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501091035.KCJQ24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 05:10:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tlAa1W0021kojtg0000000; Tue, 01 May 2007 05:10:34 -0400
In-Reply-To: <200705010926.35265.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 1 May 2007 09:26:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45930>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007 May 01, Junio C Hamano wrote:
>
>> Which leaves 'master' right now at v1.5.2-rc1 while 'next' at
>> v1.5.2-rc1-687-gcb3892c; we might want to do something about
>> this apparent discrepancy.
>
> It's perfect - I'd say that it's exactly right.
>
> git-describe is for making unique - human readable names for points in 
> history, not for describing the tree.  It makes no difference that A and B 
> have the same tree, they are different points.
>
> I've always thought of git-describe as being a way of mapping a commit hash to 
> a nicer looking name.  If A and B are different commits then they should have 
> different names.

Although 'next' and 'master' have vastly different histories
behind them, among 685 commits between master and next, only 27
are non-merges, among which 20 are "real" commits that tried to
advance various topics that failed, and 7 are reverts against
these 20 commits [*1*].

Even though hstory of failed attempts (why they initially seemed
good ideas, how they tried to solve problems, and why they
turned out not to be so good ideas in the end) are interesting,
if we ignore the failed attempts, iow, if we view the history
from the point of view of "surviving features", the development
history of 'next' and 'master' are moral equivalents.  Yes, most
of them were merged way earlier in 'next' than 'master', many of
them were merged in multiple steps of two and three to 'next'
and then finally merged to 'master' with a single merge, but the
changes did hit both 'master' and 'next' (obviously, that is why
we ended up with the same trees).

So the equivalence of 'master' and 'next' tonight is not quite
the same as equating two random commits that happen to have the
same tree.  v1.5.2-rc1 and v1.5.2-rc1-687-gcb3892c should
naturally have the same tree because they share conceptually the
same history.

But I was not talking about changing describe output because of
the above argument.  What I was wondering was that it might be a
good idea to loosen the promise of never rewinding 'next'.  It
might be easier to view the history of 'next' during development
for each cycle, if it started afresh after a feature release.

Since now we are in a stabilization freeze, I expect that
'master' and 'next' will always have identical trees until
v1.5.2 final.  We _could_ declare now that 'next' will be reset
to 'master' when v1.5.2 happens, and people who forked from
'next' to do their own customization can rebase any time that is
convenient for them between tonight and v1.5.2 final.

I was not sure if that is even a good idea, and I am now
inclined to think that keeping the failed attempt history is
probably better than potentially causing confusion to people who
follow 'next'.  But it _is_ a possibility to reset 'next' to
'master'.


[Footnote]

*1* Some topics I did not use "git revert" to revert them
one-by-one; instead, I reverted a whole topic with one commit.
