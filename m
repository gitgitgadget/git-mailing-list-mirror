Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C882B208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdHJTnd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:43:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54253 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752792AbdHJTnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:43:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EE9393BC7;
        Thu, 10 Aug 2017 15:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ALlBn6YREOkY
        OkD/RRCPS+O93Do=; b=ed5Uwxhb8R6fL7ElmreD17jr2GXLDHXRjY09/SWUPfaK
        H+j51150YiDQl5D2zZfBw6Xn0SMLqw8yMIJ9gahUQJfhxtFLizijnD1lIJFJdmZj
        YgiZLRH7icS4yiEVe3IwBL/EFAwgjHdD52Vy/4xCIgJB2k5xbsJHLmrW9aw1y7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kjVDGs
        EHa2MbozVgMr2dX4C0ytsxbq5Nf2IEPPWVpdwaGnDokOLKutiXc3aAQYNz82dabM
        AgwOTxItLazC5lab+h3v6kY3nU0Fof+CLY2bhMSFO6uBxawkWcSJrYEb2xHHg+Tw
        P9p9nOQjBx4uvPsCwOhz25V2xJK3XsVUV7DTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17FBF93BC5;
        Thu, 10 Aug 2017 15:43:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76B4393BC4;
        Thu, 10 Aug 2017 15:43:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
        <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
        <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
        <CAGZ79kaNrqvqr3OVcwhxFEMoS2sK8wvfVE_pmxXTWYVB-OBDXQ@mail.gmail.com>
Date:   Thu, 10 Aug 2017 12:43:24 -0700
In-Reply-To: <CAGZ79kaNrqvqr3OVcwhxFEMoS2sK8wvfVE_pmxXTWYVB-OBDXQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 10 Aug 2017 11:35:48 -0700")
Message-ID: <xmqqr2wj2opv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CD1B37E-7E04-11E7-AEEE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Aug 10, 2017 at 11:03 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, Aug 10, 2017 at 04:02:46AM -0400, Jeff King wrote:
>>
>>> On Wed, Aug 09, 2017 at 08:21:47AM -0400, Jeff King wrote:
>>>
>>> > This series teaches interpret-trailers to parse and output just the
>>> > trailers. So now you can do:
>>> >
>>> >   $ git log --format=3D%B -1 8d44797cc91231cd44955279040dc4a1ee0a79=
7f |
>>> >     git interpret-trailers --parse
>>> >   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
>>> >   Helped-by: Stefan Beller <sbeller@google.com>
>>> >   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>> >   Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
>>>
>>> And here's a v2 that addresses all of the comments except one: Stefan
>>> suggested that --only-existing wasn't a great name. I agree, but I li=
ke
>>> everything else less.
>>
>> Here's a v3 that takes care of that (renaming it to --only-input).
>>
>> It's otherwise the same as v2, but since the name-change ripples throu=
gh
>> the remaining patches, I wanted to get v3 in front of people sooner
>> rather than later.
>>
>
> Looks good,

Yeah, looks good to me too.  Thanks for the "--only-input"
discussion.
