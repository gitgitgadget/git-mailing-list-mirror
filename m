Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA23203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbcGYVod (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 17:44:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755101AbcGYVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC0F22F6A5;
	Mon, 25 Jul 2016 17:44:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hLGYQALVMeJ0o3U9yHwpURfL4ck=; b=XtUVfL
	o/OYu7uqCS+LDP+zLDFVeDzVcUPhdhxvuPxwxPe7yecNJHNIlN7L+u0n1xlKe8lQ
	hMSIPyArBw/9WQ27wcw+DzNz6D4SbfaoJjk7m/+9fDmgE2YnTB4QXuxGJUXxgqip
	A8UJaSbNUge886YTCqu9lvMWr/KGt/WFMsd7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TK6KLaAlsXcZiPbk5lSH68Uq8zUd7uqa
	P+9tV2971eRaAZ8avfrUUsyHIFiSLCM4KllXW3mDpSkFRRoOglTbc1t6nHOTgxmH
	srQC/UqeQwB4K+/+T4kT1USz/ZJUqSe2pIUI4hcg7YnimAP+BXNJ8GwD7/NyiIkY
	JhpV09p8ZLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D43C32F6A4;
	Mon, 25 Jul 2016 17:44:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 571222F6A3;
	Mon, 25 Jul 2016 17:44:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 02/16] Report bugs consistently
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<72d1d530bb0e3c96d3affd6679cb7c26026d8321.1469187652.git.johannes.schindelin@gmx.de>
Date:	Mon, 25 Jul 2016 14:44:25 -0700
In-Reply-To: <72d1d530bb0e3c96d3affd6679cb7c26026d8321.1469187652.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jul 2016 14:24:55 +0200
	(CEST)")
Message-ID: <xmqqfuqx4cli.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5E28B24-52B0-11E6-921C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/imap-send.c b/imap-send.c
> index db0fafe..67d67f8 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -506,12 +506,12 @@ static char *next_arg(char **s)
>  
>  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
>  {
> -	int ret;
> +	int ret = -1;
>  	va_list va;
>  
>  	va_start(va, fmt);
>  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
> -		die("Fatal: buffer too small. Please report a bug.");
> +		die("BUG: buffer too small (%d < %d)", ret, blen);
>  	va_end(va);
>  	return ret;
>  }

If "you gave me this size but you need at least this much" is truly
worth reporting, then this is misleading (ret is shown as -1 but you
do not even know how much is necessary).  In any case, this should
be done as a separate step anyway.

All the other hunks looked sensible.

Thanks.
