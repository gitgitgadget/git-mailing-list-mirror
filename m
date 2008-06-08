From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Sun, 08 Jun 2008 01:16:34 -0700
Message-ID: <7vmylwl4t9.fsf@gitster.siamese.dyndns.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
 <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org> <484B49D5.8080708@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 10:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5G5u-0007fo-PL
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 10:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbYFHIQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 04:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754316AbYFHIQt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 04:16:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYFHIQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 04:16:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3149E2407;
	Sun,  8 Jun 2008 04:16:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6E03B2406; Sun,  8 Jun 2008 04:16:42 -0400 (EDT)
In-Reply-To: <484B49D5.8080708@gnu.org> (Paolo Bonzini's message of "Sun, 08
 Jun 2008 04:54:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BAEA560-3533-11DD-875F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84258>

Paolo Bonzini <bonzini@gnu.org> writes:

>> Because original E' was an amend of E, its log message explained
>> everything E did and more.  You cannot leave that same commit message in
>> E''.  What you did in E was already explained in the history, so now you
>> would want to talk about the incremental change on top of it when you
>> desribe E''.  For that, replaying of E' must stop to allow you to fix up
>> the log message.
>
> Yes, I had suggested in the original thread to follow up with a "git
> rebase -i" to fix the commit message, because "git-rebase--interactive
> --help" did not show a -s option.  However, I found out that it does
> support it, so it is probably better to use "git rebase -i -s theirs
> --onto ..." directly.

Yeah, but that is only about the commit log message.  The issue of
recording a wrong tree when commits X and Y exist is not alleviated, is
it?

> You mean that I should a) drop the example from git-rebase.1, b)
> reword it to clarify it, c) drop the patch completely?

I have to say that the rebase example is too misleading --- unless it is
accompanied by a lot of disclaimers, its risk to give broken result to
people probably is worse than the benefit. I am afraid that we would need
a lot better use case to justify the use of "theirs" than what you wrote.

I have occasionally seen valid situations to use "ours", but I personally
haven't been in a situation that merge using "theirs" is a good solution.
Obviously if you start from a wrong branch, you should be in the situation
that you would want to merge using "theirs", just like when you started
from the right branch and would use "ours", but in practice that never
happened to me as far as I can recall.  I am not sure where this asymmetry
comes from.

On the other hand, I've sometimes heard people say "when I get a merge
conflict, I'd want to discard what I did _only in the conflicted part_."
I am not sure if such a conflict resolution makes much sense in practice,
but perhaps people know that their changes are worthless crap anyway, and
do not even care about their work themselves, to the point that they would
rather discard what they did than spend more time to fix them up properly.
Whether that makes sense or not, what they want is different from "theirs"
(which is opposite of "ours"); they want to keep their own changes for
parts that did not conflict, and give up what they did only in the
conflicted part.  Perhaps such a kind of mixed conflict resolution should
be supported under the name of "theirs", even though that would make
"ours" and "theirs" _not_ the opposite of each other.  I dunno...
