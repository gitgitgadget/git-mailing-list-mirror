Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E192018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcHHRW0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:22:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752348AbcHHRWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:22:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5967D320A2;
	Mon,  8 Aug 2016 13:22:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dwmp8kF0N7G4yoUaa5n0X9a40eg=; b=aCDbzq
	BP/AjT3gWLzgq1OQK4FRX0Gii7njeEu8t16Q89UmG0yTJrW9CPNGdYxuL8PcNrL2
	7504a8eBTu8jBjHdDBGIIZTjVlF2Qc2YuOzwrcXKnSgdahj5TQYAyYDuUS1C8r4i
	AjMDgWFe0dyzWWZ7f56q1RqB8koWgJxI4RC/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1RPRPZErMZLhfFdEbPSEmzi9xJ7a0CH
	xSUJjmw98Zd01Og/SFMiKBe1Y0nCorI7Xwurprva75O4xH6DyxGJKdUI6EYw0IP2
	newgX6idGgP8V6QzLMUKQAOidtmCR0HvotkjWgb3AUylBoPlVkS98R59GLW9OBDX
	UR/OnCpyIP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51910320A1;
	Mon,  8 Aug 2016 13:22:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D12DD320A0;
	Mon,  8 Aug 2016 13:22:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
	<alpine.DEB.2.20.1608050925240.5786@virtualbox>
	<CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
	<alpine.DEB.2.20.1608061045240.5786@virtualbox>
	<xmqq8tw9iw7i.fsf@gitster.mtv.corp.google.com>
	<20160806214325.GA9484@starla>
	<alpine.DEB.2.20.1608071039410.5786@virtualbox>
Date:	Mon, 08 Aug 2016 10:22:20 -0700
In-Reply-To: <alpine.DEB.2.20.1608071039410.5786@virtualbox> (Johannes
	Schindelin's message of "Sun, 7 Aug 2016 10:46:35 +0200 (CEST)")
Message-ID: <xmqqvazbfa5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB22414C-5D8C-11E6-AD87-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think you both got it wrong. The original citizens were the mail
> clients that allowed you to communicate with other human beings.
> ... It is our usage to transport machine-readable content (and not
> as an attachment!) that is the intruder.

It is not "its is our usage".

You are too young to remember or too old to remember the history, or
you are knowingly distorting it.  The original users of "patch" and
"diff" expected that e-mail to be a medium to safely exchange
changes to programs among themselves.
