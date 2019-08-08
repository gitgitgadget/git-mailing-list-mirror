Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB281F731
	for <e@80x24.org>; Thu,  8 Aug 2019 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404227AbfHHRTf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 13:19:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57197 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404098AbfHHRTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 13:19:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB1B56E73C;
        Thu,  8 Aug 2019 13:19:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yjymdPCL4psgptJvrE3RXtgczhI=; b=ip4wOa
        fX2pGkOC8qkHk5tndW+Yf7tZoPbMj97I1l+NMkfd5wk9hkDrdGtVZ9zRqHuO8T8L
        9kMD61lupKrJD1+l4+Ox71UlIS3OMw+zvtqvBd+okGs8is1aOxM8s6nccfEEGZnH
        InvYPzQzN5tfj/1ZY8lYEIvKPb6jSJL48UYdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jtAYBoPDRF19+BmbbcS0WJt2naXEKOqC
        4oWyFTqrMzT880Y3vQPsxmGq88lEB8zsWT8WbrpsxRHtbX2jqoNd0f4SPp0Let4H
        Frj/Auj9prtO9tt/kyTjoxahJM4ohCb7aZXH7DlR5jhgcxr4U3BJtSKhoDnEg6sR
        cfYzk+EcHwA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3E2C6E73A;
        Thu,  8 Aug 2019 13:19:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C48346E736;
        Thu,  8 Aug 2019 13:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Koning <dk@danielkoning.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: document actual range specifier behavior
References: <m2ftmcijgk.fsf@danielkoning.com>
Date:   Thu, 08 Aug 2019 10:19:24 -0700
In-Reply-To: <m2ftmcijgk.fsf@danielkoning.com> (Daniel Koning's message of
        "Wed, 07 Aug 2019 19:10:20 -0500")
Message-ID: <xmqqsgqbfucj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC7D7FD8-BA00-11E9-8218-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Koning <dk@danielkoning.com> writes:

> The git-blame(1) man page says that the .. range specifier can be used
> to exclude changes "older than" a certain revision.

Thanks for spoting a loose-and-colloquial use of "older than" in the
doc.  As you suspect, the document wanted the phrase to be understood
as "reachable from" (a.k.a "ancestor of").  

Before reading your proposed updated text, I feared that an attempt
to be techinically more precise by rewriting description that uses
more colloquial "older than" may make the result cumbersome to read,
and as I suspected the result did become so, but it does not look
too bad, either, but the explanation of how boundary commits are
shown is completely lost, which is not quite satisfactory.

I personally find "unlike ... does not perform date-based cutoff" a
bit too redundant---as you know, it is known that everywhere in Git,
dots notation is about limiting by revision range a.k.a ancestry
relationships, and the reader can interpret "older than" as
"reachable from", once the context is clear enough.  If anything,
perhaps such a description should go to "git help revisions", as it
is not just "blame" but "log". "The dots notation is not about
date-based cutoff, unlike the --since/--until options" is shared by
all history traversal tools.

>  which limits the annotation to the body of the `hello` subroutine.
>
> -When you are not interested in changes older than version
> -v2.6.18, or changes older than 3 weeks, you can use revision
> -range specifiers  similar to 'git rev-list':
> -
> -	git blame v2.6.18.. -- foo
> -	git blame --since=3.weeks -- foo
> -
> -When revision range specifiers are used to limit the annotation,
> -lines that have not changed since the range boundary (either the
> -commit v2.6.18 or the most recent commit that is more than 3
> -weeks old in the above example) are blamed for that range
> -boundary commit.
> +When you are only interested in recent changes, you can use revision
> +range specifiers and limiting options, just as with 'git rev-list'.
> +
> +You can limit the annotation to commits from the past 3 weeks:
> +
> +  git blame --since=3.weeks -- foo
> +
> +The oldest commit in that span of time will be given the blame for any
> +lines that have not changed since.
> +
> +Or you can limit the annotation to commits that are not ancestors of
> +v2.6.18:
> +
> +  git blame v2.6.18.. -- foo
> +
> +Unlike the --since option, the two-dot range specifier does not perform
> +a date-based cutoff. If changes from branch `fix` were merged in after
> +v2.6.18, the commits on `fix` which introduced those changes will appear
> +in the output of 'git blame', even if those commits took place at an
> +earlier time than v2.6.18.
>
>  A particularly useful way is to see if an added file has lines
>  created by copy-and-paste from existing files.  Sometimes this
> --
> 2.20.1
