From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Thu, 04 Mar 2010 12:48:24 -0800
Message-ID: <7vocj33jaf.fsf@alter.siamese.dyndns.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
 <201003040306.16580.chriscool@tuxfamily.org>
 <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
 <201003040755.23485.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 00:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnI67-0003LZ-NR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 21:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757087Ab0CDUsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 15:48:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab0CDUsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 15:48:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F97C9F450;
	Thu,  4 Mar 2010 15:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7KjLKaFvQp7ABLd7wlE53GXOytg=; b=dt/6pn
	ROPuzxalJN63LntbaNzAwVoSWqXgQBl1UctjG7g3nbeNydmoDDdG3qXMz6wgowC3
	FTBKyHGLWmGqGh+EFnBn2ZUTWa+zUlhM0x2AkKkxtt1HCNu8uDX7cYtwYXc7E5LY
	6/TPZEMjKSxPtITeTs8xBTBsVtq3tNg4PmAQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UeROfAVMifZVXJKuoaofVN+VIn9GxoaZ
	SiK/1XFCO20F6o0Jq2TB+Vx2uIjGj6JDr0R7fie+QrpebjWHMCsa/N3fk8ELQUmM
	yuBItge+LZBHfCtgj27fvEsIMlECz33n56By3rtJ1Qo2WNUuUZh+MuLoa956xIs7
	E/8UKIpZ6Es=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1ECA9F44A;
	Thu,  4 Mar 2010 15:48:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B3359F43D; Thu,  4 Mar
 2010 15:48:26 -0500 (EST)
In-Reply-To: <201003040755.23485.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu\, 4 Mar 2010 07\:55\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D7F9458-27CF-11DF-B37B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141544>

Christian Couder <chriscool@tuxfamily.org> writes:

>> +static int fast_forward_to(const unsigned char *to, const unsigned char
>>  *from) +{
>> +	struct ref_lock *ref_lock;
>> +
>> +	read_cache();
>> +	if (checkout_fast_forward(from, to))
>> +		exit(1); /* the callee should have complained already */
>> +	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
>> +	return write_ref_sha1(ref_lock, to, "cherry-pick");
>> +}
>
> Ok, so your patch adds new code to do the job,...

Come on.

The above calls an _existing_ code to go from one rev to another, and
another _existing_ code to update the HEAD pointer with a reflog record.
I could have inlined this at its sole callsite just so that I won't give
you an excuse to quibble like you just did, but I thought that would make
the code less readable.

Also I thought that you knew better than that, and I wouldn't need such a
"quibble blocker".  Please don't disappoint me.

In other words, it was a demonstration that no refactoring was necessary
to do what you seem to have wanted to do.  We already had API functions
that exactly match what we wanted.  No need to add "pick.c" file, no need
to touch reset.c, no need to move the code around to add a check_parent()
that is called from only one place.

It is a separate issue if there are some other functions that are totally
irrelevant to the immediate goal of implementing your "cherry-pick --ff"
(which is the title of the series) that do something similar to what
checkout_fast_forward() does.  Maybe they need to be rewritten in terms of
checkout_fast_forward(); maybe all of them and checkout_fast_forward() can
be split into smaller pieces and get their logically freestanding parts
consolidated into a common helper function.  But by conflating that into
your series, you made a lot more work to review and judge the merit of it;
I don't think it was necessarily.

You saw a handful of "*-refactor" patches queued recently.  They were all
"function X, Y and Z do exactly the same thing; add one common code and
call it from these places".  That kind of patch does not _fix_ nor improve
anything observable from the outside, but at the same time it is easy to
review.  The only thing that is necessary is to verify the claim "X, Y and
Z do the same thing" and validate the refactored code do the same thing
for X, Y and Z, and the review can _end there_.  I think you've been here
long enough to realize the difference.
