From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 09:08:10 -0700
Message-ID: <7vtxknbifp.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	<7vhagndis4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
	<CALKQrgdQRtfGmfaq9sS=VbezV2RVs9WJwUQBqVF+1Ozn7FxdJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:08:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9JT-0000HR-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3FXQIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:08:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3FXQIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:08:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B3F2B000;
	Mon, 24 Jun 2013 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+lOllgDd+mDvUmjfUmd/OBXSjPk=; b=gmEQWq
	jj2dgDiinUe+f4tVGRHlEfzOURPl6JUv8cl0Q0Tn1RKVsYrFcKk2UJLI/KrKMEtt
	FRocRBtoOM+STZ9Z2AFIM3UX8qVkjvAmtXrWG3OEPksPGQueAkJnZ2NdAVNrBD6Z
	roviCPH6ULC07EwXzIsiSlo/aUnsuLAvFF0/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QF4LEYu5D3jQidNBfBosvnDBo2dwHpc/
	z1AHBjFvwpJSTeCRdIQ0GbYPkEJDDgtQUwth0CsnOGp3t8ywaKGG6/IHlxE55wyQ
	9okU2yg2Lp45AgdI3QTyy5J3tj9cCilAfjNB6YOSEbJ3AUnCm1fu5imW6x5ja1Zc
	EmQVQH+AtvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA652AFFF;
	Mon, 24 Jun 2013 16:08:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C54D82AFED;
	Mon, 24 Jun 2013 16:08:11 +0000 (UTC)
In-Reply-To: <CALKQrgdQRtfGmfaq9sS=VbezV2RVs9WJwUQBqVF+1Ozn7FxdJw@mail.gmail.com>
	(Johan Herland's message of "Mon, 24 Jun 2013 17:23:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44BB2C70-DCE8-11E2-A1A3-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228843>

Johan Herland <johan@herland.net> writes:

> I haven't yet dug deep enough to figure out an obvious failure mode
> (and I probably should not have sent this email until I'd found one),
> but I wonder if we'd be better off forcing the $remote and $remote_ref
> configuration for a given branch to appear as more of a single unit.

That sounds sensible.  I could see perhaps we would want to require,
for branch.*.push to be effective, branch.*.pushremote must be set
(honestly speaking, branch.*.push is not my itch and I'd probably be
happier if we didn't add it in the first place, though ;-).

> What if, when setting up tracking for a given branch, we immediately
> specified its complete pull and push targets?
>
> For example, when in a centralized workflow (e.g. push.default =
> upstream) and we're checking out local branch foo from origin's foo,
> we could set up the following configuration [1]:
>
> [branch "foo"]
>     pull = origin/foo
>     push = origin/foo

They should both be refs/heads/foo, as these are meant to name the
name in _their_ repository.  I see what you are saying, but the
behaviour you want happens without branch.foo.push, and the addition
may be redundant.  I do not immediately see what it is buying us.

Other than that when the user stops being centralized and starts to
push to his own publishing repository, branch.*.push needs to be
removed in addition to flipping push.default from upstream to
current, that is.

> In a triangular workflow (assuming we had configuration to specify
> such, and also a default push remote), we could then instead set up
> the following config:
>
> [branch "foo"]
>     pull = origin/foo
>     push = my_public/foo

Again, these are both refs/heads/foo.

> This leaves no ambiguity for even the most novice user as to the pull
> and push targets for a given branch, and it's also easy to change it,
> either by editing the config file directly, or by using hypothetical
> commands:
>
>   git branch foo --pulls-from=origin/bar
>   git branch foo --pushes-to=other_repo/foo

But you need to do that for _all_ branches when you acquire your own
publishing point; isn't that a rather cumbersome usability glitch?

> Obviously, specifying the remote and/or refspec on the command-line
> would still override, as it does today, but for the argument-less
> forms of "git pull" and "git push", the hierarchy of options and
> defaults being consulted to figure out $remote and $remote_ref would
> be small and easily understandable.

Not really.

In addition to "you need to run around and change configuration for
all branches" issue, you can never do push.default=matching, if you
always set branch.foo.push and made it stronger than push.default,
no?
