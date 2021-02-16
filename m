Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22608C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEFF64E2B
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPSjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:39:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50326 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPSjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:39:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5365FA6206;
        Tue, 16 Feb 2021 13:38:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9u/iyr8UZVQ3Q8En1Taxi6L0ssI=; b=qImSQD
        Mtn5ikhKdZbWMjuyCCz+uoUVC6KWo0fZRbCCy6oKM/oXEBdIkr96LYuEJ2VcoXER
        tK12BvqqJLkFR5U8gVP8pzC4yIsCPTzgH9PcPKpyFMJ7kDmeDloM06MNpZeFE74H
        PTq3dTAb1UpqaS99KCAUCEjudsK7MA/l4b+I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UOeK/QKWaxBKR8S1AjeERGWcFPMw6gqT
        4Kud5hO9FmHhOxh6GATkytRxUPZOR/3oa3PpEwkTnC389RUaZhVuqaLmvzc1aLsI
        QuOJ+5GYJ1Gobtedgkw4inYB3i+8D9UlS3nSRVJIjqCvkTrPi3jeiQlYvt9GkEAY
        /ZHXuOwXIQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AED7A6205;
        Tue, 16 Feb 2021 13:38:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFD92A6204;
        Tue, 16 Feb 2021 13:38:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Subject: Re: [PATCH 1/1] mergetools/vimdiff: add vimdiff1 merge tool variant
References: <20210214022840.849312-1-seth@eseth.com>
        <20210214022840.849312-2-seth@eseth.com>
Date:   Tue, 16 Feb 2021 10:38:22 -0800
In-Reply-To: <20210214022840.849312-2-seth@eseth.com> (Seth House's message of
        "Sat, 13 Feb 2021 19:28:40 -0700")
Message-ID: <xmqqk0r7rh7l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25DC0272-7086-11EB-9DBC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> This adds yet another vimdiff/gvimdiff variant and presents conflicts as
> a two-way diff between 'LOCAL' and 'REMOTE'. 'MERGED' is not opened
> which deviates from the norm so usage text is echoed as a Vim message on
> startup that instructs the user with how to proceed and how to abort.
>
> Vimdiff is well-suited to two-way diffs so this is an option for a more
> simple, more streamlined conflict resolution. For example: it is
> difficult to communicate differences across more than two files using
> only syntax highlighting; default vimdiff commands to get and put
> changes between buffers do not need the user to manually specify
> a source or destination buffer when only using two buffers.
>
> Like other merge tools that directly compare 'LOCAL' with 'REMOTE', this
> tool will benefit when paired with the new `mergetool.hideResolved`
> setting.
>
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  mergetools/vimdiff | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Any vimdiff$n + "git mergetool" users care to comment?  Thanks.

> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index abc8ce4ec4..96f6209a04 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -15,6 +15,17 @@ merge_cmd () {
>  				"$LOCAL" "$MERGED" "$REMOTE"
>  		fi
>  		;;
> +	*vimdiff1)
> +		"$merge_tool_path" -f -d \
> +			-c 'echon "Resolve conflicts leftward then save. Use :cq to abort."' \
> +			"$LOCAL" "$REMOTE"
> +		ret="$?"
> +		if test "$ret" -eq 0
> +		then
> +			cp -- "$LOCAL" "$MERGED"
> +		fi
> +		return "$ret"
> +		;;
>  	*vimdiff2)
>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>  			"$LOCAL" "$MERGED" "$REMOTE"
> @@ -52,7 +63,7 @@ exit_code_trustable () {
>  
>  list_tool_variants () {
>  	for prefix in '' g n; do
> -		for suffix in '' 2 3; do
> +		for suffix in '' 1 2 3; do
>  			echo "${prefix}vimdiff${suffix}"
>  		done
>  	done
