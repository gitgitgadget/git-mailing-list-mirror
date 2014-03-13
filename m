From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 13 Mar 2014 11:47:50 -0700
Message-ID: <xmqqk3byhr55.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	<xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
	<CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
	<xmqqr46jqgfq.fsf@gitster.dls.corp.google.com>
	<CAL0uuq0LpQTQPeNVJgKGS2YLTT0gi_BM0wi02c0EP+kvBE4DyA@mail.gmail.com>
	<xmqqmwgvmfpk.fsf@gitster.dls.corp.google.com>
	<5321E8A7.3080907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOAff-00077Z-GH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbaCMSrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 14:47:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801AbaCMSry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 14:47:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2216D73C98;
	Thu, 13 Mar 2014 14:47:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5HnOhMJbgmkZAdDFCCMgDKUv8MM=; b=qqaBnX
	qqnsXK/qYETyryUel6JdELLCiXJkDrJIiJ7xjnwvge7krnQGV60c3Y9ZUofVJbO3
	0TRNhUgBBHvKdzS4ARECrfjVLvFpe9laKWQpaQ+drV0qX4dBcaxF3egQveHKEG0p
	2Hl8EzCQ5VaRdvD8AXklubKIveD6xFLwnt1PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vnm3IjKOy2VdZhtGtMlDQ3FgRbT0Tv7x
	SUD7m51DmqIgqU0YwOJ6LaXLs4/220tu02wI1oyLYtLUd3LwbylOJvn8HnYhDstC
	o71rHmQd44cSLsWIKi9JPHRVBVXb/7CDQqQEpPa8AyzDM1yKXrWYxNN0oCp5rtv4
	/bw94wtPMHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEF473C97;
	Thu, 13 Mar 2014 14:47:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20EFB73C96;
	Thu, 13 Mar 2014 14:47:53 -0400 (EDT)
In-Reply-To: <5321E8A7.3080907@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 13 Mar 2014 18:19:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FBE02F20-AADF-11E3-B1A7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244044>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It seems to me that we can infer which mark is which from the normal
> bisect user interaction.  At the startup phase of a bisect, there are
> only three cases:
>
> 1. There are fewer than two different types of marks on tested commits.
>    For example, maybe one commit has been marked "bad".  Or two commits
>    have both been marked "slow".  In this case we wait for the user to
>    choose another commit manually, so we don't have to know the meaning
>    of the mark.
>
> 2. There are two different types of marks, but no commits with
>    differing marks are ancestors of each other.  In this case, we pick
>    the merge base of two commits with differing marks and present it
>    to the user for testing.  But we can do that without knowing which
>    mark is "before the change" and which mark means "after the
>    change".  So just defer the inference.
>
> 3. There are two different types of marks, and a commit with one mark
>    is an ancestor of a commit with the other mark.  In this case, it is
>    clear from the ancestry which mark means "before the change" and
>    which mark means "after the change".  So record the "orientation" of
>    the marks and continue like in the old days.
>
> Of course, there are still details to be worked out, like how to tag the
> commits before we know which mark means what.  But that is just a
> clerical problem, not a fundamental one.

Yup, with an extra "state" kept somewhere in $GIT_DIR, we should in
principle be able to defer the "value judgement" (aka "which one
should be treated as a bottom of the range").

The first change that is needed for this scheme to be workable is to
decide how we mark such an unknown state at the beginning, though.
We assume that we need to keep track of a single top one ("bad", aka
"no-longer-good") while we have to keep track of multiple bottom
ones ("good").

There also is a safety valve in the current logic for transitioning
from case #2 to case #3; when a common ancestor is marked as "bad"
(aka "no-longer-good"), we notice that the original bisection is
screwy in the sense that the user is seeing not just a single state
flip that made something that used to be good into bad.

I am afraid that we may instead _silently_ decide that the user is
trying to locate a state flip that made something that used to be
bad (at the common ancestor) into good with the logic proposed
above.  From the point of view of the user who wanted to find a
regression by marking one as "bad" and the other "good", running
bisection whose semantics suddenly and silently changed into an
opposite "where was it fixed" hunt would be an unpleasant and
confusing experience.  I do not know, without knowing the meaning of
"slow" and "fast" (which implicitly tells us which way the user
intends to bisect), how well we can keep that safety valve.

Other than that, I like the idea.
