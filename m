Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B16D2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbcGFVL3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 17:11:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752522AbcGFVL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 17:11:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC3122BA35;
	Wed,  6 Jul 2016 17:11:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QVIRVi4hZUKtluZAuhQEg/P2bug=; b=k5MxjK
	LyYVXsT2lsfCDFkeFEIxvcZV6RlGiIYefW26291eb621C52PtHEJ97C3lKZ2mSd+
	3GRuRn+JF5XW4qMLtbuVOQfS7gEGU01XhSsAFiCjIhrVqTVqEOQR7L4VF8/Lt/RU
	+lYKxhRODsFkTD5EsfrIkUekyOR3BT7XoI1/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZHJ3PLRL0MrbcJiIN8VJHgKdAflNr7j
	UcON8E7o4+C848ltBTqmO5RTJW6li6qWOKj1q8wxGWuwfvnm7fr5hu6zDS9jIUDk
	P+cHdWLUbLs6sHaSGSf02DjKqTG3Y3qiIv6aFyym5PEF7sW9aklTH62JmUPIRG6v
	yNVS/Xf/z6Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2E4C2BA34;
	Wed,  6 Jul 2016 17:11:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49BA02BA32;
	Wed,  6 Jul 2016 17:11:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org
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
	<xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1607051625581.1824@knanqh.ubzr>
Date:	Wed, 06 Jul 2016 14:11:24 -0700
In-Reply-To: <alpine.LFD.2.20.1607051625581.1824@knanqh.ubzr> (Nicolas Pitre's
	message of "Tue, 5 Jul 2016 16:35:50 -0400 (EDT)")
Message-ID: <xmqq60sisc8z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 333226E4-43BE-11E6-886C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> Here's a patch on top of it providing small optimizations.

Thanks; will apply with a miniscule fix.

> ----- >8
> Subject: sideband.c: small optimization of strbuf usage
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ...
> @@ -97,7 +97,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  	}
>  
>  	if (outbuf.len) {
> -		strbuf_addf(&outbuf, "\n");
> +		strbuf_addch(&outbuf, "\n");

'\n', or "\n"[0] ;-)

>  		xwrite(2, outbuf.buf, outbuf.len);
>  	}
>  	strbuf_release(&outbuf);
