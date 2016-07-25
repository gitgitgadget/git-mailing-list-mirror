Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596CD203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbcGYWgZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:36:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753814AbcGYWgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:36:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C819430734;
	Mon, 25 Jul 2016 18:36:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WE8QlKQtwB4ICCyI9G+6JAivXTM=; b=NNLg4+
	uck1u3KW3+MHhmHbgKyOw0ToSvREiGzSXUQiXXzlEL9LLX7UvxhVMl1X4acyAN5V
	K2MHlChAxjPA8NfRJ3oMxnq0/vE7whkd+TDwZ+Aq/NbwPzHgvzER8JzeaA08YHz9
	BMvCrkbhSdowKgfKEg0kDrinaR+oG/NyJy3eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bu+mV5/M56vS42lQZBl3M8EZx/nCsc8m
	JAKg3cRl3yLQwrONa6njUtbk9N8mNeq9VrMnfjiGTXBctppymdQtcbI1DxgajoCr
	GU+NBCaPzoeP3Bf58oY0/qUIg1HZWjmxAm4VmejUNh3Gnklk+KK24W5pTJNLV5zA
	2hAsZLaTdnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B554E30733;
	Mon, 25 Jul 2016 18:36:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32C1C30732;
	Mon, 25 Jul 2016 18:36:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 02/16] Report bugs consistently
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<72d1d530bb0e3c96d3affd6679cb7c26026d8321.1469187652.git.johannes.schindelin@gmx.de>
	<xmqqfuqx4cli.fsf@gitster.mtv.corp.google.com>
	<20160725221700.GB14131@sigill.intra.peff.net>
Date:	Mon, 25 Jul 2016 15:36:16 -0700
In-Reply-To: <20160725221700.GB14131@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jul 2016 18:17:01 -0400")
Message-ID: <xmqqlh0p2vmn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34B034C6-52B8-11E6-B918-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 25, 2016 at 02:44:25PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/imap-send.c b/imap-send.c
>> > index db0fafe..67d67f8 100644
>> > --- a/imap-send.c
>> > +++ b/imap-send.c
>> > @@ -506,12 +506,12 @@ static char *next_arg(char **s)
>> >  
>> >  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
>> >  {
>> > -	int ret;
>> > +	int ret = -1;
>> >  	va_list va;
>> >  
>> >  	va_start(va, fmt);
>> >  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
>> > -		die("Fatal: buffer too small. Please report a bug.");
>> > +		die("BUG: buffer too small (%d < %d)", ret, blen);
>> >  	va_end(va);
>> >  	return ret;
>> >  }
>> 
>> If "you gave me this size but you need at least this much" is truly
>> worth reporting, then this is misleading (ret is shown as -1 but you
>> do not even know how much is necessary).  In any case, this should
>> be done as a separate step anyway.
>
> Hrm, isn't "ret" going to be the necessary size? According to the
> standard, it should tell us how many bytes were needed, not "-1" (this
> is the "your vsnprintf is broken" case handled by the strbuf code).

Yes.  If blen <= 0, we do not even do vsnprintf() and that is why
Dscho added "int ret = -1" initialization; otherwise his new die()
would end up referencing uninitialized ret.

> I do think the numbers are reversed, though. It should be "blen < ret".

That, too ;-)
