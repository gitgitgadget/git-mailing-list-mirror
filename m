Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9031F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbcHOVFb (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:05:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932115AbcHOVFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:05:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 24650365A1;
	Mon, 15 Aug 2016 17:05:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3nW/KPiDpOKGvHx1RshJliWGLE=; b=TSbiPL
	bw6c2dGqJA2LAD0LmKF1PxcKgBt9mhL15bRHwuZ3EFMsNb0P8t5JWkd+J2KeRJbc
	dfhRg555n/ZWux4BLfKlTRAm2orBOEZMfoi7j49y9Cu7FlaPhUYg0rVaZiVkrPIJ
	f8P7IX7GBfnnKfaI1ZCah2j79eazS6l1q1mFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EKXqq9xUNCEB9Yq35RKbeUctEMqq6ZkL
	213+orkt/ogyai8HCwXN8AOs03aDFX3GIW0jFzPvrfqy0U//hoBR+JpCRxTZcJIv
	69DxiGFA8HtpxPuK/thFVzaPgSCzMLWL49CdtBVHrlM1YsOefQ9TRJ5lex6x9nEb
	woQYVce0z6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 182DB365A0;
	Mon, 15 Aug 2016 17:05:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EA663659F;
	Mon, 15 Aug 2016 17:05:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit --detach option
References: <20160815184021.12396-1-sbeller@google.com>
	<20160815184021.12396-2-sbeller@google.com>
	<20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
Date:	Mon, 15 Aug 2016 14:05:26 -0700
In-Reply-To: <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 14:47:31 -0400")
Message-ID: <xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE76C1C0-632B-11E6-8568-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think doing it this way is _wrong_. It just feels sort of
> pointlessly over-engineered. It's also a little weird that all of the:
>
>   if (advice_foo)
>
> will trigger because "advice_foo" is set to -1. I think it does the
> right thing, but it feels like a bug (the value is now a tri-state, and
> we silently collapse two states into one).

Guilty as charged.  I do agree that this is over-engineered.
