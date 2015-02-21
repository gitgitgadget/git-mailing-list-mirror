From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next item
Date: Fri, 20 Feb 2015 23:09:57 -0800
Message-ID: <xmqq4mqfyc3e.fsf@gitster.dls.corp.google.com>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
	<xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
	<20150218230728.GA17302@peff.net>
	<xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
	<20150220014230.GA16124@peff.net>
	<xmqqwq3cxjwg.fsf@gitster.dls.corp.google.com>
	<20150221062310.GB29665@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 08:10:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP4CT-0001Vr-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 08:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbbBUHKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 02:10:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750746AbbBUHJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 02:09:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D003331ACA;
	Sat, 21 Feb 2015 02:09:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p8dI8Pc/eTHQO3c0ZruwT0/PuJs=; b=HUOy6x
	wlscTJiqmCK4K+PumLLCBGw7YK4ZSi9YZO8O5uH7kgeKyOm2tAe4e2PYZbWL6jbN
	FYM3bYPJMIzUmrPuqxZgMTDc2IDBJBsPqw9yrCO2fWL8KIX/R9m5v6lUPRH0Sc4Z
	q3nkpE+ZBxNSPn5/5OjuoyjN6qCBbXzn+jgzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8AZ2r8Qd8iuSFUpyLwrJwnxWnuGFHK+
	/qozzn8cYgcWVYRGxKks9ljE9x+5Xs5xtYJfVKPDBwLxAN0a45hmhoUHEdJd04fE
	+dnwlxgs4QfN6qehRPGox79e3lFE9rj930Ox9acIZ3BLIshOxPB0DEfFMi96pdvv
	dKBpLLT4tMM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C73BA31AC9;
	Sat, 21 Feb 2015 02:09:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F45631AC7;
	Sat, 21 Feb 2015 02:09:58 -0500 (EST)
In-Reply-To: <20150221062310.GB29665@peff.net> (Jeff King's message of "Sat,
	21 Feb 2015 01:23:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A518BCFC-B998-11E4-8C88-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264212>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 20, 2015 at 03:06:39PM -0800, Junio C Hamano wrote:
>
>> -- >8 --
>> Subject: config.txt: spell out how certain typed values are written
>> 
>> Many variables have values that are not arbitrary strings and there
>> are ways to spell these values of certain types.  The way to spell
>> colors was described in a section for color.branch.<slot> and other
>> variables refered to that section, which was technically wrong, but
>> was a bit awkward.
>
> Did you mean "not technically" here?

Yes.

> I think this patch is certainly an improvement with respect to the
> colors. And I like that it organizes the types into one place using a
> list, which is easier to scan when you are looking at a manpage. But...
>
>> +Values
>> +~~~~~~
>> +
>> +Values of many variables are treated as a simple string, but there
>> +are variables that take values of specific types and there are rules
>> +as to how to spell them.
>> +
>> +boolean::
>> +	When a variable is said to take a boolean value, many
>> +	synonyms are accepted for 'true' and 'false'.
>> +	true;; Boolean true can be spelled as `yes`, `on`, `true`,
>> +	    or `1`.  Also, a variable defined without `= <value>`
>> +	    is taken as true.
>> +	false;; Boolean false can be spelled as `no`, `off`,
>> +	    `false`, or `0`.
>
> This information is redundant with what is in the `Syntax` section:
> ...

Heh, thanks.  That is what I wanted to say when I said "other types
may need de-duping" ;-).
