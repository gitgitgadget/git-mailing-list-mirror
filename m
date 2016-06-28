Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B87B2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 22:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbcF1WzV (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 18:55:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752570AbcF1WzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 18:55:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 016F926FCB;
	Tue, 28 Jun 2016 18:47:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31V2QRbHx3ao3XJOMhiIGHPJql8=; b=NDDXvR
	GVKN/1q6GdIsGbCRA4PUhRu7CeDbKqylOrCduKRNcdzBk8u73xHp8Ijhs0AkkobQ
	Pc3+V4Jdku/o9w+9QZuImaQ12yFp8yL/1rg4uyzzO+cgVSTZFMwkzAtUTPeEASXJ
	nxkcdu88prtuqLoYlDcNCapUTVwp+SdDGm2ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COLqUQmC+lmqKmf5n6ZwDvVzoRMLq/T1
	op0JKF4I3fHiv8Q8FclkKzMat6ycdz3hQH7JlqzJ2T96yFCaF+D9HWG6tPB2/sw7
	Q40Y90doacBDFsBGxiwuh24Ku20PGtCQI1VgtJPsgHEuXTTTqL+p+QLJYyehH7w1
	xwlQGjRJa+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED28F26FCA;
	Tue, 28 Jun 2016 18:47:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FE1326FC8;
	Tue, 28 Jun 2016 18:47:54 -0400 (EDT)
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
Date:	Tue, 28 Jun 2016 15:47:52 -0700
In-Reply-To: <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jun 2016 15:33:09 -0700")
Message-ID: <xmqq8txp6icn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59E6C5D4-3D82-11E6-81E5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But then my observation still holds, no?
>
> ...
>         if (outbuf.len) {
>         	/* we still have something to say */
>                 strbuf_splice(&outbuf, 0, 0, PREFIX,
>         	strlen(PREFIX));
>                 fwrite(...);
> 	}

I guess these two are more or less equivalent.

I view "outbuf" more as "holdbuf", i.e. the payload that has been
received and yet to be shown, and from that point of view, having
and keeping PREFIX which is not something we received in there while
looping to grab more input makes me feel dirty.  IOW, I consider
"empty" is the correct base state of the hold buffer before anything
happens.

I understand that you view "outbuf" as what has been prepared to be
shown but not ready to be shown due to lack of LF, and from that
point of view, the base state of the out buffer before anything
happens could be "it has PREFIX and nothing else".

It's just that if you take the latter, then the conditional after
the loop exits (i.e. the last transmission was an incomplete line)
cannot be "is outbuf empty?", as your base state is "has PREFIX and
can never be empty".  I was working back from that if statement.


