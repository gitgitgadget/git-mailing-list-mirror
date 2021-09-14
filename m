Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5470C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 21:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6DE60E90
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 21:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhINVui (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 17:50:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60400 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhINVuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 17:50:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9546DF3B7;
        Tue, 14 Sep 2021 17:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tTGWhWgqkaftQQRkBR6o9dz8T57vFUHGgMzTwfa/WBg=; b=FsPd
        ehpJxSQh+LuDf0hroDp//UBEeCzmyfXFFjjRw068aA5GU+DIA34U3o4EaIXPRP14
        bWR7gNNmKiuOdXesSNZQZRvCHE89fB0aLTI+SsaKiCgl6zd0LDg680g12VA8SyIF
        eeV8ajrhrb3MB3oTyc9mjki+xUMDJzW1nqkdDSs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B131DDF3B5;
        Tue, 14 Sep 2021 17:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEB5BDF3B4;
        Tue, 14 Sep 2021 17:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <87r1dydp4m.fsf@evledraar.gmail.com>
        <87ilz44kdk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
        <87mtofnzv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
        <xmqqilz32hhr.fsf@gitster.g>
Date:   Tue, 14 Sep 2021 14:49:18 -0700
Message-ID: <xmqq1r5qzv35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CFDA742-15A5-11EC-AF59-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But at least I view it as a step that needs to happen sometime
> between now and at the end.  I do not yet have an opinion on
> which one is more pleasant, between (1) having to deal with a
> single Makefile that needs to be aware of two different locations
> *.[ch] lives in, and (2) having to deal with two Makefiles that
> duplicates definitions and risks them needlessly diverging.

FWIW, I am leaning towards the latter, with the assumption that this
may take more than a cycle to cook in contrib/.

Adding the Makefile bits to the top-level and keeping the topic in
'next' means all the topics that pass the pipeline will need to be
written in such a way that its Makefile change works well with and
without the unified Makefile bits from this topic, an additional
burden on other topics this topic would impose.

So it is understandable to want to keep the changes to the top-level
Makefile to the minimum, even if it may mean that it requires more
effort in the end to clean things up when the topic graduates.

An alternative would be to bypass the contrib/ phase and start as a
new subcommand that is first-class citizen from day one and let it
spend as much time as it needs to mature.  It would burden the
topics that pass the pipeline while this is cooking the same way as
having a unified build procedure in the top-level Makefile, of
course, though.
