Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0841F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 01:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfJPBVn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 21:21:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64994 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfJPBVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 21:21:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 851BC33D2E;
        Tue, 15 Oct 2019 21:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=il7kJI/O3Kz6UZskr6H5dKBWs0k=; b=YDsbZA
        1LckFxCLFVHJO2CgbFqQCHbJhW9bhu0FlOjn2Nw+80YR44xWFrI7Fj//hbrYLp61
        DelPMTedkHNVzI6+3yjK105x/eB2qMQphAD5Ua/rYXwPxVuT638fTua+f6oiIaOb
        gAtlB8xdwVy7iCG7FTxIu6yr1Ftb4CFyWNG1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dk2XvmVWjBcrs1Zy1wpveKAWH3W3uFMv
        Ks/jfBEOc9nlx6dGkF839IbeDQjIRiImNwkbo0VFoa5PMd2suYgrjPvBoPQY7D7E
        X5nNhYZxOAz9Ds3yZ7FmbNmLKYvLp1oRzsr7AATn6yDmMqSV43+Tm37qnZqIpD99
        4XCUYr+82/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DE1933D2D;
        Tue, 15 Oct 2019 21:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E017233D29;
        Tue, 15 Oct 2019 21:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
        <20191015015052.GA19636@dcvr>
        <xmqqzhi2bsp8.fsf@gitster-ct.c.googlers.com>
        <20191015071126.GA908@dcvr>
        <fdea4b03-3810-1317-7fe3-5100482f7b34@gmail.com>
Date:   Wed, 16 Oct 2019 10:21:40 +0900
In-Reply-To: <fdea4b03-3810-1317-7fe3-5100482f7b34@gmail.com> (Derrick
        Stolee's message of "Tue, 15 Oct 2019 08:54:58 -0400")
Message-ID: <xmqqd0exbi3f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F41B53A-EFB3-11E9-B6F6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/15/2019 3:11 AM, Eric Wong wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Wong <e@80x24.org> writes:
>>>
>>>> I just took a brief look, but that appears to leak memory.
>>>>
>>>> "hashmap_free(var, 1)" should be replaced with
>>>> "hashmap_free_entries(var, struct foo, member)"
>>>>
>>>> Only "hashmap_free(var, 0)" can become "hashmap_free(var)"
>>>
>>> I deliberately avoided merge-time band-aid fixups on this topic and
>>> ew/hashmap exactly because I was sure that I'd introduce a similar
>>> bugs by doing so myself.  Using evil merges can be a great way to
>>> help multiple topics polished independently at the same time, but
>>> when overused, can hide this kind of gotchas quite easily.
>>>
>>> A reroll on top of ew/hashmap would be desirable, now that topic is
>>> ready for 'master'.
>> 
>> Just to be clear, that reroll should come from Stolee (+Cc-ed), right?
>> I'll be around to help answer questions, but also pretty busy
>> with other stuff and I think Stolee knows this API pretty well :>
>
> I'm working on the re-roll, yes. I was waiting for ew/hashmap to merge
> with history that included ds/include-exclude. Now the current 'master'
> has both, so I can rebase and check everything carefully. v4 should
> have every commit compile with the new hashmap API.

Thanks, both.
