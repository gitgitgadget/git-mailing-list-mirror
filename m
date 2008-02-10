From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Sat, 09 Feb 2008 18:24:30 -0800
Message-ID: <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<20080209030046.GA10470@coredump.intra.peff.net>
	<7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
	<46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1sv-0001zC-8k
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYBJCYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbYBJCYp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:24:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbYBJCYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:24:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1163F104F;
	Sat,  9 Feb 2008 21:24:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F161104C;
	Sat,  9 Feb 2008 21:24:37 -0500 (EST)
In-Reply-To: <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 10 Feb 2008 00:50:20 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73294>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Still, the big fat ![rejected] do seem over the top when I know it
> really means "stale".

If "stale" can be proven cheaply, I think it would be a very
good change to introduce [rejected] vs [stale].

> And I don't completely follow how bad the impact of
> auto-fast-forwarding local tracking branches on a merge. If it's a
> fast-forward, my "local state" wasn't that exciting to begin with ;-)

If your branch is configured to track the remote and when your
branch is behind, it probably is safe to assume that the user
most likely wants the ff merge to happen _when_ the branch is
checked out.  I am with you that.  I am not sure if that ff
should happen when you fetch from the other side as you suggest.

Doing so automatically means it would break workflows of people
who are deliberately _holding back_ from updating to the remote
they are tracking for whatever reason.  As you said, the point
they were holding back at can be found as _one_ of the reflog
entries even if you force the auto-ff upon fetch, but that does
mean you are forcing them to go and look for it, while they used
to be able to _rely on_ that their tips will not be molested
without them telling git to do so explicitly.

So I am with you that auto-ff would help more people but I am
not convinced it would not hurt anybody.

Perhaps making "git-checkout" to notice this and offer (or
suggest) fast-forwarding at that point may be safer and make
more sense.  You cannot grow your local branch unless you check
them out, and your remote tracking will keep growing without the
auto-ff you are suggesting, so it is not like people will lose
anchoring point to compare between branches if we do not
auto-ff.
