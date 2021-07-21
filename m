Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF116C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C031D60FF3
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhGUWhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:37:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59306 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhGUWhT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:37:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F32DF24B;
        Wed, 21 Jul 2021 19:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=COazY+hVM6Xz
        A4l4um1WfBmWgMWmAOwoLDts11scR9w=; b=unz2HyWmmU1bQqNioAYhh2WM4wdQ
        rVbfkPv2bYkW8XEJ8GAtnWujLDwNcm0XLuB6FXpOS2mcoHm+1LebXBAcn1TKhgxY
        pKXzpi1vmGPeE8/afNW9E8f6M7u/bE8Ug8sw7UsGfS/mJ3ZaDjPBq664hYxylZL6
        bJbltPy6J5f7hdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE8C4DF24A;
        Wed, 21 Jul 2021 19:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BBEDDF249;
        Wed, 21 Jul 2021 19:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] http: drop support for curl < 7.19.3 and <
 7.16.4 (again)
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <patch-4.5-9a30e92520c-20210721T220402Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 16:17:53 -0700
In-Reply-To: <patch-4.5-9a30e92520c-20210721T220402Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 00:22:15 +0200")
Message-ID: <xmqqbl6vb6ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E06B694E-EA79-11EB-9F4A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the conditional use of CURLAUTH_DIGEST_IE and
> CURLOPT_USE_SSL. These two have been split from earlier simpler checks
> against LIBCURL_VERSION_NUM for ease of review.
>
> The CURLAUTH_DIGEST_IE flag was added in n 7.19.3[1], and
> CURLOPT_USE_SSL in 7.16.4[2], as noted in [2] it was then renamed from
> the older CURLOPT_FTP_SSL.
>
> 1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
> 2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html

My go-to place for cURL version information is:

https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

and it says CURLOPT_USE_SSL has been available since 7.17.0.  If
7.16.4 was the last version in the 7.16.x series, then these two
sources are consistent.

[2] says that the feature was available under a different name in
the past and up to version 7.16.4, meaning with 7.16.4, USE_SSL was
not usable. You'd need to do "<=3D 7.16.4" on the title, but it is
simpler to follow the symbols-in-versions table and say "< 7.17.0",
I would think.

The patch text looks OK.
