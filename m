Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D33C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0E2208DB
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 19:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RwHUDDDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHTT6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:58:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50075 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTT6W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 15:58:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98904D81EA;
        Thu, 20 Aug 2020 15:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0QEpABejA969
        Z9dyiIgVtYHH59U=; b=RwHUDDDdW2EitNHm1m8y4sVc8vtS6H29ni3U2/SiUcR6
        VvdDAcMTLvNthiYooxaCt9/c5FU2GV5rlRPcGq76nYfsZ2zt5z2dGwIP/TTLSPoj
        xLzGIZTDWs6fF5+BiNxD+UrDMG5rTep2CAIRJLA433bWEO8mlBUxpZrd7Z/6Ehc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=w/Bq+t
        y7aQ7dbfKgaT8WkfpAQnifMX5xCerdNvjE4tZNA6hOr8XoAN3BvymxIrzWBaLIz7
        EI/BKYdE1lSVIsMOcMwFY8pVJSmyQxyYH7xSmSZO5XKHgPQNpPO92Nvt83SuAvHW
        lZXjXYf3A+HsDDLfM/wOOJ6LtBBfb/tafb37I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F69DD81E9;
        Thu, 20 Aug 2020 15:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C9F1D81E8;
        Thu, 20 Aug 2020 15:58:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] diff: index-line: respect --abbrev in object's name
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597926783.git.congdanhqx@gmail.com>
        <3cec490500ebb7037fe13fd70bbbb43d035a65f5.1597926783.git.congdanhqx@gmail.com>
Date:   Thu, 20 Aug 2020 12:58:12 -0700
In-Reply-To: <3cec490500ebb7037fe13fd70bbbb43d035a65f5.1597926783.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 20 Aug
 2020 19:35:35 +0700")
Message-ID: <xmqqmu2pay3v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BA1F94A-E31F-11EA-B5A1-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> A handful of Git's commands respect `--abbrev' for customizing length
> of abbreviation of object names.
>
> For diff-family, Git supports 2 different options for 2 different
> purposes, `--full-index' for showing diff-patch object's name in full,
> and `--abbrev' to customize the length of object names in diff-raw and
> diff-tree header lines, without any options to customise the length of
> object names in diff-patch format. When working with diff-patch format,
> we only have two options, either full index, or default abbrev length.

Correct.


> Although, that consistent is documented, it doesn't stop users from

I am not sure what you meant by the word "consistent" here.
Dropping the word altogether makes the sentence work just fine, but
it may not be what you wanted to say, so I dunno.

> trying to use `--abbrev' with the hope of customising diff-patch's
> objects' name's abbreviation.

OK.

> Let's resolve that inconsistency.

I am not sure if this should even be called "inconsistency".  We
have two things to control, (1) length of abbreviated object names
in the "raw" output and (2) length of abbreviated object names on
the "index" line, and they can be independently controlled with
different options.  What this patch does is, as the first paragraph
explained, the latter does not take an arbitrary length as end users
may expect.

	Let's allow the blob object names shown on the "index" line
	to be abbreviated to arbitrary length given via the "--abbrev"
	option.

perhaps?

> To preserve backward compatibility with old script that specify both
> `--full-index' and `--abbrev', always shows full object id
> if `--full-index' is specified.

s/shows/show/ but otherwise good.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index b7af973d9c..1bb897d665 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -446,10 +446,11 @@ endif::git-format-patch[]
>  --abbrev[=3D<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
>  	name in diff-raw format output and diff-tree header
> -	lines, show only a partial prefix.  This is
> -	independent of the `--full-index` option above, which controls
> -	the diff-patch output format.  Non default number of
> -	digits can be specified with `--abbrev=3D<n>`.
> +	lines, show only a partial prefix.
> +	In diff-patch output format, `--full-index` takes higher
> +	precedent, i.e. if `--full-index` is specified, full blob

"precedence", I think.

> +	names will be shown regardless of `--abbrev`.
> +	Non default number of digits can be specified with `--abbrev=3D<n>`.
