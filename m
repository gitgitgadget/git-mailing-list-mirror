From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] pre-merge-hook
Date: Thu, 06 Sep 2012 11:34:01 -0700
Message-ID: <7vwr072e7a.fsf@alter.siamese.dyndns.org>
References: <cover.1346851863.git.git@drmicha.warpmail.net>
 <7v8vcn68o9.fsf@alter.siamese.dyndns.org>
 <50485BCB.20607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9gu7-0006Xc-AZ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 20:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990Ab2IFSeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 14:34:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932373Ab2IFSeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 14:34:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB8CB8197;
	Thu,  6 Sep 2012 14:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E6GYIGWDSwSwlGfQrM7ptEyCVCI=; b=UWdhaL
	fVAf0pKqjYbpb6Q/8KY7ElNn/GnfgQhp/lOEp8tYTXS3/jsL22Z63pjkJ105Nv7+
	hthIrouyQpFzSwyn7C7Y9f4SjCO1OXIDoyqNCKlDSyLZXy7i7qWJ9E388UkHKNUW
	yB8/x2/T6J8Onyuz2rqaVJ2f1hgzTa1G75hfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZreRWbW/3T+paMxdTEgmNoqgCYb5OEH
	uqNkbVMdTKFBYlRGtQwUT7nVkgwQmZKMKgzMKBwAVOmuHgE7i00XkG2g3ccpBqEv
	F3PUePIH38gA6nadcJCzppHaePvOkTNHGI1SX+Kip2AqEqSx2375GhAz0KFjHSvp
	f434DyAmH6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C97EC8196;
	Thu,  6 Sep 2012 14:34:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B1028194; Thu,  6 Sep 2012
 14:34:03 -0400 (EDT)
In-Reply-To: <50485BCB.20607@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 06 Sep 2012 10:16:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F385314-F851-11E1-9C9D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204914>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 06.09.2012 07:07:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> The pre-commit hook is often used to ensure certain properties of each
>>> comitted tree like formatting or coding standards, validity (lint/make)
>>> or code quality (make test). But merges introduce new commits unless
>>> they are fast forwards, and therefore they can break these properties
>>> because the pre-commit hook is not run by "git merge".
>>>
>>> Introduce a pre-merge hook which works for (non ff, automatic) merges
>>> like pre-commit does for commits. Typically this will just call the
>>> pre-commit hook (like in the sample hook), but it does not need to.
>> 
>> When your merge asks for a help from you to resolve conflict, you
>> conclude with "git commit", and at that point, pre-commit hook will
>> have a chance to reject it, presumably.  That means for any project
>> that wants to audit a merge via hook, their pre-commit hook MUST be
>> prepared to look at and judge a merge.  Given that, is a separate
>> hook that "can just call the pre-commit but does not need to" really
>> needed and useful?
>> 
>> I admit that I haven't thought things through, but adding a boolean
>> "merge.usePreCommitHook" smells like a more appropriate approach to
>> me.
>> 
>> I dunno.
>
> That would be an option ;)

I said "I dunno" as others may have opinions on the best direction
to go.

> Either works for me, and if we don't change the current behaviour
> (pre-commit-hook resp. no hook for non-automatic merges resp. automatic
> merges) the config option is probably less confusing.

If we were to go in the "pre-commit has to be prepared to vet a
merge already, so let it handle the automerge case" direction, I
have another suggestion.

Because you need to support "merge --no-verify" to override the hook
anyway, I think it makes sense to introduce "merge --verify" to
force it trigger the hook (and it needs to percolate up to "pull").

People who want it always on may want a boolean merge.verify, but
that should come in a separate step.  The patch that implements it
must make sure all our internal uses of "merge" is updated to pass
"--no-verify", unless there is a very good reason.

Another direction to go would be to deprecate the "commit is the way
to conclude a merge that stopped in the middle due to a conflict
asking for your help" and introduce "merge --continue" [*1*].  That
would open a way to a separate "pre/post-merge" hook much cleanly.
At that point it would be clear that "pre-commit" won't be involved
in "merge" (i.e. the user never will use "git commit" when merging).

I am fairly negative on the current mess imposed on "git commit"
that has to know who called it and behave differently (look for
"whence" in builtin/commit.c), and would rather not to see it made
worse by piling "call pre-merge if exists and in a merge, or call
pre-commit" kind of hack on top of it.



[Footnote]

*1* This has been brought up a few times during discussion on
sequencer and mergy operations, and I think it makes sense in the
longer term.  "am" and "rebase" were first to use "--continue",
instead of having the user to use "commit" to conclude, and later
"cherry-pick" and "revert" have been updated to follow suit, so
"merge" may be the only oddball remaining now.
