Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB783C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A4920739
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rzlh8RFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgJ2XvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:51:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53919 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2XvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:51:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8111996211;
        Thu, 29 Oct 2020 19:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/VeMZTY0+/bvhA4mvWE8Zo+MTWE=; b=rzlh8R
        FLNYeyLLbExPVB4gIrJi/RMQS0+hefTvTXD2fU1c7lVvLvKJz3d3DJMK1zlWe8C2
        bRIQXnavERGUkTLgMinCz9etCQvdFzNa91Csnu8PzU5wM4iFGHQx7lKMENWwTG/5
        HhB7k9qeDXmseFEzCsOK8/CJxjSNUHwyNp/yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OZhgze0jDsTB9rxHIHCtnG45Xk+hepyR
        IZK8WZbepxxTp18IodrTK3AEvXyxiU3uDMEaFzBbwW97wGZd73FCMBJ0O2DUn1y8
        bWw1RrunJk77ds+yzCzOAsb24lx4yWKX6QEhCoxCH3LatsntfwQ3gdvaorzvpKsj
        +ehzjwCyhMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C8DB96210;
        Thu, 29 Oct 2020 19:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B05299620E;
        Thu, 29 Oct 2020 19:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 03/19] convert: add get_stream_filter_ca() variant
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <c77b16f694cfe8076e66f604c0bbe053f58a2e9e.1603937110.git.matheus.bernardino@usp.br>
Date:   Thu, 29 Oct 2020 16:51:02 -0700
In-Reply-To: <c77b16f694cfe8076e66f604c0bbe053f58a2e9e.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:40 -0300")
Message-ID: <xmqqtuuc382h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AD43F68-1A41-11EB-8D8B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Like the previous patch, we will also need to call get_stream_filter()
> with a precomputed `struct conv_attrs`, when we add support for parallel
> checkout workers. So add the _ca() variant which takes the conversion
> attributes struct as a parameter.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> [matheus.bernardino: move header comment to ca() variant and reword msg]
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  convert.c | 28 +++++++++++++++++-----------
>  convert.h |  2 ++
>  2 files changed, 19 insertions(+), 11 deletions(-)

Same idea as 02/19, which is sound.

It makes readers wonder why this one is separate, while
convert_to_working_tree(), async_convert_to_working_tree(), and
renormalize_buffer() were done in a single patch in a single step,
though.


