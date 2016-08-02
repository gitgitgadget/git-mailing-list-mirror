Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2012021F
	for <e@80x24.org>; Tue,  2 Aug 2016 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbcHBVfA (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:35:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754608AbcHBVew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:34:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A24133D3B;
	Tue,  2 Aug 2016 17:27:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=md6BLsBMdJQigxtrVIi/aMm0giA=; b=RaEDQe
	LEhS4lXpR7FUj/d2K8BjWpQ2fo2izkdQjv3a4iwQrl+gkmtQPgNVUR1nuVM8iR2h
	v7oOjqqFclh9zrNSdaYotNE/AzsKmrtWM4iKvXdjtxx6yNu0ytkYxnZcS+Ir8fZt
	bjmZmtG+NgPazoKDtgBfvDsgX3HQhsCX+Euew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=av4dnkXFw35OmKN5ikNrUPG0kUBnk5f8
	y/okAxpVceYVMjEifeVa7NdlKOmUDSY2Yc4V7n9P1MpI/7YPDlD75KqOKCDvR0jz
	mS5SHrdFJRx3lapZgT3GTi87rYx2fviYIirx8bnAsWpn+1am+L0QOmiekcFZYDgz
	RIqwnmT4lQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1174F33D39;
	Tue,  2 Aug 2016 17:27:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EDA933D35;
	Tue,  2 Aug 2016 17:27:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
Date:	Tue, 02 Aug 2016 14:26:58 -0700
In-Reply-To: <alpine.DEB.2.20.1608021004080.79248@virtualbox> (Johannes
	Schindelin's message of "Tue, 2 Aug 2016 10:12:29 +0200 (CEST)")
Message-ID: <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA609448-58F7-11E6-9E54-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > There are a couple of places where return values never indicated errors
>> > before, as wie simply died instead of returning.
>> 
>> s/wie/we/;
>
> Right. What can I say, I am surrounded by too many Germans.
>
> I fixed this locally, in case another re-roll should be required. What you
> have in `pu` looks correct to me, though. Let me know if you want me to
> re-submit nevertheless.

I usually do this kind of obvious typofix and consistency fix
without even mentioning them in my review comments to reduce the
noise levels.  But that works better ONLY if the patch authors then
fetch from 'pu' and replace their copies with what I fixed up
already and base their reroll on top by amending and/or building on
top (of course, that also requires my local fix must all be limited
to uncontroversial ones).

So either I should change my workflow and mention any and all
typofixes in my review comments (which consumes the review
bandwidth), or I should force patch authors to do the "fetch from
'pu' and replace" somehow to avoid this kind of back-and-forth.

I am not sure which should be the way to go.

