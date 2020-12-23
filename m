Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125AC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F3720E65
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgLWCFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:05:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55111 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWCFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 21:05:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAA22A41C9;
        Tue, 22 Dec 2020 21:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xJMQalcIA0EO
        yiTB5r7nxoA+LBM=; b=Hcs5jl497a+UxF49qrzQARxJXnxhfTNsViP+klDFw149
        mnNp3HsLiwuV0seAHvIWLJfv/+nd2l0cb4cbNEMhmZnsa7RGDJ8qmxrqiHZcJGqk
        8NWpyXEqGAF0sBrCfA+dmTqjUjyg7sj0giaclPby0ye052G2Z3Mlma4LZtLImBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oqFBmR
        f6ivNOZNK7c+7mro3/zDbNIzB1pNK+aq1j6zU67tPLh/kUs7RUx5B0Thh5U/mvFW
        +SAHNbbhJewL7gGxe9Bsr4XBbtvW2aL5jaHjc046vMnT56woaM/fo1bEL9ELiH18
        lDE/A3KUGBy8/3Nxh7HldbiiuVmTQBaNoc+H4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2AC1A41C8;
        Tue, 22 Dec 2020 21:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 712E1A41C3;
        Tue, 22 Dec 2020 21:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 06/20] mktag tests: improve verify_object() test
 coverage
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-7-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 18:04:56 -0800
In-Reply-To: <20201223013606.7972-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:51 +0100")
Message-ID: <xmqqtusde0qf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4198F2CA-44C3-11EB-BDBA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  cat >tag.sig <<EOF
>  object $(test_oid deadbeef)
> +type tag
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- correct type,=
 nonexisting object' \
> +	'^error: char7: could not verify object.*$'
> +

OK.


> +cat >tag.sig <<EOF
> +object $head
>  type tagggg
>  tag mytag
>  tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure 'verify object (SHA1/type) check' \
> +check_verify_failure 'verify object (hash/type) check -- made-up type,=
 nonexisting object' \
> +	'^fatal: invalid object type'

tagggg is "made-up type".  Where did we grab head from?  it is
head=3D$(git rev-parse --verify HEAD) at the very beginning.  Is that
really a nonexisting object?

> +cat >tag.sig <<EOF
> +object $(test_oid deadbeef)
> +type tagggg
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- incorrect typ=
e, valid object' \
>  	'^error: char7: could not verify object.*$'

This is the "made-up type, nonexisting object", and previous one is
"made-up type, valid object", no?

> +cat >tag.sig <<EOF
> +object $head
> +type tree
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- incorrect typ=
e, valid object' \
> +	'^error: char7: could not verify object'

And this is correct.  "type tree" is not a made-up type, and $head
is a valid object but it is not of "type tree".


Somehow I feel as if this patch is trying to see if reviewers are
paying attention to ;-)

Thanks.
