Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E4EC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE12610A5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhHSTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:55:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52126 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhHSTzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 15:55:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 292B3D15F3;
        Thu, 19 Aug 2021 15:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ksP/T2UV7g+sFeq7mT9zt5xLrKccJ/utyqAfj
        /Z/c0=; b=YhOurr5IAueOtRgbJATdLAW6jUq5RFZFpifu7L2GLhELCirEDSMFoq
        vvqtqzb0xCY3f/UAD27E7E4ED+wulrC6csPnR9jVZPhwiUKVqXhpAinkF284p6Ka
        BXIOKVzHLSz/viQsG5YccKPehOn0ZVfBWqLH6+jY1zB81MA59KBjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21F05D15F2;
        Thu, 19 Aug 2021 15:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6862D15F1;
        Thu, 19 Aug 2021 15:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
References: <20210817110728.55842-1-bagasdotme@gmail.com>
        <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
        <CAPig+cT5nPJ7NKFKXRQJwTzL13oEwzMBBpAa+P+XoZxO9SEKKQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2108181222120.55@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Aug 2021 12:54:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108181222120.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 18 Aug 2021 12:25:35 +0200 (CEST)")
Message-ID: <xmqqwnohyzuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A815528-0127-11EC-A659-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -install: all
> +install: all | strip
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -- snap --
>
> I am not quite certain that this is compatible with other `make`
> implementations we still might support (if there are any, I remember that
> we often have to rely on `gmake` because the native `make` does not
> understand our `Makefile`?), so that might need to be conditional on GNU
> Make.

I think we are pretty-much dependent on GNU make already (it is
possible to raise a weather balloon to confirm by renaming Makefile
to GNUmakefile and observing if anybody complains, I think).

But I am not sure what such a rule does for a .PHONY target like
'strip'.  Does it do the right thing, i.e. "install recipe is run
after 'strip' recipe has run, iff 'strip' is also asked for"?

Thanks.
