Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbiEYS1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEYS1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 14:27:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018AAE26A
        for <git@vger.kernel.org>; Wed, 25 May 2022 11:27:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D59A212F248;
        Wed, 25 May 2022 14:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7KK0dDbXx11/
        XiLMk+Md0wE/n7dxnPs0vx7ffG/FORE=; b=bK3Idn4eLnTCrLsy1AHCKTPPqDDC
        8UdKV0EetBClv9w97Sm0THQgD0d2u8x7EveudwQrkow3/Wu/UwkRNTmxg7xLRlP+
        yO7EJMvb8OQwtcmBm+UStJyuvoGg1cgBavtf0zwjPTkSCr6wm+pGqxiDt3eInw5B
        Zus6jHXoz92JxLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC39812F247;
        Wed, 25 May 2022 14:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3255A12F245;
        Wed, 25 May 2022 14:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] dir.c: avoid "exceeds maximum object size" error
 with GCC v12.x
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
        <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com>
        <220524.86k0abxyqa.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2205242302020.352@tvgsbejvaqbjf.bet>
        <d7ee0bf0-22bc-d494-2699-7075fc92f28a@github.com>
Date:   Wed, 25 May 2022 11:27:37 -0700
In-Reply-To: <d7ee0bf0-22bc-d494-2699-7075fc92f28a@github.com> (Derrick
        Stolee's message of "Wed, 25 May 2022 09:39:53 -0400")
Message-ID: <xmqqzgj579ie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5AEB1748-DC58-11EC-89F4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 5/24/2022 5:05 PM, Johannes Schindelin wrote:> On Tue, 24 May 2022, =
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:
>>>> +	/*
>>>> +	 * It should not be possible to overflow `ptrdiff_t` by passing in=
 an
>>>> +	 * insanely long URL, but GCC does not know that and will complain
>>>> +	 * without this check.
>>>> +	 */
>>>> +	if (end - start < 0)
>>>> +		die(_("No directory name could be guessed.\n"
>>>
>>> This should start with a lower-case letter, see CodingGuidelines.
>>=20
>> This message is copied from existing code later in the same function.
>> Since it is a translateable message, I do not want to edit it because =
that
>> would cause unnecessary work of the translators. Especially given that=
 we
>> do not even expect this message to be shown, ever, but we only add thi=
s
>> hunk for GCC's benefit.
>
> Perhaps this should be a BUG() statement, then? Without any
> translation?

Yeah, both are good.  If somehow the caller managed to pass such a
long URL then it can be considered a data error at runtime, and not
that the user detected a bug in our code, so in that sense die()
would be appropriate.  It is like xmalloc() running out of memory.

On the other hand, the "should not be possible to overflow" in the
comment implicitly assumes that it is impossible to pass insanely
long URL to trigger the condition from places we think of offhand,
like the command line, where the input is limited to a much shorter
string.  As "we detected a situation that should not happen unless
there is a programming or design bug" is what BUG() means, it is
also good here---our assumption that this should not be possible
turned out to be faulty, so we noticed a design bug.

I wonder if we can add a separate macro to add more to the
documentation value, though.  With something like

    #define FALSE_WARNING(expression, message) \
	do { if (expression) { BUG(message); } while (0)

the above would just become

	FALSE_WARNING(end - start < 0, "ptrdiff_t would not overflow here");

without a need for a big comment before it.  We might even be able
to optimize it out when building with compilers that do not need the
workaround.

