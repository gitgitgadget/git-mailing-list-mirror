Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4388FC433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhLEU2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 15:28:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59641 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbhLEU2i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 15:28:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 539B5FAB2C;
        Sun,  5 Dec 2021 15:25:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ub5t330XZVjXaBlDEVHMe+V7dN1jKP2t5cZBoG
        BoCek=; b=pSPcjEez/b9Ax3T/GR93hdNT6X1X01fqfnKlUGvrjfa/SsGMD4CxSn
        36zE0CALS4NEO7eLV/8nN+ZbdkdJXw3KmH2S2DAnTHL3RDwwGJjxqcECs1Z9WJbP
        4dYc9/DEIdGw31cFpbGY90XOQW0lv0f8kLHc4N3DSooNrBPo0pUb8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31836FAB2A;
        Sun,  5 Dec 2021 15:25:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35916FAB29;
        Sun,  5 Dec 2021 15:25:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re* [PATCH] grep: clarify what `grep.patternType=default` means
References: <xmqq7dcq62af.fsf@gitster.g>
        <20211205133352.ukucgvynpuvypfnn@gmail.com>
Date:   Sun, 05 Dec 2021 12:25:06 -0800
In-Reply-To: <20211205133352.ukucgvynpuvypfnn@gmail.com> (Johannes
        Altmanninger's message of "Sun, 5 Dec 2021 14:33:52 +0100")
Message-ID: <xmqqy24ykdel.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70755608-5609-11EC-BDFF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> On Mon, Nov 29, 2021 at 02:10:48PM -0800, Junio C Hamano wrote:
>> Back in the days when the "return to the default matching behavior"
>> part was written in 84befcd0 (grep: add a grep.patternType
>> configuration setting, 2012-08-03), grep.extendedRegexp was the only
>> way to configure the behaviour since b22520a3 (grep: allow -E and -n
>> to be turned on by default via configuration, 2011-03-30).
>
> The 'the "return to the default matching behavior" part' is a forward
> reference, so I tried this instead:
>
> Commit 84befcd0 (grep: add a grep.patternType configuration setting,
> 2012-08-03) documented that grep.patternType=default falls back to the
> "default matching behavior". Prior to that, grep.extendedRegexp was the only
> way to configure the matching behavior (since b22520a3 (grep: allow -E and
> -n to be turned on by default via configuration, 2011-03-30)).
>
>> It was understandable that we referred to the behaviour that honors
>
> "It was" -> "It is"?
>> the older configuration variable as "the default matching"
>> behaviour.  It is fairly clear in its log message:
>
> I guess %s/behaviour/behavior/

Let me steal that.

>> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
>> index 44abe45a7c..72f5e03614 100644
>> --- a/Documentation/config/grep.txt
>> +++ b/Documentation/config/grep.txt
>> @@ -8,7 +8,8 @@ grep.patternType::
>>  	Set the default matching behavior. Using a value of 'basic', 'extended',
>>  	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
>>  	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
>> -	value 'default' will return to the default matching behavior.
>> +	value 'default' will use the settings of `grep.extendedRegexp` option
>> +	to choose between `basic` and `extended`.
>
> Yes, much better.
> Maybe "settings" -> "value". Probably subjective but plural sounds weird
> since grep.extendedRegexp is just one bit.
>
> Also this introduces a local inconsistency: above we write 'basic' and here `basic`.

Thanks for carefully reading.
