Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF28820229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbcKATNm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:13:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62632 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbcKATNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:13:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77E124BF5B;
        Tue,  1 Nov 2016 15:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qeSJjCFYTHTZFuVu/ZXFvJeMSEY=; b=HN2UNw
        dI3R0cwfEfxoqPDOm99g1bLKYMzgEAz5CFiesf8zF3IMHeLjMmV9y08UgevDr30B
        rwgG4b4dTHs9UPe1JQsHXxakEhw6Hzuthchuq7rAi3Cai2nA//IpbsSljp8IhAjD
        v1yL2+y0TgujtBncLD/R8AKcqjc/GsLKNpi68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rX4nveOnM2dMV1wdd4RpdkcCh72UHvNY
        Z+444XqTfOJorexkCWwI5prYl1hWQXb5axyobuAtuQfdIlAYI/zVgMj1xe8h+/nS
        dJu1MDmLlDc9XIlFzfTI+Ap3F2lKjR5WM+Hxq3oo/Jcs+Af6CF5/wR2bacXrk+mt
        2Al/yeKqy4g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EF424BF5A;
        Tue,  1 Nov 2016 15:13:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4DE64BF59;
        Tue,  1 Nov 2016 15:13:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 09/19] config: add git_config_get_max_percent_split_change()
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-10-chriscool@tuxfamily.org>
        <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
Date:   Tue, 01 Nov 2016 12:13:38 -0700
In-Reply-To: <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Oct 2016 17:06:05 +0700")
Message-ID: <xmqqh97rovx9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C056B6C-A067-11E6-AB10-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> This new function will be used in a following commit to get the
>> +int git_config_get_max_percent_split_change(void)
>> +{
>> +       int val = -1;
>> +
>> +       if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
>> +               if (0 <= val && val <= 100)
>> +                       return val;
>> +
>> +               error("splitindex.maxpercentchange value '%d' "
>
> We should keep camelCase form for easy reading. And wrap this string with _().
>
>> +                     "should be between 0 and 100", val);
>
> I wonder if anybody would try to put 12.3 here and confused by the
> error message, because 0 <= 12.3 <= 100, but it's not an integer..
> Ah.. never mind, die_bad_number() would be called first in this case
> with a loud and clear complaint.

OK.

>
>> +               return -1;

Perhaps do the usual

	return error(_("..."));

here?

>> +       }
>> +
>> +       return -1; /* default value */
