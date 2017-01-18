Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACA91F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdART1G (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:27:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59779 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752178AbdART0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:26:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1744C5F695;
        Wed, 18 Jan 2017 14:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gY5JYgC0D0LRfDR/ebqWmRFelac=; b=fiThFt
        QiPfQfPTk6Wb4rYliHR2FJS5OqHCZI+IS/AnE3dIHadqhNuDp7/JhGmmvSgY5KUh
        3RjXdyF8bK+qUpUC1boOux1EJL7JKtt5gHNpmtG4NLLM8+svangAbAO5lnXgNsg/
        DzuHJvdI0txD2JDeXLcq3MaDu+dcwoce/RtVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KKEE3cl8uZxjQZpiVbBs4S8TMB+kw+qB
        Tm2TG+qRr3NyShkSd9U6i1keECxkVzd/eGJxlpGUBwK1mF4VH9XPNEEySpQgHQid
        s2sKZTsESS4IruUTtkcTl/uJq1WjuF5K1Knz/Klhvybnl4o3fSY6k2iRKywW5aPa
        1rJ2Epn1id0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B43A5F694;
        Wed, 18 Jan 2017 14:19:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 355F15F690;
        Wed, 18 Jan 2017 14:19:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] mingw: follow-up to "replace isatty() hack"
References: <867bafbe582df549b10729a5d688458bb6a98d51.1484741665.git.johannes.schindelin@gmx.de>
Date:   Wed, 18 Jan 2017 11:19:50 -0800
In-Reply-To: <867bafbe582df549b10729a5d688458bb6a98d51.1484741665.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 18 Jan 2017 13:14:35 +0100
        (CET)")
Message-ID: <xmqq7f5s9nvt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 162DFD36-DDB3-11E6-AEF1-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The version of the "replace isatty() hack" that got applied to the
> `maint` branch did not actually reflect the latest iteration of the
> patch series: v3 was sent out with these changes, as requested by
> the reviewer Johannes Sixt:

Thanks for an update.  

Does the above "the version taken was not updated before getting
merged" mistake only apply to 'maint', or is it also true for
'master'?  

As a rule we only merge things to 'maint' that have already been
merged to 'master', so I am guessing that the answer is yes, in
which case I'd queue it on js/mingw-isatty and then merge it to
next, master and maint in that order as usual.

> - reworded the comment about "recycling handles"
>
> - moved the reassignment of the `console` variable before the dup2()
>   call so that it is valid at all times
>
> - removed the "handle = INVALID_HANDLE_VALUE" assignment, as the local
>   variable `handle` is not used afterwards anyway
>

Also if the v3 had been reviewed and acked, it would be nice to have
the acked-by around here (which I can locally do).  Hannes?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.

> Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-fixup-fixup-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-fixup-fixup-v1
>
>  compat/winansi.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3c9ed3cfe0..82b89ab137 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -494,19 +494,16 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
>  	 * It is because of this implicit close() that we created the
>  	 * copy of the original.
>  	 *
> -	 * Note that the OS can recycle HANDLE (numbers) just like it
> -	 * recycles fd (numbers), so we must update the cached value
> -	 * of "console".  You can use GetFileType() to see that
> -	 * handle and _get_osfhandle(fd) may have the same number
> -	 * value, but they refer to different actual files now.
> +	 * Note that we need to update the cached console handle to the
> +	 * duplicated one because the dup2() call will implicitly close
> +	 * the original one.
>  	 *
>  	 * Note that dup2() when given target := {0,1,2} will also
>  	 * call SetStdHandle(), so we don't need to worry about that.
>  	 */
> -	dup2(new_fd, fd);
>  	if (console == handle)
>  		console = duplicate;
> -	handle = INVALID_HANDLE_VALUE;
> +	dup2(new_fd, fd);
>  
>  	/* Close the temp fd.  This explicitly closes "new_handle"
>  	 * (because it has been associated with it).
>
> base-commit: 3313b78c145ba9212272b5318c111cde12bfef4a
