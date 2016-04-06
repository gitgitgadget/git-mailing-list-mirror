From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Triangular workflows and some anecdotes from the trenches
Date: Wed, 06 Apr 2016 10:01:26 -0700
Message-ID: <xmqqbn5my8m1.fsf@gitster.mtv.corp.google.com>
References: <CAFOYHZARoEXkT6kVy7+wMSqUxSVVHHMV5KfhU6FON3tB6XEuMg@mail.gmail.com>
	<xmqq37qz1ypa.fsf@gitster.mtv.corp.google.com>
	<CAFOYHZDx1cqwUnR9E=RQKboSfF4gWDjERvEWQA_YePZq64QarQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:01:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqpk-0005CE-NC
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcDFRBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 13:01:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750847AbcDFRB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 13:01:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06CC552CA7;
	Wed,  6 Apr 2016 13:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0L/acKmCa8E5cxxP3QVK9TEuVk=; b=jBpDbr
	0vIK/ADuLUCnU52L7/nqTm16vpd6VFdwcvitoBumFRucOoOoERgGvQlw6YiWLYjJ
	aSLLup8ijAVjbD0cAVyz0YWnjahMrjatgUR9kuzGUtmESrrZOf6DUKxkGDZLnGTB
	nLvLa7XlkZDvk8SBpMyuUWoMagHS72WLKRbY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCOd6kj82xSSHa02aNv4R/9XFIQZ3bAv
	5rw77geAVTWYAuRJMTm1fFnoIH/ziGVbpcqxxsK1G7PWxADLPTFlynLm/ZEOQrGS
	OhCT1jaBDY78AJ+NeJsYkX8RdzN+DdyuSDr3WB4HctEOJHbVwoUZXUxfKCTmWQVt
	sIcYRTZsNOA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2D9352CA6;
	Wed,  6 Apr 2016 13:01:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FF1652CA5;
	Wed,  6 Apr 2016 13:01:27 -0400 (EDT)
In-Reply-To: <CAFOYHZDx1cqwUnR9E=RQKboSfF4gWDjERvEWQA_YePZq64QarQ@mail.gmail.com>
	(Chris Packham's message of "Wed, 6 Apr 2016 20:30:29 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33991526-FC19-11E5-A7FF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290854>

Chris Packham <judge.packham@gmail.com> writes:

> On Wed, Apr 6, 2016 at 10:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Developer ending up amending is not an issue per-se, unless the
>> result is pushed back to the public.
>
> Correct and that was when the developer in question realised he had a problem.

But then "push" would have failed and correcting would all be local,
no?

>> A bigger problem may be how you make sure everybody sets up
>> @{upstream} correctly.  You may fork your own copy of a branch from
>> the target branch, start working on it, further fork other branches
>> on your work to experiment different approaches, with the intention
>> to later use the best one to update your first fork.
>>
>> At which point, the @{upstream} of the secondary branches are your
>> own first branch, not the public one--which is not a problem per-se,
>> because your first branch (whose @{upstream} is the remote one) is
>> not yet public and you should be allowed to freely update it to
>> polish it by rewriting.  But then after you push out your first
>> branch as an interim snapshot to the public, you no longer want to
>> rewrite the commits reachable from it.  So (to put it mildly) it
>> would be quite complex to get all the corner cases right, and the
>> definition of "right" would probably depend on the exact workflow.
>
> I think you could still argue that if @{upstream} exists. Warn about
> (or disallow) re-writing anything anything that is reachable from it.
>
> There is still the possibility of if someone else rewinding
> @{upstream} on you and I think the scenario you've highlighted is just
> a case of doing it to yourself.

But at that point, you are not doing much to help the normal users.
I was actually expecting a response with a different approach, e.g.
instead of relying on @{upstream} that may or may not serve as a
good check anyway, make sure nothing reachable from any of the
refs in refs/remotes/* is not updated by amend or rebase.
