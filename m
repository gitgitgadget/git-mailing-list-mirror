Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A84420A26
	for <e@80x24.org>; Fri, 22 Sep 2017 04:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdIVEUs (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:20:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751368AbdIVEUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:20:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6649A7D47;
        Fri, 22 Sep 2017 00:20:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XwjRCy8TW3bioYicersspbKs7pE=; b=sPLzPS
        T3lscfIFGeTR82JmCNEM9C2ETspwbZJpjaoN41O3ot/6GGsW3YqYiBmRTxW+gU43
        Tpt132HrbbFRheIFnQZ4onB0mic8s0iyDMDzR2vC3JIL3m8C161FkXCOlCcSZ2pj
        kcID+2+Q9KJfIO6gzJbW2+7JrZeMWNn+Pv41Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iYMoYCQaAvTNrU1jsBdJH3EpQI5WkLqx
        D5q+k9LaH1AFxhSer7G14uVC4Cxtv6cEC/Z4gZfj2CgWKFR8GcG9nf+69Jh+q6Gw
        aIxOUv4NUa07uBDjOUlah1+pq1GjjxQ9gZUv35MqaVKZQjsHtCaeTp2lmsbm6qtU
        TTPNWYGFhgI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7A36A7D46;
        Fri, 22 Sep 2017 00:20:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12B3FA7D45;
        Fri, 22 Sep 2017 00:20:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] ALLOC_GROW: avoid -Wsign-compare warnings
References: <c97784ce-d85d-2b7a-4eb7-d4043dc1a0b7@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 13:20:44 +0900
In-Reply-To: <c97784ce-d85d-2b7a-4eb7-d4043dc1a0b7@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 21 Sep 2017 17:49:38 +0100")
Message-ID: <xmqqd16jl5yb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67CDB1F2-9F4D-11E7-B7D8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/pack-objects.c |  4 ++--
>  config.c               |  2 +-
>  diff.c                 |  2 +-
>  line-log.c             | 18 +++++++++---------
>  line-log.h             |  2 +-
>  revision.c             |  2 +-
>  tree-walk.c            |  3 +--
>  7 files changed, 16 insertions(+), 17 deletions(-)

Thanks.  

I did not spot any questionable conversion (e.g. "something that
used to be signed was because it wanted to store -1 as a sentinel"
would be broken if we just change that to unsigned) by going over
the places these variables and fields are actually used.

A review of a patch like this involves reading through 10x more
lines than we see in the above diffstat, and producing it would most
likely have taken the same amount of effort, at least.  Very much
appreciated.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a57b4f058..a6ee653bf 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2563,8 +2563,8 @@ struct in_pack_object {
>  };
>  
>  struct in_pack {
> -	int alloc;
> -	int nr;
> +	unsigned int alloc;
> +	unsigned int  nr;

This is a bit questionable ;-) but it is something I can locally
tweak easily.

