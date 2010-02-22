Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 31493 invoked by uid 107); 22 Feb 2010 19:57:42 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 22 Feb 2010 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab0BVT5T (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Feb 2010 14:57:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0BVT5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:57:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC949CD94;
	Mon, 22 Feb 2010 14:57:17 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zJnwgwLrcUB80Za/QeyAAqwDooI=; b=yUT5lx+odKGmtMBA4jNx7U1
	a3bGgNuTMu4LfHwyz51y7LFa694rKG2nV0l7Byo8/dJJ/Y0GbI11pmWqL5mCthgV
	kPbRQq+gUOciZ0gfgeUQRTJas1gTOMY5bqfMCVGjCb5Yl2rx6ycfrf2lGWe5teE4
	igMZEIx9Jeklp5/6KTKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OuRHdQmAl6kS1/+9Gxzuz4Fcn7Vse0E+JnZKz5zRC3izCoDiJ
	lclgvK17BclDn6iZN8AXBZ6cK/o2qAGoX8Dh7hnzZEjr7BhmTuc89cHA0ARJdY9o
	62d1+q1AsccsiZG8FanfeiiCunRluVL6ybI0uLDYtHXFlAQ/BaYFVg7rtY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A05289CD8D;
	Mon, 22 Feb 2010 14:57:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE1DC9CD8B; Mon, 22 Feb
 2010 14:57:08 -0500 (EST)
To:	Don Zickus <dzickus@redhat.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
Subject: Re: 'git mailinfo' whitespace bug
References: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
 <7vzl343160.fsf@alter.siamese.dyndns.org> <20100222151344.GK3062@redhat.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 22 Feb 2010 11:57:07 -0800
Message-ID: <7vocjhcacs.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 78591478-1FEC-11DF-B49F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> But when is it correct to ltrim a header line?  It means we are going to
>> accept a header (or header-looking line in body) that is indented.  I
>> don't know why 87ab799 (builtin-mailinfo.c 2007-03-12) was coded that way.
>
> In regards to 87ab799, I just deleted and pasted it from the function
> handle_inbody_header (which you can see from that commit).  The original
> code for those lines came from ae448e3854d8b6e7e37aa88fa3917f5dd97f3210.

Thanks for clarifying.  The one in ae448e3 (mailinfo: ignore blanks after
in-body headers., 2006-06-17) was about removing blank lines before the
in-body headers begin, and never about removing indentation of the first
in-body header.  Admittedly, it was also being lenient and skipped over
lines that are not empty but all whitespaces, and if we apply the quoted
patch we will be retroactively tightening the rule, but I somehow do not
think people would care.

>>  builtin-mailinfo.c |    3 +--
>>  t/t5100/msg0015    |    2 +-
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
>> index a50ac22..ce2ef6b 100644
>> --- a/builtin-mailinfo.c
>> +++ b/builtin-mailinfo.c
>> @@ -779,8 +779,7 @@ static int handle_commit_msg(struct strbuf *line)
>>  		return 0;
>>  
>>  	if (still_looking) {
>> -		strbuf_ltrim(line);
>> -		if (!line->len)
>> +		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
>>  			return 0;
>>  	}

We probably could do something like

	if (still_looking) {
        	if (strspn(line->buf, " \t\n") == line->len)
			return 0;
	}

to keep people with blank but not empty lines before the first in-body
header happy.  I somehow don't think it is worth it, but what would I
know...
