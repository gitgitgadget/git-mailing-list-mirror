From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: --amend cannot be combined with -c/-C/-F.
Date: Thu, 25 Jan 2007 14:21:47 -0800
Message-ID: <7vodom9284.fsf@assigned-by-dhcp.cox.net>
References: <20070124195446.GA13817@bohr.gbar.dtu.dk>
	<slrnerh8la.7v0.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Peter Eriksen" <s022018@student.dtu.dk>
To: Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACym-0000OT-9V
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbXAYWVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbXAYWVu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:21:50 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38174 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030633AbXAYWVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:21:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125222148.VYDJ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 17:21:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FaLq1W00Y1kojtg0000000; Thu, 25 Jan 2007 17:20:51 -0500
In-Reply-To: <slrnerh8la.7v0.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Thu, 25 Jan 2007 12:29:30 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37768>

Mark Wooding <mdw@distorted.org.uk> writes:

> Currently -c (copy some other commit message, and then edit it) is
> considered to be a `force message to be...' kind of option, like the
> others I've listed above.
>
> So, for some reason, is --amend.  This last is really annoying.

I think the mindset is a bit different.  The -C/-c options are
about the latter half of cherry-picking.  The user asks "reuse
the message from an existing commit so that I do not have to
type", or "I could reuse the original log message almost as-is,
but I am using the change in a slightly different context from
the original commit (and that is why cherry-pick did not finish
by itself and you need to run git-commit after fixing up), so I
would need to talk a bit about what I did in the fix-up in the
log message".  Both are useful.

Amend is conflated -- you are amending what you did, either
perhaps you found a small typo in the code in which case the
difference between what is being amended and what will be
committed may only be the tree and you would want to re-use an
existing message as-is, or you found a small typo in the log
message in which case there won't be any difference in the trees
but you do want to spellfix the log message, or you may be
fixing both.

We happen default to the edit behaviour for no particular
reason, other than "because :q or C-x # are cheap".

Unfortunatly there is no good default for this case -- fixing
tree and fixing message are both almost equally often used in
the real world, so changing --amend not to let you edit by
default and adding --edit option would inconvenience other use
case.

Adding --no-edit option is not very nice either.  It's almost as
cumbersome to type as "EDITOR=:".

What you want might be an --amend-tree option; it would be to
the --amend option what the -C (--reuse-message) option is to
the -c (--reedit-message).
