Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F2C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJVRyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJVRyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 13:54:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29530DF20
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 10:54:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92BD1161BEA;
        Sat, 22 Oct 2022 13:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Os6eO2K7f5QLBuCgUxNRMs4ypNfo5pxY1i+bXc
        li5Pc=; b=XkssaO0LEoqtM+OX8hFukha/qR4hzwzS8OZhs4IPHifmAgwuZVu5P4
        KzaYXhlK7zUqkR8ZjcKX7Uu+nsdWelsM2qVxOEqLOyM/CSsIy7YH5z8tyl0VOTMw
        +ZmVs6W2xSMBt37Qg6UG5mLac5Lo22OIEYQI4rjKT2SsUNuW0ZekY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8928A161BE9;
        Sat, 22 Oct 2022 13:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1820161BE8;
        Sat, 22 Oct 2022 13:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] git_parse_unsigned: reject negative values
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
        <Y1L9fF6yd9EIIp9e@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 10:54:23 -0700
In-Reply-To: <Y1L9fF6yd9EIIp9e@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 16:13:48 -0400")
Message-ID: <xmqqeduzhhgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90D4953C-5232-11ED-8E42-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It does make me wonder if anybody uses a negative value like this in the
> wild for "no limit", as it does what you might imagine currently (I get
> 2^64-1).

I vaguely recall complaints on the command line argument that used
to take -1 to mean "practically unlimited" when its parsing got
tightened.  I wouldn't be surprised if we are making a new issue in
the same category in the configuration file with this change.

But we can switch to the signed variant when it becomes an issue, I
guess.

