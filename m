Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34520C32771
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 18:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIOSrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOSrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 14:47:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51E9A99C
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 11:47:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CFC91B18DF;
        Thu, 15 Sep 2022 14:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XR6V90PyU5lz7ZTqabxrZpsw24ofQAEqvP0SRc
        gdIVA=; b=olE3xebtE30/fEhSZK2BPgfo03mE5QDdVy7G1ji0v7kHIEf3sx2IFs
        Bj2cu+6iaxcbjnsvDUd0jc9GuAqUbN+grddQ8liFkVTrYaDFfUAspvOv8RC7iabb
        uJOtTNfGCS3o3ZJ8ok7Pv5nBVf6Pxz4eVYDH0ujlH75eGz9nwoA9k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 263021B18DE;
        Thu, 15 Sep 2022 14:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B07F81B18DD;
        Thu, 15 Sep 2022 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff-merges: cleanup func_by_opt()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-2-sorganov@gmail.com>
Date:   Thu, 15 Sep 2022 11:47:24 -0700
In-Reply-To: <20220914193102.5275-2-sorganov@gmail.com> (Sergey Organov's
        message of "Wed, 14 Sep 2022 22:31:00 +0300")
Message-ID: <xmqqfsgsmq4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7691DE8-3526-11ED-9122-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Get rid of unneeded "else" statements in func_by_opt().

While it is true that loss of "else" will not change what the code
means, this change feels subjective and I'd say it falls into "once
committed, it is not worth the patch noise to go in and change"
category, not a "clean-up we should do".

I haven't looked at diff-merges.c for quite a while, but I did.  I
notice that the code is barely commented on what each helper
function is supposed to do, etc., and very hard to follow.  The file
needs cleaning up in that area a lot more, I would say.

Thanks.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 7f64156b8bfe..780ed08fc87f 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -60,15 +60,15 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
>  		return suppress;
>  	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
>  		return set_first_parent;
> -	else if (!strcmp(optarg, "separate"))
> +	if (!strcmp(optarg, "separate"))
>  		return set_separate;
> -	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
> +	if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
>  		return set_combined;
> -	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
> +	if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
>  		return set_dense_combined;
> -	else if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
> +	if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
>  		return set_remerge_diff;
> -	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
> +	if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
>  		return set_to_default;
>  	return NULL;
>  }
