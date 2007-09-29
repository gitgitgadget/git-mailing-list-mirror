From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 15:25:00 -0700
Message-ID: <7vlkapjeir.fsf@gitster.siamese.dyndns.org>
References: <87ir5us82a.wl%cworth@cworth.org>
	<20070929000056.GZ3099@spearce.org>
	<E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibkll-0001jJ-Oj
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbXI2W0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbXI2W0c
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:26:32 -0400
Received: from rune.pobox.com ([208.210.124.79]:58000 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321AbXI2W0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:26:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id F047313E5E8;
	Sat, 29 Sep 2007 18:26:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EBE8F13E631;
	Sat, 29 Sep 2007 18:26:08 -0400 (EDT)
In-Reply-To: <E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de> (Steffen Prohaska's
	message of "Sat, 29 Sep 2007 23:48:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59503>

Steffen Prohaska <prohaska@zib.de> writes:

> Quite often git prints a lot of very technical information that
> is not very interesting as long as things succeed without error.
> Some examples are
> - git fetch (see above)

Probably.

> - git rebase: prints a lot of details that I'm not interested in
>   unless the rebase fails.

Yes.  Most of the clutter is coming from "am" which also should
be squelched.

Saying

	Switched to branch <blah>

is good when the branch to rebase is specified.

	"HEAD is now at ..."
is not useful -- it is a side effect of rewinding the head to
the --onto commit.

	<blank line>
        Applying <patch subject>
	<blank line>
        Wrote tree <tree object>
        Committed: <commit object>

are coming from "am" for each patch.  We could squelch these
into just one "Applying <patch subject>" and nothing else, which
would also help making "am" quieter.

> - git push: prints updates of remote heads. A message about
>   failing to update a remote head may get lost.

Please do not remove the report of successful update, as people
often say "git push" or "git push $there" without explicitly
saying which refs to push.  When pushing out to publish, I say
"git push ko" (to mean k.org) and I _want_ my positive feedback.

> - git merge: the fact that a merge is a fast forward merge gets
>   printed at the very top, followed by (often a lot of) diffstat.
>   I know diffstat can help to judge if the merge did what you
>   expected. But even more important is the fact that the merge
>   was just a fast forward, which may get buried under lots of output.

I do not think fast-forwardness is particularly interesting.  If
you find fast-forwardness interesting, I suspect you would even
want to know what _your_ change that were not in the other side
of the merge, which is something that we do not even report
right now.

> Maybe git should become more quiet, as other unix tools are, and
> per default only report problems. Technical details and progress
> could be requested explicitly by '--verbose' or similar.

I'd agree with this sentiment in principle, and many of the
things you propose to remove above fall into the "unnecessary
clutter" category.  But some of the existing output fall into
the "necessary info" category --- diffstart after merge and
report of successful remote ref updates are such things, so we
should be careful not to go overboard.
