Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655A71FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 16:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcF2QkW (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 12:40:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751585AbcF2QkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 12:40:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A531260C3;
	Wed, 29 Jun 2016 12:40:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AMLDSboS7MXrVjZPubTupEal6TM=; b=GZsH9M
	lszdKfqPm8UxRVUN3Fb/v8LGTj1dYhYPxgK/vS7JFwgPbXZ8oET7WfC232zkpwEd
	6iAIm+TY18/ryGLtej3Jh1UtVab956/zaC0JJG9mxSTGXoMNyVcVySdGYZVdlB2T
	IW/4rq3soT1lT4Amj86I8i9af4zhsbgs/H3Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhsoHYm+5Se9XdnP1wwqB8k3RBhDmNvC
	yv5Dx/YaUZXvXHFTd0VdWFok/WL59tlowuu+c1oz8jPMMro3WE9Sfz6lE2odD2sR
	xHroatKQpmikw2GJsTMu12GSvKzno2QuiVQpNWZoA9i52yqNFni7KcWSDUh21Z1G
	8SdtngOQJdc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82EA8260BF;
	Wed, 29 Jun 2016 12:40:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A37D260BE;
	Wed, 29 Jun 2016 12:40:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
	<xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
	<xmqq60st853d.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
	<xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
	<xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr>
Date:	Wed, 29 Jun 2016 09:40:16 -0700
In-Reply-To: <alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr> (Nicolas
	Pitre's message of "Tue, 28 Jun 2016 22:02:50 -0400 (EDT)")
Message-ID: <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A4D3BDC-3E18-11E6-B872-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> To make it clearer, here's a patch on top of pu that fixes all the 
> issues I think are remaining. All tests pass now.
>
> diff --git a/sideband.c b/sideband.c
> index 36a032f..0e6c6df 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -23,10 +23,8 @@ int recv_sideband(const char *me, int in_stream, int out)
>  	const char *term, *suffix;
>  	char buf[LARGE_PACKET_MAX + 1];
>  	struct strbuf outbuf = STRBUF_INIT;
> -	const char *b, *brk;
>  	int retval = 0;
>  
> -	strbuf_addf(&outbuf, "%s", PREFIX);
>  	term = getenv("TERM");
>  	if (isatty(2) && term && strcmp(term, "dumb"))
>  		suffix = ANSI_SUFFIX;
> @@ -34,14 +32,15 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		suffix = DUMB_SUFFIX;
>  
>  	while (!retval) {
> +		const char *b, *brk;
>  		int band, len;
>  		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
>  		if (len == 0)
>  			break;
>  		if (len < 1) {
>  			strbuf_addf(&outbuf,
> -				    "\n%s: protocol error: no band designator\n",
> -				    me);
> +				    "%s%s: protocol error: no band designator",
> +				    outbuf.len ? "\n" : "", me);

OK, because you no longer put PREFIX in outbuf, outbuf.len becomes
an easy way to tell if we have anything accumulated, and if there
already is something, we separate our message from it with a LF.

I like the simplicity and clarity of the logic.

> @@ -50,7 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		len--;
>  		switch (band) {
>  		case 3:
> -			strbuf_addf(&outbuf, "\n%s%s\n", PREFIX, buf + 1);
> +			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
> +				    PREFIX, buf + 1);

Likewise for all other changes.

> -	if (outbuf.len)
> +	if (outbuf.len) {
> +		strbuf_addf(&outbuf, "\n");
>  		fwrite(outbuf.buf, 1, outbuf.len, stderr);
> +	}

... and this does make sense.

Lukas, can you see what is in 'pu' after I push out today's
integration result in several hours and tell us if you like the
result of the SQUASH??? change?

Thanks.

