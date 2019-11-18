Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB551F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 03:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKRDms (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 22:42:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52294 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRDms (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 22:42:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D1BAAA4FF;
        Sun, 17 Nov 2019 22:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zmz2MUy3n02135iMFHNyWorfq3E=; b=od0JUZ
        kwlUluXPwNcCoAF54DSuOWtVZ/wvrnCP5YrFhAGlIPXYvMZnT5tum10APMRIxhHY
        IdPsvI+9uochfd3ANz2r+i+nqmirElJ4eUhvGIWl47QnCoZauUUhm+h5qfExElUS
        1NoL9qTY9ZBki+cC1WCLBE2xQsp3yM4tKXuMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NyrCFIjD9Gg2Tg14wKYyfpg3ZEZ7Ef3v
        c8/bXD8XRzLBKxp96ZuKkSxAA0QJcHW/MSvh19LjQS6uihR/B0IrjUA+sM3RKV31
        L61l72FOEEfBNuIUqqhtag4vjtcm8qJB1yuuUkoBSKyL8ONCICe06CqnZ52Bb7Ub
        R114JCfiEsM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 963BCAA4FE;
        Sun, 17 Nov 2019 22:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C57D4AA4FD;
        Sun, 17 Nov 2019 22:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/2] Make git rebase -r's label generation more resilient
References: <pull.327.git.gitgitgadget@gmail.com>
        <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
Date:   Mon, 18 Nov 2019 12:42:41 +0900
In-Reply-To: <pull.327.v2.git.1574032570.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sun, 17 Nov 2019 23:16:08
        +0000")
Message-ID: <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A90AE46-09B5-11EA-98F2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Those labels must be valid ref names, and therefore valid file names. The
> initial patch came in via Git for Windows.
>
> Change since v1:
>
>  * moved the entire sanitizing logic to label_oid(), as a preparatory step.
>
> Johannes Schindelin (1):
>   rebase-merges: move labels' whitespace mangling into `label_oid()`
>
> Matthew Rogers (1):
>   rebase -r: let `label` generate safer labels
>
>  sequencer.c              | 72 +++++++++++++++++++++++++---------------
>  t/t3430-rebase-merges.sh |  6 ++++
>  2 files changed, 51 insertions(+), 27 deletions(-)

I think Dscho meant to Cc you as these two patches are meant to be a
more complete solution to supersede your [*1*].


[Reference]

*1* <860dee65f49ea7eacf5a0c7c8ffe59095a51b1ce.1573205699.git.congdanhqx@gmail.com>
