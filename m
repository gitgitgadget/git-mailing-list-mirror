Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39BC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 06:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D86613AA
	for <git@archiver.kernel.org>; Wed, 19 May 2021 06:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhESGK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 02:10:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhESGK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 02:10:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32FA112C009;
        Wed, 19 May 2021 02:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aSeJrZkxQHjQPQDWFWcY52W4fe4beoWYZpLSwx
        usIpA=; b=CKPAQFNJJvDuVsNH3Ozul+1ND8Fn39/NbJiYY1hx0T0VIQbsuDl7Hr
        EZ4O2kjEBJnvvc/++sWxO34BkqWQGDnk+CF3wIOw9I8zuTDa0O4i53xPeaodE7fZ
        d5pyfbaKd3gU/07UFUpLEtcuOfVUywRUp/35IT9nk0+fNZA0gTbsA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 200E412C008;
        Wed, 19 May 2021 02:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4851B12C007;
        Wed, 19 May 2021 02:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
        <xmqqfsyj1qe1.fsf@gitster.g>
        <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
Date:   Wed, 19 May 2021 15:09:32 +0900
In-Reply-To: <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 19 May 2021 02:07:38 +0000")
Message-ID: <xmqq1ra3z23n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C864AE02-B868-11EB-B138-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-05-19 at 01:08:54, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > In general, this is made worse because Git doesn't honor the unofficial
>> > but widely supported NO_COLOR[0], so reading the documentation is
>> > obligatory.
>> 
>> I vaguely recall that we were contacted by NO_COLOR folks to be
>> an early supporter of their cause to break the chicken-and-egg
>> problem they were hagving, and (unhelpfully) answered with "sure,
>> when we see enough people support it---otherwise we'd end up having
>> to keep essentially a dead code that supports a convention that is
>> not all that useful".
>
> Yeah, I seem to recall you were somewhat negative on it at the time, but
> I do personally find it useful, and someone on Twitter reminded me of
> it just today.
>
>> I wonderr if it is just a matter of hooking into want_color(), like this?
>> 
>>  color.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git c/color.c w/color.c
>> index 64f52a4f93..2516ef7275 100644
>> --- c/color.c
>> +++ w/color.c
>> @@ -373,12 +373,17 @@ int want_color_fd(int fd, int var)
>>  	 * we always write the same value, but it's still wrong. This function
>>  	 * is listed in .tsan-suppressions for the time being.
>>  	 */
>> -
>> +	static int no_color = -1;
>>  	static int want_auto[3] = { -1, -1, -1 };
>>  
>>  	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
>>  		BUG("file descriptor out of range: %d", fd);
>>  
>> +	if (no_color < 0)
>> +		no_color = !!getenv("NO_COLOR");
>> +	if (no_color)
>> +		return 0;
>> +
>>  	if (var < 0)
>>  		var = git_use_color_default;
>>  
>
> Yeah, that will probably do it.  I hadn't looked at it, but I assumed it
> would be pretty easy, and it looks like it is.

Actually I doubt it satisfies the FAQ #2 of no-color.org; we
probably would need to go one level lower, like the original
proposal from 2018 did:

cf. https://lore.kernel.org/git/87efl3emlm.fsf@vuxu.org/

