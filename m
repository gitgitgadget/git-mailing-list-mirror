Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1D620899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdHNWZq (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:25:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752408AbdHNWZp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:25:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F03869118B;
        Mon, 14 Aug 2017 18:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OZU2K4JBWbeN6PwD0N+sRAeB+kg=; b=LeXKJZ
        pZNd6ujZFVkAy/UCiCP8mmooMKkvmqX/k1SemM3NMYUa2oNnZEU30BdUdbVDCJh/
        NtwYOdpGEO/qWRnUyj+gWO2DN76Sf6Z+WsLSaN1LnUHRd5J4ySmJ2m3L3vwNnAb0
        mgS5ya4qDXJfhk/0WbzoptpI4TmoeuZ/YwpMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BKBz0A6mMx22cC8fxrypR/9kCsb3wvwg
        y0M/k7A4wkw6dZrksWvPUXIPm0Lso+F1rF7WKkGJoaVTz5SPi9QjJ4+zzwF140Cn
        CKe8t05fEVnuDd47QZkRaI+z0PYfoxx4pHWxQ/8t6QkQAZjLv4nIyo228nKUNjuy
        9h4yJnGUdZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8CE29118A;
        Mon, 14 Aug 2017 18:25:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DEA691188;
        Mon, 14 Aug 2017 18:25:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peff@peff.net, peartben@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
References: <20170808012554.186051-1-bmwill@google.com>
        <20170814213046.107576-1-bmwill@google.com>
        <20170814213046.107576-3-bmwill@google.com>
Date:   Mon, 14 Aug 2017 15:25:43 -0700
In-Reply-To: <20170814213046.107576-3-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 Aug 2017 14:30:46 -0700")
Message-ID: <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83451D34-813F-11E7-8E34-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add the 'style' build rule which will run git-clang-format on the diff
> between HEAD and the current worktree.  The result is a diff of
> suggested changes.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ba4359ef8..acfd096b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2414,6 +2414,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> +.PHONY: style
> +style:
> +	git clang-format --style file --diff --extensions c,h

Did we get "git clang-format" subcommand, or is "s/git //" implied
somewhere?

> +
>  check: common-cmds.h
>  	@if sparse; \
>  	then \
