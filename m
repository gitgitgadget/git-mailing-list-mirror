Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614BA20281
	for <e@80x24.org>; Thu, 21 Sep 2017 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdIUBMv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:12:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53627 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751681AbdIUBMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:12:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EE7E92933;
        Wed, 20 Sep 2017 21:12:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TtTQFbOcEwLARoCQEFDZlyxqmng=; b=GY6PeM
        FydWDGVVdc01+gdvmxb6s2sCpiKANnNuxUEHAULFteLabPVHja0DUurFq5y5bDyu
        9INkVqaj32fbxbyUX9/qoOlAaru3upq8x5rsVpQcQc85oaz2ivXKEw2FoYLNogT3
        g5nGHlweNRlNSL61K5WyMi9IfS4XIspZWVh9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zxf/eBQO4xJVeOXvgdroEY2hysuOcgid
        WeseL4pkyoNV236kv9wO4jPghNJJjzE7wuxRrJFt6aZkE/Kr2Ig1yj17tNiV80Na
        5cA3PMX8xPBKQ+1Nh0jf2VY6bCDyhmNsFkyB8VGPY6nvhP0DL36y/Op17PjjlJG6
        UEELJVSpiAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 355D192932;
        Wed, 20 Sep 2017 21:12:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 824F892930;
        Wed, 20 Sep 2017 21:12:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <20170920023008.GB126984@aiede.mtv.corp.google.com>
        <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
        <20170920052705.GC126984@aiede.mtv.corp.google.com>
        <87vakd2v22.fsf@linux-m68k.org>
        <20170920173134.GZ27425@aiede.mtv.corp.google.com>
        <87lgl9rqbq.fsf@linux-m68k.org>
Date:   Thu, 21 Sep 2017 10:12:48 +0900
In-Reply-To: <87lgl9rqbq.fsf@linux-m68k.org> (Andreas Schwab's message of
        "Wed, 20 Sep 2017 23:51:53 +0200")
Message-ID: <xmqqtvzwn9bj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC163F30-9E69-11E7-809F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Sep 20 2017, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>> Andreas Schwab wrote:
>>> On Sep 19 2017, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>>>> B. #define for_each_string_list_item(item, list) \
>>>> 	if (list->items) \
>>>> 		for (item = ...; ...; ... )
>>>>
>>>>    This breaks a caller like
>>>> 	if (foo)
>>>> 		for_each_string_list_item(item, list)
>>>> 			...
>>>> 	else
>>>> 		...
>>>>
>>>>    making it a non-starter.
>>>
>>> That can be fixed with a dangling else.
>>
>> I believe the fix you're referring to is option C, from the same email
>> you are replying to.  If not, please correct me.
>
> A variant thereof, yes.

Now you make me curious.  How would that variant be different from
option C. in Jonathan's message?  Perhaps that different version may
be a solution to work around the potential issue mentioned in the
description of option C.?

