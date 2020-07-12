Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7956CC433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4103C206F0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ek37z4wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgGLSKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:10:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLSKT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 14:10:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68D8AE3A95;
        Sun, 12 Jul 2020 14:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jf0K6uwiz0eF
        N+5D9rSOXlPdhHE=; b=ek37z4wWlKzMwZy+4p49vFt73uWisUNU0r3yKPm7nyTi
        Heqo9TS0NuWkj1qSDYm2o3shT/6gRWv69he6spT/WRcF6nN49zi2c8KShmPfdtdC
        VjSg9JGurl7N73bdiUkdx19Zs3K3Pgz0FSEylehuIrFzBnaZAZlYk5/Jh264Kag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KI+SPD
        cGHQCissFdpbFcUcp61w/aszyl8yRDNoK2apkGqE56aIUQ0iIlobj+Jkj4rJLp8l
        XSf2S3qrB2a1IGFeWny3RIqWfzayyvrvc5mhVvxCwTV/hkE81ibvI989EYrBBiKi
        6Rtqt71u0kLqS0WSbQRLr5q88A8K+BZZ7yahE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5468DE3A94;
        Sun, 12 Jul 2020 14:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D005E3A92;
        Sun, 12 Jul 2020 14:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH] bundle: improve message when unknown hash algorithm detected
References: <20200712165005.705979-1-sandals@crustytoothpaste.net>
Date:   Sun, 12 Jul 2020 11:10:11 -0700
In-Reply-To: <20200712165005.705979-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 12 Jul 2020 16:50:05 +0000")
Message-ID: <xmqqv9isppto.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE8BB96A-C46A-11EA-9662-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The current code states "unknown hash algorithm length".  This is
> slightly confusing, and moreover, we've gotten feedback that it's hard
> to translate into other languages.  Since the case is that we cannot
> detect the hash algorithm, let's just say that.  This is clearer and
> more direct, reflects the intent of the code (which calls the function
> detect_hash_algo just a few lines above), and will be easier to
> translate.
>
> Suggested-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Matthias contacted me privately about this message and I thought since
> we're still in the RC period, it would make sense to include this in to
> help translators and those who aren't native speakers.

Yup, and yuck.  Didn't we find any room in the bundle header to
sneak in the actual hash algorithm name in a backward compatible
way?  I am actually OK if we declared that v2 bundle files are SHA-1
only and v3 bundle file has an item in the bundle header to say what
hash algorithm is used, than using "ah this uses a hash algorithm
that produces a 32-byte output, so it must be algorithm X", to be
honest.

>  bundle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index 2a0d744d3f..69c807bda9 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -66,7 +66,7 @@ static int parse_bundle_header(int fd, struct bundle_=
header *header,
>  		if (!header->hash_algo) {
>  			header->hash_algo =3D detect_hash_algo(&buf);
>  			if (!header->hash_algo) {
> -				error(_("unknown hash algorithm length"));
> +				error(_("unable to detect hash algorithm"));
>  				status =3D -1;
>  				break;
>  			}
