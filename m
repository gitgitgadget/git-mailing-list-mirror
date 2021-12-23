Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FDCC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 22:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhLWW0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:26:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52332 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350457AbhLWWZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 17:25:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A360F16B344;
        Thu, 23 Dec 2021 17:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6MmEce7YenNS
        /K1cGFyp/TdFRRPqkSQ2PdpnAR4TCa8=; b=EiP2r3Zhz3tpKyRiM3XDb4wihsiz
        7Wfgf3uEINL+xlcL98UTnstIFgwVvgFI2rrKOcOAwO7ezVxl3j67/mad8SVAyPTr
        Vj227nlFV/U07jdntMMsrrKzhlaXQkQHr0qnvqblsBfydIZSVAtDnxbBpY2PASFQ
        TCz3z/1Uqy0LFwY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D2F116B343;
        Thu, 23 Dec 2021 17:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7949716B342;
        Thu, 23 Dec 2021 17:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 3/7] grep tests: add missing "grep.patternType"
 config test
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
Date:   Thu, 23 Dec 2021 14:25:11 -0800
In-Reply-To: <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Dec
 2021 03:58:53
        +0100")
Message-ID: <xmqq35mj7yd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3287CDC8-643F-11EC-9FE8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the grep tests to assert that setting
> "grep.patternType=3Dextended" followed by "grep.patternType=3Ddefault"
> will behave as if "--basic-regexp" was provided, and not as
> "--extended-regexp". In a subsequent commit we'll need to treat
> "grep.patternType=3Ddefault" as a special-case, but let's make sure we
> ignore it if it's being set to "default" following an earlier
> non-"default" "grep.patternType" setting.
>
> Let's also test what happens when we have a sequence of "extended"
> followed by "default" and "fixed". In that case the "fixed" should
> prevail.

The grep.patternType configuration variable has the "last one wins"
semantics just all the usual configuration variable, but the meaning
of the variable when it is set to "default" depends on the value set
to grep.extendedRegexp variable.

If you rewrite with the above understanding, what you wrote will
become a lot more concise.

    Extend the grep tests to assert that grep.patternType is the
    usual "last one wins" variable, and specifically, setting it to
    "default" has the same meaning as setting it to "basic" when
    grep.extendedRegexp is not set (or set to false).

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t7810-grep.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 6b6423a07c3..113902c3bda 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -451,6 +451,25 @@ do
>  		test_cmp expected actual
>  	'
> =20
> +	test_expect_success "grep $L with grep.patternType=3Dextended and gre=
p.patternType=3Ddefault" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.patternType=3Dextended \
> +			-c grep.patternType=3Ddefault \
> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.patternType=3D[extended -> def=
ault -> fixed]" '
> +		echo "${HC}ab:a+b*c" >expected &&
> +		git \
> +			-c grep.patternType=3Dextended \
> +			-c grep.patternType=3Ddefault \
> +			-c grep.patternType=3Dfixed \
> +			grep "a+b*c" $H ab >actual &&

And from that point of view, I think the second new test has much
less value than a possible alternative to ensure grep.patternType
set to fixed and then default behaves like setting it to extended
when grep.extendedRegexp is set to true.  As written, this is just
testing that the variable we designed and know to be "last one wins"
behaves as one once more.

> +		test_cmp expected actual
> +	'
> +
>  	test_expect_success "grep $L with grep.patternType=3Dextended and gre=
p.extendedRegexp=3Dfalse" '
>  		echo "${HC}ab:abc" >expected &&
>  		git \
