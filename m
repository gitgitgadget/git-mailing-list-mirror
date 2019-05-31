Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117181F462
	for <e@80x24.org>; Fri, 31 May 2019 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaQON (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 12:14:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55397 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 12:14:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F2E713F8C1;
        Fri, 31 May 2019 12:14:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lA5jDMHLGeYkdOqYybRBMv3BeK8=; b=P6qDxo
        k/gNUnV547ZPSqCCl6NAd56yUSODabHXKgDBWwD2TMXSYDI30xw2cWIbPXYwTo4S
        2WtdtrOvhIyrbL2RUGYUzUVDMqSqrMq1WusNn81ov0f2YMRDwe+qQMh8bFvlOoym
        Q9KnaU6MI+PDCUePSWgSgtRLv+wuGCDXO/qFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E20CO5JqWVmzbb/QqcxexeToIQpSXG7F
        c3PFcheHkm+0Wrel30KtahnC5rFex9zHVRJaZ+BvVp9XvIWuAmXaXXZr63m+JPdj
        LJyANd7i7POgRygZql9ESquIXwi8lz+KlbcCXW6+hornYiDIcSLG77CJRHVlPGpG
        DjxWA1AVLAE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23D3B13F8BF;
        Fri, 31 May 2019 12:14:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DEBF13F8BE;
        Fri, 31 May 2019 12:14:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 04/16] promisor-remote: implement promisor_remote_get_direct()
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
        <20190409161116.30256-5-chriscool@tuxfamily.org>
        <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
        <nycvar.QRO.7.76.6.1905302235000.44@tvgsbejvaqbjf.bet>
        <2329a4c7-bfb9-10ce-9d1c-8c754d6dee05@gmail.com>
Date:   Fri, 31 May 2019 09:14:03 -0700
In-Reply-To: <2329a4c7-bfb9-10ce-9d1c-8c754d6dee05@gmail.com> (Derrick
        Stolee's message of "Thu, 30 May 2019 16:54:47 -0400")
Message-ID: <xmqqlfymwqic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C200F2C-83BF-11E9-B858-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> This global 'fetch_if_missing' swap seems very fragile. I'm guessing you
>>> are using it to prevent a loop when calling oid_object_info_extended()
>>> below. Can you instead pass a flag to the method that disables the
>>> fetch_if_missing behavior?
>>  ...
>> The flag is actually used only in `oid_object_info_extended()`, and that
>> function accepts an `unsigned flags`, so one might think that it could be
>> extended to accept also a `OBJECT_INFO_LOOKUP_FETCH_IF_MISSING`. But then,
>> there are many callers of that function, some of them also pretty low in
>> the food chain. For example, `oid_object_info()` (does not accept `flags`)
>> or `read_object()` (does not accept flags either).
>>
>> So it looks as if the idea to pass this flag down the call chain entailed
>> a pretty serious avalanche effect.
>
> It could be approached in small bits.
>
> First, add an OBJECT_INFO_NEVER_FETCH_IF_MISSING flag that overrides fetch_if_missing,
> and then use the flag in small places like this one. Then, build up to the other
> methods as appropriate.
>
>> An alternative that strikes me as inelegant, still, but nevertheless
>> better would be to move `fetch_if_missing` into `struct repository`.
>
> This is literally the _least_ we should do to reduce our dependence on
> globals. Maybe this happens first, then the flag idea could be done bits
> at a time.

The bit is not an attribute of a repository instance, and I agree it
is an ugly hack to take advantage of an unrelated fact that a repo
is getting passed throughout the codechain.  It is better than
nothing if we stop there and will not do anything more to the topic,
but in the longer term, it is not that better than a global, I am
afraid.  We may not be doing the save-flip-and-restore-the-bit dance
on the global anymore, but instead would be doing the same for the
field in the repository object, no?

In any case, thanks for taking a look at the topic; what it wants to
achieve is worthwhile, but its execution does look like it needs
quite a lot more polishing, which is helped by review comments like
these.


