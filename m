Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D90C1F462
	for <e@80x24.org>; Wed, 29 May 2019 19:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfE2T7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:59:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59706 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2T7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:59:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A521778C4;
        Wed, 29 May 2019 15:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YuFByNBrW2ZgR2zhYTiu9Q5aPWA=; b=I98cPg
        +ZLcMg434kVGjJGYTUl1l0GUSRCInAvqBZBQ0pBKDttPte4F85VBHHmOVD/ndtbc
        LeH2VrhpBUDhoJ9V7wJ83TbRYWLDz5hnPlZv4omDf/MkplRxA/RWwkiPlg8OXUXD
        9UM7sbu1nWyvza6U6zD6dVkrU0X7Njpg96QLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJHcKDl941U09HHsOTzAcdoa0z9amV4T
        cpW03zfaoiF/wD+nPbM3zRCM9+3bIhRQbzHqFtB2MD16ziuY7WaJTerAAgfQrv+R
        CGo2qa7UIRyWRmZvN8O3C0OgN/6lLRG8XV5kX/aofPmio5OZXsZKQ2/oJMTnj0JB
        X5i9DQltlbs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 427ED778C3;
        Wed, 29 May 2019 15:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A14B8778C0;
        Wed, 29 May 2019 15:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] clone: respect user supplied origin name when setting up partial clone
References: <20190524000150.GD70860@google.com>
        <20190524001525.12952-1-delphij@google.com>
Date:   Wed, 29 May 2019 12:59:26 -0700
In-Reply-To: <20190524001525.12952-1-delphij@google.com> (Xin Li's message of
        "Thu, 23 May 2019 17:15:25 -0700")
Message-ID: <xmqqr28hxc9t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 445081DA-824C-11E9-B383-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> Signed-off-by: Xin Li <delphij@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  Can you add a test to demonstrate existing breakage without
this single-line code change in the same patch?

>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..822208a346 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1215,7 +1215,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			remote_head_points_at, &branch_top);
>  
>  	if (filter_options.choice)
> -		partial_clone_register("origin", &filter_options);
> +		partial_clone_register(option_origin, &filter_options);
>  
>  	if (is_local)
>  		clone_local(path, git_dir);
