From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 12:23:52 -0700
Message-ID: <7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
	<7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
	<CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 21:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpkSe-0007hy-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 21:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131Ab3FTTX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 15:23:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161069Ab3FTTXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 15:23:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F6FE29D94;
	Thu, 20 Jun 2013 19:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eshIqDpYuz6XKl0hl54s2TxlGZY=; b=f+ZukEvdN5A8U3wERP9i
	9wCnbeviXX6CCxxcA6XWfVEsLn8rqvV8z86SOZpTHw4graiinY7iN6Uv6B/uwl/p
	Fa/ggVZyJRva68HvacE9iGcbgezYM+ob9DdXoISSKDSciQwSDLo6y1tCR2iS2Ajo
	+aBugu9CdahLP9NeuA/1jas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=CsMWPiHpBnISSUgcr/GmYwSqra3xZngOqnUK6pqQ6hPtXc
	AOF8W6A9Qs9zV81ZkYttZuzS3XQ87yS9Q3fJyeb0SujwFnYO9ewNh0MoTwTZ3qEd
	bT/NvaW7f/weuDndsO6/NJiGzVjuk3I489DhRU3gRicghdLbrQSscwjGlOmbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43F0129D93;
	Thu, 20 Jun 2013 19:23:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CAFA29D8C;
	Thu, 20 Jun 2013 19:23:54 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F23C4FC6-D9DE-11E2-B834-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228525>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> Decouple `simple` from `upstream` completely, and change it to mean
>>> `current` with a safety feature: a `push` and `pull` should not be
>>> asymmetrical in the special case of central workflows.
>>
>> Double negation confused my parser.  'push' and 'pull' should be
>> kept symmetrical in central workflows?
>
> They're not the same thing.  It is very much intentional and intended:
> the safety net is not to "ensure that the push and pull are
> symmetrical" (i.e. among other things, error out if
> branch.$branch.merge is unset), but rather "ensure that the push and
> pull are never asymmetrical".

Hmmmm....

    not to "ensure that the push and pull are symmetrical"
    rather "ensure that the push and pull are never asymmetrical".

They still talk the same thing to me.  What am I missing?

Am I being clueless, or is there something else going on?

Your "among other things", after reading it three times,
unfortunately did not help clarify anything to me, so perhaps
somebody other than me (or you for that matter) who is more clueful
can help find a different way to explain the difference you are
trying to express to me.

Help, anybody?

>> Provided that we would want to keep the "Push the current one to the
>> same name but you have to have it set up as your integration source"
>> safety for central workflow (which I am starting to think we
>> should), we would want something like this on top of your entire
>> series, I think.  The behaviour change can be seen in the revert of
>> one test you made to the test that expects "simple" to fail due to
>> the safety.
>
> Now I'd like to question what you are labelling as "safety".  What is
> the consequence of erroring out when branch.$branch.merge is unset
> when pushing using `upstream`?

Nothing noteworthy.

I wasn't suggesting to change what `upstream` does at all.

If you do not have a `upstream` configured, we do not know what
branch you are integrating with, and the operation has failed in the
code even before we started adding triangular.

I do not see a reason to change that in the triangular world;
`upstream` is about the central workflow as you originally wrote in
the "config.txt" patch in this series.

The name of the branch the repository you fetch from and integrate
with does not have anything to do with the name you want to push
your derived work as to a different repository

I thought we already discussed and agreed on this point.

  http://thread.gmane.org/gmane.comp.version-control.git/227028/focus=227313

The conclusion is that using push.default=`upstream` is meaningless
when you are using a triangular workflow.  If you are using a
centralized workflow, and if a branch does not have branch.*.merge
configured, we do not know to which branch you are pushing it back,
so we error out.

What I am changing from the patch you posted with the "how about
this on top" patch back to the current behaviour is what 'simple'
does for centralized workflow.

> I didn't want to contaminate this series with an unrelated improvement
> to `upstream`

I think we share that, and it is not just `upstream`, but also
`simple` when it is applied to folks who employ a centralized
workflow.  The safety we need to keep is the one we have had since
day one of introducing 'simple' for them.

When you are doing a centralized workflow, 'simple' was defined to
be 'upstream' with added restriction that the branch at the remote
you integrate with must have the same name as the current branch you
are pushing, i.e.  in

    [branch "frotz"]
	merge = refs/heads/$branch

the value of $branch must be 'frotz'; otherwise 'simple' errors out.

  http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=196199

Now, no existing series has casted in stone the best behaviour for
`simple` in a triangular workflow.  With this series (and also with
my fixup patch I sent last night), it is defined to act as `current`,
but it may need a bit more safety to help new users avoid pushing
branches they did not intend to (perhaps pushing out `current` only
when the branch with the same name already exists at the destination?
I dunno).
