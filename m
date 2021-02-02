Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC82C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 04:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1526E60230
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 04:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhBBEqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 23:46:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55083 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBBEqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 23:46:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F07A12433A;
        Mon,  1 Feb 2021 23:46:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i8d6b7knUQBJ
        Lxl+X5aPZNVQ+zQ=; b=WwJubqYpoLswIeAyysktFblqmxuoT6yyUc7O4oMJzID2
        cZK/PkEoExdWSJTWzcqz8OfBP5K3tt6h0vueKL4GLwLEVo5eNgOiVPXUP1UdpQm4
        L3rlQX0OGOo13jAAO4BxqCvaCZqC80lbpnMR9MiNksMibLLLoOXEPnH20WGXttU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A6TxQl
        NpezWmEgAoPst6L+fA6nPwovfAX0FviZ5iNqK+Dgtuy4W5y4kB8WiwazMtJVA0SS
        3QC6EzPBvZ1DLqhW7b0CWKAJHxCfr+p//YDPDnS8ECh1QsDsezQxG2wdeVEEIc4c
        1qQgOfKjQR92tcFhkl9PyD5Qg6JVGj8d8UT8g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 037CA124339;
        Mon,  1 Feb 2021 23:46:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47B27124338;
        Mon,  1 Feb 2021 23:45:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
        <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
        <87wnvrefbv.fsf@evledraar.gmail.com>
        <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
        <87tuqvdy1b.fsf@evledraar.gmail.com>
Date:   Mon, 01 Feb 2021 20:45:56 -0800
In-Reply-To: <87tuqvdy1b.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 02 Feb 2021 03:05:36 +0100")
Message-ID: <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AD65D56-6511-11EB-9D90-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> But yeah, we could patch git to handle this in the general case....
>>
>> Sorry, but now you lost me.
>>
>> I was merely wondering if Denton's patch can become a small update
>> on top of these, if we just made sure that the exit code of the
>> pager noticed by wait_or_whine() is reported to the code where
>> Denton makes the decision to say "let's not re-raise but simply exit
>> with 0 return as what we got is SIGPIPE".  I guess we could even
>> make git exit with the pager's return code in that case, as the
>> end-user observable result would be similar to "git log | less"
>> where 'less' may be segfaulting or exiting cleanly.
>>
>> IOW, something like this on top of your three-patch series?
>>
>>  pager.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> ...
> I sent a WIP start at something like this at the end of my v2, please
> discard it when picking up the rest:
> https://lore.kernel.org/git/20210202020001.31601-6-avarab@gmail.com/
>
> As noted there it's going to be a lot more complex than this.

Sorry, but you still have lost me---I do not see if/why we even care
about atexit codepath.  As far as the end users are concered, they
are running "git" and observing the exit code from "git".  There,
reporting that "git" was killed by SIGPIPE, instead of exiting
normally, is not something they want to hear about after quitting
their pager, and that is why the signal reception codepath matters.

Yes, I can see you are making it "a lot more complex" in your patch,
but what I do not see is why we even need to.

Thanks.
