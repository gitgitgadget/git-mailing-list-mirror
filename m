Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B198C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37967610E6
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhJGVZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:25:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50515 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhJGVZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:25:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16FDB1642E9;
        Thu,  7 Oct 2021 17:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I4eRQ/WpTxeciNEdBqGiNpcRW0ScuxCMSeLb6S
        fv5Eo=; b=Irx+OOQA1C4IfBg422VJIcQA102CC3oh0J0MaOJr8XFR8TAQD4isBQ
        RNoznCNm/hdUsN+iWAA6UmTUDktO0Q5NQRhBtDSvioP+21I3dxC8bzTKvnDPgxdG
        UlvMa9jz4T8i6xMBOImhwJoWhW3dQPExDtlZgaPT7ojlnQAXrwwjU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F3821642E8;
        Thu,  7 Oct 2021 17:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 735621642E1;
        Thu,  7 Oct 2021 17:23:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
        <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 14:23:13 -0700
In-Reply-To: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 07 Oct 2021 18:07:21 +0000")
Message-ID: <xmqqee8wpm0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C80313D4-27B4-11EC-ABFF-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      * Fixed the spelling of Stolee's name (sorry Stolee)
>      * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
>     
>     [1]
>     https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/

I've seen the exchange, but ...

> -	for OPERATION in "merge -m merge" cherry-pick rebase
> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
>  	do

... it looks too strange that only one of them requires a "--quiet"
option.  Is it a possibility to get whoever's fork corrected so that
it behaves sensibly without requiring the "-q" option only for the
particular rebase backend?

In the meantime, I'll queue the patch as-is (I actually queued the
previous round with namefix already).

Thanks.
