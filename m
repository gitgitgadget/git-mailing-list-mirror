From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] New sequencer workflow!
Date: Sun, 13 Nov 2011 16:04:18 -0800
Message-ID: <7vaa7zmuwt.fsf@alter.siamese.dyndns.org>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <7v39droi63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 01:04:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPk2E-0004Ar-M5
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 01:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab1KNAEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 19:04:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab1KNAEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 19:04:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60022624E;
	Sun, 13 Nov 2011 19:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49HZC2DXqIYRaiCZHVXVVOPTtks=; b=UT1/gj
	RYE4GaVWRUP4EbJFavAcX50S0rkV/FWZ+U0urB83g0HXI6NFmWWlabyCr/+8LdIG
	x04tc3NVIb7nSS32BiNMUK8Gw3Y8GiGjguDCLc/QaF7NZpm6kmQYVpkUhPAjwkSp
	KHzYdtDiBqpr2hqDdiKwe/CrOQfMxazwPeGfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pwdx+5ZLqRkubClBmHoPpU8SelMhDFiy
	uqqCy2OKofSikan+DB3JqAdRlDRaihizhgO+CX0whuyJ7G3fzTQPyaX9NK9g7MA2
	QNQqEsbZZ2c1ypbUy/xzrSaTQdTQyndCoUH9uBYrAncLRwfKkV7jasOrZZgPooTE
	1icpvI6d+w0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DBC624D;
	Sun, 13 Nov 2011 19:04:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D941624C; Sun, 13 Nov 2011
 19:04:19 -0500 (EST)
In-Reply-To: <7v39droi63.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 13 Nov 2011 12:56:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3324B7EC-0E54-11E1-BBC4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185355>

Junio C Hamano <gitster@pobox.com> writes:

> Almost. If these are replaced with "git cherry-pick --continue" and "git
> revert --continue" that internally triggers "git sequencer --continue"
> *and* errors out if a wrong command was used to "--continue", it would be
> perfect.
>
> The longer-term ultimate goal would be to make it "git continue" that
> covers more than the sequencer based workflow, i.e. allow "git merge" that
> conflicted to be concluded with "edit && git add && git continue".

To clarify a bit.

While I do not mind "sequencer --continue" as a step to get us closer to a
more pleasant user experience at the implementation level, exposing the
name "sequencer" or having the user to type "sequencer --continue" is going
in a very wrong direction at the UI level.

There are many commands in the Git suite that take an order from the user,
attempt to perform the necessary operation but stops in the middle to ask
for help from the user. "cherry-pick" and "revert" are two of them, and
there are many others: e.g. am, merge, pull, rebase, "rebase -i". They use
different mechanisms to keep track of their states before giving the
control back to the user when they ask for help.

The original workflow was "pull; edit && add && commit", and it is very
unlikely this will change while we are still in Git 1.X series. The
original single commit variants of "cherry-pick" and "revert" are in the
same category. We would need to keep supporting "cherry-pick/revert; edit
&& add && commit" as a workflow for a while.

Others that deal with more than one stop-point follow a different pattern
from necessity. The user tells the same command to continue after the
command asks for help in "am; edit && add && am --continue" and "rebase
[-i]; edit && add && rebase --continue" sequence. Multi-commit variants of
"cherry-pick" and "revert" take the same approach for consistency.

In the shorter term, a person new to Git, after learning "run command X, X
gives back control asking for help, help X by editing and adding, and
telling X to continue" pattern from these commands, will eventually find
that the commands in single stop-point category (i.e. "pull", "merge" and
single-commit "cherry-pick" and "revert") inconsistent from others that
take "--continue" to resume. For this reason, "git cherry-pick --continue"
that would work even when picking a single commit like this would be
beneficial:

    $ git cherry-pick X
    ... conflicts
    $ edit && add
    $ git cherry-pick --continue

That is, no "commit" by the user. The "helping" part is literally that;
the user helps Git because Git is too stupid to read the user's mind to
come up with a perfect conflict resolution. Git knows, given a correct
resolution, how to make a commit out of it perfectly fine and does not
need help from the user to commit the result.

In the medium term, extending the above "shorter term" goal, it would make
sense to support (but not necessarily require) the following flow for
consistency:

    $ git pull ;# or "git merge branch"
    ... conflicts
    $ edit && add ;# again, no "commit"
    $ git pull --continue ;# or "git merge --continue"

Now, if you rename "cherry-pick --continue" and "revert --continue" to
"sequencer --continue", what message are you sending to the users? They
now need to learn that only these two commands are based on something
called "sequencer", can be resumed with "sequencer --continue", but other
commands need to be continued with "X --continue".

That is totally backwards, no? You are _adding_ mental burden to your
users by introducing another thing or two they need to learn about.

In the longer term (now we are talking about Git 2.X version bump), it
would be ideal if all the "git X --continue" can be consolidated to a
single "git continue" command (and "git abort" to give up the sequence
of operations).

Given that bash-completion script can tell in what state the repository
is, I think this is doable. "git continue" may invoke your implementation
of "git sequencer --continue" internally when it detects that the state is
something the "sequencer" machinery knows how to continue, and if it is in
the middle of conflicted "am -3" or rejected "am", the command may invoke
"git am --continue" instead.

That way, the user does not have to learn which command can be resumed
with "sequencer --continue" and which other command needs to be called
with "--continue" to resume. The user does not even need to know there is
a mechanism called sequencer, some commands are already using it while
others are not yet using it, and these other commands are in the process
of being rewritten to use the sequencer machinery.
