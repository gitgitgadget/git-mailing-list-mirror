From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Fri, 08 Feb 2008 19:24:06 -0800
Message-ID: <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<20080209030046.GA10470@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 04:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNgLJ-0007Na-EW
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 04:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYBIDYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 22:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYBIDYm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 22:24:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYBIDYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 22:24:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE225830;
	Fri,  8 Feb 2008 22:24:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E1036582E;
	Fri,  8 Feb 2008 22:24:33 -0500 (EST)
In-Reply-To: <20080209030046.GA10470@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 8 Feb 2008 22:00:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73188>

Jeff King <peff@peff.net> writes:

> Thinking about this more, this situation is more than a minor annoyance:
> it is actually somewhat dangerous. If you ever wanted to push _one_
> non-ff case (say, for your current branch) and you were to use "git push
> -f", you would rewind history for random branches, and sorting the mess
> out at the remote could be awful (especially if it is a bare repo
> without reflogs).

Yeah, -f using "matching refs" is dangerous, but on the other
hand, that would be how you correct that mistake in one shot,
after you fixed the mistake locally.

Is there anything wrong with "git push $there $branch_name"?  I
thought we discussed this last time and there was even a patch
that does "git push $there HEAD" to push out the current branch,
which I am fairly sure that I accepted (but I do not remember,
as I do not use such a shorthand. When I want to push a single
branch, I _want_ to be explicit, to make sure I push out the
right thing).

So after doing a fix on a single branch, you would:

	$ git push origin HEAD

and you are done.  No need to spell out the long branch name you
are currently on.

I do not know if this was part of the last round of patches, but
I suspect it is not a problem to allow

	$ git push HEAD

if it is unambiguous.  That is, "HEAD?  Do we have such a remote
nickname?  No.  Then can we default to 'origin' and use it as
the ref to push?  Yeah, we can, so the user meant 'git push
origin HEAD'".
