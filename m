From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Mon, 13 Feb 2012 12:29:58 -0800
Message-ID: <7vaa4meat5.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu>
 <7vlio9n5ym.fsf@alter.siamese.dyndns.org> <4F389FB1.2070706@alum.mit.edu>
 <7vsjifgrwl.fsf@alter.siamese.dyndns.org> <4F38D9D4.5000203@alum.mit.edu>
 <7v4nuvghfk.fsf@alter.siamese.dyndns.org> <4F391F5C.1000400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>,
	Albert Yale <surfingalbert@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2XL-0006hY-3y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab2BMUaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:30:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab2BMUaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:30:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4FE06A4E;
	Mon, 13 Feb 2012 15:30:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9LW1GjKky4fJzddYnQ9am2femSo=; b=dnUx12
	5KrKQFhZMXNHlAUHHPd1NCLnt91OQ+eV53EgdYI61O8to1w2UppRjds5AUB74Thb
	b45lty5F9jHE9frU5fpp50nO6dLmoGcbac1hAVWzloQTjW0uZQ3g+DA06dkJlMqw
	UBFOBEQj+PaE9f+U5OSQFuTmgxJVb4418yoxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ro1X1e2dcOB4UM2MJEGjqHGB5We53y1Z
	bRnl/BA7rjfKt6ZtF0AEvkRO0VJ2SMuQQhiNI2aLEv3r16dP9H0cfoAiU8I6zHf2
	gAPTTxydw9JzwHgSuaga3s962uN6r2qg2XzkPCVEhIKshu18I4Ze/R6fmFIiJeXB
	kgsMkCffzTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3746A4D;
	Mon, 13 Feb 2012 15:30:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31FEA6A4C; Mon, 13 Feb 2012
 15:30:00 -0500 (EST)
In-Reply-To: <4F391F5C.1000400@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 13 Feb 2012 15:34:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8061B2C4-5681-11E1-8B70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190664>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Having said all that, if your argument against using "^" as negation for
>> for-each-ref *were* with something like this from the beginning:
>> 
>>     git rev-list --all --exclude-refs=refs/tags/v\*
>> 
>> it would have been very different. I would wholeheartedly buy the
>> consistency argument that says
>> 
>>     git for-each-ref --exclude-refs=refs/tags/v\*
>> 
>> ought to give all refs (only because for-each-ref "all" is implied) except
>> for the tagged tips, and
>> 
>>     git log --all --exclude-refs=refs/tags/v\*
>> 
>> should be the notation to produce consistently the same result as
>> 
>>     git log $(git for-each-ref --format='%(objectname)' --exclude-refs=refs/tags/v\*)
>> 
>> but if we used "^" as negated match in for-each-ref argument, we would
>> close the door to give such consistency to log family of commands later.
>
> That *has* been exactly my argument from the beginning [1].

Well, if the only thing you say is "rev-list A B ^C" and you are expecting
that your reader to substitute A with any dashed option like --all, --not
or --stdin, I would have to say you are expecting too much.  I wouldn't
even think of substituting A with $(git for-each-ref refs/heads/) in such
an example.

> I cautiously hope that we are now talking about the same thing, even if it
> is not yet clear whether we agree on a conclusion.

I think we are on the same page now.  Given that we seem to have settled
for the recent "find in the paths that pathspec matches, but exclude
matches from paths that match these patterns" topic by Albert Yale to
tentatively use separate --exclude [*1*] command line option instead of
mixing the negatives to the usual list of positives at the UI level, it
appears to me that the most sensible way forward would be to expose the
negative match to the UI level is to introduce a similar --exclude-refs on
the command line.

That would eventually allow us to say something like [*2*]:

	git log --all \
            --exclude-refs=refs/heads/experimental/* \
            --exclude-paths=compat/ \
	    --since=30.days \
            -- '*.c'

to ask for recent changes to all C sources outside the compat/ area for
everything except for the experimental topics.


[Footnote]

*1* It might be better to spell this as --exclude-paths, though, if we are
going to call this other exclude-refs-by-pattern --exclude-refs.  The
longer names would not bother us with the help of parse-options, and the
commands that need to support both, namely the commands in the log family,
need to allow users to be explicit which exclusion they want anyway, and
having --exclude vs --exclude-refs as options that work on different
dimensions look asymmetric.

*2* "something like" includes using a convenience short-hand on this
command line such as "--branches --exclude-branches=experimental/*"
instead of "--all --exclude-refs=...", but I consider that is icing on the
cake after the first step to define the overall structure settles, so I
would prefer not to go into the tangential details.
