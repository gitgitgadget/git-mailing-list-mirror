Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB3D1F45F
	for <e@80x24.org>; Sun,  5 May 2019 05:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEEF2I (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 01:28:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64372 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEEF2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 01:28:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF360157166;
        Sun,  5 May 2019 01:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q5TZR4BXt4jtsTRni4h28/cuwyI=; b=qPWw36
        F2lUmXfo6PaWs7aN5CGDDPTTH/NlndeTZcF7QuauS/ly30zteS/TfHEACnYaTijz
        G8i9OtW74d51Se2IJ+9dgLJBDiJTvZ4uBWZ9cJR7cy3YRzbzATiDZQVfn4l2mJWf
        m01p/b53JYGqOMYzueqnh6UnDcwArYvVqs7AI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BmDkC9GstjXykDyG8pwrRKGk5/EnLqdO
        y9ot7wxm3eVShcMzBP1GsMQ/DvLHVRX/G+L922y+sqZdJgcSuiJEz0L0Gy7SqlaR
        8tnbJpi0MiOeeC7d++EUygJ6npxC+OhGF232e4cOQLdcJH2BE7vfyr4sM+RtMwCV
        6ujD4AZHBEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6B16157165;
        Sun,  5 May 2019 01:28:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FF6B157164;
        Sun,  5 May 2019 01:28:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
References: <cover.1555352526.git.liu.denton@gmail.com>
        <cover.1555487380.git.liu.denton@gmail.com>
        <20190422214901.GA14528@sigill.intra.peff.net>
        <20190425120758.GD8695@szeder.dev>
        <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
        <20190501100108.GA8954@archbookpro.localdomain>
        <20190502000422.GF14763@szeder.dev>
        <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
        <20190503144211.GH14763@szeder.dev>
        <20190503174503.GA8242@sigill.intra.peff.net>
Date:   Sun, 05 May 2019 14:28:04 +0900
In-Reply-To: <20190503174503.GA8242@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 3 May 2019 13:45:03 -0400")
Message-ID: <xmqqo94hsc63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F10B186-6EF6-11E9-A9CA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think spatch is smart enough not to hit the same header multiple
> times. But the problem is that we invoke it once per file, so it
> actually processes cache.h many times. That's slow, but also produces
> bogus patches.

Yes, I've seen this and was a bit irritated myself, but not enough
to do something about it myself, yet.
>
> Jacob Keller's patches to collapse this to a single invocation do fix it
> (and I've used them selectively in the past rather than cleaning up the
> resulting patch manually ;) ).

Ah, that is nice to know.  Do we want to resurrect it?
