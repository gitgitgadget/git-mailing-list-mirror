Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA138C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE21619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhC3Xyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:54:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57383 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3Xyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:54:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FBE9C1B7B;
        Tue, 30 Mar 2021 19:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XuBGSWjwr9xh
        cAork5N0W7onb9A=; b=QlkIuTEH926xfYTx0ImmIBb9b0sdM5EOsGtLLz9xSKTy
        mIkxkrpGsEZZJ3pvMV9No2E0rUloBHOISa3t8G+PhEOSipuH/xUUmPkmHE3rGKA+
        s+tslwGaHl49DIR4aYJWeIb1o9mXfJdwS5TVXiSkhrmAehFZa2tIKNeLWoHGNLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y+LbtI
        Xa967Y9mP3138gFLaNl4d/xVYm/Z5DcGcKkkyv+9+yYITksceueNJBcjEUY6Hu5T
        u/qWQYIbRxF7QjsxMmCuU/hwNATAqJ8r5SKHR2LoqBq600a+77b0PU/EAKLCSgFq
        4Eo5iY4W7vU7JH8St8HbgqzA6Q768ozIUHdIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27841C1B7A;
        Tue, 30 Mar 2021 19:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7333EC1B79;
        Tue, 30 Mar 2021 19:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 16/22] pickaxe -S: support content with NULs under
 --pickaxe-regex
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-17-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:54:36 -0700
In-Reply-To: <20210216115801.4773-17-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:55 +0100")
Message-ID: <xmqqim589ozn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 490167A8-91B3-11EB-905D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a bug in the matching routine powering -S<rx> --pickaxe-regex so
> that we won't abort early on content that has NULs in it.
>
> We've had a hard requirement on REG_STARTEND since 2f8952250a8 (regex:
> add regexec_buf() that can work on a non NUL-terminated string,
> 2016-09-21), but this sanity check dates back to d01d8c67828 (Support
> for pickaxe matching regular expressions, 2006-03-29).
>
> It wasn't needed anymore, and as the now-passing test shows, actively
> getting in our way.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  diffcore-pickaxe.c     | 4 ++--
>  t/t4209-log-pickaxe.sh | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index dd1b5c72332..0bf50a2f595 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -78,12 +78,12 @@ static unsigned int contains(mmfile_t *mf, regex_t =
*regexp, kwset_t kws)
>  		regmatch_t regmatch;
>  		int flags =3D 0;
> =20
> -		while (sz && *data &&
> +		while (sz &&
>  		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
>  			flags |=3D REG_NOTBOL;
>  			data +=3D regmatch.rm_eo;
>  			sz -=3D regmatch.rm_eo;
> -			if (sz && *data && regmatch.rm_so =3D=3D regmatch.rm_eo) {
> +			if (sz && regmatch.rm_so =3D=3D regmatch.rm_eo) {

OK.  As we always require start-end support, we do not need to stop
at NULs, and we shouldn't if we are dealing with a haystack with NUL
in it.  The needle may be behind that NUL.

Makes sense.

>  				data++;
>  				sz--;
>  			}
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 4b65b89e7a5..6ea1f02d142 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -201,4 +201,12 @@ test_expect_success 'log -S looks into binary file=
s' '
>  	test_cmp log full-log
>  '
> =20
> +test_expect_success 'log -S --pickaxe-regex looks into binary files' '
> +	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
> +	test_cmp log full-log &&
> +
> +	git -C GS-bin-txt log --pickaxe-regex -S[a] >log &&

Please quote this so that readers do not have to look around to see
if there _could_ have been a file with such a name that matches the
[glob] to cause the needle not passed literally to us.

> +	test_cmp log full-log
> +'
> +
>  test_done
