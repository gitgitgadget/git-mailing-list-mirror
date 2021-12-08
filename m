Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhLHQjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbhLHQjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:39:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54238171255;
        Wed,  8 Dec 2021 11:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wmylMvwcWy3ZGoavwWzKFvOhYc6Hj2L0siGxuS
        TA+Xs=; b=jKzVIicitGcOZim3EU9awuwoc6FMue7mgnM3JOruRfZVZHf1rEbA09
        hxlrMfUP5YUdgTPDtJynTCBn+ALDxrw3mR0F3pv71utsIEChTzSrujG+R1RB7TOE
        qMxyaGsNMsT/0ub65OukJcVQpXFde/3OzpbOlrRWRfLQDmrLh2tuQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AEC4171254;
        Wed,  8 Dec 2021 11:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F774171252;
        Wed,  8 Dec 2021 11:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <CAFQ2z_NuOy+-pfSoNAYjJhS9jZCYOfoFue10=k=iyPVsPYrB3g@mail.gmail.com>
Date:   Wed, 08 Dec 2021 08:35:36 -0800
In-Reply-To: <CAFQ2z_NuOy+-pfSoNAYjJhS9jZCYOfoFue10=k=iyPVsPYrB3g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 8 Dec 2021 11:30:11 +0100")
Message-ID: <xmqq1r2n3vhj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E01ED3C0-5844-11EC-9418-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Dec 8, 2021 at 5:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >> error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]
>> >
>> > Hmm. It's interesting that the regular DEVELOPER=1 doesn't catch this.
>> > It's because we don't specify -std there, and newer gcc defaults to
>> > gnu17 (unnamed unions appeared in c11, I think). I wonder if it would be
>> > helpful to teach config.mak.dev to pass -std=c99.
>>
>> FWIW, I use -std=gnu99 as our Makefile suggests.
>
> I understand that the default build should be lenient rather than
> strict for portability reasons. However, it would be good if the CI
> was strict with this.

Yeah, I agree with the above, and was a bit surprised that I found
the issue via my local build after it came from GGG.


