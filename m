From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 08:47:34 -0700
Message-ID: <7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
	<7vip1moq3k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
	<7v4nd6l31d.fsf@alter.siamese.dyndns.org>
	<CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 17:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4Jr-0006aD-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 17:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab3FJPrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 11:47:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3FJPri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 11:47:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E8126C69;
	Mon, 10 Jun 2013 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVtKn37JywhKzUJLMvBEcZrJrFc=; b=h9GObo
	05JFrQ/mc/XgcwxuWeOiv4BhWxeI3EYRdQyEBESzCBvssL3MZD8w4zB64cDO5dDP
	NmwBCq63UZ2KLO/9a0/Y9boCmGO3EkR0HY8DYi0u8Gge4WFz+sHygNTODKMS0Cqy
	EDNyuMTUUKnTQc2kN1G5sWOdn/D1W779PqhW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t4k1tl8DulqTVRqBHx7NJOfU8+c2CCUy
	DmuCS2VYHdMYrAh9Z6tJlop9iY+mGmvnKE1Cxc4sJVWPZFVcjDAepRhbPsdzST9S
	/QzAuf5JiWP7mpHqKo8OFoel1JdqQSwjSsrrPOw7JtOn5JUj8eFiuUIVhq+giaCi
	wNYXrep+mhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665F726C68;
	Mon, 10 Jun 2013 15:47:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D21A26C64;
	Mon, 10 Jun 2013 15:47:36 +0000 (UTC)
In-Reply-To: <CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 17:18:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12B183FE-D1E5-11E2-8CE5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227305>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The name under which the local branch is published needs a sensible
>> default (when branch.$name.push is not specified), and I agree that
>> you would get the name of the branch my work was forked from if you
>> reuse the "upstream" code.  I am saying that it does not necessarily
>> give us a good default.
>
> See, that's the problem: push.default is simply a default refspec to
> push to for all branches, that can be _overridden_ by
> branch.<name>.push.

Think again and remember that Git is distributed.

As you say, the push.default configuration specifies the mode that
computes what remote branches are updated.  Where we differ is that
I consider "triangle" branch at your repository I fetch from and
"triangle" branch at the repository I push to (in the triangular
workflow) different entities, just like "triangle" branch in my
local repository is different from both.  branch.triangle.merge
configuration is used to link the first and the third, and the first
is called "upstream" of the third for this reason.  It does not have
anything to do with the second.  You seem to think branch.*.merge is
used to link the second with the first, and I do not think it makes
any sense.

> Getting an override is not going to solve the
> problem we are facing: what to do when branch.<name>.push is
> unspecified?  Fall back to push.default, right?

That is not the issue.  We both are solving it by falling back to
push.default, but the problem is that the mental picture you have
for push.default has not been updated to support the triangular
world better.  In the centralized world, the first and the second
(in the above description) remote branches, both of which are named
"triangle", are the same, because they are in the same remote
repository.  Trying to reuse that in the triangular world is *not*
automatically being orthogonal and better; it may be simply keeping
things inconvenient by choosing a wrong definition, which is what I
am trying to avoid by thinking things through.

>> Now think _why_ I renamed the branch on my end, i.e. not calling
>> that branch in question "triangle" that is the blanket name for the
>> collective effort but calling it with a more specific name
>> "pushbranch", in the first place.
>
> Look, it's very simple.  upstream was built to support the case when
> the local branch name is different from the remote branch name, but it
> was too specialized for central workflows.  How do we extend it for
> triangular workflows?

"upstream" is for the case where you push back to your "upstream",
that which you fetch from and integrate with.  It is perfectly fine
to extend it for triangular workflow by erroring it out when it is
used, as you do *not* want to update "upstream" in that workflow.
You are sending your work to your publishing repository.

> Just like we introduced branch.<name>.pushremote to override
> branch.<name>.remote, we get branch.<name>.push to override
> branch.<name>.merge.  If branch.<name>.pushremote is unset, where do
> the pushes go?  branch.<name>.remote.  If branch.<name>.push is
> unspecified, what is the refspec to be pushed?  branch.<name>.merge
> (when push.default = upstream) [*1*].
>
> What does this mean?

Doesn't it just mean that you do not understand "distributed"?  

What makes you think that the repository you fetch from and the
repository you push to, which are by definition different
repositories, have to share the same namespace?

>  I publish the branch "triangle" on ram (what my
> local branch is called or what push.default I use is irrelevant).  You
> have a branch called pushremote with branch.pushremote.remote set to
> ram, remote.pushdefault set to junio, branch.pushremote.merge set to
> refs/heads/triangle, and push.default set to upstream.
>
>   # on jc's machine; on branch pushremote
>   $ git pull
>   # integrates changes from ram's triangle just fine
>   $ git push
>   # publishes the branch as triangle on remote junio

Only if I want to publish the result of the work forked from your
"triangle" as my "triangle", but that is not the case.  A fork to be
integrated by other is by definition more specialized than the
original, and I would publish my "pushbranch" subtopic as such, not
as "triangle".

It appears that the message you are responding to failed to convey
the primary point, so it may not be very useful for me to repeat it
here, but anyway.

> [Footnotes]
>
> *1* remote.pushdefault overrides branch.<name>.remote, while
> push.default will be overridden by a future branch.<name>.push.  Not
> exactly elegant, is it?

But that is not what is happening, unless you keep thinking
"push.default decides the name of the branch regardless of what
repository it lives in", which is where our difference lies, I
think.

Imagine the case where I forked two branches from your "triangle"
topic and pushing them to my repository using the triangular
workflow.  By your definition, they will both try to push to
"triangle", which means you, the "triangle" topic maintainer, cannot
receive two independent pull requests from me.  You can only get a
single branch that pre-merges both, and if you want to get one but
not the other, you have to do the untangling of these two topics.

The solution to the above becomes clear and simple, once you stop
thinking that the branch namespace you have has to be the same as
the branch namespaces other people have (which was limitation
imposed by central workflow, to which triangular has no reason to be
bound to).  Pushing to "upstream" by tying the name I fetch from and
the name I publish the result as is not appropriate in triangular
workflow, so just fail it.

I am not saying that you have to pick one to use for push.default
among the remaining ones (i.e. matching, current, what else?).  It
is very plausible that the triangular workflow wants a different
logic to pick what branches are to be updated and how.  Perhaps we
would want something that is capable of mapping your local branch
name to a branch name suitable in your publishing repository, and I
am not opposed to have such a mode.

But I think it _is_ a short-sighted mistake to consider "upstream"
the appropriate choice, if the reason to think so is only because
that is the only one that does any form of mapping in the current
system that was specifically designed to support workflow that
pushes back to where you fetched from to integrate with
(e.g. centralized).  We need to first ask if its mapping (i.e. what
the branch at "upstream" repository you merge into your local branch
in question is named) is the appropriate mapping to be used also for
pushing.  And I asked that question in the message you are
responding to (and my answer is it is not suitable).
