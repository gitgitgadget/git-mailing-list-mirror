Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F5C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C6608FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ1QjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:39:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64084 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhJ1QjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:39:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C79E1617B6;
        Thu, 28 Oct 2021 12:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XUKSZdQvx8keuOvCFONjtgdG+RCzzgVfb/g48R
        upH6E=; b=QCDs5aKC9+tb9gy6IqgyetOCWiZjps2qpEMuHBoaWCK7MxBtLkGHkk
        +tqectbjyIdUBwMgqw28T3jiqd1HtsownXSlxvZ4oDCIf51Ue342HpHjpTgBEzzF
        WhE8UIfNYt7uwZyuY49X2u5gp0Pq2dzcpsfGIFYmTP/ssldPvZUOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3A931617B5;
        Thu, 28 Oct 2021 12:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 456FC1617B4;
        Thu, 28 Oct 2021 12:36:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Estelle <robertestelle@gmail.com>,
        Robert Estelle <robert.estelle@gmail.com>
Subject: Re: [PATCH v2] completion: fix incorrect bash/zsh string equality
 check
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
        <pull.1096.v2.git.git.1635200973354.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 09:36:33 -0700
In-Reply-To: <pull.1096.v2.git.git.1635200973354.gitgitgadget@gmail.com>
        (Robert Estelle via GitGitGadget's message of "Mon, 25 Oct 2021
        22:29:33 +0000")
Message-ID: <xmqq8rydt8by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36935954-380D-11EC-9B6C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4bdd27ddc87..8ca9b15f21d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -515,7 +515,7 @@ __gitcomp_file ()
>  # argument, and using the options specified in the second argument.
>  __git_ls_files_helper ()
>  {
> -	if [ "$2" == "--committable" ]; then
> +	if [ "$2" = "--committable" ]; then
>  		__git -C "$1" -c core.quotePath=false diff-index \
>  			--name-only --relative HEAD -- "${3//\\/\\\\}*"
>  	else
>
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf

Thanks.  We can trace this back to April 2013, if not earlier.  It
is sort of surprising that nobody else has noticed it since then
X-<.

Will queue.  Thanks, again.
