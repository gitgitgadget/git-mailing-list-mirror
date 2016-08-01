Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25F91F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbcHAUkq (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:40:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319AbcHAUkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:40:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDFB03220A;
	Mon,  1 Aug 2016 16:40:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uPHz/2wIMhcwEVAwSLptU4L7NGc=; b=B3vwVn
	4bkeG466nzHtvRRPqIm5c9y2wKoEjNAfqPmPIz73er4K3a3vaCyog9H/mXgjs7x2
	i0c2FxWG37hoqR9uTMTFU3ELPOhb53HoKVgG+Ik7FjmW5rFjJFr9UboMickKopH0
	8svsDjpWCpzsKt4VoVlY/f3/W5beD/iP8aIGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KejJAECQWP1Sv56/M6USrvKo3p66HSuM
	dieTUtUUOtbjqyrrmE6ppKno9WtLJuTOj09uGDxDps1WPJiw01oYRanrsyz7MJoJ
	wjEvnntW4azV3UXz7P2AG7lpRYQxdipKuBr+FE6EYOWgdf3F0951tXJDh32ktK0y
	T1KL658vU4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4ADF32209;
	Mon,  1 Aug 2016 16:40:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6937632204;
	Mon,  1 Aug 2016 16:40:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v9 33/41] environment: add set_index_file()
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
	<20160730172509.22939-34-chriscool@tuxfamily.org>
	<CAGZ79kYzxCq6M49Zmf_4J7xTdXHMunvgPuFaLnV7fXtuTbEogQ@mail.gmail.com>
	<xmqqlh0gi5sv.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 01 Aug 2016 13:40:41 -0700
In-Reply-To: <xmqqlh0gi5sv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Aug 2016 13:37:52 -0700")
Message-ID: <xmqqh9b4i5o6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 378959FA-5828-11E6-A3C0-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> In cache.h we have a NO_THE_INDEX_COMPATIBILITY_MACROS,
>> and lots of
>>   #define foo_bar(..) frob_bar(&the_index, (..))
>>
>> Could you operate on the raw functions that take pointers to &the_index
>> and point these to a temporary index?
>
> Isn't mention of the_index is a red-herring?
>
> The in-core index_state does not even know what file it needs to be
> written to, so whether you explicitly specify your own index or use
> the compat macros to access the_index, you would need to specify to
> which file you would write it out or from which file you would read
> the new contents.

Having said that, I agree with you that the cop-out "Yes we know
this is bad" needs a lot more clarification, pointing out what issue
this side-steps and a direction to solve it correctly.
