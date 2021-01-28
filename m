Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073CC433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2386664E01
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 23:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhA1X0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:26:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61564 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhA1X0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 18:26:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE7D8FB4C7;
        Thu, 28 Jan 2021 18:25:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O8pm0x0mlQceIxS/POwgwPiZvyM=; b=miY+Xe
        U7KCrYD6xGu56s9rkJapNcxRsJFPJT5uzmA6pJkkuLavu+UVaK1nUT2Q53zgrfYM
        xAi6PGeSizPmuvhnyVJatmyHuClBTzcEtM86A0z0YjBDBR467ae3m+xnxMIKhxqu
        An30LopSIuUoaWPh6X0tAR/0wVZ+lUi9AfXw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ffEP/VCPRaPVqbKqU7rW/SZGeXR7cGwv
        soHUy+Vf+rWkTeQHZWDgf2yIHPsSqUFCJ6g/Zh7a9mtSzd3qF/DGD4NnPjkMlWvv
        Qw/ukAxr+XUdZGNNyTtvR128+rt5AwVyVji1Qyecw7Y1Toy4WnPdCvcYRPjtIbxl
        /tFrov2sbk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6D25FB4C5;
        Thu, 28 Jan 2021 18:25:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19713FB4C4;
        Thu, 28 Jan 2021 18:25:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] pretty: lazy-load commit data when expanding user-format
References: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
Date:   Thu, 28 Jan 2021 15:25:47 -0800
In-Reply-To: <YBMXM83xCZvC5WyA@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Jan 2021 14:57:39 -0500")
Message-ID: <xmqqlfccve2s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 279D9F5A-61C0-11EB-A2E2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I added the final test to show where we don't improve (the 1% there is
> just lucky noise), but also as a regression test to make sure we're not
> doing anything stupid like loading the commit multiple times when there
> are several placeholders that need it.
>
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This benefits "rev-list --format=", as well, though there you can also
> use things like "--parents" instead, which are already fast.

Quite pleased to see more work lazily done (and personally I am
happy to see Michael's name on the list---say Hi, I missed him).

