From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] reset: add option "--merge-safe" to "git reset"
Date: Wed, 16 Sep 2009 11:37:09 -0700
Message-ID: <7vfxamzqga.fsf@alter.siamese.dyndns.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org>
 <20090916041443.3737.63217.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnzNr-0001CY-04
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 20:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566AbZIPSha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZIPSh3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 14:37:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbZIPSh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 14:37:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F8D3502A;
	Wed, 16 Sep 2009 14:37:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DrNNtlbbB3ZYsAMEPzbDLvbwlHI=; b=wUQZ2gpCS9D4Wf5SUErwhvp
	wE2v4IcqWUKD/gJJGdDceWvsONojh814FaTihiPg+B9MefjIirWmtkIs6QghMTvz
	l88saH99tVLresjdzYCQMXkuWw6aEnK2pXcf56IXnBsuz0IktHhzoE9UtNb+r+0a
	tPYMe6aTiQzvAY7cjU1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eb0PziVVpFiA0WJbgZ20LRNJpPafvdLQer+v25jQ4h2TkxWd6
	qX0s67Ht2hpBUTaEeR/Z8Irn9cxk9NlduzSF5vyDjDORZRYJJDYrvdJYez9/jbXW
	ATHILytFQd6Bvxkhc3ttq2mRzbhu1y9j5CUAbQqNZArwCPFsgv893RwTK4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D23E35029;
	Wed, 16 Sep 2009 14:37:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D5EB3501E; Wed, 16 Sep
 2009 14:37:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F93F9F8C-A2EF-11DE-A4BD-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128671>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This option is nearly like "--merge" except that it is
> safer. The table below show the differences between these
> options.
>
> working index HEAD target         working index HEAD
>   B      B     A     A   --m-s      B      A     A
>                          --merge    A      A     A
>   B      B     A     C   --m-s       (disallowed)
>                          --merge    C      C     C
>
> In this table, A, B and C are some different states of
> a file. For example the first 2 lines of the table mean
> that if a file is in state B in the working tree and
> the index, and in a different state A in HEAD and in
> the target, then "git reset --merge-safe target" will
> put the file in state B in the working tree and in
> state A in the index and HEAD.

At first, I had to spend a few minutes guessing what you meant by "target"
in the table.  All the other words are well known and do not need to be
explained, but you can make it even easier to understand by updating the
sentence before the table, perhaps like:

    When running "git reset --option target" to reset the HEAD to another
    commit (as a special case "target" could be the same as HEAD), here
    is what happens to paths in various state.

As you mentioned in the proposed commit log message of the other entry,
you have a different behaviour for unmerged case.  Can you add that case
to the table as well?

The original use case of Linus's "reset --merge" was:

    $ edit ... ;# you may have some local changes to the work tree
    $ git merge/pull ...
    ... (1) it merges cleanly;
    ... (2) you see conflicts and do not commit, or
    ... (3) you resolve conflicts and commit, while leaving the earlier
    ...     modified paths alone.
    ... In any of the three cases, you inspect the result, and say
    ... "ah, crap!"
    ... You want to go back to the state before the merge, i.e.
    ... target = HEAD^ in (1) or (3) above and target = HEAD in (2).
    $ git reset --merge $target

Recall that "git merge/pull ..." step does not even touch anything if you
have a dirty index (i.e. "diff --cached" is non-empty), so any difference
between the index and HEAD to reset the failed merge away must come from
the merge itself

Immediately before you run "reset --merge" in the above sequence, you can
categorize the paths in various states this way:

  work   index  HEAD  how that path got into this state...
    A      A     A    not involved in this merge.
    B      A     A    not involved in this merge, originally modified.
    B      B     A    cleanly merged.
    B      B     B    cleanly merged (and committed if (1) or (3)).
    C      U     A    merge left conflicts

where U denotes unmerged path in the index, and C is a file in the work
tree with conflict markers.  The path had content A in HEAD before the
start of the merge that you are resetting away.

Note that the target is A in all cases in the above table.

We would want to go back to HEAD == index == target for all of these
cases, and discarding B in "cleanly merged" entries is absolutely the
right thing to do.  Clearly, --merge-safe is _not_ designed to work in
this scenario.

Don't get me wrong.  I am not saying --merge-safe is unsafe nor useless.

I am trying to show a way with an intended use-case (and the mechanical
notation you and Daniel wrote up, which is very nice to illustrate what
exactly happens) to explain how --merge works, and more importantly why
it works that way.

That is because I would like to see an intended use case of this new
feature in a bigger picture.  With the table, I can see what it does (or
at least what you wanted it to do), but it does not clearly explain what
this new mode of operation is good for, in what context it is designed
to be used, and what problem it intends to solve.  I think you find it
very clear, by reading my explanation above, what Linus's --merge is
intended to solve:

	After a (possibly conflicted) merge modified my index and my work
        tree, "reset --hard" to the commit before I started the merge will
        discard the local modifications I had in the work tree before the
        merge.  "reset --merge" was invented to let me go back to the
        state before the merge, without discarding such local changes I
        had before the merge.

I want to be able to explain to others what --merge-safe is for in a
similar way myself before I have it in my tree, and I can't (yet).
