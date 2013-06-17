From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Sun, 16 Jun 2013 20:28:49 -0700
Message-ID: <7vli69iff2.fsf@alter.siamese.dyndns.org>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 05:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoQ7l-0005TV-0i
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 05:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab3FQD2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 23:28:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603Ab3FQD2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 23:28:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52E32215C;
	Mon, 17 Jun 2013 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6U2c2NY7M1iK3cdH9ocCEVLS9M=; b=JgG2un
	B5ymTaOtrtRc23ZHq7hNIgtNNZXAQ3rN5VwaUAqjKrxMoW3e0PS237y6nyC7sJyJ
	FImwzNJIqN/ZqDFzFtxOYsCSGLd4v/OmYceTNHsfmHdueZJmPNng7dYevr9SsT6D
	BHZe0wZjUEAPgfeQ/UxV8s1Y6thcBuXv2N7AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BgQC8Ufn7CigLQC+N0oZa0NOswOUzY+y
	hI07S0RFnWWyrr1ncLT5DNE10xSinVWu2I3WjlWdDJuqLkcH0Af1y8Rq4ofziDg5
	9BV36qsy544EZjju0Z1OfUPkhmZio9NjtbRwicEEY6OSr/LCpzh1gL8BWUKT0PYd
	7wWi0dZghRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2E92215B;
	Mon, 17 Jun 2013 03:28:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D753922159;
	Mon, 17 Jun 2013 03:28:50 +0000 (UTC)
In-Reply-To: <1371377188-18938-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 16 Jun 2013 15:36:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 076968A4-D6FE-11E2-BDB1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228037>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Design by Junio.

Not necessary.  The conclusion of discussion is a result of
collaboration.

Thanks for writing it down.  It is a good start, but I agree with
reviews by Philip Oakley and Matthieu Moy we already saw.  

 - To understand "if central, works as upstream, otherwise works as
   current", the readers need to know if their workflow is 'central'
   or not, so we need to say how that is decided upfront (probably
   immediately before "Possible values are:" in the introductory
   paragraph for push.default;

 - For each of these choices, what it means is more important to the
   readers than how the implementation achieves that semantics
   (e.g. "current uses refs/heads/foo:refs/heads/foo when you are on
   foo branch"). I think the ideal is a description of the meaning
   that is clear enough not to require any implementation detail.

I do no think the remainder (snipped) belongs to the log message.

As this is an attempt to _define_ the semantics of what should
happen in triangular workflow, I think it would be healthy to wait
for a week or so in order for others (not just two of us) can see if
we have defined a sane semantics we would want to go forward with.
I am reasonably sure 'current' would be the best default for
triangular (and that is why I suggested 'simple' to fall back to
it), but I do not think others had a chance to see what design our
discussion settled, think if that makes sense, and think of a better
alternative.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7fd4035..30350a3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1832,33 +1832,32 @@ push.default::
>  	line. Possible values are:
>  +
>  --
> -* `nothing` - do not push anything.
> -* `matching` - push all branches having the same name in both ends.
> -  This is for those who prepare all the branches into a publishable
> -  shape and then push them out with a single command.  It is not
> -  appropriate for pushing into a repository shared by multiple users,
> -  since locally stalled branches will attempt a non-fast forward push
> -  if other users updated the branch.
> -  +
> -  This is currently the default, but Git 2.0 will change the default
> -  to `simple`.
> -* `upstream` - push the current branch to its upstream branch
> -  (`tracking` is a deprecated synonym for this).
> -  With this, `git push` will update the same remote ref as the one which
> -  is merged by `git pull`, making `push` and `pull` symmetrical.
> -  See "branch.<name>.merge" for how to configure the upstream branch.
> -* `simple` - like `upstream`, but refuses to push if the upstream
> -  branch's name is different from the local one. This is the safest
> -  option and is well-suited for beginners. It will become the default
> -  in Git 2.0.
> -* `current` - push the current branch to a branch of the same name.

> +* `nothing` - error out unless a refspec is explicitly given.

I do not think 'error out' is the primary effect of this mode.
Wouldn't "do not push anything" be much better?

> +* `current` - push the refspec "$HEAD".  HEAD is resolved early to a
> +  branch name (referred to as $HEAD).  In other words, push the
> +  current branch to update a branch with the same name on the pushing
> +  side.

As already pointed out, dropping everything before and including "In
other words, " would be better.  Also "push the current branch" is
talking about the branch on the pushing side (you, the one who is
running "git push"), and the side that is getting updated is at the
receiving end, not "pushing side".

> +* `upstream` - push the refspec "$HEAD:branch.$HEAD.merge", and error
> +  out if the push destination is not the same as branch.$HEAD.remote.
> +  The name "upstream" refers to the revision "@{u[pstream]}" in
> +  linkgit:gitrevisions[7].  It is useful in central workflows, to make
> +  the `push` symmetrical to `pull`.
> +
> +* `simple` - in central workflows, behaves like `upstream`, except
> +  that it errors out unless branch.$HEAD.merge is equal to $HEAD.  In
> +  non-central workflows, behaves like `current`.  It will become the
> +  default in Git 2.0.

I think listing 'simple' at the end would be easier to read.  The
above already swaps the order to make sure current and upstream are
described before it, which is good.

But I do not see a reason to move 'matching' which was next to
'nothing' here. The 

> +* `matching` - push the refspec ":".  In other words, push all
> +  branches having the same name in both ends, even if it means
> +  non-fast-forward updates.  This is for those who prepare all the
> +  branches into a publishable shape and then push them out with a
> +  single command.  Dangerous, and inappropriate unless you are the
> +  only person updating your push destination.

It was already pointed out that unnecessary negativity needs to be
fixed, but more importantly the above "Dangerous" is not even
correct.

If you are "I am done with this one branch, I want to push it out,
the other branches I have touched but they are not yet in a good
shape to be pushed out" kind of person, it does not matter if you
are the only one who is pushing to the destination.  You would end
up pushing out half-baked ones as well if you used 'matching', which
is not what you want.

> -+
> -The `simple`, `current` and `upstream` modes are for those who want to
> -push out a single branch after finishing work, even when the other
> -branches are not yet ready to be pushed out. If you are working with
> -other people to push into the same shared repository, you would want
> -to use one of these.

And I do not see a reason to drop this part, especially the first
sentence.
