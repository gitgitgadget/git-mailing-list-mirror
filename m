From: Junio C Hamano <gitster@pobox.com>
Subject: Re: need help with syncing two bare repos
Date: Fri, 03 Aug 2012 14:34:42 -0700
Message-ID: <7vy5lvacct.fsf@alter.siamese.dyndns.org>
References: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
 <7vboirbva3.fsf@alter.siamese.dyndns.org>
 <CAPZPVFZpLBXG0Ntbf06dWRS_Z4hVzMXF-2FmfqvT2mN9A8Ektg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxPWF-0002dr-A9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 23:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab2HCVeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 17:34:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab2HCVep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 17:34:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC46E8E50;
	Fri,  3 Aug 2012 17:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+gFw2xGfWovo
	w3yV3r2slf9Fero=; b=o/34mh6Kngt6QQZHxHBycePrF+UWbNvpSRXvKqZ9IP5u
	8uO4kL9g8LBiIthu8EpTr7Ag8db7h6ICioE3b+Gq2fK6x5EiFdMWCqdBe9SHQljY
	ca84XXWAx+Cqgp6MOiQ7HD8cRNauY27wFnv/3rNAp0mzcxpoWtf5CgV4g4VgLK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mhNvOM
	9wE891u8C5avYc2UprOae4RvTZ5Lpd5UVPyFjdsL8yCqFbSehyDAzxGV6IwA1T+k
	DDrzAVnnKrGeuEpwf1vXychrO7HczMt/5YjMzjfOaLplCFB4wvS/t1seadXISNko
	SsYj5gBbYSFowMDO0ffz0EYwkPWrdrlmlm7Xg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA30F8E4F;
	Fri,  3 Aug 2012 17:34:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1595C8E4E; Fri,  3 Aug 2012
 17:34:43 -0400 (EDT)
In-Reply-To: <CAPZPVFZpLBXG0Ntbf06dWRS_Z4hVzMXF-2FmfqvT2mN9A8Ektg@mail.gmail.com> (Eugene
 Sajine's message of "Fri, 3 Aug 2012 16:31:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A62C1A8-DDB3-11E1-9060-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202864>

Eugene Sajine <euguess@gmail.com> writes:

> On Fri, Aug 3, 2012 at 4:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> I think the best variant would be to do something like:
>>>
>>> $ git pull --rebase /refs/heads/*:/refs/heads/*
>>> $ git push origin /refs/heads/*:/refs/heads/*
>>
>> You perhaps meant "worst" not "best" here.  From the point of view
>> of people who have pushed into the "origin" repository we see above,
>> their history is rewritten; you are screwing half the population by
>> doing this.
>>
>> Not allowing B to accept pushes while it is not positively sure that
>> A has gone down would of course be the best solution (in your scenar=
io,
>> B started serving when it merely found out that *it* cannot contact
>> A), but barring that, the recovery for two histories at A and B,
>> once they diverged, should be to "merge" corresponding branches.
>
> ... but wouldn't merge result in the same
> history changes for people pushing to the origin (bareA)?
> Still all their consequent changes will not be fast-forwardable
> because of merge commit. Or am i missing something?

Welcome to the world of distributed version control.

Even with a single server, it always is possible that other people
have been working on their changes and pushed their results out
while you are working on your changes when you are working with
others.  It is perfectly expected that your changes may not be
fast-forwardable.  In such a case, you can, and you are expected to,
fetch the updated tip from the public meeting point, integrate your
work with it and then push the result back.

That is not an issue.

If the project has "strictly linear history only" policy [*1*], then
the "fetch the updated tip, integrate your work and push back" would
involve a rebase on the participant's part, and only in that very
narrow context, it wouldn't make a difference if you rebase at the
server end while doing your recovery procedure.  In a way, the
rebase during your recovery procedure is doing the rebase the
particupants would have to perform anyway for them.

But in a more general workflow where project participants are either
allowed or encouraged to merge (as opposed to rebase and immediately
push the untested results out), the history resulting from a merge
by a participant, when he finds that what he has is not a strict
descendant of the recovered A's history, will contain the commits he
made originally to A when it was half-alive and their doppelg=C3=A4nger
commits your recovery procedure produced by rebasing, which is a
disaster.


[Footnote]

*1* Projects can enforce strictly linear history by rejecting push
of a history with any merges in their pre-receive hooks.  Such a
practice may be denying its participants major benefit of Git,
namely, distributedness, but it is probably easier to explain to
people coming from CVS or systems where branching and merging are
impossibly hard.
