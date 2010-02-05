From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reverting vs resetting
Date: Thu, 04 Feb 2010 23:09:10 -0800
Message-ID: <7v1vh0jh0p.fsf@alter.siamese.dyndns.org>
References: <20100205091223.6b4cffb1@pbmiha.malagasy.com>
 <32541b131002042248x5461d904r276b184533ac492a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mihamina Rakotomandimby <mihamina@gulfsat.mg>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3g-0003Bj-OA
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357Ab0BEHJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 02:09:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933247Ab0BEHJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 02:09:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CBC396963;
	Fri,  5 Feb 2010 02:09:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jvp/uZqSOTkWUSO3sERk0bJ+5eg=; b=E7nEos
	Bky42Usw/6laDxC98JmRAXbqMZ3pSbOTOBBs6ZLne6XASIE0HL/5VzIt1ts8zqQZ
	7fonLofpYW1KHAKmFpqXQnWWkb4ifHzSOpTW8f0fBYpa8VOFJlyAi5M65Fv+hVm/
	9IEj5H62CauyFjbde3XKvyNy7zRVBfS7d+8uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwOwMEGTi2YVKhSRGwbYURpjMT8l16qB
	mHXsazhIlVqydOEMusIZQwMmetKI/jNzRPboJ+Bq0PgtqYb/6ixvMAjyESkWZKnP
	ZOcYZ8MFOjK+l67/fuIX8d1JpliA9doz7U46uRAdTyWUEKdAFRpJEzSlZIR2XnLY
	b4P2eVz2tmo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D96196962;
	Fri,  5 Feb 2010 02:09:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C96C96961; Fri,  5 Feb
 2010 02:09:11 -0500 (EST)
In-Reply-To: <32541b131002042248x5461d904r276b184533ac492a@mail.gmail.com>
 (Avery Pennarun's message of "Fri\, 5 Feb 2010 01\:48\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EEFE770-1225-11DF-99EC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139036>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Fri, Feb 5, 2010 at 1:12 AM, Mihamina Rakotomandimby
> <mihamina@gulfsat.mg> wrote:
>> When we decided to giveup, we decided to get back to the configuration
>> before Bob broke it. But it would be interesting to see Andy's history.
>>
>> Reverting or resetting?
>
> Try this:
>
>     git checkout HEAD~5 .
>     git commit -m "reverted back to the version before this mess"

Caveat: if Andy added new paths while experimenting, the above won't
remove it.  You would need something like this instead:

	git read-tree -m -u HEAD~50
        git commit -m "reverted back to the version before this mess"

But this all assumes that the futile experiment is worth keeping.  I
highly doubt it.

I would recommend to do this:

	git branch andy_failed_experiment
        git reset --hard HEAD~50
	;# and perhaps revert Bob's change here as well

There is no sane reason to keep the failed experiment that added nothing
of value to the history leading to the tip of the 'master' branch.

I am using the word _value_ but keep in mind that value is relative to the
purpose you have in mind.  The purpose of the 'master' branch presumably
is to keep and to improve on a working configuration of the gateway box.
For that particular purpose, you have to admit that Andy's futzing around
didn't add anything of value in the result.  Hence, that shouldn't be kept
in its history.

Andy and other people may be able to learn from the failed experiment
later, so it is perfectly Ok to keep the series of random hacks in a
separate branch to study at their leisure.  The purpose of the branch is
different from that of the 'master': it is to serve as a catalog of
things/ideas that did _not_ work.
