Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5741F462
	for <e@80x24.org>; Tue, 28 May 2019 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfE1R7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:59:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50516 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1R7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:59:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CC4014976F;
        Tue, 28 May 2019 13:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7xgilu9vJB7PV0gMUiXpszNpDU=; b=F/JIYR
        0TENrimSqaR78fxOcIyf7ToJ+nNwkhJujDo6SibxSbyjuJgNUe438DiZ8DCuQc6C
        Q+CuAvFE/i+SulcGC6q1vV534AMm54gXrMlVYpxj3wQDWsNBdX8TaZxsYY27gWR8
        Arl6pnE9/nAneNYjg2N3RV1s+b9+NGZwthRKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H+28fDj0tmuFaC4mz1UPMWhUebA30L7O
        PzApVnh6GNyKWYLkisGuLFuZTpyBdbI3s7HpqGBVYSUmUhgwdETYo6FTv/tuR/Qt
        VbNX1/04kCL8tmkHKJA41nouFO7/1ZmL4n6D3tCN6zLDqBikAYpuK7PgPP2N+IJC
        pjEA3YrB+SE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 018E314976E;
        Tue, 28 May 2019 13:59:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B5EA14976D;
        Tue, 28 May 2019 13:59:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        matvore@comcast.net
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
References: <cover.1558484115.git.matvore@google.com>
        <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
        <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
Date:   Tue, 28 May 2019 10:59:31 -0700
In-Reply-To: <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 24 May 2019 17:01:15 -0400")
Message-ID: <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 589E7A46-8172-11E9-AD1D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> In the RFC version, there was discussion [2] of the wire format
> and the need to be backwards compatible with existing servers and
> so use the "combine:" syntax so that we only have a single filter
> line on the wire.  Would it be better to have compliant servers
> advertise a "filters" (plural) capability in addition to the
> existing "filter" (singular) capability?  Then the client would
> know that it could send a series of filter lines using the existing
> syntax.  Likewise, if the "filters" capability was omitted, the
> client could error out without the extra round-trip.

All good ideas.
