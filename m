Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5ABC20954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdKZDcQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:32:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56629 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751947AbdKZDcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:32:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 210FC9F562;
        Sat, 25 Nov 2017 22:32:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cI3Qu7hL4JYikIhZYqDQoCL8V/8=; b=pHwZoc
        PvCW8rHORrQmCXI3eniWJmEF8G+O4YcM8VrQolhuu3ndKF2A4R41KFyuBHf20gQh
        EC+IpFOWBqorJzogjX8mo1oa9FkKwxuRfRixONnAvUVE1U9vsQJRijM68WEtgUyj
        RG1O+K3HNqpRf7w/IUwq57aublgPqZim/wdPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SCaL76G4tM4Db7LkdfD78qpuQQ+hrPGZ
        KsA8b3btHRxgxPDVR0xJRFYedCgh3rYoDygbUyaxZIZ+0mIkcFkucdPEWpsEln8W
        6444v5PKbcYwOvVJlm1bD4JrYLqLwbPteNMbnKaEcEsQAJRxP9+iRjfMfOhKt240
        lynosSLFcas=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 170939F561;
        Sat, 25 Nov 2017 22:32:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7ABB59F55F;
        Sat, 25 Nov 2017 22:32:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
        <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
        <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
Date:   Sun, 26 Nov 2017 12:32:13 +0900
In-Reply-To: <20171122220627.GE2854@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 17:06:27 -0500")
Message-ID: <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65425E98-D25A-11E7-AF64-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What I was trying to get at is that naming it "status --no-lock-index"
> would not be the same thing (even though with the current implementation
> it would behave the same). IOW, can we improve the documentation of
> "status" to point to make it easier to discover this use case.

Yeah, the name is unfortunate. 

What the end user really wants to see, I suspect, is a "--read-only"
option that applies to any filesystem entity and to any command, in
the context of this thread, and also in the original discussion that
led to the introduction of that option.  

While I think the variable losing "index" from its name was a vast
improvement relative to "--no-lock-index", simply because it
expresses what we do a bit closer to "do not just do things without
modifying anything my repository", it did not go far enough.

