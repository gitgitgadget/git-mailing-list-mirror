Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A7B20286
	for <e@80x24.org>; Thu, 14 Sep 2017 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdINCNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 22:13:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50655 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbdINCNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 22:13:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90F57B1060;
        Wed, 13 Sep 2017 22:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CMvYcF9EjSuqgBCn4a8ymnasQsc=; b=leR2Qz
        rfMkau8yJ8+Xbf8pRSTyXVrbEkNdu5iO2rS0NVd8qmso2aWSb4seZ6221sxuEXPm
        5D5z59UjNVL0IWqoP4gZRG1sywG44+4zRSwGZSA5mMSHFsAtjfUZoNaPTK/+E1OV
        WDiEgM0Db8WJujc8/lXeGmJ2W+AOY5ESlHVYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUe5+nbtXpPVTdVF+WnHVcabGssgfxjl
        GuAD78v4bawHNZ7fEEeshc5FCvHbJ720zMtYmLrmsd4T2UXrfI1JAnEzUNnkxI70
        hOQAnJZ+H8QO0Dn9C8PVjK9dMjGG3r058AeeOgAo7znA55sf6Vks1QzGx7l3S1K/
        x16q33e9GFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 868C7B105F;
        Wed, 13 Sep 2017 22:13:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4B74B105E;
        Wed, 13 Sep 2017 22:13:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
        <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
        <20170911185913.GA5869@google.com>
        <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
        <20170913163052.GA27425@aiede.mtv.corp.google.com>
        <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
        <20170913221854.GP27425@aiede.mtv.corp.google.com>
Date:   Thu, 14 Sep 2017 11:13:38 +0900
In-Reply-To: <20170913221854.GP27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 13 Sep 2017 15:18:54 -0700")
Message-ID: <xmqqpoauyqlp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52F729A4-98F2-11E7-8525-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, a long lifetime for the hash absolutely is a design
> goal.  Coping well with an unexpectedly short lifetime for the hash is
> also a design goal.
>
> If the hash function lasts 10 years then I am happy.

Absolutely.  When two functions have similar expected remaining life
and are equally widely supported, then faster is better than slower.
Otherwise our primary goal when picking the function from candidates
should be to optimize for its remaining life and wider availability.

Thanks.
