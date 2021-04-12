Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2FC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244026105A
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhDLV1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:27:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57718 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhDLV1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:27:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53BF5C73B5;
        Mon, 12 Apr 2021 17:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=90ISAKfhNXqIKnPOKy4+QyCLqok=; b=SLh5Ko
        vkPQeprbwEjvnSwE65KG9EhKL44M3TK/rlmPVnuVM+7cTd3rc/ggH51BR4KXI0CZ
        5AECMvFo1/TAfPUqvC/+1oToHuRbCEDuGujyMs/I1bwqqwCtnSHdU3bz4exBBy6p
        ABWxpG5T45Lou2Vt7B2vNPkrcfvcOr9z7OVno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qp2OqAKcz06jBgwBQkd/dW760J29iFtD
        hxeM4r1MdFGDUd+Zkox46Mg0zPJs0H3TITuU/eGg/n6YOgoEPTW4eYnn+FSgLRIo
        mmTTbmpNo6RT8HvTN44weMO/aeuJ1oekXsSDjaeFwNvm2yEuveuEWHwu6nY/Tetb
        mF8XLX/BVl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 454ADC73B4;
        Mon, 12 Apr 2021 17:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85FFEC73B2;
        Mon, 12 Apr 2021 17:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to
 test_commit
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
        <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
Date:   Mon, 12 Apr 2021 14:27:18 -0700
In-Reply-To: <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 12 Apr 2021 15:05:56 -0400")
Message-ID: <xmqqk0p7b3d5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC906268-9BD5-11EB-9939-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The name "printf" has such strong association in programmer's minds
> with "%" and argument consumption that the name of this option alone
> almost begs people to take advantage of argument interpolation even
> though it's documented here as not allowing it. Taking into
> consideration that people often do not read documentation, `--printf`
> as the name of the option may be an unfortunate one. Perhaps it could
> be called `--raw` or something less likely to suggest argument
> interpolation.

The reason we want to use 'printf' instead of 'echo' is because only
some implementations of 'echo' honors '\t\n\r' etc., and 'echo' by
others show these literally.  Using printf(1) allows us to write
these backslashed special characters universally.

So, I find 'raw' equally confusing, if not more.

>> @@ -192,6 +196,7 @@ debug () {
>>
>>  test_commit () {
>>         notick= &&
>> +       echo=echo &&
>
> This could be slightly confusing. I wonder if naming this variable
> `emit` would be clearer.

Perhaps.
