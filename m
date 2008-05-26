From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and appending merge commits
Date: Sun, 25 May 2008 21:59:28 -0700
Message-ID: <7vej7pek3z.fsf@gitster.siamese.dyndns.org>
References: <483A300E.6090104@zombino.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Majer <adamm@zombino.com>
X-From: git-owner@vger.kernel.org Mon May 26 07:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Uou-0004Ai-Is
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 07:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbYEZE7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 00:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbYEZE7h
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:59:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYEZE7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 00:59:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EA5F6E51;
	Mon, 26 May 2008 00:59:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AAE526E50; Mon, 26 May 2008 00:59:31 -0400 (EDT)
In-Reply-To: <483A300E.6090104@zombino.com> (Adam Majer's message of "Sun, 25
 May 2008 22:35:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8931786A-2AE0-11DD-A5EC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82900>

Adam Majer <adamm@zombino.com> writes:

> Is current output by design?

Yes, it is _very much_ by design and it not "messed up" at all.  Look at
the output of URL you quoted and notice that you are asking for condensed
combined diff ("diff --cc").

For a merge commit with N parents, you can define "a diff for the
resulting merge commit" in various ways:

 * You could have a set of diffs between each parent to the merge result.
   You can get this with "git diff-tree -p -m $commit".

 * You could say the first parent is special, and define it as the diff
   between its first parent and the merge result.  You can get this by
   asking "git diff $commit^1 $commit".

 * You can say what non-trivial changes the merge itself did.  This is the
   combined merge and what "git show $commit" (and "git log -p") gives.

Depending on what you want, you can ask these various forms of diffs.

When you are reviewing the changes series of commits introduced to the
history (iow, "git log -p"), a single diff between parent and the merge
result is not so interesting, primarily because each individual change
from commits on each side branch is (or should be) much easier to read and
understand, but if a merge needed to do something non-trivial to resolve
conficts, you would want to know about it, and that is the reason why --cc
format is the default.

In a combined diff, unlike the single column to show "+/-/ " at the
beginning for one-parent diff, each parent gets one column.  And in a
condensed combined diff, a hunk whose result is inherited solely from one
parent (iow, a trivial conflict resolution) is removed from the output, so
that only a non-trivial conflict resolution that leaves result that is
different from all parents are shown.
