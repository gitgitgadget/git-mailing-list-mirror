Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E17C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF44C21D24
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWH4eLve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405621AbgJUSjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:39:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57462 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgJUSjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:39:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2DD77E531;
        Wed, 21 Oct 2020 14:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iDBWu7KJxQqkrcRxYnVq/PCde24=; b=WWH4eL
        ve7Pe+kG4bw4F+ksoJdRgv+2aqegU2VR4XL8WO+LFzOEBbr1N+uocgIb/7HQparg
        Y+xRc8WP7RMwikx4H7yDH0tQmgjCuFpmIh96PB2RsRWDqmzdAK3/dzE0UMKeu7H/
        aBnfMs5A7fZC7rD/XiUQTtdYECFeigBDDWfLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G9oNnI/vCJXQyLLI7UgCWYycNCfBM3q9
        ujbK43WJ3c72jalTxf7FUQrRoPl+7EUWOOo2Ae1leuAgAffteLU1G49v3TUYvMcC
        alIhwGB60nodniR2Ok75/wo8CoJjiM6AIAHxGA8uTRfGkYID/EsPbFK0QxHgukbk
        DEcctIqrUHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9AFC7E530;
        Wed, 21 Oct 2020 14:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 071C17E52E;
        Wed, 21 Oct 2020 14:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Victor Engmark <victor@engmark.name>, git@vger.kernel.org
Subject: Re: [PATCH v2] userdiff: support Bash
References: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
        <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
        <1442e85cfbe70665890a79a5054ee07c9c16b7c6.camel@engmark.name>
        <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
Date:   Wed, 21 Oct 2020 11:39:04 -0700
In-Reply-To: <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org> (Johannes Sixt's
        message of "Wed, 21 Oct 2020 09:07:12 +0200")
Message-ID: <xmqq8sbz8lvb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24C21A4-13CC-11EB-9923-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> diff --git a/t/t4018/bash-missing-parentheses b/t/t4018/bash-missing-parentheses
>> new file mode 100644
>> index 0000000000..d112761300
>> --- /dev/null
>> +++ b/t/t4018/bash-missing-parentheses
>> @@ -0,0 +1,4 @@
>> +functionRIGHT { # non-match
>> +    :
>> +    echo 'ChangeMe'
>> +}
>
> To check for a non-match, you write the test like this:
>
> 	function RIGHT () {
> 	}
> 	# the following must not be picked up:
> 	functionWrong {
> 		:
> 		ChangeMe
> 	}
>
> That is, you present a positive match, and then expect that the
> subsequent negative match is not picked up.

All good suggestions, but I especially appreciate this one ;-).

>> diff --git a/userdiff.c b/userdiff.c
>> index fde02f225b..8830019f05 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -23,6 +23,28 @@ IPATTERN("ada",
>>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
>> +PATTERNS("bash",
>> +	 /* Optional leading indentation */
>> +	 "^[ \t]*"
>> +	 /* Start of function definition */
>> +	 "("
>
> The purpose of this outer-most pair of parentheses is actually to mark
> the captured text, not so much "the function definition".

This, too (I called it "here comes the whole thing" in my suggested
version ).

>> +	 /* Start of POSIX/Bashism grouping */
>> +	 "("
>
> You could omit the comment if you indent the parts that are inside the
> parentheses:
>
> 	"("
> 		"..."
> 	"|"
> 		"..."
> 	")"
>

An excellent readability suggestion.

Thanks for a review.  Especially the parts that mine didn't touch
(i.e. the proposed log message).

> (But perhaps don't indent between the outer-most parentheses; it would
> get us too far to the right. But judge yourself.)
>
>> +	 /* POSIX identifier with mandatory parentheses */
>> +	 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
>> +	 /* Bashism identifier with optional parentheses */
>> +	 "|(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
>> +	 /* End of POSIX/Bashism grouping */
>> +	 ")"
>> +	 /* Optional whitespace */
>> +	 "[ \t]*"
>> +	 /* Compound command starting with `{`, `(`, `((` or `[[` */
>> +	 "(\\{|\\(\\(?|\\[\\[)"
>> +	 /* End of function definition */
>> +	 ")",
>> +	 /* -- */
>> +	 /* Characters not in the default $IFS value */
>> +	 "[^ \t]+"),
