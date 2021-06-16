Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86386C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD861107
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhFPArs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50492 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFPArq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F1DAE628D;
        Tue, 15 Jun 2021 20:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iLBTBfIQ6izL
        /+a4zset/E1aZLarHtgxjTh+e3bZ5T4=; b=Oe8rWBBihqoWXzWdWOZzQVuyekhe
        yYDBzVn4GZhJsOVVIrwByLo/Jo/2lC3Ge6geiYUgwdc1iKorDsOnTxnp3aVeaj7j
        sw53gPb2TP8IqxcmTqW/MdHTJY5Af3zNxEJ7qPX89el5mws3tnIlYAYpIng0jbA4
        qEQ+6glw7YDc5Vc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96218E628C;
        Tue, 15 Jun 2021 20:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F013E628B;
        Tue, 15 Jun 2021 20:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/30] Minimal restart of "config-based-hooks"
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
        <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
        <YMe6nJHxN2yO36wf@google.com>
Date:   Wed, 16 Jun 2021 09:45:39 +0900
In-Reply-To: <YMe6nJHxN2yO36wf@google.com> (Emily Shaffer's message of "Mon,
        14 Jun 2021 13:22:52 -0700")
Message-ID: <xmqqeed2vdqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C4BC066-CE3C-11EB-96DE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Jun 14, 2021 at 12:32:49PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>=20
>> I proposed splitting Emily's "hook config" topic[1] into at least a
>> topic that retains all current behavior of the codebase, and merely
>> refactors existing behavior to new APIs, and then doing behavior
>> changes later.
>>=20
>> This is a re-roll of an attempt to do that. See v1's CL [2] for much
>> more details.
>>=20
>> I was hoping to get more feedback from Emily in reply to [3] and
>> related E-Mails on the v1, but as it's been almost 2 weeks with no
>> reply, and both her topic and mine semantically conflict with changes
>> since merged to "master" I thought I'd send this re-roll.
>
> Yes, sorry about this. I'm planning on reviewing your series this week.
> Thanks for sending the v2.

Thanks, both.  In the meantime, I will eject es/config-based-hooks
out of 'seen' and replace it with these patches, to see if there are
unexpected interactions with other topics in flight.

