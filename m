Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6555C1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 08:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeKQTNZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 14:13:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeKQTNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 14:13:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E72EA3713F;
        Sat, 17 Nov 2018 03:57:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gno5pQjH6aYotDSj9kZ9152CPzA=; b=LBvN+S
        Kgf3eO05+DaNQoNAKllxZn/amlwTdr+8I45UKQb2vsVTYuLWVlLZCiLtHF4iV+i+
        QOweeocJLdRVrtMvz6POz+C30U1Fx8PHkJDxypAitZCURaGQ0X97udYJM+hTVcgy
        q4wIXnbnRTQIP+XA2W8J5/Eyb1bMBKP+zqh+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lhnx+S8/Toh+jYN5RhHSZZCufKgS03fY
        8QNdlqBm7jVuXY0BmjYwGz3YQbLr+d1+Kg8wEQWU+hiqbwjfNqgFBk7TArYrY0UN
        Sj1oLx2Ur2VZDnzAiIN8t4xtV9gS0xul2CG8Ykwb8K1d4a+UqT+hioMme6xtGw5f
        gJiBYI2oSdo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E023D3713D;
        Sat, 17 Nov 2018 03:57:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EE163712E;
        Sat, 17 Nov 2018 03:57:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
        <20181116182934.GN30222@szeder.dev>
        <CAP8UFD2tC9B_m=NmK4DTCJP=o+L+RKy9C_2ra9fgeNMzOuCZ3A@mail.gmail.com>
Date:   Sat, 17 Nov 2018 17:57:18 +0900
In-Reply-To: <CAP8UFD2tC9B_m=NmK4DTCJP=o+L+RKy9C_2ra9fgeNMzOuCZ3A@mail.gmail.com>
        (Christian Couder's message of "Fri, 16 Nov 2018 20:25:43 +0100")
Message-ID: <xmqqy39sgjyp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CABB842A-EA46-11E8-8261-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> > +test_expect_success POSIXPERM 'same mode for index & split index' '
>> > +     git init same-mode &&
>> > +     (
>> > +             cd same-mode &&
>> > +             test_commit A &&
>> > +             test_modebits .git/index >index_mode &&
>> > +             test_must_fail git config core.sharedRepository &&
>> > +             git -c core.splitIndex=true status &&
>> > +             shared=$(ls .git/sharedindex.*) &&
>>
>> I think the command substitution and 'ls' are unnecessary, and
>>
>>   shared=.git/sharedindex.*
>>
>> would work as well.
>
> If there is no shared index file with the above we would get:
>
> shared=.git/sharedindex.*
> $ echo $shared
> .git/sharedindex.*
>
> which seems bug prone to me.

It is not bug *PRONE*, but is already wrong, as the way this
variable is used is

        +		case "$shared" in
        +		*" "*)
        +			# we have more than one???
        +			false ;;
        +		*)
        +			test_modebits "$shared" >split_index_mode &&
        +			test_cmp index_mode split_index_mode ;;
        +		esac

i.e. we'd think there is a singleton ".git/shared/index.*" and we
can feed it to test_modebits.

So what you wrote originally is corrrect.
