Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE621F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfG3Uj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:39:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50217 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfG3Ujz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:39:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1898760AF;
        Tue, 30 Jul 2019 16:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IqmDnbXeCA8T
        +ZqBLzF5SCcYoqM=; b=eDNEpL4th3g2Utt6v8HCd5L6HL/i2Fe1wlsxQX2GcW2S
        HrEIGDTTIoHX7BJmig04tDnCjN+f/CNA/R4j8K75r9sxktGs09TnPi11i8e7abg1
        FOLFpNDFygZQv/tgwhGrSA3L4NSykcJPZ7xR6B9x3gCDFcDJplyx4eSBxfEVzaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tJoFEO
        4A6VNuuXACuhVHYkJA9oVxCaqafuJI7wRzFJOZASRE2ir+fg8XwyeuntsknWmZKt
        UbSe29CEXxiknvVr0yLN7FTkAdyrSxMlg//BS74XfpwkCZ77gCuxmMKjBbUyHTOM
        w5TR1UHOzvxDdVshEPeckGz4JhWTsZMEy+BH0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A97D0760AD;
        Tue, 30 Jul 2019 16:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C597B760AA;
        Tue, 30 Jul 2019 16:39:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
        <20190730194938.GZ4545@pobox.com>
        <20190730200203.GA4882@sigill.intra.peff.net>
Date:   Tue, 30 Jul 2019 13:39:48 -0700
In-Reply-To: <20190730200203.GA4882@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Jul 2019 16:02:03 -0400")
Message-ID: <xmqqpnlrs1d7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2DA3F9FA-B30A-11E9-A3CB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> @@ -116,19 +116,11 @@ unsigned int memihash_cont(unsigned int hash_seed=
, const void *buf, size_t len);
>   * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash c=
ode
>   * for use in hash tables. Cryptographic hashes are supposed to have
>   * uniform distribution, so in contrast to `memhash()`, this just copi=
es
> - * the first `sizeof(int)` bytes without shuffling any bits. Note that
> - * the results will be different on big-endian and little-endian
> - * platforms, so they should not be stored or transferred over the net=
.

;-)

> + * the first `sizeof(int)` bytes without shuffling any bits.
>   */
>  static inline unsigned int oidhash(const struct object_id *oid)
>  {
> -	/*
> -	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
> -	 * platforms that don't support unaligned reads.
> -	 */
> -	unsigned int hash;
> -	memcpy(&hash, oid->hash, sizeof(hash));
> -	return hash;
> +	return get_be32(oid->hash);
>  }
> =20
>  /*
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> index bbe719e950..6656db9d69 100755
> --- a/t/t0016-oidmap.sh
> +++ b/t/t0016-oidmap.sh
> @@ -93,9 +93,9 @@ put three 3
>  iterate" "NULL
>  NULL
>  NULL
> +$(git rev-parse three) 3
>  $(git rev-parse two) 2
> -$(git rev-parse one) 1
> -$(git rev-parse three) 3"
> +$(git rev-parse one) 1"
> =20
>  '
>
> which not only fixes this test but any other hash-based oddities. I
> wonder if it's appreciably less efficient. I'll bet I could nerd-snipe
> Ren=C3=A9 into doing a bunch of measurements and explorations of the
> disassembled code. ;)

I'd rather see us go in the direction of discouraging people from
relying on the hash order.
