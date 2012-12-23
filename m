From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 11:18:51 -0800
Message-ID: <7v4njcpof8.fsf@alter.siamese.dyndns.org>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
 <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
 <7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
 <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 20:19:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmr58-0004vR-UR
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 20:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab2LWTS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 14:18:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab2LWTSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 14:18:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 723CDAB5F;
	Sun, 23 Dec 2012 14:18:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BvXMs98nCgXERqez0qDKrDAvefk=; b=nfjaiv
	xNmZnC3gQ4gRXgV/NNmufA9WqLGDR2g/WGo19sTxDCXFWTVxCxPrBq7HIumU551n
	6/SZKPEXhQYMlzNs2JrSmNz1wGnGx4nxc8J86S9b3CyC61e4DcjIPlXd5vidX5jL
	WiHf6R0me/EafXG7oz2uFSo5WwEGDZMJJU6H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pnvuy4pQkyo238FJtRADZ1FfZ7WEqdqQ
	wCvmBJn8Hwro4lJ/g9QPRB0qTwgmiMXMaVvn4a3Khqy7iy+A8fK74Stv6cJTaT2f
	v0MQ2nyRyWceEhOV8XKOab5q8qRVR0hRIDjXHkSPRPGSPnhABCWi4LwjpyVevMT0
	e/29N9p5SxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E4EBAB58;
	Sun, 23 Dec 2012 14:18:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B145AB54; Sun, 23 Dec 2012
 14:18:53 -0500 (EST)
In-Reply-To: <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Sat, 22 Dec 2012 22:24:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96FED75E-4D35-11E2-A467-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212086>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Sat, Dec 22, 2012 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>>
>>>>From the user's point of view, it seems natural to think that
>>> cherry-picking into an unborn branch should work, so make it work,
>>> with or without --ff.
>>
>> I actually am having a hard time imagining how that could ever be
>> natural.
>
> Fair enough. What's natural is of course very subjective.  ...
> happens to be empty. Of course, pretty much any operation that needs
> more than the tree (indirectly) pointed to by HEAD would fail the
> "whenever possible" clause. I realize that cherry-pick _does_ need the
> current commit to record the parent of the resulting commit,...

Yes, and I do not think it is an implementation detail.

I am not opposed to an "internal use" of the cherry-pick machinery to
implement a corner case of "rebase -i":

    1. Your first commit adds "Makefile" and "hello.c", to build the
       "Hello world" program.

    2. Your second commmit adds "goodbye.c" and modifies "Makefile",
       to add the "Goodbye world" program.

    3. You run "rebase -i --root" to get this insn sheet:

	pick Add Makefile and hello.c for "Hello world"
        pick Add goodbye.c for "Goodbye world"

       and swap them:

        pick Add goodbye.c for "Goodbye world"
	pick Add Makefile and hello.c for "Hello world"

    4. The first one conflicts, as it wants to add new bits in
       "Makefile" that does not exist.  You edit it and make the
       result pretend as if "goodbye.c were the first program you
       added to the project (i.e. adding the common build
       infrastructure bits you did not change from the real first
       commit back to "Makefile", but making sure it does not yet
       mention "hello.c").

    5. "rebase --continue" will give you conflicts for the second
       one too, and your resolution is likely to match the tip
       before you started the whole "rebase -i".

In step 4., you would be internally using the cherry-pick machinery
to implement the step of "rebase -i" sequence.  That is what I would
call an implementation detail.  And that is cherry-picking to the
root.  It transplants something that used to depend on the entire
history behind it to be the beginning of the history so its log
needs to be adjusted, but "rebase -i" can choose to always make it
conflict and force the user to write a correct log message, so it
won't expose the fundamental flaw you would add if you allowed the
end-user facing "cherry-pick" to pick something to create a new root
commit without interaction.

> In the same way, I think "git reset" should work on an unborn branch,
> even though there is no commit that we can be "modifying index and
> working tree to match" (from man page).

I agree that "git reset" without any commit parameter to reset the
index and optionally the working tree (with "--hard") should reset
from an empty tree when you do not yet have any commit.  If HEAD
points at an existing commit, its tree is what you reset the
contents from.  If you do not have any commit yet, by definition
that tree is an empty tree.

But I do not think it has anything to do with "cherry-pick to empty",
so I do not agree with "In the same way" at all.

> As for use cases, I didn't consider that much more than that it might
> be useful for implementing "git rebase --root". I haven't implemented
> that yet, so I can't say for sure that it will work out.

I think it makes sense only as an internal implementation detail of
"rebase -i --root".

> One use case might be to rewrite history by creating an new unborn
> branch and picking the initial commit and a subset of other commits.

If you mean, in the above sample history, to "git cherry-pick" the
commit that starts the "Hello world" and then do something else on
top of the resulting history, how would that be different from
forking from that existing root commit?

> Anyway, I didn't implement it because I thought it would be very
> useful, but mostly because I just thought it should work (for
> completeness).

I would not exactly call X "complete" if X works in one way in most
cases and it works in quite a different way in one other case, only
because it would have to barf if it wanted to work in the same way
as in most cases, and the different behaviour is chosen only because
"X that does something is better than X that stops in an impossible
situation and barfs".
