Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C12C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80519206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVimAMeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgKYHxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:53:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63097 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKYHxn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 02:53:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77F49F6E1B;
        Wed, 25 Nov 2020 02:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F2v2KJbCzGA9
        /7CzKTM/EsbDfvI=; b=aVimAMeAex96RqwifWB9KRe3jG5eVb3zERHycITBl5fd
        ik3d2kYzJF8aP3cBFJ+e+gu2O4kWGPlndkHKNEJsDka976YOuByT6OhH+3EO8RlB
        SnW3uxx7fJYLooO0QnM6JgrtCgwAlQZeCEMjLpVKIRdKXaffUemrRKwH9hagKcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hTuXo0
        U5vp2miXzRL3KOI09Uj2OoXT1ayJunojjow8S8Ten/PUs8HfJXb/KdeFb9MUTBur
        B7yajejxGfgPc3Lp/l9B4B5oXmcEwP+wssc+9jPlVRcznZC+2wcXmDHx3w0G7deF
        TCW4/9vnFZD0Xb2Tz9d95GviU/aLwmse6ndQk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 708B9F6E19;
        Wed, 25 Nov 2020 02:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BCE93F6E18;
        Wed, 25 Nov 2020 02:53:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] grep: copy struct in one fell swoop
References: <cover.1605972564.git.martin.agren@gmail.com>
        <cover.1606251357.git.martin.agren@gmail.com>
        <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
        <xmqqsg8ygza7.fsf@gitster.c.googlers.com>
        <CAN0heSoM+qQe8BdKHVpqhA0RAqzyyL3Qr98G=O8kD504diruCg@mail.gmail.com>
Date:   Tue, 24 Nov 2020 23:53:37 -0800
In-Reply-To: <CAN0heSoM+qQe8BdKHVpqhA0RAqzyyL3Qr98G=O8kD504diruCg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 25 Nov 2020 07:25:07
 +0100")
Message-ID: <xmqqlfepg9dq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 541A6B1C-2EF3-11EB-AA6C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Tue, 24 Nov 2020 at 23:34, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> +/*
>> + * grep_config() initializes one "default" instance of this type, and
>> + * it is copied by grep_init() to be used by each individual
>> + * invocation.  When adding a new field to this structure that is
>> + * populated from the configuration, be sure to think about ownership
>> + * (i.e. a shallow copy may not be what you want for the type of your
>> + * newly added field).
>> + */
>>  struct grep_opt {
>>         struct grep_pat *pattern_list;
>>         struct grep_pat **pattern_tail;
>
> Ok, that makes sense. Maybe put it in `grep_config()` though? We can ad=
d
> anything we want to to this struct and initialize it from the command
> line. It's when we start pre-filling it in `grep_config()` that we need
> to think about this. What do you think? We could also do both of
> course to really hedge our bets...

I agree with you that it would be the most helpful to have the
comment near grep_config(), as that function is what defines the
design of populating the singleton to be copied by the instance
used by individual invocation.

>   /*
>    * The instance of grep_opt that we set up here is copied by
>    * grep_init() to be used by each individual invocation.
>    * When populating a new field of this structure here,
>    * be sure to think about ownership (i.e. a shallow copy in
>    * grep_init() may not be what you want).
>    */

I find the text near the end of both my version and yours a bit
unsatisfying.  One thing I care about is not to mislead readers to
think that the way grep_init() copies the singleton template is
correct and sacred and they need to design their data structure to
be compatible with the shallow copying.  We'd want it to be clear
that it is expected that they will deep copy the field, and release
it once individual invocation is done, when they need a new field
that won't work well with shallow copying.  Perhaps "may not be wnat
you want" is explicit enough, but I dunno.

Thanks.



