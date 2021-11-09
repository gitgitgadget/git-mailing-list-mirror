Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDDDC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B4F611CA
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhKIXhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:37:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52305 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKIXhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:37:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E40CF93D3;
        Tue,  9 Nov 2021 18:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ONWZzUC3Alj77r+7KcLdlvGgeiJ6MwpmQ56Y2V
        lENq0=; b=D/fS+nsES187FrefSYBCvq3+TyOxIfb4PmRu1D7/Vq9fTGKS+Mco8M
        wwKziSHjGCdyTuCGJDmE7Q0m5fWYt3jzEwYEFcEffzvCTcaLO7gI4twGLHiLlzZn
        TdVDW7Fx+p0dEOemVlh9554iHiPT5L+wZ5UvEGJQdEX0K+SsBAjtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42E7CF93D2;
        Tue,  9 Nov 2021 18:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACEFAF93D1;
        Tue,  9 Nov 2021 18:34:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
        <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
        <20211104194619.GA12886@dinwoodie.org>
        <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
        <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
        <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet>
Date:   Tue, 09 Nov 2021 15:34:15 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 10 Nov 2021 00:01:24 +0100 (CET)")
Message-ID: <xmqqee7ozyx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DE71716-41B5-11EC-83C3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I fear that it is a bit late in the -rc cycle to try to get this into the
> official v2.34.0. Adam, since you are the maintainer of the Cygwin git
> package, would you mind incorporating this patch into Cygwin's version of
> Git?

I do not mind taking a Cygwin-only #ifdef block in compat/ like we
see below from folks who have stake in Cygwin, and who are clearly
leading Cygwin users on the list, like Ramsay and Adam are, even
after I tag -rc2.

I cannot give the change any better test than they can, and it is
their platform to improve, or break by accident while trying to do
so.

Thanks.
