Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A2B2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbcGAUCn (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:02:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751207AbcGAUCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:02:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D2B327B2A;
	Fri,  1 Jul 2016 16:01:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KxmOAjelxGBm14AVp+edw2moXF4=; b=q131r/
	2oXNniYyfXEdIZMY9E7GYoWRbwTGChc8p5H9ONCKbDAZZs34j2kmbvYUGfDGM3T1
	cC3I4fmB71ZiJonYD1SymN8wbMCoVoKDe9O/7b2pYDmPUuR7FKXPJOJrnQZoxPJG
	taqISPwG6ygE7JN0eTryjlCpNqSX6EZsGR/ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLGYpfzLJ19d5VW1BCjd4NYY4qN8LK9/
	WQo4mUhqlOwRqwaAiFkiu3GVL8jmI9H7e3r7KYtUN9U64ZlUd4z+jWGED269DDsS
	pHgi5/EEpLzcYT34TI/xmdGC5zFWQFiyhOP03pyV5Fz4p8f/7B+DlqeftkEjqbYq
	7tyd7lmRxWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8540A27B29;
	Fri,  1 Jul 2016 16:01:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B5EF27B27;
	Fri,  1 Jul 2016 16:01:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	"Nicolas Pitre" <nico@fluxnic.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
	<xmqq60st853d.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
	<xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
	<xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr>
	<xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
	<146726738438.11587.1114281440699318943@s-8d3a3869.on.site.uni-stuttgart.de>
Date:	Fri, 01 Jul 2016 13:01:48 -0700
In-Reply-To: <146726738438.11587.1114281440699318943@s-8d3a3869.on.site.uni-stuttgart.de>
	(Lukas Fleischer's message of "Thu, 30 Jun 2016 08:16:24 +0200")
Message-ID: <xmqqfurtxh3n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5ED0C54-3FC6-11E6-9998-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lukas Fleischer <lfleischer@lfos.de> writes:

> Oh, and one more detail: I wonder why we still use fwrite(), now that we
> know we can use xwrite() which guarantees atomicity. Is there a reason
> for that?

The code (before squashing anyway) used to use fprintf() directly
bypasing the outbuf for unusual cases, and we didn't want to mix raw
file descriptor access with stdio access.

That no longer is the case, so I think we can switch to xwrite(),
and lose the last paragraph of the log message entirely.

Thanks.
