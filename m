Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50346C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B1F24696
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gaUzdwxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgARSrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:47:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56598 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARSrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:47:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F71340A9D;
        Sat, 18 Jan 2020 13:47:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GbsVu3L2YT29Y1IRCPnoit5sUWk=; b=gaUzdw
        xlp2IrSQeF+ony9lh9EQ5bVNh3/VyGNswy8HQ/92P3lskgOgEglgv+WUoSKu6eiX
        2aDIgzuD9oUQy98D8MKcPolYwWy1OZZH9mgbFKXnJokKs3pvyNaUwGooGrTW8yR5
        yQePqSUl7ZEjAVWffJ/FeN4di678VSCMsi5Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t5+SBLODE3CovtLoEqYvLlN6OkWRV9rd
        r+AhbRSARQOClHhHURiKw1AYpf7WKQe9YLcCozNxGikDZX3ixyA8TarrcoPBUVXc
        /Gy+AgtZmkWaEtZZodCREU5rFHUgHOpPLARHYh9ySb1uJlBtUzMr8946CRrryvag
        KeL305ecLPE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 350E940A9C;
        Sat, 18 Jan 2020 13:47:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A9A340A9B;
        Sat, 18 Jan 2020 13:47:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 2/3] color.c: Support bright aixterm colors
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
        <20200118145318.5177-1-shawarmakarma@gmail.com>
        <20200118145318.5177-2-shawarmakarma@gmail.com>
Date:   Sat, 18 Jan 2020 10:47:03 -0800
In-Reply-To: <20200118145318.5177-2-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Sat, 18 Jan 2020 09:53:17 -0500")
Message-ID: <xmqqv9p8bo0o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBA86B58-3A22-11EA-B5F4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> These colors are the bright variants of the 3-bit colors.

OK, so this round the design is to reuse the ANSI mode instead of
introducing a new AIX mode that sits next to ANSI, 256 and RGB?

For this to work, not just the 90-97 range for bright-ansi orders
the colors the same way as 30-37 range (only brighter), but also
the differences between corresponding fore- and background colors
must also be 10 just like the regular ANSI colors.

So perhaps an additional sentence or two deserve to be there, e.g.

	... of the 3-bit colors.  Instead of 30-37 range for the
	foreground and 40-47 range for the background, they live in
	90-97 and 100-107 range, respectively.

or something like that, perhaps?

>  The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
>  `blue`, `magenta`, `cyan` and `white`.  The first color given is the
> -foreground; the second is the background.
> +foreground; the second is the background.  All the basic colors except
> +`normal` have a bright variant that can be speficied by prefixing the
> +color with `bright`, like `brightred`.

Nicely and readably written.

I have to wonder if spelling "bright<color>", i.e. two words smashed
together without anything in between words, is in widespread use (in
other words, are we following an established practice, or are we
inventing our own), or if we need to prepare for synonyms?  HTML/CSS
folks seem to use words-smashed-without-anything-in-betwen so they
should be fine with this design; I no longer recall what X did ;-)

Looking good.  Thanks.
