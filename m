Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D0C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8357860EE9
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 22:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhKEWt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 18:49:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52974 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhKEWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 18:49:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DAFEF86BB;
        Fri,  5 Nov 2021 18:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hm+xcK35a1Mo
        wc6nrlDQfoP5UL53qPkJkwOrO/9wK2E=; b=VyMG+uur07MiW9CoXW28F6NZ4ekP
        SKcs+Nz3DeB5528BQ5xVUsTlgjpaeTZhRQEB9OHeG578qcb+wv+kWC0Ls/lvxQt7
        qphU5fAqVMTbuK/BHRcIlSZQbngvJsIG+3DliG2AYmL1/7DZ9PLC2584M6rZ7wWM
        Y49V54mBwgmFKDg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71E53F86BA;
        Fri,  5 Nov 2021 18:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D56F4F86B9;
        Fri,  5 Nov 2021 18:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 03/10] generate-cmdlist.sh: spawn fewer processes
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
        <patch-v3-03.10-737cca59d99-20211105T135058Z-avarab@gmail.com>
Date:   Fri, 05 Nov 2021 15:47:13 -0700
In-Reply-To: <patch-v3-03.10-737cca59d99-20211105T135058Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 5 Nov
 2021 15:08:01
        +0100")
Message-ID: <xmqq7ddmw77y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 524EBC14-3E8A-11EC-A407-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 5114f46680a..27367915611 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -11,15 +11,14 @@ command_list () {
> =20
>  get_categories () {
>  	tr ' ' '\012' |
> -	grep -v '^$' |
> -	sort |
> -	uniq
> +	LC_ALL=3DC sort -u
>  }
> =20
>  category_list () {
>  	command_list "$1" |
>  	cut -c 40- |
> -	get_categories
> +	get_categories |
> +	grep -v '^$'
>  }

It is funny that this changes "grep then sort" into "sort then
grep", which will be "corrected" in two steps down.  The series
seems a bit over-engineered and broken down too much, at least to
me, but let's not waste any more time on it by an extra reroll.

