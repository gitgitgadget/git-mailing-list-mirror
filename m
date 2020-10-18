Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F406EC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDC2220B
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 21:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGVjFNAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgJRVB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 17:01:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63853 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJRVB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 17:01:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90BEC72102;
        Sun, 18 Oct 2020 17:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gj4qWryK/cpXhLB1nJYlQfRl/JM=; b=tGVjFN
        AZfTbwEbKgniw8wDrgEFMJ2vyevSAj1xhWf40ZcZ6/5IOhHJzbmegyPgrpl/H5gu
        LxT4nFq+1nOb1mSQ4uakcUkHKUoRBgnxNV8Y5GcGIxsjA2nysS+P8OrQYg/n2/aC
        5wnQLnRl18S5s6qUleWsvqw530T8C9gbJOido=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nz73vtgaN2ARVfkE9OkL5e5acrqWMpaq
        uk/XY6w9BfzbjjVG7tHjshmsPWQ+YK2+dlKzWqu7Vdd/Av/pw3wYXWfz9TFki6er
        ddanEj5XsbNo+MsFTo1rl9WT9C/mNr5QFzS9nVXjQXPIrRXP4cAaKZDFLqvAe683
        Vk+XtiNZzyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87FB372101;
        Sun, 18 Oct 2020 17:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F1C372100;
        Sun, 18 Oct 2020 17:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Amanda Shafack via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Subject: Re: [PATCH v3] t2200,t9832: avoid using 'git' upstream in a pipe
References: <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
        <pull.885.v3.git.git.1603054088108.gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 14:01:54 -0700
In-Reply-To: <pull.885.v3.git.git.1603054088108.gitgitgadget@gmail.com>
        (Amanda Shafack via GitGitGadget's message of "Sun, 18 Oct 2020
        20:48:07 +0000")
Message-ID: <xmqqv9f7uu2l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27318FDA-1185-11EB-81C7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Amanda  Shafack  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Amanda Shafack <shafack.likhene@gmail.com>
>
> Avoid placing `git` upstream in a pipe since doing so throws away
> its exit code, thus an unexpected failure may go unnoticed.

Well explained.

> Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
> ---



> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index f764b7e3f5..7cb7a70382 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -179,7 +179,8 @@ test_expect_success 'add -u resolves unmerged paths' '
>  
>  test_expect_success '"add -u non-existent" should fail' '
>  	test_must_fail git add -u non-existent &&
> -	! (git ls-files | grep "non-existent")
> +	git ls-files >actual &&
> +	! grep "non-existent" actual
>  '

In the scope of this patch, the above change is a good rewrite.
Let's stop the iteration here---you've demonstrated through the
microproject that you can now comfortably be involved in the review
discussion.

In a larger scope of "can we write this particular line better?",
however, the above may not be the _best_ answer.  For example,

	test_must_fail git ls-files --error-unmatch non-existent

would be another and a more direct way to ensure that the named path
does not appear in the index.

Thanks.
