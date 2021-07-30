Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B198C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5261060EE2
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhG3QSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:18:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56133 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhG3QSd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:18:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6551714E5D7;
        Fri, 30 Jul 2021 12:18:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fKsbKCXBHnQI
        KL5ai8C3XvSTIYQXWhexcgarJjJ8axI=; b=mIoSxfn+yhyj4MI8kUP1h6fFkuqQ
        /ePGqlhAvXZcortMSWLs6VuLLqHSmrDq/x5nRV3b1HUBIVEiy28uY3hTl3IIp1lX
        ZCrpwOg5U5wIC9NLvzBdmy562aoLTGabG4uqRW8FpWtJYjxqcv1dwuKcNcHD8pbR
        z/baRSrwJvNE6mE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CDC814E5D6;
        Fri, 30 Jul 2021 12:18:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9605214E5D3;
        Fri, 30 Jul 2021 12:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 4/7] http: drop support for curl < 7.19.3 and <=
 7.16.4 (or <7.17.0) (again)
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <patch-v3-4.7-230b968382f-20210730T092843Z-avarab@gmail.com>
Date:   Fri, 30 Jul 2021 09:18:15 -0700
In-Reply-To: <patch-v3-4.7-230b968382f-20210730T092843Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Jul
 2021 11:31:56
        +0200")
Message-ID: <xmqq8s1n3hdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BFBB9F82-F151-11EB-9A84-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the conditional use of CURLAUTH_DIGEST_IE and
> CURLOPT_USE_SSL. These two have been split from earlier simpler checks
> against LIBCURL_VERSION_NUM for ease of review.
>
> The CURLAUTH_DIGEST_IE flag was added in 7.19.3[1], and
> CURLOPT_USE_SSL in 7.16.4[2] or 7.17.0[3], depending on the source. As
> noted in [2] it was then renamed around that time from the older
> CURLOPT_FTP_SSL.
>
> 1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
> 2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
> 3. https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-ver=
sions

I still think "depending on the source" is wronge.  Let's read #2
(whose copy we also have in our comment) again:

    This option was known as CURLOPT_FTP_SSL up to 7.16.4, and the
    constants were known as CURLFTPSSL_*

A program that uses the CURLOPT_USE_SSL symbol would have failed to
compile with 7.16.4, as that version and older ones, even they had
the feature itself, did not use CUROPT_USE_SSL to invoke the
feature.  That is how I read the above sentence.

Perhaps everything after the first paragraph can be like this instead?

    The CURLAUTH_DIGEST_IE flag was added in 7.19.3 and
    CURLOPT_USE_SSL in 7.17.0.
    (cf. https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in=
-versions)

The patch text looks good to me.

Thanks.
