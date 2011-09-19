From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Where is information of "git read-tree" stored?
Date: Mon, 19 Sep 2011 10:36:42 -0700
Message-ID: <7vzki0a0yd.fsf@alter.siamese.dyndns.org>
References: <loom.20110919T103707-867@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manuel Reimer <manuel.spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Mon Sep 19 19:36:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5hlz-0007rX-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 19:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab1ISRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 13:36:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab1ISRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 13:36:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C855B2C;
	Mon, 19 Sep 2011 13:36:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xQC9GToEiTj9Yd+PcJCNtxeQkRA=; b=v5+PJ+
	CU5/uJC8U8E36xAwAitKxew5biRlvehR763FhZovyE3afVmrup1vMy24fm2fwOfT
	NH5+lV17NDcFnQXociEwoE5Gj5csW0UYTRliZNacS8M6xG9XO5wvr+iqyTdZk8UB
	QJwCIfAuOB3ja8+FiZaNLYPbO3SbkUiAFrxjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YWQZRUkOwir45tGjoLd6BN7aESbmmjcd
	rYw5NBRwYDuFBc/L3TZIMWYiVQBi/S7V2hXf5/MPUpLU3x3P5gB4hut+DceRJBfS
	1CMpsrE8AnYUgBLri/1gr0clXTohJBhsJqPPCHUE1kDqKWZFrwcYm1FEHTmU3AXD
	RnZfho0zGPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C07445B2B;
	Mon, 19 Sep 2011 13:36:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 451745B2A; Mon, 19 Sep 2011
 13:36:44 -0400 (EDT)
In-Reply-To: <loom.20110919T103707-867@post.gmane.org> (Manuel Reimer's
 message of "Mon, 19 Sep 2011 08:46:31 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F132113E-E2E5-11E0-975B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181686>

Manuel Reimer <manuel.spam@nurfuerspam.de> writes:

> Hello,
>
> following situation:
>
> - Project hosted on GIT. Have a local copy and push to remote server.
> - Small addon is hosted on a remote SVN server
> - I now cloned the SVN to a local GIT (svn git clone)
> - Then I used the instructions from here:
>
> <http://git-mirror.googlecode.com/git-history/7444c60/howto/using-merge-subtree.html>
>
> to get the local SVN copy merged into a subdirectory on my project GIT. Anything
> worked well.
>
> To test the worst case, I cloned my project GIT to a new local repository. The
> remote connection to the local SVN copy was lost, so I recreated it.

It is unclear to me what you meant by "connection" "lost" and "recreated"
above, but I am guessing I can ignore them, as long as I take it that you
mean by that local mirror from the subversion repository "Bproject" below.

> Now, for some reason, I can immediately call
>
> git pull -s subtree Bproject master
>
> to pull changes from the SVN copy to the subdir... I didn't have to call "git
> read-tree" again.

That "how to" may be badly written and this may have been unclear to you
but the first four steps are to be done _only once_ to set things up, and
after that you need to run only the fifth step whenever you want to update
from the Bproject. Could you suggest a better wording to update the doc?

The very first "subtree merge" (the one that is recorded with the commit
after the read-tree) records all paths from Bproject renamed to elsewhere
in the merge result (you can view it with "git show -M
$that_merge_commit"), and that is what allows "pull -s" (both the initial
one and subsequent ones; indeed the fifth step in the initial round is not
any more special than the subsequent round) notice where changes from the
Bproject ought to go.
