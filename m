Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8EE1F609
	for <e@80x24.org>; Tue, 11 Jun 2019 19:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405684AbfFKTpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 15:45:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405627AbfFKTpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 15:45:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEFEC6886F;
        Tue, 11 Jun 2019 15:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PRJoA3FVQBDxX2AiWt1EFmhhmAw=; b=FNnNlc
        5bZ56JtFpCjkD7iCGO//iAA9ujvwi955f6AKQMwHxvOxmG91HwGsytpIB4ccBNRx
        9egCZnyWWKcnqvqIg8pQRurzj9pK73r2pX6L3sUkP3YEgEqV8yfcwQnqJNV37Rqv
        m035Pxu4SA49qzKKgR10OdQjt+BTWrFNutcqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YBaPPMHf60nSw3K73+4j4gDAN9i+02rJ
        afhBU9/nZYbljcNrZwPUT0S8pNWdDa5lKItozA63ey5H8DbKDxCssV21qR7gQITp
        fcy4EljixSjeeX946Ow/xlIerlg0q+iszhW3gd3G7AHcP8bVqPrX3kxjfqg0f8MP
        ZsF3scL0po0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C476B6886E;
        Tue, 11 Jun 2019 15:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0C046886D;
        Tue, 11 Jun 2019 15:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 08/14] commit-graph: add --split option to builtin
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <c42e683ef644e7d34614eb74156e5a2b31392758.1559830527.git.gitgitgadget@gmail.com>
        <xmqqwohxnjmu.fsf@gitster-ct.c.googlers.com>
        <2dd1552f-72a3-c676-f46c-1393717ffd82@gmail.com>
Date:   Tue, 11 Jun 2019 12:45:17 -0700
In-Reply-To: <2dd1552f-72a3-c676-f46c-1393717ffd82@gmail.com> (Derrick
        Stolee's message of "Tue, 11 Jun 2019 08:51:50 -0400")
Message-ID: <xmqqk1drlxde.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71D60212-8C81-11E9-809C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I think the more correct thing to say is that `--split` implies `--append`:
> As we write a new tip graph, we do not discard any commits from the lower
> layers, even if we merge them together.
> ...
> There is nothing that stops them both from being specified, so this
> usage describes a strictness that is not enforced. I can change this
> to be "[--append] [--split]" if that is preferred.

Given that specifying both at the same time does not make much
sense, I do not think it makes sense more than "[--append|--split]".

Between erroring out when both are given and following the usual
"the last one wins" pattern, I am slightly in favor of the latter.

Thanks.
