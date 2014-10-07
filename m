From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Tue, 07 Oct 2014 13:35:15 -0700
Message-ID: <xmqqa957ehz0.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202743.GH16293@peff.net> <5433E8CB.1050005@alum.mit.edu>
	<xmqqsiiziy94.fsf@gitster.dls.corp.google.com>
	<20141007201805.GA22703@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbbTh-00056Z-56
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbaJGUfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:35:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62212 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754307AbaJGUfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:35:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 438A113209;
	Tue,  7 Oct 2014 16:35:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9jQDluhAqgMZTevq7oPymIaqfjk=; b=Rl/Nvs
	CP43vjU7QbJlCNOK46IpAQ6W2bNpNPqU8FmW3W9ejBvX29jNVap3CqD5ngKIlGoV
	nrKi/lw5mGFtj8LjeanBwriWKj4tjvzzoETePN6za/YRbX4xUDrYcHbZ6ICYHdlU
	kYSwRsIx9oCR7Jxj+MqBmwjcnC/YDUUBgv9vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y17GcTag04J76TeupPMeRlQwZQQkROB/
	4IjrQ0Esu79hoapZquo36YSSpZdxL9Ei287RKAWaV7PFqkKX3aI/08ZLMSdL/iJO
	1S8KnXwnK0Evn+ft809sTUiHdRan6FKJqACKr1yXNqZSnBTVzdA7Mf0cH7kix/jq
	4XrJMWGjNhA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A34213208;
	Tue,  7 Oct 2014 16:35:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDE2A13207;
	Tue,  7 Oct 2014 16:35:16 -0400 (EDT)
In-Reply-To: <20141007201805.GA22703@peff.net> (Jeff King's message of "Tue, 7
	Oct 2014 16:18:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7281EFFE-4E61-11E4-84A2-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257959>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 07, 2014 at 10:29:59AM -0700, Junio C Hamano wrote:
> ...
>> The function is similar to test_cmp which takes two files but takes
>> two strings, so "test_cmp_str" or something perhaps (we already have
>> test_cmp_rev to compare two revisions, and the suggested name
>> follows that pattern)?
>
> Based on your responses, I'm leaning towards:
>
>   test_cmp_str() {
> 	test "$@" && return 0
> 	echo >&2 "command failed: test $*"
> 	return 1
>   }
>
> since the point is really just to print _something_ when the test fails
> (any quoting or whitespace may be wrong, of course, but that's OK; it's
> for human consumption, and is just a hint).

Yeah, if we are going to reduce it down to the above implementation,
intereseting things like "test -f $frotz" will become possible and
"cmp-str" stops making sense.  It really is about "We run test and
expect it to yield true.  Report the failure a bit more prominently
under the '-v' option to help us debug".

So among the ones you listed, test_verbose may be the least silly, I
would think.
