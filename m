Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3301F461
	for <e@80x24.org>; Wed, 26 Jun 2019 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFZSpJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 14:45:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58589 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZSpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 14:45:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5F3150702;
        Wed, 26 Jun 2019 14:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SsF2gDtq7yIK3/BAaPwi3C49cBo=; b=UQ6riO
        e+bMJVuM5IFt0KCjpS/5RSLm3wtChbyeciHOHQEkU8JJT8PbJdq38ikfvQ6NZ6eL
        KDZU7Y1Fks7PhgOVhXjBaiey2Rix6PKi60/2EAVtxFnX6lGjyYVBCyep8KVKulMD
        yoQN0G9V7ei4BDJeqLpxDdmj2MOR/XXKtCpy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QwcarO+uGraz45mA58AqBSzUJDIH4bRF
        lG0fuTMDnQ5a6UD0asAE/mQRvDdbXpxYghgrU3v+D+Ztuu7pMBCq2RYaH0i/DtKD
        3RTFzK/Bm5V1vkbOD+8t+gBkn76x3gpyuR55SUkfm23I2stdyl9FJDSDCAkBPE60
        Hg93dVrVn1I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20FEC150700;
        Wed, 26 Jun 2019 14:45:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14F181506FD;
        Wed, 26 Jun 2019 14:45:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string search
References: <87r27u8pie.fsf@evledraar.gmail.com>
        <20190626000329.32475-8-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Jun 2019 11:45:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Jun 2019 16:13:45 +0200 (CEST)")
Message-ID: <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8231973A-9842-11E9-A8CF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> Ah hah!
>
> If we would not have plenty of exercise for the PCRE2 build options, I
> would be worried. But AFAICT the CI build includes this all the time, so
> we're fine.

Well, I'd feel safer if it were not "all the time", i.e. we know we
are testing both sides of the coin.
