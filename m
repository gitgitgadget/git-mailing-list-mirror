Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32404C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE20610A4
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhHRU6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:58:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65426 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhHRU6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 16:58:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E52C0B76;
        Wed, 18 Aug 2021 16:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eFTYhFimhQJx2jUgxKkccblRXqRHmqZhCKpSLA
        THSAs=; b=kxIhCTeEyZAVzuhFfXR9a+H+yduvR0+AYPrBAWasDRnLjFK/5lsoD0
        9BzB5nRVTFbGOIi5D2ba/QiVY2aX87JVbqhk0/lq3fgLD5y0iPgkcf0eBfVFAG9E
        IkL/umdHoNDJIGpYS+vFEpyE4qIdb5luA/0pXMwuSANNd1IJv3h7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA02C0B74;
        Wed, 18 Aug 2021 16:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F685C0B73;
        Wed, 18 Aug 2021 16:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: tcsh: Fix regression by drop of wrapper
 functions
References: <20210818132729.26021-1-tiwai@suse.de>
Date:   Wed, 18 Aug 2021 13:57:23 -0700
In-Reply-To: <20210818132729.26021-1-tiwai@suse.de> (Takashi Iwai's message of
        "Wed, 18 Aug 2021 15:27:29 +0200")
Message-ID: <xmqqtujm4gjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3662122-0066-11EC-B252-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> The cleanup of old compat wrappers in bash completion caused a
> regression on tcsh completion that still uses them.
> Let's update the tcsh call site as well for addressing it.
>
> Fixes: 441ecdab37fe ("completion: bash: remove old compat wrappers")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  contrib/completion/git-completion.tcsh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks.  Will queue.



> diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
> index 4a790d8f4ec1..ba797e5b3cd5 100644
> --- a/contrib/completion/git-completion.tcsh
> +++ b/contrib/completion/git-completion.tcsh
> @@ -80,8 +80,9 @@ else
>  	COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
>  fi
>  
> -# Call _git() or _gitk() of the bash script, based on the first argument
> -_\${1}
> +# Call __git_wrap__git_main() or __git_wrap__gitk_main() of the bash script,
> +# based on the first argument
> +__git_wrap__\${1}_main
>  
>  IFS=\$'\n'
>  if [ \${#COMPREPLY[*]} -eq 0 ]; then
