From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] sequencer: add "do_fast_forward()" to perform a
 fast forward
Date: Sat, 22 Aug 2009 00:29:03 -0700
Message-ID: <7vab1s5mtc.fsf@alter.siamese.dyndns.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org>
 <20090822041616.4261.40442.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 09:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mel2b-0003hd-Oi
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 09:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbZHVH3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 03:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbZHVH3U
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 03:29:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238AbZHVH3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 03:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4543E14D51;
	Sat, 22 Aug 2009 03:29:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=etQOu8sDxD8PvXUXk5fOiIXgcMo=; b=hWwF89JCmNwmQX5bK3jKpln
	lwQA2Ra7kdSws+2C5JXp8hyAuYB4O6sWvznEngR1pWIG+LNa6nk1mnsxFKRG1wmL
	WHi9lQwNWI5WUWbNMTO4SDm8KnL3l7HU+64FEl0/Z0STVdBwTgz9wNZjnMyho1wG
	P6OAfNhBc8XAXfeCHqgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OFy2dFgC6HZEsOYvWJ42flHdok5OHYjPF9HIl9BeEy0i6jKl2
	DsGJe1K0VfA7R67qpeHcTo7E07SPqPP9XOiZfskuzti5Ml9WSAaBJqk1eIuJ8fYt
	0x92hPDbQmPtDguu5NxPDzlBfDNNvmAhaTJAiCGCW5QbYNw89UeIRbs+go=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCA1F14D50;
	Sat, 22 Aug 2009 03:29:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 893EB14D4E; Sat, 22 Aug
 2009 03:29:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CBB8B3A-8EED-11DE-9FEB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126799>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This code is taken from the sequencer GSoC project:
>
>     git://repo.or.cz/git/sbeyer.git
>
>     (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)
>
> but the messages have been changed to be the same as those
> displayed by git-rebase--interactive.sh.

Hmm, forgot to amend, or perhaps you sent out a wrong series?

The log message does not explain:

 - why the patch adds a new static function that nobody calls;
 - what the new function is good for;

which are the most important things in order to defend the change.

"The messages have been changed to..." hints that the original commit by
Stephan had different messages produced, perhaps so that it can be used in
a different context.  I hoped, in an ideal world, perhaps Stephan defended
why the change was relevant to his project in some way, and because you
are using it in a different context that needs modification of the
message, perhaps Stephan's defense of his commit could be reworded to
defend your change here.

So I decided to take a look at the quoted commit to see if I can reword
this mess.

But the quoted commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20 does not
even seem to be a commit that corresponds to this change.  It is a merge
from upstream.

    commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20
    Merge: 0c73ae7 99ddd24
    Author: Stephan Beyer <s-beyer@gmx.net>
    Date:   Wed May 20 10:54:37 2009 +0200

        Merge branch 'junio/master' into seq-builtin-dev

        After this merge f79d4c8 "teach git-am to apply a patch to an unborn
        branch" has to be reimplemented in sequencer by allowing the "patch"
        insn on unborn branches.
        The related test in t/t4150-am.sh is set to test_expect_failure.

        Conflicts:
            git-am.sh

It does not help that the function that is crucial to the implemention of
this new function, reset_almost_hard(), is not explained at all in the
earlier commit in the previous series (36f692b (sequencer: add
"reset_almost_hard()" and related functions, 2009-08-05).  

The log message to the commit does not even hint in what sense "almost"
the function is, iow, in what situation it behaves exactly like "reset
--hard", and in what other situation it doesn't, and more importantly why
that distinction is there.  I thought I asked these questions when the
previous series was submitted, but I do not remember ever seeing
satisfactory answers to them.

I am afraid that the whole cc/sequencer-rebase-i series needs a serious
reroll before it gets near 'next'.

Before giving up, I'll quickly re-review how (un)readable the log of each
commit is in the series.  The following comments are mostly about the log
messages, which are supposed to entice people to review the code, and more
importantly, used as part of the release notes to summarize what the newly
added toys are about.  If they are horrible, the code has little chance to
be even read, and I'll have a hard time merging the series up into a new
release.



6db6551 sequencer: add "builtin-sequencer--helper.c"

Good.

b512803 sequencer: add "make_patch" function to save a patch

Passably okay, but the limitation that it always writes into a file with a
fixed name "$SEQ_DIR/patch" should be noted in the log.

0ccc92b sequencer: free memory used in "make_patch" function

Should be squashed to the previous.

f121b06 rebase -i: use "git sequencer--helper --make-patch"

Good.

36f692b sequencer: add "reset_almost_hard()" and related functions

Horrible.  See above.

9d41fbd sequencer: add comments about reset_almost_hard()

Should be squashed to the previous---lift some text to justify the
existence of the function in the commit log message.  Even though
allow_dirty is referred to in the comment as affecting the behaviour, it
is unclear who sets that global variable using what interface, making the
reader suspect that maybe it should be a function parameter instead of a
global (but the other parts of the helper may also look at allow_dirty
and the internal implementation might be--I am just guessing--simpler this
way, in which case _that_ should be explained and justified).

022a9e7 sequencer: add "--reset-hard" option to "git sequencer--helper"

This by itself is Okay, provided if 36f692b were made readable.  Then you
can expect the reader to know why reset_almost_hard() needs to be there,
and you need an interface to that function.  Until then, it is totally
unclear why you need this, instead of using "reset --hard" itself.

ad28459 rebase -i: use "git sequencer--helper --reset-hard"

Ditto.

e4b3f0f sequencer: add "do_fast_forward()" to perform a fast forward

See above.

1d88073 sequencer: add "--fast-forward" option to "git sequencer--helper"

Okay.

6eff656 sequencer: let "git sequencer--helper" callers set "allow_dirty"

Why?  What for?

877ddc1 rebase -i: use "git sequencer--helper --fast-forward"

It is unclear how this relates to the previous one, nor why it is more
appropriate than "reset-hard" it replaces.

ff312f0 revert: libify pick

Almost good.

ab67716 pick: libify "pick_help_msg()"

Good.

d871b0e sequencer: add "do_commit()" and related functions

We can see from "git show" what static functions that are never called in
this commit are added, but nobody explains why they are needed.  For
example, do_commit() may create a new commit object, but does not share
the code with what "git commit" and/or "git commit-tree" do?  If so, how?
If not, why not?

ac5fc4d sequencer: add "--cherry-pick" option to "git sequencer--helper"

Passably okay.  I can see ff312f0 made about a half of cherry-pick
accessible to the sequencer, and this patch uses it to finish the other
half, although that is not explained in the log message.  Also it is
unclear why the resulting "libified" code does not share more
infrastructure with "git cherry-pick" itself (and "git revert").

664c7ab rebase -i: use "git sequencer--helper --cherry-pick"

Passably okay, even though it is not quite convincing why using
sequencer-helper's cherry-pick option makes it easier to later port the
script, than keeping calls to cherry-pick.
