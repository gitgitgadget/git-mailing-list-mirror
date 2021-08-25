Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FBC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9146C610A1
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHYV1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:27:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65256 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYV1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 17:27:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D64DE757;
        Wed, 25 Aug 2021 17:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CZYBtgaZo0tI/FiRaqm0k720dy4REBsEMN1YEV
        VLfSY=; b=MQsv9GlyXIBOlbYTjbcyTGgE03LTIwgIUju7WvBmZAlurmyDOY3SGt
        lhqLnRmPZCu4AL9Xi9THRj5SpSeXYAI0+i690+gUl5ZyPHJTWm38eILvVCbTW6C8
        aQR322bdzx72JBkSpa/Nj/p9tpC4vgpakyVUcGs27xWUCaY867Oes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88FB5DE756;
        Wed, 25 Aug 2021 17:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1868ADE754;
        Wed, 25 Aug 2021 17:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2108251551100.55@tvgsbejvaqbjf.bet>
Date:   Wed, 25 Aug 2021 14:26:49 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108251551100.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 25 Aug 2021 20:52:26 +0200 (CEST)")
Message-ID: <xmqqv93tgqqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28C64588-05EB-11EC-A639-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It makes sense, but I would recommend using a more easily explained value
> than `2`. Maybe `delayed`? Or `bulk` or `batched`?

While we have less than 100% confidence in the implementation, it
may make sense to have such a knob to choose between "do we fsync
the old, known-safe but slow way, or do we fsync in batch"
behaviours, and I agree that the knob should not be called cryptic
"2".

But in a distant future when this new way of flushing proves to be
stable, it would make sense if the enw behaviour were triggered by
the plain vanilla 'true', no?  In a sense, running fsync in a batch
(or using syncfs) is an implementation detail of "we sync after
writing out object files and before declaring success".

Thanks.
