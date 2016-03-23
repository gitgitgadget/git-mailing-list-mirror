From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 09:15:36 -0700
Message-ID: <xmqqy499cgrb.fsf@gitster.mtv.corp.google.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603231238180.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:15:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ailRf-0006gs-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 17:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbcCWQPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 12:15:40 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753493AbcCWQPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 12:15:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB4124DC0C;
	Wed, 23 Mar 2016 12:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A3oh9JLn93+bWM9s+l0c9m35oVU=; b=IziWxI
	L2SF3sfyh5Y+poVNgfdjv8Nke+qH6DVetq+UTyheFMEoDwPtR5eKAbJYMrbamMvw
	V35RwBaDxpbVWy4DwOdINa8QqX1RLDXuSz4Y7HkXxpF++0nxtXVdsk1Kz/j8jMHE
	I1BLnROR7kJuG5DYjQCdLztUmor6O9icWiFXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/3zGZEb4baPNGGhLgfkmJ/2uPFkvEbM
	jxwFsAe0N1l+VrDNk1BNTLttb82QUnDqfA1W5NlumPUVOL1XCULfCCczNYhqSIkJ
	ufSpAtECl2RC4GSnr41GOHqh6xtuDxkDDHOKjiH4HL5M78EORGPTICdu6iHFLlWP
	lmhgAo8bI8o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2C4F4DC0B;
	Wed, 23 Mar 2016 12:15:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 253774DC09;
	Wed, 23 Mar 2016 12:15:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603231238180.4690@virtualbox> (Johannes
	Schindelin's message of "Wed, 23 Mar 2016 12:57:17 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B19B7A0-F112-11E5-ADF4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289664>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
>> +	    "replay", "log", "run", NULL))
>
> If I understood Junio correctly, he meant to line up the second line with
> the corresponding level. In this case, as "replay" is a parameter of the
> one_of() function, the indentation would look like this instead:
>
> 	if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
> 		   "replay", "log", "run", NULL))

Thanks for clarification.  It may also make sense to wrap the first
line one word earlier.

>> +		die("can't use the builtin command '%s' as a term", term);
>> +
>> +	/* In theory, nothing prevents swapping
>> +	 * completely good and bad, but this situation
>> +	 * could be confusing and hasn't been tested
>> +	 * enough. Forbid it for now.
>> +	 */
>
> I see quite a few comments that put the closing "*/" on its own line, but
> do not award the same pleasure to the opening "/*". Personally, I much
> prefer the opening "/*" to have an entire line to itself, too, but I guess
> that there is enough precendence in Git's source code to accept both
> forms.

We do want to see "/*" and "*/" on their own lines, and new code
should definitely do so.

>> +	if (!strcmp(term, "bad") || !strcmp(term, "new"))
>> +		if (strcmp(revision, "bad"))
>> +			die("can't change the meaning of term '%s'", term);
>> +
>> +	if(!strcmp(term, "good") || !strcmp(term, "old"))
>> +		if (strcmp(revision, "good"))
>> +			die("can't change the meaning of term '%s'", term);
>
> I am still convinced that
>
> 	if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
> 	    (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
> 		die("can't change the meaning of term '%s'", term);
>
> looks so much nicer.

... and more importantly, easier to understand what is going on.

Thanks.
