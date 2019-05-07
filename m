Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28421F45F
	for <e@80x24.org>; Tue,  7 May 2019 04:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEGEwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 00:52:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50738 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGEwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 00:52:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7A7E145655;
        Tue,  7 May 2019 00:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z3nbEKP44h62XJntJSR/eIDMlQg=; b=P/oYz3
        nwBe+3PLQRHm5XadDAf1iRImyohsaL8K5lB5fLunubI+7hy/EBD2khn65+HvaVdY
        w4YYTCTPU+eKwESk9BW+ssNfpjZ/CXRb0sZQyDDnf/ReWxo2dywmC7z6/+sOEP8H
        ZxvP1K8A9sBDHy6n2wiYtN5eQ79q5UevR5Yhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wwkxq4uBLIbGlkXQ00u3pXTtZ6a6Ho34
        N+EmM6ViaEQcGzZ/cftBCsPNRhdxXpX89s2p3Ubc5fBg85i74AbFC71rg13fTIil
        IO+Lp/5Pdu9o3+x9RsyVVGmgq8hu0ZwlDmErWgzsoWNOsjPhp+JfbqXHDDu+si8i
        iWuyzeWV524=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEDCF145653;
        Tue,  7 May 2019 00:52:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 263C7145651;
        Tue,  7 May 2019 00:52:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
References: <20190501100108.GA8954@archbookpro.localdomain>
        <20190502000422.GF14763@szeder.dev>
        <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
        <20190503144211.GH14763@szeder.dev>
        <20190503174503.GA8242@sigill.intra.peff.net>
        <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
        <20190506051148.GB30003@sigill.intra.peff.net>
        <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
        <20190506234334.GA13296@sigill.intra.peff.net>
        <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
        <20190507025501.GA3417@sigill.intra.peff.net>
Date:   Tue, 07 May 2019 13:52:32 +0900
In-Reply-To: <20190507025501.GA3417@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 6 May 2019 22:55:01 -0400")
Message-ID: <xmqqh8a6n9wv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0F4746-7083-11E9-A68E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, 2^31-1 is probably a better number, but it's harder to write out. :)
>
> Here's what a patch might look like to implement "0". By still using
> xargs in the unlimited code path, it's not too bad. I dunno.



As somebody who is too used to run "diff -U999" and be happy, I
cannot claim that I care enough, but the result does not look
too bad.

>
> ---
> diff --git a/Makefile b/Makefile
> index daba958b8f..0765a59b7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2792,7 +2792,12 @@ endif
>  
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
> -	if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
> +	if test $(SPATCH_BATCH_SIZE) = 0; then \
> +		limit=; \
> +	else \
> +		limit='-n $(SPATCH_BATCH_SIZE)'; \
> +	fi; \
> +	if ! echo $(COCCI_SOURCES) | xargs $$limit \
>  		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
>  		>$@+ 2>$@.log; \
>  	then \
>
> -Peff
