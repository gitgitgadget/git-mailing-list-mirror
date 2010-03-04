From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 04 Mar 2010 13:42:19 -0800
Message-ID: <7vmxynydac.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 00:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnJ7P-0003X7-F2
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 23:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab0CDVm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 16:42:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab0CDVm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 16:42:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDEC9FCC2;
	Thu,  4 Mar 2010 16:42:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WqKtfPcjznpvcYwSH4IALXOCwk8=; b=DkMk1v
	3Dj+aVGqOTfD75ZFUUH5xtvWToyqp2FjnpouG3RAGyC3uprIuJMosGeKIiFWx5o6
	0It+1KJiYTSEYo9VnH9cAnSciA6eCwEOSt0F5zrQQ3q8oSq8zYro7wROQ32qe6KB
	LkQg9g/PmhzIpcVfZuxEuMjTXQGwE5oaNc21U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G3Bij0czjASPEhtK7q52W73kh6izkoJo
	U3e4R9gFvwNQXphaog9cr3vEpg4+hF27wEM9JO/KABysJLh6bJp8wyfsAJVTeOhg
	Yrngt1xgzqJKj4t0kxTBtKGliJxvTJkvIrp9VqvzCES7upj4vrCVfKZlN9MpDBEf
	Joj2jNw0NiQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D6B59FCC1;
	Thu,  4 Mar 2010 16:42:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 425839FCBD; Thu,  4 Mar
 2010 16:42:21 -0500 (EST)
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Mar 2010 16\:02\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1EB6EFE-27D6-11DF-B317-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141545>

Junio C Hamano <gitster@pobox.com> writes:

> * cc/reset-keep (2010-01-19) 5 commits
>  - reset: disallow using --keep when there are unmerged entries
>  - reset: disallow "reset --keep" outside a work tree
>  - Documentation: reset: describe new "--keep" option
>  - reset: add test cases for "--keep" option
>  - reset: add option "--keep" to "git reset"
>
> I am not sure if this series is useful, and even less sure if the
> usefulness of it outweighs the confusion factor.

Regarding this, I've been thinking about how I would explain this new
feature to end users (both new ones and old timers) as a good addition.  I
still haven't reached a satisfactory explanation, but here is my "WIP" try
to describe a scenario.

I understand that in essense, "reset --keep" does exactly a "checkout
<commit>" does but without detaching the HEAD.  I often deliberately stay
on detached HEAD because I find it highly useful that I can jump around
freely with "checkout <commit>" once the head is detached (I would stay in
a detached HEAD state and keep local changes around).  I think there must
be a similar usefulness I can gain by "reset --keep".

But I am not really succeeding to explain that to potential users.

    I have built commits A, B and C on my 'topic' branch, and the contents
    in the working tree is a checkout of C (which is at the tip of the
    branch).  I can make a small improvement, and start hacking.  And then
    I realize that the change I just did, which I haven't committed nor
    even added, is an improvement to commit A.

    I could do:

        $ git checkout topic~2              ;# to detach at A
        $ git commit --amend -a             ;# to improve on A
        $ git rebase --onto HEAD @{1} topic ;# rebase the rest and come back

    to fix up A and rebuild B and C on top of it.  With "reset --keep",
    I could do this instead:

        $ last=$(git rev-parse HEAD)
        $ git reset --keep topic~2
        $ git commit --amend -a
        $ git rebase --onto HEAD @{1} @{2}  ;# rebase the reset
        $ git branch -f topic               ;# and come
        $ git checkout topic                ;# back

The above however is clearly not an improvement.

So far, the _only_ use case I can think of that "reset --keep" may be
superiour than anything existing is this:

    I have built commits A, B and C on my 'topic' branch, and the contents
    in the working tree is a checkout of C (which is at the tip of the
    branch).  I can make a small improvement, and start hacking.  And then
    I realize that the change I just did, which I haven't committed nor
    even added, is an improvement to commit A.  Also I realize that B and
    C are completely bogus, and I want to get rid of them.

    I could do:

        $ git checkout topic~2		;# to detach at A
        $ git commit --amend -a         ;# fix it
        $ git branch -f topic           ;# the rest I do not need
        $ git checkout topic	        ;# and now on the branch

    but it would be far easier if I can do this:

        $ git reset --keep topic~2
        $ git commit --amend -a

You have some addition in Documentation/git-reset.txt in this topic, and
the last example (starting at around line 350) may be describing this
situation, but it was not very clear to me.

    Keep changes in working tree while discarding some previous commits::

    Suppose you are working on something and you commit it, and then you
    continue working a bit more, but now you think that what you have in
    your working tree should be in another branch that has nothing to do
    with what you commited previously. You can start a new branch and
    reset it while keeping the changes in your work tree.

    ------------
    $ git tag start
    $ git branch branch1

I take it that this is supposed to be "checkout -b branch1".

    $ edit
    $ git commit ...                            <1>
    $ edit
    $ git branch branch2                        <2>

I take it that this is supposed to be "checkout -b branch2".

    $ git reset --keep start                    <3>
    ------------

    <1> This commits your first edits in branch1.
    <2> This creates branch2, but unfortunately it contains the previous
    commit that you don't want in this branch.
    <3> This removes the unwanted previous commit, but this keeps the
    changes in your working tree.

The above sequence is not very convincing.  After you edited the second
time, you create branch2 and that is presumably because you realized that
the change in the work tree belongs to a separate topic.  It would be a
lot more natural to do this:

    $ git tag start ;# we do not have to tag, but just to make the
                       remainder of the illustration easier to read...
    $ git checkout -b branch1
    $ edit	    ;# do the work for the first topic
    $ git commit    ;# and commit
    $ edit          ;# start working more and then realize that the
    		       change belongs to a separate topic, and the previous
                       commit is unrelated to that new topic
    $ git checkout -b branch2 start 
    $ edit          ;# continue working
    $ git commit    ;# and conclude it

so the example makes the use of "reset --keep" look artificial.
