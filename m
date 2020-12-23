Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC15C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCFF21D81
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLWCK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:10:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57448 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWCK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 21:10:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 798A8104BDD;
        Tue, 22 Dec 2020 21:10:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tQku3J9eQLUA
        8ARqYAXa/lcBpaA=; b=mEE9rtkC06cs6rvn1NeP1wpnCZp+Uy5mRLR3J6Eqkvty
        6eUvj8CyW6MqvmlkwoQ9lKTWLLzAGwEJUQf3sc81ul/spFTjBvwPYOf2r/XXf9W6
        5kSiD2poeugasBLuExhCs9qMQAtNKezfCo3E2ngy1qSjsI9ZlIdAnnj93FQsvQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LciO+r
        Fc/MmFY9OCHGtAM2zPOgxsthTq9l9Eaq/oKqKUve1ch/6jagVdvv61DV385Udz0x
        +OyM3dRp/eRkHxUOz0gjbg8DmEtUtIYojMMEqG5yWFRpSMf2gDIq8pHeu7Byb7Y+
        wLZRiixjlDI68EsVwFN9LDOEOVUquzGWf93YA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 716FA104BDB;
        Tue, 22 Dec 2020 21:10:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B356D104BDA;
        Tue, 22 Dec 2020 21:10:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 07/20] mktag tests: don't pipe to stderr needlessly
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-8-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 18:10:10 -0800
In-Reply-To: <20201223013606.7972-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:52 +0100")
Message-ID: <xmqqpn31e0hp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCEB252A-44C3-11EB-8CC5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the piping of stderr to "message" in the valid tag test. This
> pattern seems to have been copy/pasted from the failure case in
> 446c6faec6 (New tests and en-passant modifications to mktag.,
> 2006-07-29).
>
> Nothing is piped to "message" here, and in the event of the test
> failing it only serves to hide the error.

I think the verb "to pipe" specifically means "redirecting the
output to a pipe" and nothing else.

    mktag tests: don't redirect stderr to a file needlessly

    Remove the redirection of stderr to "message" in the valid tag
    tests.  This pattern ... 2006-07-29).  Nobody examines the
    contents of the resulting "message" file, so the net result is
    that error messages cannot be seen in "sh t3800-mktag.sh -v"
    output.

or something like that?

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3800-mktag.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 9ae1b0bb0a..bbd148618e 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -257,7 +257,7 @@ EOF
> =20
>  test_expect_success \
>      'allow empty tag email' \
> -    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
> +    'git mktag <tag.sig >.git/refs/tags/mytag'
> =20
>  ############################################################
>  # 16. disallow spaces in tag email
> @@ -385,7 +385,7 @@ EOF
> =20
>  test_expect_success \
>      'create valid tag' \
> -    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
> +    'git mktag <tag.sig >.git/refs/tags/mytag'
> =20
>  ############################################################
>  # 25. check mytag
