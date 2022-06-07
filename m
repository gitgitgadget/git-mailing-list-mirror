Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C672FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 01:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiFGB01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 21:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGB00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 21:26:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A68A07E
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 18:26:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32D5E1A1D18;
        Mon,  6 Jun 2022 21:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=heogAq/NVholv7rMF0Fo29Cs2eDLQXaCx+MNgb
        NLtCY=; b=rVY+354BkfXnch/sd0LDq2InZxDa8NRiE0wCCquaoBuwVitBGMpFeM
        vwriixVu9FJYA+y1FlncxX942ekuS0BDVlQivWfECMNrKPf4lJ7A94LNWqKjiy9V
        cKdSKxnMS2PaYzqP1MQafno+CU50H6YkYIZEKody+dGvaylJsP4xo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DF841A1D17;
        Mon,  6 Jun 2022 21:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8420F1A1D16;
        Mon,  6 Jun 2022 21:26:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
        <xmqqwndznf0z.fsf@gitster.g>
        <ed907ed2-ee9c-789f-0f25-0a1f5b58714f@gmail.com>
Date:   Mon, 06 Jun 2022 18:26:20 -0700
In-Reply-To: <ed907ed2-ee9c-789f-0f25-0a1f5b58714f@gmail.com> (Philippe
        Blain's message of "Mon, 6 Jun 2022 16:33:35 -0400")
Message-ID: <xmqq8rq91cxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D68CB81E-E600-11EC-B78E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Just to be clear: the "out of the box" behaviour (i.e. nothing in the config)
> is correct, i.e. submodule changes are detected and shown by 'git range-diff'.
>
> It's only if someone has 'diff.submodule={log,diff}' in their
> config that submodule changes are quietly ignored (log) or might
> crash 'git range-diff' (diff). So I do not think of any user or
> workflow that benefit from the current behaviour, no. If you have
> diff.submodule={log,diff} set in your config, it's most probably
> because you work in projects that involve submodules and you do
> care about submodule changes. So having these changes "hidden" by
> range-diff (or having range-diff crash) just because the output
> format of 'git -c diff.submodule={log,diff} log' does not use a
> 'diff --git' header for submodules is really not expected. So I do
> not think we need to make that configurable. I think hardcoding
> '--submodule=short' is an easy fix and a good first step in making
> 'git range-diff' more useful for submodule users.

OK.  As "diff.submodule=none" does not exist, hardcoding "short"
would not hurt anybody, I agree.

Thanks.
