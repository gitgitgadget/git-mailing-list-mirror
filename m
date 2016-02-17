From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 09:50:30 -0800
Message-ID: <xmqqio1njkex.fsf@gitster.mtv.corp.google.com>
References: <20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<20160216223451.GB9014@sigill.intra.peff.net>
	<CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
	<20160216231811.GA18634@sigill.intra.peff.net>
	<xmqqbn7gkxev.fsf@gitster.mtv.corp.google.com>
	<20160217002215.GA1187@sigill.intra.peff.net>
	<xmqq37sskwo5.fsf@gitster.mtv.corp.google.com>
	<20160217003259.GD1187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:50:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6FJ-0003Ik-GR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 18:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161551AbcBQRue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 12:50:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161464AbcBQRuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 12:50:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9A124292A;
	Wed, 17 Feb 2016 12:50:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFrSaGXYPj72VO+WC2YCqCvLWYA=; b=nJuaTv
	bx3lbst/OXN54H9C2A0sMZVx5RiAfYXSi5y9iQZ2kH0RFWStnQ2eUBYdvWryC2Zh
	zRgA/iNlyl4z8qSRkRDUk6QkVpB4F9ZRFs9zP6ESVWU2zTWhMgISirbP5qoUP9yZ
	Y4TW5vlVY6dC/KIhNmL+bJsWIHk+IRpmSynNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rRFuceAIGaj4nB9C5jfN/zs0/YsNShb9
	nyL5z4k6oc6J7c8zvCsH3nvYtgpeJRntTNOebO97RY8dJGCnVhos6T+9aQ98JggK
	OzwJDHz9mZmU6Rv7BE9y9dc8Lthtyq1B9CSAshyqNCrOkjWFNtIN58OA8mkbhLzM
	BZyF5jXr9M0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E12B742929;
	Wed, 17 Feb 2016 12:50:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E6C442927;
	Wed, 17 Feb 2016 12:50:31 -0500 (EST)
In-Reply-To: <20160217003259.GD1187@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 16 Feb 2016 19:32:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F012FC04-D59E-11E5-ADD1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286515>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 16, 2016 at 04:28:10PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Tue, Feb 16, 2016 at 04:12:08PM -0800, Junio C Hamano wrote:
>> >
>> >> > To be honest, though, I am now on the fence, considering the possible
>> >> > whitespace issue.
>> >> 
>> >> Certainly not having to see s[0]->buf over and over is a huge win ;-).
>> >> 
>> >> Is the "whitespace issue" a big deal?  Does it involve more than a
>> >> similar sibling to string_list_split() that trims the whitespace
>> >> around the delimiter (or allows a regexp as a delimiter "\s*,\s*")?
>> >
>> > I think that solution would work (and IMHO would actually be preferable
>> > to the split-then-trim that strbuf_split does). But it does mean writing
>> > new code.
>> 
>> True, but only when we decide to support trimming the whitespace,
>> which can come later.
>> 
>> I do not even know if it is wise to accept %(align:position=left, width=4)
>> when %(align:position=left,width=4) would do the job just fine.
>
> Yeah, it was mostly just about being friendly to the user. But if nobody
> is complaining, it may not even be worth worrying about.

I was more worried about the possibility that we may have to support
values with leading or trailing whitespaces in the future.

    0. %(align:position=left,width=4)
    1. %(align:position=left, width=4)
    2. %(align: position =left, width =4)
    3. %(align: position = left, width = 4)
    4. %(align: position = left , width = 4)

We can probably accept 1. without ambiguity, and probably 2., too.
These examples are about keys with possible leading or trailing
whitespaces, and it is unlikely that we need to support them.

To those who do not think carefully themselves, however, going from
1 & 2 that are handlable (and some might even argue that 1. is
easlier to read) to 3 & 4 will not appear as a big syntax-breaking
leap.  But 3 & 4 are; these need disambiguation rule on the value
side (we either introduce quoting, declare no values can have
leading or trailing whitespaces, etc.).

That is why I suggested not to even accept 1. to avoid the slipperly
slope.
