Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CF3C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53D361466
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEJSnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 14:43:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51144 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:43:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CF1F133803;
        Mon, 10 May 2021 14:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rhB2bprxqaLO
        muryfaK0aUJoxUURBBy6m+dxQEseSXc=; b=tmFtR0qP0TlR9vF1s+hvkLXDV5Cy
        7R42WPKa5/TJ++xxsLnyfaNbjlQPvNK7Mw2pCuHpPJnlgqBwT0ugYE6AL8V66/GR
        W1RGdDAUDnlRiwhV/rCjKCG2HVjojh1noPLcC9M5EXYaApaMY5y1j/T9XoW6pMRx
        1VpHlz9Vg2zEw2w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7534B133802;
        Mon, 10 May 2021 14:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 899EE133800;
        Mon, 10 May 2021 14:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/8] maintenance: add --schedule option and config
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
        <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
        <87blctcp30.fsf@evledraar.gmail.com>
        <1eff631f-b079-d097-b16d-36dc974efea9@gmail.com>
        <87o8diu6jn.fsf@evledraar.gmail.com>
Date:   Tue, 11 May 2021 03:42:31 +0900
In-Reply-To: <87o8diu6jn.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 10 May 2021 14:16:12 +0200")
Message-ID: <xmqqpmxyph0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B9EEF10-B1BF-11EB-BE03-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Feb 09 2021, Derrick Stolee wrote:
>
>> On 2/9/2021 9:06 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>=20
>>> On Thu, Oct 15 2020, Derrick Stolee via GitGitGadget wrote:
>>>=20
>>>> +--schedule::
>>>> +	When combined with the `run` subcommand, run maintenance tasks
>>>> +	only if certain time conditions are met, as specified by the
>>>> +	`maintenance.<task>.schedule` config value for each `<task>`.
>>>> +	This config value specifies a number of seconds since the last
>>>> +	time that task ran, according to the `maintenance.<task>.lastRun`
>>>> +	config value. The tasks that are tested are those provided by
>>>> +	the `--task=3D<task>` option(s) or those with
>>>> +	`maintenance.<task>.enabled` set to true.
>>>=20
>>> I see from searching on list and from spying on your repo that patche=
s
>>> for this maintenance.<task>.lastRun feature exist, but there's no cod=
e
>>> for it in git.git.
>>>=20
>>> So we've got a 2.30.0 release with a mention of that, and it can't wo=
rk,
>>> because it's only in the doc due to b08ff1fee00 (maintenance: add
>>> --schedule option and config, 2020-09-11).
>>
>> Thank you for pointing out this docbug. This is based on an early
>> version of the patch series and should have been changed.
>>
>> Please see this patch which attempts to do a better job. I can
>> create a new thread with this submission if we need more edits.

Or resend it in a new thread for better visibility, with or without
change, with a mention of the original under the three-dash line.
Nobody can tell, with the above comment, if you abandoned the patch
or if you thought it is good enough.

Thanks.
