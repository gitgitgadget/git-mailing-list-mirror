Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822CA1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfI1KOI (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 06:14:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53546 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfI1KOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 06:14:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BA3837405;
        Sat, 28 Sep 2019 06:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P2zTwRfjvOh+9fgrE6aEyaIJoCQ=; b=CA0h1u
        1acxPuYSs/7hBmdG8PLD77mGldWZ4QGaVbKsfy+yT1EMWrHCThuLk5RVvtH6EPUW
        4sZbYwIqK6FeNyydY0yL/y4LUBvtdpJPnMikD27ZdBxswMJSkYEqdqSHPSndKy1j
        gctdMK+kRb6P8OYe2fNpvvSlVTk2p8Uc/97fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cu2yg8/6iE1Iw2VrK9RJq+4R76Ecbxzt
        qx0/aD15fugbu62VLDu7AY5Ir39Qc6aXxVeTiI4uTie7sVPDv2P2/nBbH5S1nGk+
        /Y4S3F0Dq0ovKyAZffX6D3XPg6vXvfoSjcOylR77noXoZNIffWKiwlF9302yHFsX
        Cdb1htKAK1Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21F9C37403;
        Sat, 28 Sep 2019 06:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71B1A37400;
        Sat, 28 Sep 2019 06:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Move git_sort(), a stable sort, into into libgit.a
References: <pull.352.git.gitgitgadget@gmail.com>
        <1202809db71a7b0d06efd5e50716861ecff186de.1569400558.git.gitgitgadget@gmail.com>
Date:   Sat, 28 Sep 2019 19:14:04 +0900
In-Reply-To: <1202809db71a7b0d06efd5e50716861ecff186de.1569400558.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 25 Sep 2019
        01:36:00 -0700 (PDT)")
Message-ID: <xmqqftkgk9sj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3A80E68-E1D8-11E9-9F21-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ---
>  Makefile                  | 2 +-
>  compat/mingw.c            | 5 -----
>  git-compat-util.h         | 4 +++-
>  compat/qsort.c => qsort.c | 2 +-
>  4 files changed, 5 insertions(+), 8 deletions(-)
>  rename compat/qsort.c => qsort.c (97%)

Quite pleasing.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 738f0a826a..77d4ef4d19 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1229,11 +1229,6 @@ static int wenvcmp(const void *a, const void *b)
>  	return _wcsnicmp(p, q, p_len);
>  }
>  
> -/* We need a stable sort to convert the environment between UTF-16 <-> UTF-8 */
> -#ifndef INTERNAL_QSORT
> -#include "qsort.c"
> -#endif
> -

Especially these ;-)

> diff --git a/compat/qsort.c b/qsort.c
> similarity index 97%
> rename from compat/qsort.c
> rename to qsort.c
> index 7d071afb70..08f80eea09 100644
> --- a/compat/qsort.c
> +++ b/qsort.c
> @@ -1,4 +1,4 @@
> -#include "../git-compat-util.h"
> +#include "git-compat-util.h"

I however do not think this goes far enough.  With a bit more effort
would make the intention of the API more obvious.

What we are saying now is that

 (1) some platforms do not even have qsort()
 (2) some codepaths do care the stability of sorting

the former used to be the reason why we called our implementation
git_qsort() and aliased qsort() to use git_qsort().

But now (2) is in the picture, we would probably want to make it
more clear that our own implementation is not about having a sort
function that behaves like qsort() and We want a lot more out of it
(namely, stability).  It probably is time to rename git_qsort() to
git_stable_qsort() or something like that.

Macros QSORT() and QSORT_S() are about having a convenient and less
error-prone thin wrapper that retains an interface similar to
qsort(3) and qsort_s(3) that developers are familiar with, so they
can and should stay the same name, and it is perfectly fine if the
former called qsort() that in turn calls git_stable_qsort() on some
platforms.

And that way, if/when the calling site of QSORT() (not the calling
site of STABLE_QSORT()) needs a more performant but unstable sort
implementation, we can safely give the most sensible name for it,
which is git_qsort().

Other than that, the two patches look good to me.  Thanks for
working on this topic.



