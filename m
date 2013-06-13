From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Thu, 13 Jun 2013 14:02:40 -0700
Message-ID: <7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 23:02:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnEfQ-0006eS-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 23:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab3FMVCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 17:02:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757798Ab3FMVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 17:02:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50623277CC;
	Thu, 13 Jun 2013 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ih9TOMKoqEg23+Ro8K1pIO3stkU=; b=mLRj9H
	G9XRaLzbO3BuDbZZgL1y9K46RMrsrpe871iU/1GI/7OjusFkLQtjF76xdZ1vPKp1
	V3EmASKFR9gJkVK6gJh3y1WMb2bzRZxtVjds4mYrQowwspraRYoMpfOkOIXXJtXE
	Ks8WfvAff7YCa5OVYGO0kTMwdi8IwhFQkNDrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmqGqrk2ouMILoGAMzEy66FUf14zpE19
	HiIDbAtNhia2zgkHj319FNy+ssm2RYBY23vfbuWPKAc3vO/u/eIgD8C3dRytAqP7
	b1LNAalcHj5uO/QGX41waa903ybKhhtsZDVCUiupO+SSLHhRDxfyJA2wrtJqHdDN
	qF0VapBuDlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA33277C1;
	Thu, 13 Jun 2013 21:02:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4772A277BE;
	Thu, 13 Jun 2013 21:02:42 +0000 (UTC)
In-Reply-To: <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 00:18:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 969DE796-D46C-11E2-BD18-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227777>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> To be clear: the problem is not the feature, but rather in the
> _implementation_ of the feature.

OK, but are we discussing the same "feature" (see below)?

>> You were at 1.8.2 but no longer are, so in the following sequence:
>>
>>     $ git checkout v1.8.2
>>     $ git status
>>     $ git reset --hard HEAD^
>>     $ git status
>>
>> the former would say "detached at v1.8.2" while the latter should
>> *not*, because we are no longer at v1.8.2.  "detached from v1.8.2"
>> is too subtle a way to express the state, and is confusing, but I
>> would not be surprised if people find it useful to be able to learn
>> "v1.8.2" even after you strayed away.
>
> What is wrong with git describe?  Is this cheaper, or am I missing something?

I think what you are missing is that the "detached from" is not
about your current HEAD after you flipped it around with many resets
and commits.  It is about what tag or what specific commit you
detached your HEAD at originally.

"You can ask the same to describe" is wrong and is not a valid
argument.  Once you replace the HEAD^ with a distant commit
(e.g. HEAD~400) in the third step in the example, "describe" will
not talk about v1.8.2 at all.

Your argument can be that it is not a useful piece of information,
and as you can probably guess from my "I wouldn't be surprised"
above, I am not sure how useful it would be and in what situation
[*1*].

But the original commit thought it was necessary and that was done
for a reason; we need to be careful here.  With a good justification
why it is not necessary (or misleading to the user), I do not think
we cannot change it.

As various tools that use detached "intermediate" states leave
enough clues for "status" to notice what is going on, I actually
think it is a mistake to focus on what happens when we are in such a
detached "intermediate" status with this codepath.  For example:

	$ git rebase master
        ... replays some but stops
        $ git status

currently uses that "HEAD detached from" codepath, but I think that
is a mistake.  We could not just tell the HEAD is detached, but the
reason _why_ the HEAD is detached (i.e. we are in the middle of a
rebase).  The prompt script can do it, "status" should be able to do
the same, and do a lot more sensible thing than unconditionally
showing that "HEAD detached from" and then say "You are currently
rebasing" on a separate line.  Most likely we do not want to even
say "Not currently on any branch" but just say "You are currently
rebasing branch X on top of Y" (and perhaps "N commits remaining to
be replayed").


[Footnote]

*1* One thing I could think of is to start sightseeing or (more
    realistically) manually bisecting at a given release point,
    reset the detached HEAD around several times, and then want to
    be reminded where the session started from.  I do not think it
    is particularly a very good example, though.
