Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F34EC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C5A60F9C
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhKQIwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:52:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62343 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhKQIwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:52:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F42F47BE;
        Wed, 17 Nov 2021 03:49:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ccf48q0udv8E5tTlW45kqjur1YOsQG5gesNA/efPXJM=; b=djKB
        QJF/JJGRjFuhQrtrOV7BrwN6q+UzYreteRybYDYE/ZDgzN5MlN7dn6x+WbjItJiX
        jv0ZgfJYBNHq633KyupkJqlnOaaVPVLKRQP15aDQAvv16AjsGZiMekRsCBbKQb2B
        wXLo9SO6FXYcY9PjdNYoC/v5C+lnprYmW/gepIs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 693F1F47BD;
        Wed, 17 Nov 2021 03:49:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8614F47BC;
        Wed, 17 Nov 2021 03:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] name-rev: prefer shorter names over following merges
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2111161227090.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 17 Nov 2021 00:49:08 -0800
Message-ID: <xmqq35nv416j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B093B68-4783-11EC-B2FA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thank you. As you most likely figured out, that magic weight was
> introduced by me, in ac076c29ae8 (name-rev: Fix non-shortest description,
> 2007-08-27). And indeed the motivation was to keep the name as short as
> possible.
>
> Technically, your solution does not fix the problem fully, as we still do
> not determine the _shortest possible_ name. Having said that, I think your
> patch improves the situation dramatically, so: ACK!

It really depends on how you define "short".  Is v1.0~11 and v1.0~99
the same length and v1.0~100 a bit longer than these two?

I wonder what happens if we counted what the proposed commit log
calls "segments" and nothing else, e.g.

    v2.32.0~1471^2			has 2 segments ("~1471", "^2")
    v2.32.0~43^2~15^2~11^2~20^2~31^2    has 10 segments

and use number of hops only for breaking ties, instead of giving a
magic weight and trying to count both hops and segments.

In any case, this seems to give us a much better results than the
current code, so let's take it and leave further futzing outside the
scope.

Thanks.
