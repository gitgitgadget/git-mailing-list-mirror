Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763EAC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6321D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BaW55xpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAWUxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:53:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58172 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWUxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 15:53:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB28EB5299;
        Thu, 23 Jan 2020 15:52:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xLvNv8qWXH/e
        iH7m13/1LjwcSxs=; b=BaW55xpzmHFbIYBJECoNXqtYDMBEEsUTZCzU5swSmkqj
        OTlm9LLySKbS4Y6Fd3lgXxofG6sXDOSET4hvbiPOOxds9kCvI8EdGM3C2eq8AdhI
        6DSR/SV5HBJbRpUpYSN00413aTvgRTgc+33d7Q0ua1357ktPQN5kkJ2qa8j6ckU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eRkKRt
        wwqyPC82TFDl6sakj1ilkkNKhSLAgSAuLw8pLtDxjn+jQjZYI0QpSF2IjF6QMpAr
        14j5mno4732N1abtKtx+cnkBusdJanHBwRFpwDVMbYj8WHG/HV9MkTCspPpIsCGV
        mzByJ38kAw0JDJtig2iBWDC3NQqwmFAS8v1pE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3119B5298;
        Thu, 23 Jan 2020 15:52:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D96C2B5297;
        Thu, 23 Jan 2020 15:52:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200123175645.GF6837@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 23 Jan 2020 18:56:45 +0100")
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <20200122235333.GA6837@szeder.dev>
        <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
        <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Importance: high
Date:   Thu, 23 Jan 2020 12:52:53 -0800
Message-ID: <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 54B2CB68-3E22-11EA-980A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Replacing that last patch of the series with the diff below works both
> on Linux and macOS and both on Travis CI and Azure Pipelines.
>...

Yang, care to do the honors to wrap it up with summary of the
decisions as a replacement patch for the last step?

Thanks all for helping to tie loose ends.

>  --- >8 ---
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a90d0dc0fd..c3a8cd2104 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -162,6 +162,9 @@ linux-clang|linux-gcc)
>  	if [ "$jobname" =3D linux-gcc ]
>  	then
>  		export CC=3Dgcc-8
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> +	else
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
>  	fi
> =20
>  	export GIT_TEST_HTTPD=3Dtrue
> @@ -182,6 +185,9 @@ osx-clang|osx-gcc)
>  	if [ "$jobname" =3D osx-gcc ]
>  	then
>  		export CC=3Dgcc-9
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> +	else
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
>  	fi
> =20
>  	# t9810 occasionally fails on Travis CI OS X
