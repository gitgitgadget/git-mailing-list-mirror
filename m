Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF13C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79706121E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbhDMVHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:07:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61412 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhDMVHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:07:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E40B5F07;
        Tue, 13 Apr 2021 17:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ULIz9MoZa0C50FRtryUa4zP5aCs=; b=D2HB7m
        nk28iB1mwNJsaogGpWx9zPcaRQveAGK2a+FHDyZIvh95PVx7yWsMACtdXxb1lMfr
        B3Sv5tulNKakY/86FN1bzkdY4cZSXXX4eEyWuyDURzu+NSDOTpEM9zX11BOOOd0F
        1RYA2oZtK6BoMk1m1AVnHuI1vJvqgxGv7FiNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uzqQKVU7tVU8bQeEfU9ApelopkpFlQOO
        rF/Laga5GrPa+4+hcg00UBmgr3nty318d/Er5OlwJrt7fvdpSLr6UiqPUselcds8
        ZsUZ/pZ5G2TmntcMZORptESyKvGvSu+TqePxXA9WegUhP1xhzyODhfwhw/Or41A9
        ma/5nUb2NTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D923B5F04;
        Tue, 13 Apr 2021 17:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9F42B5F03;
        Tue, 13 Apr 2021 17:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
        <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
        <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
        <YHVPAGVDjS1EH6L3@coredump.intra.peff.net>
Date:   Tue, 13 Apr 2021 14:07:13 -0700
In-Reply-To: <YHVPAGVDjS1EH6L3@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Apr 2021 03:57:52 -0400")
Message-ID: <xmqqblahlwqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 383AB656-9C9C-11EB-83D2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> + * We restrict this trick to gcc, though, because while we rely on the
>> + * presence of C99 variadic macros, this code also relies on the
>> + * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
>> + * work even if no format specifiers are passed to error().

The last part of this comment is puzzlling.  Do we ever call error()
without any format specifier?  There may be GCC-ism behaviour around
the __VA_ARGS__ stuff, but are we relying on that GCC-ism?

>> + * Since we're only trying to help gcc, anyway, it's OK; other
>> + * compilers will fall back to using the function as usual.
>>   */
>>  #if defined(__GNUC__)
>
> I don't mind leaving this gcc-only, since as you note that's the point
> of what the code is trying to do. But wouldn't this always work because
> we know there is at least one arg (the format itself)?
>
> I.e., if we had written:
>
>   #define error(fmt, ...) (error(fmt, __VA_ARGS__), const_error())
>
> that would be a problem for:
>
>   error("foo");
>
> But because we wrote:
>
>   #define error(...) (error(__VA_ARGS__), const_error())
>
> then it's OK.

I think so.  At least I find the new comment confusing, and I'd
prefer to see it cleaned up.

Thanks.

