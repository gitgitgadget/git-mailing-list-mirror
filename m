Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507A21F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 00:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJUAwR (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 20:52:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58335 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfJUAwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 20:52:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B42999AC62;
        Sun, 20 Oct 2019 20:52:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Tbdl4p2m0HrO
        IPrlbqoJaIpaHOE=; b=lA2EMRF2xeqEX9sT4Ig/5z9xOkEJRhno0K5k1pbGgZ76
        ZHhfyfe/J4dwAB9zZlfVjaXVyHSC449x9Tj5PfrgPVGQXPDXoNNFoElyiqJaP3aY
        yltBx7VnV/JAYzm3lZ+pR8/qucAuEH93gjQ4uAZKSyi3EtpGdv3uOVdSCT7f4Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a7/rY3
        Jcg62x2BP3o3vkuoi0NX7GXFPnr2ulu07TJrntaP8DgyNG35I4y+yhSbTn6DcwRX
        X/XjHRPRAXeOOV7qjzyYCqQ1eIh0rZ+3saXYSpPtPc54CnJbkI+1raDmsY4GWOTM
        n7rqBnaEKvFyEPOPjM8aaAgIR9RlnWYEBTf44=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC04E9AC61;
        Sun, 20 Oct 2019 20:52:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6C1A9AC5F;
        Sun, 20 Oct 2019 20:52:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
        <20190731071755.GF4545@pobox.com>
        <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
        <20191019233706.GM29845@szeder.dev>
Date:   Mon, 21 Oct 2019 09:52:11 +0900
In-Reply-To: <20191019233706.GM29845@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 20 Oct 2019 01:37:06 +0200")
Message-ID: <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 057BFE0E-F39D-11E9-902E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The reason for that bogus value is that '--total's parameter is parsed
> via parse-options's OPT_INTEGER into a uint64_t variable [1]...
>
> Change the type of that variable from uint64_t to int, to match what
> parse-options expects; in the tests of the progress output we won't
> use values that don't fit into an int anyway.

OK, so when the call to start_progress() is made, the second
argument (i.e. "total" which now is int) is promoted to what the
callee expects, so there needs no other change.  Makes sense.

> [1] start_progress() expects the total number as an uint64_t, that's
>     why I chose the same type when declaring the variable holding the
>     value given on the command line.

I can sympathize, but I do not think it is worth inventing OPT_U64()
or adding "int total_i" whose value is assigned to "u64 total" after
parsing a command line arg with OPT_INTEGER() into the former.

Catching a pointer whose type is not "int*" passed at the third
position of OPT_INTGER() mechanically may be worth it, though.
Would Coccinelle be a suitable tool for that kind of thing?

>  int cmd__progress(int argc, const char **argv)
>  {
> -	uint64_t total =3D 0;
> +	int total =3D 0;
>  	const char *title;
>  	struct strbuf line =3D STRBUF_INIT;
>  	struct progress *progress;
