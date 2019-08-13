Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B76B1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfHMQlD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 12:41:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59302 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHMQlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 12:41:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D272115A1F3;
        Tue, 13 Aug 2019 12:41:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MaZzx88xqk3/0jEQyLzJhO04pVQ=; b=B+yWLo
        9HRyI0KKwX4VkZRIa0mq3E088hohxN2sBQL3QB7N8C2SFH19KTq0Al5xlFfuUHOG
        Ghf5a6Edwh1cp8+01wTxy7VxEKLndbNg6L8teFIyk1B1zi3AqDt0G3p+sZNpT+rN
        H9jAlMk4riiIvr0agqk6EyQ0+qqKvtW6ziti8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=phFWmZIDGlHiiK75WFDC5QLfkbsEBX9/
        xq1rHCImaH4648ZJ1rQrs3N0NMtPpcQvZ447OpZcPQ7BD5HqDsLSdezGNY3H4Czj
        gpqFbo4lA5nKKj09nS/YK5nibY3sKeL0HNWvUP/zwLlAcVAnhleo3EExXrgZbsmG
        LKHbmcY4wGw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B563615A1F2;
        Tue, 13 Aug 2019 12:41:00 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB4A915A1F1;
        Tue, 13 Aug 2019 12:40:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-2-sandals@crustytoothpaste.net>
        <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
        <20190812011054.GA9180@genre.crustytoothpaste.net>
        <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
        <20190812224021.GA229582@genre.crustytoothpaste.net>
Date:   Tue, 13 Aug 2019 09:40:58 -0700
In-Reply-To: <20190812224021.GA229582@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 12 Aug 2019 22:40:21 +0000")
Message-ID: <xmqq4l2l9fxh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2192B90A-BDE9-11E9-945A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Well, I split it out from a function that handles multiple path
> components, mostly so that I could leverage existing work (and not have
> to worry about getting it wrong). It wasn't explicitly intended that it
> support multiple components, since I don't require that for my
> implementation, but I could see future users taking advantage of that.
>
> I think "ends_with_path_components" might be the way forward, unless
> you think something else would be better.

Good; thanks.
