Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A422203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbcGZRcg (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:32:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751261AbcGZRcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 13:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A19C2ED03;
	Tue, 26 Jul 2016 13:32:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WCnpSN64h5aL
	JWXkhLB/6pEZqgw=; b=S5cJvT+r1BMaueYCbes9jLQ7MHe4z2db3R7crIWMewlv
	Th11DOIPgK9uzRqgSXr6b0GIgR/uJ4kMjY7CENEIkC7HKflNUjgYVYefoaluU0Xv
	ps8X+EFcaZjAhOxG2ErHK4j75f1/dSsMlbMAoExMe6ZS/2Rz3mnwG+KDaXaQrbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VkoQJ9
	ToDhspSE/ne6y7sIFr/utgCRF4rHQ1NYS0+UI2YpBC/CmRMKLoQGkTVCE/9Dlfrg
	C0ZBdDuwSqmjz2LGJQ4cNnHCv0KXAgVgSxnqa69rEiAUZlKIJFeWBLWWzYaBgZIL
	IptZi1kyE18btgOfkU4Q9SHyt4KAhUk/9NY0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92FB82ED02;
	Tue, 26 Jul 2016 13:32:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1312A2ED01;
	Tue, 26 Jul 2016 13:32:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
	<010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
	<7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
	<CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
	<xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
	<f6657922-555e-affa-8904-678bc7ee3f71@web.de>
Date:	Tue, 26 Jul 2016 10:32:30 -0700
In-Reply-To: <f6657922-555e-affa-8904-678bc7ee3f71@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 26 Jul 2016 03:42:52
 +0200")
Message-ID: <xmqqmvl41f0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF71B99E-5356-11E6-86D4-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On 07/25/2016 06:53 PM, Junio C Hamano wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>>>> >>> +enum terms_defined {
>>>>> >>> +       TERM_BAD = 1,
>>>>> >>> +       TERM_GOOD = 2,
>>>>> >>> +       TERM_NEW = 4,
>>>>> >>> +       TERM_OLD = 8
>>>>> >>> +};
>>>>> >>> +
>>>> >> ...
> Is there any risk that a more generic term like "TERM_BAD" may collide
> with some other definition some day ?
>
> Would it make sense to call it GIT_BISECT_TERM_BAD, GBS_TERM_BAD,
> BIS_TERM_BAD or something more unique ?

I am not sure if the scope of these symbols would ever escape
outside bisect-helper.c (and builtin/bisect.c eventually when we
retire git-bisect.sh), but BISECT_TERM_{GOOD,BAD,OLD,NEW} would not
be too bad.
