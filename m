Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C399C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384192AbiAYCBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:01:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53844 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851355AbiAXXcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 18:32:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C596111D7EE;
        Mon, 24 Jan 2022 18:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CJKEriuvQjtOs4xJVpJhZu4AZT27MOiyAlsgNg
        usNn4=; b=F2CzaPSb15IeA92e8pmMzxKXgyoNey5uf+y7r+C46eA7ExxWYE8IXp
        07MdcacCVSV6XcAJ1i7jJO4xkLxET2C5Ao9TIDzN+syGorPDFdV8WmTK9K7SGr4+
        7clKsoCAI4JXaEEBasfIMQbyjEb+dD86W7WUHU6aXDfF6CZOnJF2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC3C611D7ED;
        Mon, 24 Jan 2022 18:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E96111D7EC;
        Mon, 24 Jan 2022 18:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "BoJun via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, BoJun <bojun.cbj@gmail.com>,
        Chen Bojun <bojun.cbj@alibaba-inc.com>
Subject: Re: [PATCH] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 15:32:29 -0800
In-Reply-To: <pull.1124.git.1642987616372.gitgitgadget@gmail.com> (BoJun via
        GitGitGadget's message of "Mon, 24 Jan 2022 01:26:56 +0000")
Message-ID: <xmqqk0eo1zhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E65D5E8E-7D6D-11EC-A097-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +	/*
> +	 * If there is no command ready to run, should return directly to destroy
> +	 * temporary data in the quarantine area.
> +	 */
> +	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next);

Write the empty body of the loop like this:

	for (...)
		; /* nothing */

to make it stand out.

> +	if (!cmd)
> +		return;
> +

> -mk_empty () {
> +mk_empty() {
>  	repo_name="$1"
>  	rm -fr "$repo_name" &&
> -	mkdir "$repo_name" &&
> -	(
> -		cd "$repo_name" &&
> -		git init &&
> -		git config receive.denyCurrentBranch warn &&
> -		mv .git/hooks .git/hooks-disabled
> -	)
> +		mkdir "$repo_name" &&
> +		(
> +			cd "$repo_name" &&
> +				git init &&
> +				git config receive.denyCurrentBranch warn &&
> +				mv .git/hooks .git/hooks-disabled
> +		)
>  }

Documentation/CodingGuidelines.  As far as I can tell, the above
does not change anything the function does, and the only change in
the patch is to violate the style guide badly.  Why?
