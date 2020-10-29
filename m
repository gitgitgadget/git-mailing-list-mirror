Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32103C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECE22075E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dt+tU36a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJ2Xxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:53:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50295 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Xxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:53:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A658FCED4;
        Thu, 29 Oct 2020 19:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Psv8/F/2u5lmnW8/wUwSch0QxiI=; b=dt+tU3
        6aJJD8sCeP8Ovyv6coAVGN2iacFSMvYAumSD61+oJWCfLqZnJOsC+i8mA0fAk5C8
        XCxjUlGwydWOfA+LLbdksvRmC+suyX8tvkBPh/sXnKdSeQmeNg6izpcHgFDGJN/T
        qkgZKZOcKHVWxgZIPs7VWty33ZiMbWosesTlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h3NNRu6/WxwImhKZVDxD+sDqpm2xeaTT
        Uyitbb5LGG4WRDKD22qImjGHF/DMS+XBImmqt59Yyqeu5O6QZqmEoYwuCZJ7f/JU
        7tfNyCCXSZDPPfAbKRf4TF703xEFc+9sPmD9NMbyw3qCSKqfL/iA82x2OqUFNu4X
        Rb/kkDBTTNw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71F7BFCED3;
        Thu, 29 Oct 2020 19:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B79D7FCED0;
        Thu, 29 Oct 2020 19:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 04/19] convert: add conv_attrs classification
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <18c3f4247e717a7766f13b4b33a0bbe31aee6b69.1603937110.git.matheus.bernardino@usp.br>
Date:   Thu, 29 Oct 2020 16:53:48 -0700
In-Reply-To: <18c3f4247e717a7766f13b4b33a0bbe31aee6b69.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:41 -0300")
Message-ID: <xmqqpn5037xv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDC56F52-1A41-11EB-940F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create `enum conv_attrs_classification` to express the different ways
> that attributes are handled for a blob during checkout.
>
> This will be used in a later commit when deciding whether to add a file
> to the parallel or delayed queue during checkout. For now, we can also
> use it in get_stream_filter_ca() to simplify the function (as the
> classifying logic is the same).
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> [matheus.bernardino: use classification in get_stream_filter_ca()]
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  convert.c | 26 +++++++++++++++++++-------
>  convert.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 7 deletions(-)

Yup, having an actual user of the new layer of abstraction in the
same patch makes it more easily understandable.  If only the new
function and enum were presented without anybody using, it would
have been much harder to swallow, without visible and immediate
benefit.

Looking good.
