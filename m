From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 13:26:00 -0800
Message-ID: <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
References: <5281012D.4060708@op5.se>
	<20131112083240.GA1684@sigill.intra.peff.net>
	<xmqqy54timsm.fsf@gitster.dls.corp.google.com>
	<20131112.214357.1022923291448967795.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, ae@op5.se, git@vger.kernel.org, apenwarr@gmail.com,
	Johannes.Schindelin@gmx.de, jrnieder@gmail.com, max@quendi.de
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 12 22:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgLTT-00026A-CU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3KLV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:26:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3KLV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:26:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBCF50054;
	Tue, 12 Nov 2013 16:26:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzMiWfXtRfmKiAPKldjwsuVUINw=; b=hSxzm4
	brgN9vzMAgLOjBAg+k0WcW9XR/9adUG5hUeMhQ3BcbGXLDyD/3R0JqH/B7R+mT+P
	Zx0iroSxUBdXRdBlQIxqA7+HoJMUQxy9c8vayC7vrHXgzZ4xakbeyoTrmNYfergr
	w7QTrfOvPtE7SPGQMF/51pqdrEpudbUEq9c3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HyRpDPMiSWnZjogKBl6n3n2oT1CUL7vX
	zaLfi2N/U3XxZPRj3N4d4BfxPWeoGgv1FHriAXjV1eGztkVveuGkvrfc1m8+EfHR
	KFyM2Bjr6m+h1yWUsq8AWL+ulyl5klLpMADIZdDq1FgeFMcIUYPPUNufErwF1fzp
	LQk10Yp5+oU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE54450053;
	Tue, 12 Nov 2013 16:26:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C22750050;
	Tue, 12 Nov 2013 16:26:08 -0500 (EST)
In-Reply-To: <20131112.214357.1022923291448967795.chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 12 Nov 2013 21:43:57 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0B7633D4-4BE1-11E3-893D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237759>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>> 
>> Even though we already added has_suffix() for tail matches, it is
>> not too late to rethink, as it is not in 'master' yet.
>> 
>> One thing I noticed is that it is probably misnamed, or at least in
>> a way that invites confusion.  Can people tell which one of these is
>> correct without looking at existing callsites?
>> 
>>         has_suffix(filename, "txt");
>>         has_suffix(filename, ".txt");
>> 
>> The semantics of the function we have is the latter and is better
>> called endswith(), I suspect.  And the corresponding function to
>> check for head matches should probably be called beginswith().
>
> I don't know if has_suffix() is confusing for a native speaker.
>
> After a look at some languages, Python has "startwith()" and
> "endswith()", and Java has "startWith()" and "endsWith()".
>
> But while we are at it, why not
> "ends_with()" and "begins_with()"? To me using an underscore seems
> more consistent with what we are doing in Git.

Sure.

I do not think Peff and I were discussing at that level yet to
debate between camelCase and words_with_underscore.  We were mainly
talking about what words to be used, which needs to come before the
final appearance.
