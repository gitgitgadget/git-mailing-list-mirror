Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9425D1F4BE
	for <e@80x24.org>; Thu,  3 Oct 2019 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJCW53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:57:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJCW53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:57:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F2AE263A0;
        Thu,  3 Oct 2019 18:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VxY1P022ucSSEIpvkCQYlyncwDI=; b=aQIrvp
        q/X1jWFsHZiu9yd2O/b3ueoimwRbP80Uq8OFHabYnuFC0x5nEruBnzFP6PvUtg4+
        kc/VmBaKE1YtYRsxUjgKEAv5JdVAF7rOnjMF4NKy+jNCmutP5W5NsCbIg/A34+dB
        +2pXDHzK03eRY+gnkKaMs7LDkAK03Ga6aPWzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wKddNgEcH0VkxPDvuBouIByq8Fe8UjXj
        m32AzGh7wg618BKIfZJ9aydYscN+jEK9KAEdSmbWkKq53x7wzj0UBQ2Pthr86lnx
        L/Z+e/VmmEY+J33siBuf1ybI5FwTSa1HHqcs4TBbWWdcIoPYps14rIfbmoa1G5Jr
        MKDZsG6Gu98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 754DA2639F;
        Thu,  3 Oct 2019 18:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2A172639E;
        Thu,  3 Oct 2019 18:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de,
        michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
References: <20190807213945.10464-1-carenas@gmail.com>
        <20190809030210.18353-1-carenas@gmail.com>
        <20190809030210.18353-3-carenas@gmail.com>
        <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
        <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
        <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910031007060.46@tvgsbejvaqbjf.bet>
        <CAPUEspiMOn8h0+WEkpe0CRgOQohKL-07TacM6CmiZBZh7GBCnw@mail.gmail.com>
Date:   Fri, 04 Oct 2019 07:57:25 +0900
In-Reply-To: <CAPUEspiMOn8h0+WEkpe0CRgOQohKL-07TacM6CmiZBZh7GBCnw@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 3 Oct 2019 04:17:42 -0700")
Message-ID: <xmqqlfu1a14a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B7B5A06-E631-11E9-884F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> or we could drop the current branch in pu and start again from scratch
> now that all of the required dependencies had been merged.

That would be the cleanest from my point of view.  Thanks, both.

