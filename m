Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD2C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJUXfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJUXfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:35:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDDC543E5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:35:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB7E515C8BA;
        Fri, 21 Oct 2022 19:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=27xnpZaVtNj6
        NLez5VPz9Y6FgPmEDbni4WAz3vboBss=; b=XRQ9CuQA3wwaZxs30p81AHbTzbot
        9eP8UvfV9qhMdkHOhlv4aF+sy3XP0tog9li7+kSmlNe/+x7PUo5NerZbaU1iDRBE
        WeH/JMIAqEBvlf+tCjTaWb6xuEgvAqubOZjnTAHXroyVgkpOQ7pQv8PQ9+Y/hbO3
        mEqJmCAwaISYO+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D374E15C8B9;
        Fri, 21 Oct 2022 19:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BA3D15C8B7;
        Fri, 21 Oct 2022 19:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jan =?utf-8?Q?Po?= =?utf-8?Q?korn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
        <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
        <Y1Mm9zTX3XwN3IWu@nand.local>
        <Y1MrXoobkVKngYL1@coredump.intra.peff.net>
Date:   Fri, 21 Oct 2022 16:35:17 -0700
In-Reply-To: <Y1MrXoobkVKngYL1@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 19:29:34 -0400")
Message-ID: <xmqqfsfgiwcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05828B54-5199-11ED-B682-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I actually considered writing it that way, but it felt a bit sill=
y
> to use _ARRAY for something which is clearly meant to be a single item.

You are not alone.  I updated R=C3=A9ne's coccinelle rules to refrain
from converting xcalloc() to CALLOC_ARRAY() for a single element
case exactly because it feels silly to use array function for a
singleton with 1c57cc70 (cocci: allow xcalloc(1, size), 2021-03-15).

