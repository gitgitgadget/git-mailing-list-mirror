Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D7220281
	for <e@80x24.org>; Sun, 24 Sep 2017 03:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdIXDwq (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 23:52:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63770 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751578AbdIXDwp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 23:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1847A3C26;
        Sat, 23 Sep 2017 23:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JKEM9TQ0ARyFIeVSh1KFOS3mZ1A=; b=mXgvIc
        O5EYEa/8OC6gBBN+wvqL+E3VaK1wg3HQnQ2D7XXMQXTMQYOhVjklZfhX4ZG4ZJEq
        AAftnRTzcWJR2IfhJgzoIrSfHfL3JBowgGBZGpTYPMepDAN3BpKFz9WKoxsqTl/P
        regmTF9RzCfpCtZnlOwzYkn6OX1SD452CA6Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MeVpRDAIuXU8ux47DhU7VOgy8+FJftpa
        lReSth+/ZvV9gVSwDoUBGcCuGC6hZ445ABRbVX9QTDNV01KlxebLgA+fdt5bJuAP
        Vi1Hk1Pd0hwOhEcRZgJDqLYC1ZSDlMUyQPb+agla8JOmrNtRf4mz6l8dgcin71gF
        t+U/gZk8gnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7D74A3C25;
        Sat, 23 Sep 2017 23:52:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C3F8A3C24;
        Sat, 23 Sep 2017 23:52:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        David Turner <David.Turner@twosigma.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
References: <20170922163548.11288-2-benpeart@microsoft.com>
        <20170922233707.25414-1-martin.agren@gmail.com>
        <MWHPR21MB047887A575D5DFFB213092A1F4640@MWHPR21MB0478.namprd21.prod.outlook.com>
Date:   Sun, 24 Sep 2017 12:52:42 +0900
In-Reply-To: <MWHPR21MB047887A575D5DFFB213092A1F4640@MWHPR21MB0478.namprd21.prod.outlook.com>
        (Ben Peart's message of "Sat, 23 Sep 2017 23:31:50 +0000")
Message-ID: <xmqqshfchhx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2240940-A0DB-11E7-86AE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>> @@ -183,8 +183,8 @@ static inline uint32_t get_be32(const void *ptr)  static
>> inline uint64_t get_be64(const void *ptr)  {
>>  	const unsigned char *p = ptr;
>> -	return	(uint64_t)get_be32(p[0]) << 32 |
>> -		(uint64_t)get_be32(p[4]) <<  0;
>> +	return	(uint64_t)get_be32(p + 0) << 32 |
>> +		(uint64_t)get_be32(p + 4) <<  0;
>
> This is surprising.  Every other function in the file uses the p[x] syntax.  Just for
> consistency, is there a way to stick to that syntax but still make it work correctly?
> Is there a typecast that can make it work?

I'll do "get_be32(&p[0])" etc. while queueing for now.

Thanks, both of you.
