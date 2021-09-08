Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFBC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB456113E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbhIHQNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:13:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53286 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhIHQNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:13:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8F14ECEDD;
        Wed,  8 Sep 2021 12:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4MiKG3B4FOmq3GZxUvjxsHGTke50v1n8QUe6qe
        4HHcs=; b=aJ2fYXkKsxnwiO/dSfz/N3Jw9Fk2EuNtteEeWBzwqSkzjUDXAqxQ5+
        cfikMwZ+s8VbtMoCy6kBNdnZ9sFPk0Mi1FI8f4HtAjb9L+txFJtRbNolkXZwtEGT
        3hyp5DIyUaNngldqil0ZKoBKhqNfv2pJA2yjF2qFUC2OcoG9RIcec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0428ECEDC;
        Wed,  8 Sep 2021 12:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B54EECEDB;
        Wed,  8 Sep 2021 12:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 0/9] Sparse index: delete ignored files outside
 sparse cone
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
        <xmqqwnnr7icz.fsf@gitster.g> <xmqqczpj7dyk.fsf@gitster.g>
        <4a0125d2-67d9-b533-4f8b-618c3de3b411@gmail.com>
Date:   Wed, 08 Sep 2021 09:11:58 -0700
In-Reply-To: <4a0125d2-67d9-b533-4f8b-618c3de3b411@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Sep 2021 07:39:54 -0400")
Message-ID: <xmqqk0jr59o1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ED90D46-10BF-11EC-9EC0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I rebased the dependent topic myself, but I would not be surprised
>> if I weren't careful enough and introduced a new bug.  Please double
>> check when a new 'seen' is pushed out in several hours.
>
> Did you have any conflicts? I don't think this version changed any
> of the textual dependencies. Anyway, the test suite passes with
> GIT_TEST_SPARSE_INDEX=1 on my machine at 'seen' (except for an issue
> with t7900-maintenance.sh that is unrelated).

There was a bit of test refactoring in the other topic, so I
initially punted but then I found a bit of energy to look at
the conflict and realize it was not all that bad.

