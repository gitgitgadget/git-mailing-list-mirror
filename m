Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE8B1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 18:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfGQSNI (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 14:13:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60313 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 14:13:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC1A316BD00;
        Wed, 17 Jul 2019 14:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OOG1A7ukfaBJuhThLXXdZ3UVBZA=; b=Fa4xoS
        V9168efr+ZAZlxxB5AVjh7104QsUZ6Qd131eW31bdXxVP5INkZnBGy1x0o7Xhg+m
        QUtyK8OBlbouq6cI/cLphXOS5H1yRmhjUOVUzzKjy1ECvEf0lPr7V1xJ1SSn+poq
        Ic7JZwpYAYehjTwUHwtYyknd203++4avAm78w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T4ziG5DMqEREp4UozlwPpeDMBhe5ASi1
        83PFQ0Xu9Vgzjw3uXlLU5tIBX1OSIiJzWjpJ3M3qgjspKu0TjxneB8gMrCPh+mg2
        /34ONAE1Jl5wEjdJ7BbBkx8PrzJJfjl6y5FKgkmJaoqGkRCOrRDQP/c/sQxHhXN/
        1fGZ3pa6DRk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D21F816BCFF;
        Wed, 17 Jul 2019 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46AB816BCFC;
        Wed, 17 Jul 2019 14:13:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
        <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
        <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
        <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
        <20190714005129.GA4525@sigill.intra.peff.net>
        <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
        <20190715144602.GA26636@sigill.intra.peff.net>
        <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
        <20190715181527.GA30747@sigill.intra.peff.net>
        <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
        <20190716200101.GA6558@sigill.intra.peff.net>
Date:   Wed, 17 Jul 2019 11:13:04 -0700
In-Reply-To: <20190716200101.GA6558@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 16 Jul 2019 16:01:01 -0400")
Message-ID: <xmqq1ryo1qdr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85C56F7A-A8BE-11E9-B1E0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... My big question is if we use "{}" for gcc (and
> compatible friends), does that squelch all of the complaints from other
> compilers and tools that might see the "{0}" version? In particular,
> does it work for sparse?

Yeah, I agree that it is the most important question.  The best
solution is not to do the macro, use "= { 0 };" everywhere *and*
somehow arrange sparse not to complain about it.  I am not sure if
the last part is doable, though.
