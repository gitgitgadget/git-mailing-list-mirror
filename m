Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD47FC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C98C610FB
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhD0HJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:09:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65247 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0HJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:09:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3468D6079;
        Tue, 27 Apr 2021 03:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0RjJsaNnvhtw
        KafKSpxEaw/E0fpSEzrsZG2XVydteOU=; b=enZ/E6bXz5GRfE0eLvT3aOXeyMu1
        fOAFoL0gxu5VnwmtLdjwDeY67Gi9xukWBa2DoqdCXUXykLOvXZm2Dt1wAwHgWC3Z
        jfNG4VYSIq/nuKFNOT4P0hUHn/tvS15cgX3Mhuj38L8akrdD/e8ZjsOBLdivy+fw
        aMbjq+nMERYIpz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BA46D6077;
        Tue, 27 Apr 2021 03:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBEEDD6076;
        Tue, 27 Apr 2021 03:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>
Subject: Re: [PATCH 1/2] pretty tests: simplify %aI/%cI date format test
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
        <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
        <patch-1.2-4a90e4a141a-20210425T090506Z-avarab@gmail.com>
Date:   Tue, 27 Apr 2021 16:08:44 +0900
In-Reply-To: <patch-1.2-4a90e4a141a-20210425T090506Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 25 Apr
 2021 11:11:32 +0200")
Message-ID: <xmqqtunsdx1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67A2BF48-A727-11EB-A458-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  # ISO strict date format
>  test_expect_success 'ISO and ISO-strict date formats display the same =
values' '
> -	git log --format=3D%ai%n%ci |
> -	sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
> +	git log --format=3D%ad%n%cd --date=3Diso-strict >expected &&
>  	git log --format=3D%aI%n%cI >actual &&

While these two must show the same output, I wonder how much value
we are getting out of them.  Don't they end up exercising pretty
much the same codepath?

Not that I think the original is any better at all, though ;-)

>  	test_cmp expected actual
>  '
