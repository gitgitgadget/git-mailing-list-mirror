Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3EC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32DD600EF
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBQXev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:34:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51034 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhBQXet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:34:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16ED3B1E1F;
        Wed, 17 Feb 2021 18:34:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RZUZtw8WtzZZrRWImi4G/kFDMvM=; b=UkCIoK
        xSLEaNbF5Xlf5SDKsEBKZBlb1DSadckss2sQBxekATSWt/M9LPzNE07Jr83THG1G
        bhT4Fxl01+zuqsgrgsm/1RsfVremQl46X/7CXyWPxSrb60hUApJlVt3SSIdaI5iE
        1ZTVvdWttryHDW2aROmWNbL9j1OJQ9LKox/4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m9OnhLJZ/01nQWOvIvVq2pljWajv778b
        /kyjnqn0UuvpkLxFjHtQRwytcN6S4ksa3baBB9nAr+a7i15BZVZ2kDjbutpRYjRj
        G8giV3v3oTXE7hnuvA9y20Ijig/wEUaqwuxhQpTK5i63mJyHVdcrnDqPxqzDrG8g
        ZERgq28L6G8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4EB2B1E1D;
        Wed, 17 Feb 2021 18:34:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E191EB1E1C;
        Wed, 17 Feb 2021 18:34:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
        <xmqqpn0yi9ii.fsf@gitster.g>
        <CAPig+cT_ASSSe0jzEWiW_EPEa5FfHigfM+6fGQyG_kwj57XPfQ@mail.gmail.com>
Date:   Wed, 17 Feb 2021 15:34:03 -0800
In-Reply-To: <CAPig+cT_ASSSe0jzEWiW_EPEa5FfHigfM+6fGQyG_kwj57XPfQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 17 Feb 2021 18:22:17 -0500")
Message-ID: <xmqqh7mai80k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F7D5250-7178-11EB-BA81-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Feb 17, 2021 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Matheus Tavares <matheus.bernardino@usp.br> writes:
>> > +for opt in "" -f -u --ignore-removal
>> > +do
>> > +     if test -n "$opt"
>> > +     then
>> > +             opt=" $opt"
>> > +     fi
>> > +     test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
>>
>> The above is cumulative, and as a consequence, "git add -u <path>"
>> is not tested, but "git add -f -u <path>" is.  Intended?  How was
>> the order of the options listed in "for opt in ..." chosen?
>
> I may be misreading, but I don't think this is cumulative (though it's
> easy to mistake it as such due to the way it inserts a space before
> $opt).

Ah, yes, I misread it.

> ... A more idiomatic way to do this would
> have been:
>
>     for opt in "" -f -u --ignore-removal
>     do
>         test_expect_success " git add${opt:+ $opt} does ..." '

Yes, indeed.
