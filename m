Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C2C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7FD6108B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbhIMT73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:59:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58452 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbhIMT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:59:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 942FDD54AF;
        Mon, 13 Sep 2021 15:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yBhJNilObH27ER7RYzYy+/sSED+x8+o7xDt8VxQiWf0=; b=fnKX
        Xt+PUsDAm3x7C0O4Y/zUkS9dVT75wEoC0DqqcGskv/MZPAa/7aHD925u2BS9NYfE
        UCqW2sQYwZonJxcTyZ9JjG9B1Gtck7iiunX9/TcIyoOIE+YLCf66dv81ojYND0Mf
        7sV/anXTvsVVbnTaEd0taC5VjtAqWAvJB5mhGcU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD12D54AE;
        Mon, 13 Sep 2021 15:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12632D54AC;
        Mon, 13 Sep 2021 15:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
        <YSvsQcGNpCMZwS8o@nand.local> <xmqqeeaa6fey.fsf@gitster.g>
        <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
        <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
        <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
        <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet>
        <YT+FzPT0RCP2PdNL@coredump.intra.peff.net>
Date:   Mon, 13 Sep 2021 12:58:11 -0700
Message-ID: <xmqqy280dz8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECD52224-14CC-11EC-BEA9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another approach is to stuff the appropriate globals into the repository
> struct, and then "push" onto the global the_repository pointer, treating
> it like a stack. And then low-level code is free to use that global
> context, even if it wasn't passed in.
> ...
>   - it's a challenge with threading (an obvious problem would be a
>     multi-threaded grep which wanted to descend into a submodule). Using
>     a thread-local global for the_repository might solve that.
>
> It's possible that this is a terrible direction to go, so I'm not
> necessarily endorsing it, but just offering it as a possibility to think
> about. The trickiest thing is that any devil would likely be in the
> details, and we wouldn't know until proceeding for a while along that
> path. Whereas passing around a context struct, while verbose and
> annoying, is a well-understood construct.

I agree that it is cute, thread-unsafe, and tricky.  Let's leave it
at an interesting thought experiment for now.

Thanks.

