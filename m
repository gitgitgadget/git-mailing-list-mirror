From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
 file
Date: Thu, 05 Feb 2009 12:50:47 -0800
Message-ID: <7vvdrobobc.fsf@gitster.siamese.dyndns.org>
References: <20090205202104.GA11267@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBCu-0000N7-7p
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZBEUux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZBEUux
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:50:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbZBEUux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:50:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CC1852A81F;
	Thu,  5 Feb 2009 15:50:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 064E82A7EB; Thu, 
 5 Feb 2009 15:50:48 -0500 (EST)
In-Reply-To: <20090205202104.GA11267@elte.hu> (Ingo Molnar's message of "Thu,
 5 Feb 2009 21:21:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ACBE2800-F3C6-11DD-809B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108615>

Ingo Molnar <mingo@elte.hu> writes:

> So i have to do something like:
>
>    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
>
> (tucked away in a tip-revert-file helper script.)
>
> But it would be so much nicer if i could do the intuitive:
>
>    git revert kernel/softlockup.c
>
> Or at least, to separate it from revision names cleanly, something like:
>
>    git revert -- kernel/softlockup.c

All three shares one issue.  Does the syntax offer you a way to give
enough information so that you can confidently say that it will find the
commit that touched the path most recently?  How is the "most recently"
defined?

At least you can restate the first one to:

    git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)

to limit to "the one that touched this file _on this topic_".

> Would something like this be possible in generic Git? It would sure be a 
> nice little touch that i would make use of frequently.
>
> Or is it a bad idea perhaps? Or have i, out of sheer ignorance, failed to 
> discover some nice little shortcut that can give me all of this already?

The closest I can think of is

	git revert ':/the title of the commit'

but it shares the exact same issue of "how would I limit the search space
to make sure it finds the right commit".
