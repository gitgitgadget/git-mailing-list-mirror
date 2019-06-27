Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F431F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF0SEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:04:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55332 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfF0SEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:04:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03B3C6A115;
        Thu, 27 Jun 2019 14:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YfH9OqLq0h4HC95hZvLmm5Z0GQg=; b=t/YQC+
        YN/vj3bUGzCzp5jh3k5g5JGNsszhiKOIDiRzq+54FWXtP8xULZgrWO3ETdcRrx4z
        9lVj2Mungphwdalg+YSDGZ0hcTUYPriV6E3rqKGnJuCCL+x0M1a9kAnULw39gYiy
        jpqHpoasecBKmirz2zSOwlVQpV6+/VBbdhIZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ljkznwOLHhi7Ku3Ttk4R295d3AUvm4eB
        OnggR4eN9ABGGqXCYpS6m3eTpCJWepNdkL/oLiFI9pvvPb2kxn3ms/Rjxy5Z5P2i
        ZfVMMw1JlVZko+2Q7TytMKxpV0/IIlZPo5EaNz0jZdif7XzHT9VlcUW91MxcLuwQ
        OgdE5CcM5aM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF4A96A114;
        Thu, 27 Jun 2019 14:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22DC76A112;
        Thu, 27 Jun 2019 14:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
References: <20190627052515.GA21207@sigill.intra.peff.net>
        <20190627055739.GA9322@sigill.intra.peff.net>
        <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com>
        <8736jv8bnc.fsf@evledraar.gmail.com>
        <CACsJy8AgmM0xYMMdYvpRSs4JRbNahcQyGcMMfPmaTS4Uv=Ok6A@mail.gmail.com>
Date:   Thu, 27 Jun 2019 11:04:17 -0700
In-Reply-To: <CACsJy8AgmM0xYMMdYvpRSs4JRbNahcQyGcMMfPmaTS4Uv=Ok6A@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 27 Jun 2019 19:32:53 +0700")
Message-ID: <xmqq4l4ac3by.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC7EADAC-9905-11E9-BDD0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> without
>> being caught, because msgfmt will catch this (and other common issues):
>>
>>     po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'
>
> Ok good. And with the downside of degraded performance, sure remove
> all the *printf_ln()

Sounds good.  Thanks.
