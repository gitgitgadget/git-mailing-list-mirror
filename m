Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C51203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbcG0QNM (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:13:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754160AbcG0QNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 12:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CF4F2FA4E;
	Wed, 27 Jul 2016 12:13:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oY/0wMA3ZD4v
	51kZw/TD5hKQX3U=; b=i88wMI97F5B2RFSdBoBpFCmPYTj4weJUdhByTxAQDag8
	gAJ8GdF2X6sT0XAUlYL6cnkvUzb4jA2Xl4WA3mvOqRG+1ZW7LY2BHJ/8YYl9B4QG
	PPs/kYd2xlKAmRuIY8ku/mHfX76JY4mjLTqLM78xxf/e5eiWR5YwlG0/1bSiqIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BvyWRj
	gIDiJpgDrXjQ2vJBsJ8h0cZ1X0erwvXsb4i2F0FnHXSBWghg7NGrWP2/X2sqsq1k
	MNBnkf28uums5XNz6g4zsth8o2dCMrm2ef9yTBq3kORHZigMu33oeI7V2JcTdaHI
	Bd1mKqV4zRZiDzlP04VJU/gChdeyENcYZ3T5A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 637B72FA48;
	Wed, 27 Jul 2016 12:13:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6ECA2FA47;
	Wed, 27 Jul 2016 12:13:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
	<010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
	<7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
	<CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
	<xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
	<f6657922-555e-affa-8904-678bc7ee3f71@web.de>
	<xmqqmvl41f0x.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPP=AL6V+AitmVD6qnt7FvUJiX1wqrn5C2UjEKxAnnumew@mail.gmail.com>
Date:	Wed, 27 Jul 2016 09:13:06 -0700
In-Reply-To: <CAFZEwPP=AL6V+AitmVD6qnt7FvUJiX1wqrn5C2UjEKxAnnumew@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 27 Jul 2016 09:50:49 +0530")
Message-ID: <xmqqeg6fxdnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 022C975C-5415-11E6-AAB9-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Tue, Jul 26, 2016 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Torsten Bögershausen <tboegi@web.de> writes:
>>
>>> On 07/25/2016 06:53 PM, Junio C Hamano wrote:
>>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>>
>>>>>>> >>> +enum terms_defined {
>>>>>>> >>> +       TERM_BAD = 1,
>>>>>>> >>> +       TERM_GOOD = 2,
>>>>>>> >>> +       TERM_NEW = 4,
>>>>>>> >>> +       TERM_OLD = 8
>>>>>>> >>> +};
>>>>>>> >>> +
>>>>>> >> ...
>>> Is there any risk that a more generic term like "TERM_BAD" may collide
>>> with some other definition some day ?
>>>
>>> Would it make sense to call it GIT_BISECT_TERM_BAD, GBS_TERM_BAD,
>>> BIS_TERM_BAD or something more unique ?
>>
>> I am not sure if the scope of these symbols would ever escape
>> outside bisect-helper.c (and builtin/bisect.c eventually when we
>> retire git-bisect.sh), but BISECT_TERM_{GOOD,BAD,OLD,NEW} would not
>> be too bad.
>
> I agree that it wouldn't be too bad. This can be considered as low
> hanging fruit and picked up after the completion of the project as
> after the whole conversion, some re-ordering of code would need to be
> done.
> For eg. there is read_bisect_terms() is in bisect.c while
> get_terms() is in builtin/bisect--helper.c but they both do the same
> stuff except the later one uses strbuf and a lot more important stuff.

The criteria to decide if a known "room for improvement" can be left
as a "can be later touched up" is "would it be a long-term
maintenance burden if it is left unfixed?", and from that point of
view, I actually view the latter as a part of the necessary
"polishing in response to review comments" for the initial version
of a new topic to land in the official project's tree.

As to TERM vs BISECT_TERM, I do not think it matters that much as I
said (IOW, I do not think it would make it a maintenance burden if
we kept using TERM_{BAD,GOOD,NEW,OLD}).

