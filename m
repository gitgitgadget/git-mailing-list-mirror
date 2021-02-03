Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4938C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8931E64F8C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhBCSOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 13:14:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhBCSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 13:13:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CF94AADFB;
        Wed,  3 Feb 2021 13:12:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iEdbqeu/bkph
        Uht3odqlAGrpVmk=; b=rr51maiEpVCJJymY9gC3kWfzwVj1wBpVLF5CxNtccbax
        Y6BZWE7hErvcDuIsUFp8gdiBgaWpTKgZlqs+NHkOVepmJea2vlZruE512bH6fkXo
        FCBzWSfUa083dH5vbCnt59oIifagz84NRtO7lP5xcVM34ESM5KBqDnFOo6TShv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VKM2ab
        taZd3o+E0s4T7G4EcJ+/Gkch2E7ZFRtOQUXzuWKsRgSjkBglwOf+XK6FeW3+O/wH
        SAYek+QZFEg0pN2CUj/qleuofUso1C0PbItEfRFmXv3ZAoJUk5AfIvtXJ5qea/3w
        oRjSBfsaXYySAF9CgDyha29nf1QpqHOR3JB3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C5D6AADFA;
        Wed,  3 Feb 2021 13:12:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73B84AADF9;
        Wed,  3 Feb 2021 13:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
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
        <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
        <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
        <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org>
        <xmqq35yegrcv.fsf@gitster.c.googlers.com>
        <12a440af-c080-089d-bf60-76262d5aec7a@kdbg.org>
        <xmqqwnvqdsax.fsf@gitster.c.googlers.com>
        <aa672f2b-6886-a2bf-5129-f10f4e488961@kdbg.org>
Date:   Wed, 03 Feb 2021 10:12:25 -0800
In-Reply-To: <aa672f2b-6886-a2bf-5129-f10f4e488961@kdbg.org> (Johannes Sixt's
        message of "Wed, 3 Feb 2021 18:07:02 +0100")
Message-ID: <xmqqr1lxc96e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F7389BE-664B-11EB-8719-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> I guess we are then in agreement---I do think it makes sense to send
>> the true exit code from the pager as the exit code from the pager to
>> the trace output, which is what the early part of =C3=86var's patch do=
es,
>> but I do not think the exit code of the pager should affect the exit
>> code from "git log" as a whole.
>
> Then we do not agree. The exit code of `git log | less` is ignored, and
> I regard `git -p log` just as a short-hand for that.

I think you skipped "not" while reading the "but I do not think"
part of the last sentence.

> The only thing I care is that git does not die due to a SIGPIPE when th=
e
> pager is closed early.

Makes two of us ;-)
