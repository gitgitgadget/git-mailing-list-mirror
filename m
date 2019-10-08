Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D8E1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 03:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfJHDx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 23:53:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfJHDxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 23:53:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 962442CF97;
        Mon,  7 Oct 2019 23:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g1fjGk3++ubpelhBfCHfL5BS+nY=; b=IaW6kF
        lz8q5B8zhYNWCs0758byXvB5wH3igyrairZqr7CuXG8Seio6BHNb/RYJGlwSCcnN
        EzW3cEgfH5oEqYNA8NzGbE7pZ8kQbOO77Q3RgWdQrvWHm0KwnDZp25L7XLMK6L0r
        BqaMegde3V6pKkt4p6uPCT6tk3XkGtt441rSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xcTciczLqx1GT9/HDKiLtJ2+w14AXt/J
        DERQGbEb6ZFROC/4SlHquU5U2jCRHnOUFLMDhrbqkts6DClROaLwYevEgfnDst0N
        ib1sHA6X99YITyekpRQD5WXswvgzs0dfKMt5wLrOnN1fpbQDtplTizGOLZdndGx8
        yb9rAsJ+Or8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D95D2CF96;
        Mon,  7 Oct 2019 23:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F39EB2CF95;
        Mon,  7 Oct 2019 23:53:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] add trace2 regions to fetch & push
References: <cover.1570059953.git.steadmon@google.com>
        <20191007214644.236055-1-jonathantanmy@google.com>
        <20191007223644.GA8397@google.com>
Date:   Tue, 08 Oct 2019 12:53:21 +0900
In-Reply-To: <20191007223644.GA8397@google.com> (Josh Steadmon's message of
        "Mon, 7 Oct 2019 15:36:44 -0700")
Message-ID: <xmqq4l0jopu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C9D8778-E97F-11E9-9DD7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2019.10.07 14:46, Jonathan Tan wrote:
>> > We'd like to collect better statistics about where the time is spent in
>> > fetches and pushes so that we can hopefully identify some areas for
>> > future optimization. So let's add some trace2 regions around some of the
>> > fetch/push phases so we can break down their timing.
>> 
>> Thanks.
>> 
>> Patch 1 looks good to me - different regions at the same level
>> (builtin/fetch.c, so it will be just for "git fetch") and one specific
>> one just for negotiation, which has to be in fetch-pack.c because only
>> that file operates at that level.
>> 
>> Patch 2 mostly looks good to me too - unlike fetch, a lot happens in
>> transport.c, so it's reasonable to put most of the regions there. One
>> comment: in transport_push(), should trace2_region_{enter,leave} take
>> "r" instead of "the_repository"?
>
> Ah yeah, thanks for the catch. Fixed in V2.

Yuck.  It's already in 'next', isn't it?

