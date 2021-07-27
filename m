Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB745C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8778660F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhGZXht (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:37:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60143 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhGZXhs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:37:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E1CEDF31B;
        Mon, 26 Jul 2021 20:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TzVJ42nMskWD
        2R7MpTL3rl8Ef9jP7wOJsOh+Y+R4FzA=; b=URubkTzWAt/4pTPZZorJ4GYypXol
        60k1eDe3UEu8/Q6Wu73RckQV/VC1juUVObSTNHPMaYG5cUZ+zxaR6NlmyKFwypQ1
        ibl0sas5C6eWPhHLOccZ03S3KDJwsGPtvBDiHRVk+aAUprep2JQ0SJJp3S72P5z1
        2AczUWQjLlWhg7Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E5D6DF317;
        Mon, 26 Jul 2021 20:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC29FDF316;
        Mon, 26 Jul 2021 20:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v9 0/7] refs: cleanup errno sideband ref related functions
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
        <877dhcskh4.fsf@evledraar.gmail.com>
Date:   Mon, 26 Jul 2021 17:18:14 -0700
In-Reply-To: <877dhcskh4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 27 Jul 2021 01:49:40 +0200")
Message-ID: <xmqqmtq8fw3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2314C62E-EE70-11EB-BA65-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 20 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> A v9 re-roll of the v8, see
>> https://lore.kernel.org/git/cover-0.7-00000000000-20210716T142032Z-ava=
rab@gmail.com/
>> and more imporantly the real summary of what this is in v7 at
>> https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avar=
ab@gmail.com/
>
> FYI I did not re-roll a v10 of this on top of the just re-rolled base
> topic:
> https://lore.kernel.org/git/cover-00.11-0000000000-20210726T234237Z-ava=
rab@gmail.com/#t
>
> The range-diff I have locally between the two (this version, and my
> rebased "should I need a re-roll" version) shows no changes, so this
> still cleanly applies on top.

Thanks.  I just rebased it on top of the base topic locally.  No
need to resend.

