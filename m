Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5CAC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6662076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVEcSjHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVXCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:02:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63510 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgDVXCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:02:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F4E343FE9;
        Wed, 22 Apr 2020 19:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+AmsLRJPdrP1HjBgachMElGEzVs=; b=RVEcSj
        HlixjT/R3AOxyQ+VwT4USqLNHlukgwlvBJDlRzr/8BDYlDWmb7xNct/WuuttGZv8
        8l7GRAt4TtRlSXmlaqkqeIpq+IS8fOmvO4KbWG+FrL6RgWPRxK+958e5lkhFmVq9
        HE0lPeXPBxul7vG7447KYs/nKoya6x2raNo+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oezM5tPY5rUMKImCJBtmbJK5zmOCuobX
        dYZpqWqVCoBZexYyyZauMum0q/ku0OH6EO1BuvlfQHMMljm9CeIVIP4N3TxVzImk
        WiDguk7Pf5xxS6EPOHCMrQ/+y3cjz9jbQ/Ub0FeRAsmciJZjsjQTJyZltIwABaES
        eV++F7y0Prw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 954AF43FE7;
        Wed, 22 Apr 2020 19:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 198AC43FE6;
        Wed, 22 Apr 2020 19:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict mode
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
        <xmqqh7xbi28f.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004230042370.18039@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Apr 2020 16:02:13 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004230042370.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 23 Apr 2020 00:50:37 +0200
        (CEST)")
Message-ID: <xmqqd07zi0p6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E22A70C-84ED-11EA-90AC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is not obvious from the diff: `url` is never changed. It would still
> point at the first `h`, as you said.
>
>> > +	if (slash - url > 0)
>> > +		c->host = url_decode_mem(host, slash - host);
> ...
> I guess a better condition would be `if (proto_end || slash - host > 0)`.

Yeah, that would probably be more intuitive to read.  What triggered
my reaction was the mismatch between "slash - url" in the condition
and "slash - host" that specifies the length of the memory region.


