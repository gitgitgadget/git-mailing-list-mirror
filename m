From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 14:56:04 -0700
Message-ID: <7v38scqwej.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
	<7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
	<CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
	<7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTthYyHRkxqK2Z3uP3uUmtQADyZt7CERY_40iQSQyzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upmq0-0005Ok-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab3FTV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab3FTV4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:56:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397042A1EF;
	Thu, 20 Jun 2013 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e5ixEV1j6uuuyXuYDKveosBYl4M=; b=x4D59n
	pzeG2QIZKqSpRF0zW2KBECggsZLGbv2uNCrEL/CXpq7ui8klvX7OXdKs7FPW7u/g
	cqZiNurXOzZB3ONRLogy4Mxac20WFk110KXj6ep/e9uzx/A4Ld8vPaABGE67Ep0q
	BlHseY+SVz6fK3TqZvCkVze3o1hY+qwaSOnos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCB30rIe3Xu9fVuHwWJbSz9hCb4OW7hy
	wWyazxM1F13MNk9WpgrhTo46G18Gl256I31iGiDWkvalhJU5bi6PQUs85tZ2qy+l
	seu6hxTs8so1mfF7ft4UbJNfVWOBTOR3fttZnPbPYmpjTiwBOwodx4B+bg5nO/Uk
	SbQ/6oJ5lcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9D02A1ED;
	Thu, 20 Jun 2013 21:56:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFBD92A1EC;
	Thu, 20 Jun 2013 21:56:08 +0000 (UTC)
In-Reply-To: <CALkWK0mTthYyHRkxqK2Z3uP3uUmtQADyZt7CERY_40iQSQyzAA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 02:52:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36CE062E-D9F4-11E2-9654-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228545>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> They're not the same thing.  It is very much intentional and intended:
>>> the safety net is not to "ensure that the push and pull are
>>> symmetrical" (i.e. among other things, error out if
>>> branch.$branch.merge is unset), but rather "ensure that the push and
>>> pull are never asymmetrical".
>>
>>     not to "ensure that the push and pull are symmetrical"
>>     rather "ensure that the push and pull are never asymmetrical".
>>
>> They still talk the same thing to me.  What am I missing?
>
> Never mind the wording then.  I am proposing preventing asymmetry by
> explicitly disallowing a push when $branch is different from
> branch.$branch.merge, instead of shutting down immediately when
> branch.$branch.merge is unset.

We always said "upstream is to update the branch you fetch and
integrate with", and tried to make sure the push destination is the
branch you configured the current branch (i.e. the one you are
trying to push out) to fetch and integrate with.  That is how we
prevent asymmetry.

We fail if branch.$branch.merge is set to something else.  We also
fail if branch.$branch.merge is *not* set, because by definition the
branch you are trying to push to in that scenario cannot be the
branch you fetch and integrat with by "git pull [--rebase]".

I know your patch was attempting to change the behaviour for the
latter.  You are trying to let anything go if branch.*.merge is not
set.  How would it help prevent assymetry?

>>> Now I'd like to question what you are labelling as "safety".  What is
>>> the consequence of erroring out when branch.$branch.merge is unset
>>> when pushing using `upstream`?
>>
>> Nothing noteworthy.
>>
>> I wasn't suggesting to change what `upstream` does at all.
>
> No, but I did....

Really?  Then where did this come from?

> I didn't want to contaminate this series with an unrelated improvement
> to `upstream`

>> If you are using a
>> centralized workflow, and if a branch does not have branch.*.merge
>> configured, we do not know to which branch you are pushing it back,
>> so we error out.
>
> And I said: have a sane default.

Like you said, I do not want to contaminate this series with such an
unrelated change.  Worse, you are trying to break a sane default by
replacing it with "anything goes".

We already have a sane default, which is to error out.  We do not
need your broken default.
