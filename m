From: Junio C Hamano <junkio@cox.net>
Subject: Re: cherry-pick --since ?
Date: Mon, 23 Apr 2007 12:32:29 -0700
Message-ID: <7v8xciga42.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
	<7v647qy7dn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704231208490.4667@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4H4-0003ZW-CZ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 21:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161482AbXDWTcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbXDWTcb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 15:32:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62925 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161482AbXDWTca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 15:32:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423193231.MNRO1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 15:32:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qjYV1W00N1kojtg0000000; Mon, 23 Apr 2007 15:32:29 -0400
In-Reply-To: <Pine.LNX.4.64.0704231208490.4667@torch.nrlssc.navy.mil> (Brandon
	Casey's message of "Mon, 23 Apr 2007 12:52:35 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45354>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> On Fri, 20 Apr 2007, Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> ...
>>> Here's my use case:
>>>
>>> Two branches, 'A' and 'B'.
>>> 'A' is the master branch.
>>> 'B' was forked some time ago and is in bug fix only mode.
>>> Much of 'A' and 'B' are still the same, but there have been
>>>   some intrusive changes made to 'A' that should not go into 'B'.
>>
>> You forgot to say "My objective is to make sure all the good
>> fixes in B are forward ported to A" but I am assuming that is
>> the case.
> 
> Yes, that is the case, but the flow is both ways. Other developers
> may implement fixes in 'A', which must be backported to 'B'. They
> don't care about 'B'.

That shows a problem in the project management that needs to be
fixed independent of what SCM tool you use, doesn't it?

I do not think you would necessarily want to have a VC tsar to
say "No, that is perfectly valid fix for the maintenance branch
and you should make it go through the maintenance branch, do not
directly commit to the master".  People should be able to
self-police that, with a general, shared understanding of what
the overall process is, and can strive to make it easier for
everybody.

Even with that, mistakes can happen, and sometimes you may
realize that a fix or enhancement is applicable to the
maintenance branch as well long after it hit the master branch.
I would not disagree that you would need to have a way to deal
with the ones that need backporting by cherry-picking (otherwise
we would not have git-cherry-pick).  And I am certainly not
against a cherry-pick that can do more than one commit.  What I
am saying is that having to cherry-pick should be the exception,
not the norm, and otherwise there is something wrong in the
process.

If you want to do a cherry-pick that handles more than one
commit, I think you need to worry about sequencing -- how to let
the user continue after aborting in the middle and having him
resolve conflicts.  What "git-rebase --continue" does already
can be used as a model for you to mimick in such an
implementation.
