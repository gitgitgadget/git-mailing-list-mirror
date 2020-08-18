Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F8C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C772075E
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tzs5ak+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRT1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:27:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60374 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHRT1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 15:27:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EBE08E68D;
        Tue, 18 Aug 2020 15:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7JrzoN3IagqD
        E8d7k/UJS+lowXY=; b=tzs5ak+jaJhydYUJINehmPQdNR60SLzpmQiDnnRB3blV
        9PVoI9YtTGbT5FQ1/2waBmLKtDvL7vX9yu/OWEIwvpqAcRPzj6Vzo0fgZKZqssY2
        0uN57I4xlK9sWPFTwph6bbE5HNIJaI7u0dMyF78c5n+yeb01ujb5mEj1DRdhg1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GlE6h5
        mkClkmAyw76/jWdtGasZtEVml3Zzq7f6xrY9re9mDsa5yX3W5eKD/djAf5B1Yv27
        O3nmPn+TPhEitkqXXbM3kgOqDZBcCbRZisqnPttWDdYrOQB/sJ5mgFx7cSiuyPHF
        KVAcaKBBaZfZIbsZy1TsEEiACzQjhg/3v/8O8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 560958E68C;
        Tue, 18 Aug 2020 15:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D25998E68B;
        Tue, 18 Aug 2020 15:27:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/3] Extend and add a little more generalization to the mem_pool API
References: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
        <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 12:27:00 -0700
In-Reply-To: <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 15 Aug 2020 17:37:54
        +0000")
Message-ID: <xmqqsgcjycu3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA94DEAC-E188-11EA-8760-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In my new merge algorithm, I made use of the mem_pool API in a few
> places...but I also needed to add a few more functions and also needed =
to
> make the API a bit more general.
>
> Changes since v2:
>
>  * Remove 'x' from mem_pool_xstr[n]?dup() names and remove check for NU=
LL
>    since mem_pool_alloc() already handles that (via xmalloc), as sugges=
ted
>    by Ren=C3=A9
>  * Rewrite mem_pool_strndup() to not rely on strnlen(), since that may =
be
>    too new from some systems (comes from POSIX 2008 ). Also pointed out=
 by
>    Ren=C3=A9

Thanks; will queue.

