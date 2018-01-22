Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0801F404
	for <e@80x24.org>; Mon, 22 Jan 2018 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeAVTwk (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 14:52:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56629 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeAVTwj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 14:52:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC716C828D;
        Mon, 22 Jan 2018 14:52:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=POJ8ZDQBe935
        QOstIe+1os/BLoU=; b=qBSIewKneH+/aouhUKO5xVUoziclKwcZWxX5zTm5QCDv
        BPcMyegImlQMiSxJRz+cm+etUn5eRme2B0/6nO/uJpyL4tZqLl2lMETDB30GhjyA
        2YhQtUZxkFYFQo1GNcDxefv2rVvPsAjar79cdME/VNmlvEjkYb+5sobi8tw4lmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WXsXd2
        FYvzxhslMEw1qB0DCZVE9dI6/XDw6JafhkFNFmJisHSY0JREShAWWMnsfT5XbVz+
        ayWyEmc8sNq9X62B3GQu0ws0FcEqqHfmLrz8kmLgTZdFREu1NhyoCR/ef87Kfzgk
        JHELvl6IVDPkYVp2QdiJ7+LlG8ScJBh666tc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C351EC828C;
        Mon, 22 Jan 2018 14:52:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27ADBC828B;
        Mon, 22 Jan 2018 14:52:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/12] fetch tests: double quote a variable for interpolation
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180119000027.28898-1-avarab@gmail.com>
        <20180121000304.32323-5-avarab@gmail.com>
Date:   Mon, 22 Jan 2018 11:52:36 -0800
In-Reply-To: <20180121000304.32323-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 21 Jan 2018 00:02:56 +0000")
Message-ID: <xmqqbmhln01n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC702FC0-FFAD-11E7-B624-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> If the $cmdline variable contains multiple arguments they won't be
> interpolated correctly since the body of the test is single quoted. I
> don't know what part of test-lib.sh is expanding variables within
> single-quoted strings,...

    dothis=3D'echo whatever $IFS separated strings'
    test_expect_success label '
            $dothis
    '

works because test_expect_success ends up beint a glorified 'eval'
and it sees the value of $dothis. =20

> but interpolating this inline is the desired
> behavior here.

I am not sure what you meant by this, though.

> -			git fetch $cmdline &&
> +			git fetch '"$cmdline"' &&

Would this work with cmdline that needs to be quoted for the
resulting shell script to be syntactically correct (e.g. cmdline
with a single dq in it)?  By stepping out of sq pair, you are
allowing/asking the shell that forms test_expect_success command
line arguments to interpolate cmdline, instead of asking the shell
that evals test_expect_success with its command line argument
strings.

In other words, I suspect that the caller of test_configured_prune
now must sq_quote the cmdline arguments it passes to this helper,
i.e.

	cmdline=3D"$(git rev-parse --sq-quote arg1 'arg"2' arg3)"
	test_configured_prune ... "$cmdline" ...

for this patch to be correct.
