Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2291F454
	for <e@80x24.org>; Fri,  8 Nov 2019 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKHDDr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 22:03:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59619 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHDDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 22:03:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12E9D20E02;
        Thu,  7 Nov 2019 22:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTF/fsdd2GCcvaYySx1seuOBNZY=; b=JRe+gH
        /YS1MAfMhrZZFITMZzY/KuDRR/S8CEdphKK9TbJwVfLbuMmxRcr8eCIlb3nSTg3v
        VMmdzDUtdG9qhYuUFxsGQqY9w3tcvjS+GkTQWgiM8NPPXlCRzhcQoE6a9luMhw5W
        F2jzgGaWQy4oN6f11zrIuxpJRnIvFcSkew8xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GHZudpF7lNKu3dLC0jKupU9TWF6ixXBb
        ID158H2t4dk3wxWRRngjtlgfCJecgV5nHwKkrkVAaU4DpPw50dTZgk7dBO0ei9F3
        PSRsJE1O8be3vPIqAFAzzc86j+0Ho8pe0UYR04/Ai3vD2xLA4xmJEuQk1nY+ZrbI
        3WyVUOwqiMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA5320E01;
        Thu,  7 Nov 2019 22:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F92520E00;
        Thu,  7 Nov 2019 22:03:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
        <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
        <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911062031480.46@tvgsbejvaqbjf.bet>
        <xmqq1ruks0rz.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911071338320.46@tvgsbejvaqbjf.bet>
Date:   Fri, 08 Nov 2019 12:03:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911071338320.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Nov 2019 13:40:36 +0100 (CET)")
Message-ID: <xmqqy2wrnk6o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60132014-01D4-11EA-8597-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I would like to stick with "custom allocator" because even
> releasing the memory is the duty of an "allocator", even if that
> allocator happens to "deallocate" at that point what it has allocated
> before.

My preference is to think of the set of functions we feed
curl-global-init-mem as a (allocator, deallocator, reallocator, ...)
tuple.

But you are calling that set itself as an allocator that has service
functions like (alloc, free, realloc), and as long as that (i.e. how
you defined the word "allocator") is clear to the readers that is
perfectly OK.  

To me as one reader, it was not clear and that was where my comment
came from.
