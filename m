Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF6C07E9C
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 04:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7892F61CDD
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 04:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHEde (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 00:33:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56730 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHEd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 00:33:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 634DFD2963;
        Thu,  8 Jul 2021 00:30:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KNl5q6SK5uvEIuETRH7usf5xNsPvak54kSATAj
        tu4yk=; b=dLXtdgTg3hl0b2tDEkrSe2grOSLDprz3tk90EnitdRyjSBjvj/J0uw
        Lf+qi/r/bf9PK+WODVhoKTe9vl3Y+A/FSSLP3hMBpbCbNPlCqKN6AThHEz7qlMeY
        6X0Z/FfOhck0Y9jkhB26J8HOugvjFFVDN6QFjlh/U/AtF6AW7clXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58E33D2962;
        Thu,  8 Jul 2021 00:30:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3FF2D2961;
        Thu,  8 Jul 2021 00:30:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/5] speed up alt_odb_usable() with many alternates
References: <20210629205305.7100-1-e@80x24.org>
        <20210707231019.14738-2-e@80x24.org> <xmqq8s2hd5ay.fsf@gitster.g>
        <20210708011446.GA15899@dcvr>
Date:   Wed, 07 Jul 2021 21:30:46 -0700
In-Reply-To: <20210708011446.GA15899@dcvr> (Eric Wong's message of "Thu, 8 Jul
        2021 01:14:46 +0000")
Message-ID: <xmqq1r89ctqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44071672-DFA5-11EB-A5E6-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>> > v3: Introduce and use fspatheq and fspathhash functions;
>> >     avoid unnecessary checks for allocation failures already
>> >     handled by our own *alloc wrappers.
>> 
>> The last one does not belong to the commit log message, as "git log"
>> readers do not care about and will not have access to v2 and earlier.
>
> Oops :x  Are you going to remove that on your end or do you want a resend?
> Looking at "git log", it looks like I've done it a bit over the years :x

OK.  I guess there are a few more patches in the series with the
same issue.  "rebase -i" is our friend ;-)
