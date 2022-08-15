Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144AC25B0D
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 05:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiHPFHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiHPFGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 01:06:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C327263F
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 14:07:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC87B19EB7B;
        Mon, 15 Aug 2022 17:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q64oY9UrU4z8zrRfUKRwAuz1hqpCDR6tDkF3gK
        cc3Q0=; b=qs2W5gtE9Mmm+u5+hE6c1rsnZ+M9aG+M3SnIqfUf46+XzfjCZ83FvZ
        dPn9MW2cGSNx8z7vr5Ys5WeV1hts+hwTW2althUc6QgdMttRujj2SD+mXx7M4gpY
        dfMKmtGJ0CLIBrZhgN9aSEiGtDbhPY6bxICZFCLYvUJD+bKV3BcUk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D50FC19EB79;
        Mon, 15 Aug 2022 17:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54DAA19EB78;
        Mon, 15 Aug 2022 17:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 5/5] rebase --keep-base: imply --no-fork-point
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <68bcd10949ec7767d1e0ee8e2f0730ca36bad1c5.1660576283.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 14:07:06 -0700
In-Reply-To: <68bcd10949ec7767d1e0ee8e2f0730ca36bad1c5.1660576283.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 15 Aug 2022 15:11:23
        +0000")
Message-ID: <xmqqczd1z05h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3871DC12-1CDE-11ED-8A32-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Given the name of the option it is confusing if --keep-base actually
> changes the base of the branch without --fork-point being explicitly
> given on the command line.

Does it merely "imply"?  As keep-base requests exactly the same base
commit reused from the current history, doesn't fork-point a
competing and conflicting request, i.e. "please compute an
appropriate fork-point by looking at merge base with possibly
rewound tips of upstream branch"?

> +		/*
> +		 * --keep-base ignores config.forkPoint as it is confusing if
> +		 * the branch base changes when using this option.
> +		 */

The comment singles out config.forkPoint (Isn't that "rebase.forkPoint"???)
as "confusing".  Do we ignore rebase.forkPoint when --keep-base is given?
Do we honor --fork-point from the command line when --keep-base is given?

> +		if (options.fork_point < 0)
> +			options.fork_point = 0;
