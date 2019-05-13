Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305371F461
	for <e@80x24.org>; Mon, 13 May 2019 02:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEMC5G (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 22:57:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62417 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMC5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 22:57:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1B8D65582;
        Sun, 12 May 2019 22:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NVjmZg3+fDazWfp1FBcfWqS8ZS8=; b=B11uSV
        DzAvtlrAiUCLKSX+cG+WFlPzRrxop2xyfkqN31iquVzy57u0wjtqSvmxl0YHFzzY
        M8ASTJOYV4OCjSkldcK1la/lP18i1qB2POUsFQZiwr9SFBF7ZQYMtJwZ/lIRT6qo
        lbSSzk5On0eAEDrk6otRbnZHDusyWhWs/ygk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tdy6gZjtCCb2BKmdjwQxoaN1GzB4QzeL
        mIv6HVPfjko5Cxv3sBpi3wGPuiKSpR3HesWBUJ4cjxFzxX20daKzXzIHLQXTojE6
        /RjqMH9UcUDjfTxgXUJZl7x8QID3fjFOLU/toRHf9rOa2tB1yn0pHeXPkUdyzJBr
        WDf4CjozBYo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB20F65581;
        Sun, 12 May 2019 22:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 09E966557F;
        Sun, 12 May 2019 22:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/11] commit-graph: fix the_repository reference
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
        <0be7713a255d6f52c51ccb19299d0c9797e9a03f.1557411749.git.gitgitgadget@gmail.com>
Date:   Mon, 13 May 2019 11:56:58 +0900
In-Reply-To: <0be7713a255d6f52c51ccb19299d0c9797e9a03f.1557411749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 09 May 2019
        07:22:31 -0700 (PDT)")
Message-ID: <xmqqbm07dptx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7ACB2DA-752A-11E9-948B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The parse_commit_buffer() method takes a repository pointer, so it
> should not refer to the_repository anymore.

Yup, makes sense.  Thanks for spotting.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index a5333c7ac6..e4d1233226 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -443,7 +443,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	item->date = parse_commit_date(bufptr, tail);
>  
>  	if (check_graph)
> -		load_commit_graph_info(the_repository, item);
> +		load_commit_graph_info(r, item);
>  
>  	return 0;
>  }
