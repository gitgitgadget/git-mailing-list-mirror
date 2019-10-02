Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC4D1F4BE
	for <e@80x24.org>; Wed,  2 Oct 2019 05:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJBFr5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:47:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJBFr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:47:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6388338DA;
        Wed,  2 Oct 2019 01:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o9y48itBB/v6KI5zM10TtBp+aYE=; b=uRYyZi
        maP7dmoynfsi0KqZDMjsfI4y2mHJPEHSciF4AZHFy8mIgkP5h22qSgBXrRSPZkYm
        ci0lWbWZYpriY5TmIQwL2bPWG6VmoFlFH5Hs3FqJSDTkVaJjVJXt5SDSQjFMgvn6
        TxsFsV06sw3lq0GaRyDy6baaseh5PbNI5MsDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KEgkLpfQ69Pfk9vcJIj2i2WpYp+PJenu
        68xMP4gUMnqvss2KczB7BWXd1hkGGeZYrtQugzFcuAwcj+2n01DxaGR1nU4DA7K2
        HhIJ4BNDAxUWnxiRjvQ9ucV0E44DekKuaukgIjYRPl/QsHKKcxAVNXNrH6Q3isNQ
        o9+SoMbeOkI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE2A1338D9;
        Wed,  2 Oct 2019 01:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 275AF338D8;
        Wed,  2 Oct 2019 01:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Git's rename detection requires a stable sort
References: <pull.352.git.gitgitgadget@gmail.com>
        <pull.352.v2.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Oct 2019 14:47:53 +0900
In-Reply-To: <pull.352.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Mon, 30 Sep 2019 10:21:53 -0700 (PDT)")
Message-ID: <xmqqo8yzg0l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DAAE134-E4D8-11E9-9817-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> With the en/merge-recursive-cleanup patches already having advanced to next,
> the problem I discovered when rebasing Git for Windows' branch thicket
> becomes quite relevant now: t3030.35 fails consistently in the MSVC build &
> test (this part of the Azure Pipeline will be upstreamed later).
>
> The solution: use a stable sort.
>
> Note: this patch series is based on top of en/merge-recursive-cleanup.
>
> Changes since v1:
>
>  * The function was renamed to git_stable_qsort(), as per Junio's
>    suggestion.
>
> Johannes Schindelin (2):
>   Move git_sort(), a stable sort, into into libgit.a
>   diffcore_rename(): use a stable sort
>
>  Makefile                         |  2 +-
>  compat/mingw.c                   | 11 +++--------
>  diffcore-rename.c                |  2 +-
>  git-compat-util.h                |  9 ++++++---
>  compat/qsort.c => stable-qsort.c |  6 +++---
>  5 files changed, 14 insertions(+), 16 deletions(-)
>  rename compat/qsort.c => stable-qsort.c (89%)

Thanks.  All looked sensible.


>
>  1:  1202809db7 < -:  ---------- Move git_sort(), a stable sort, into into libgit.a
>  -:  ---------- > 1:  8a99008a64 Move git_sort(), a stable sort, into into libgit.a

This is where the current range-diff could be improved to shine
more.  If it were allowed to compute a pairwise diff with rename
detection, readers would be able to see that qsort.c from version 1
is renamed to stable-qsort.c in version 2 with minimum adjustment of
one function name.

