Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994D5C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15B64EC2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBATwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:52:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55330 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhBATwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:52:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F8A8120DDC;
        Mon,  1 Feb 2021 14:51:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ftoOc5QJSvCxkAuL2ejQdpZgwbg=; b=c4SA9m
        GM5FNxCjG1UF6v8js9rXeHJ5m0P4dhEKCSoffedy18pvp+DYbxE9YFWBs8kjXaIu
        bUfDBF7CQOl+/RQQea4u1dNxdEDOZTiF83HlQFmls+FXNCAHWU/UkwF4JwMvvU0I
        y1pz70RsSRmpeFZBWBigXwlCSUjKNwpnTby6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i5IjvZc7KJK8KMKUBo0YMZ3c6geo7Wji
        CFqw2C3qIGDeWovIJRbAV7QNY0RhrTFcVNw8cszodkWXIHPUpcy3AxDPoxY85Hj4
        rABrBef/t+T1nGIMEHGfEiYhUrw1RUUN669omFGcQSiMNPvvwva7muONWd4t9okP
        x1N4p/wb09A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 685E1120DDB;
        Mon,  1 Feb 2021 14:51:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE1BB120DDA;
        Mon,  1 Feb 2021 14:51:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/5] commit-reach: reduce requirements for
 remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <649f6799e6bfa0662ed5a4debf915053598fe142.1612183647.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 11:51:52 -0800
In-Reply-To: <649f6799e6bfa0662ed5a4debf915053598fe142.1612183647.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 Feb 2021
        12:47:23 +0000")
Message-ID: <xmqqmtwnlg6f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEC7898E-64C6-11EB-8F83-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Remove a comment at the beggining of remove_redundant() that mentions a
> reordering of the input array to have the initial segment be the
> independent commits and the final segment be the redundant commits.
> While this behavior is followed in remove_redundant(), no callers rely
> on that behavior.
>
> Remove the final loop that copies this final segment and update the
> comment to match the new behavior.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Makes sense, especially since this is a file-local/static helper
function, we have reasonably tight control over its callers.

Will queue.  Thanks.

>  commit-reach.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index e38771ca5a1..9af51fe7e07 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -160,9 +160,10 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
>  {
>  	/*
>  	 * Some commit in the array may be an ancestor of
> -	 * another commit.  Move such commit to the end of
> -	 * the array, and return the number of commits that
> -	 * are independent from each other.
> +	 * another commit.  Move the independent commits to the
> +	 * beginning of 'array' and return their number. Callers
> +	 * should not rely upon the contents of 'array' after
> +	 * that number.
>  	 */
>  	struct commit **work;
>  	unsigned char *redundant;
> @@ -209,9 +210,6 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
>  	for (i = filled = 0; i < cnt; i++)
>  		if (!redundant[i])
>  			array[filled++] = work[i];
> -	for (j = filled, i = 0; i < cnt; i++)
> -		if (redundant[i])
> -			array[j++] = work[i];
>  	free(work);
>  	free(redundant);
>  	free(filled_index);
