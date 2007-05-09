From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 09 May 2007 12:37:11 -0700
Message-ID: <7v8xbxu6u0.fsf@assigned-by-dhcp.cox.net>
References: <11787000032830-git-send-email-hjemli@gmail.com>
	<7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 21:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlryP-00042N-M0
	for gcvg-git@gmane.org; Wed, 09 May 2007 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbXEIThO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 15:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbXEIThN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 15:37:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37158 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799AbXEIThM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 15:37:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509193710.CPSV13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 15:37:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x7dB1W00D1kojtg0000000; Wed, 09 May 2007 15:37:11 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46771>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 5/9/07, Junio C Hamano <junkio@cox.net> wrote:
>> Lars Hjemli <hjemli@gmail.com> writes:
>>
>> > This teaches git-checkout to strip the prefix 'refs/heads/' from the
>> > supplied <branch> argument
>>
>> Why is this necessary, may I ask?
>>
>
> I'm playing around with a gui frontend, and there I use
> git-for-each-ref to obtain possible arguments for git-checkout. That's
> how I discovered the 'problem', and solved it by stripping
> 'refs/heads/' in my frontend.

Pathspec-less variant of "git checkout" takes two kinds of
parameters and has two flavours in its behaviour:

 (1) an exact branch name, in which case it switches to the
     branch; otherwise

 (2) any arbitrary commit object name, in whch case it checks
     out and detaches HEAD.

A tricky part is that an exact branch name is often a perfectly
valid commit object name, so rule (1) trumps the rule (2).  You
just discovered a way to have a detached HEAD at a commit that
happens to be at an existing branch -- by naming that commit
without using its exact branch name.

An easier way to spell that would be:

	$ git checkout master^0

but

	master^0
        heads/master
        refs/heads/master

are all perfectly good ways to talk about the commit at the tip
of the 'master' branch without spelling it as an exact
branch name (which is 'master').
