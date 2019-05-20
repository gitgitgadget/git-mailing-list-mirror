Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690411F462
	for <e@80x24.org>; Mon, 20 May 2019 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbfETQuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:50:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:30330 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388598AbfETQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:50:40 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 77F433F408D;
        Mon, 20 May 2019 12:50:39 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:995c:4aa3:4774:bbd8] (unknown [IPv6:2001:4898:a800:1012:4a90:4aa3:4774:bbd8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 228C23F408A;
        Mon, 20 May 2019 12:50:39 -0400 (EDT)
Subject: Re: [PATCH] trace2: fix up a missing "leave" entry point
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
References: <08be5aadbef7f6b404d2e1c47cf3657ced585ba1.1550874298.git.gitgitgadget@gmail.com>
 <20190510133738.4511-1-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1ef6ca23-8046-e0a1-16b8-14f14d4a4680@jeffhostetler.com>
Date:   Mon, 20 May 2019 12:50:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510133738.4511-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/10/2019 9:37 AM, Ævar Arnfjörð Bjarmason wrote:
> Fix a trivial bug that's been here since the shared/do_write_index
> tracing was added in 42fee7a388 ("trace2:data: add trace2
> instrumentation to index read/write", 2019-02-22). We should have
> enter/leave points, not two enter/enter points. This resulted in an
> "enter" event without a corresponding "leave" event.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   read-cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 61b043bac3..4fad4e3f9a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3131,7 +3131,7 @@ static int write_shared_index(struct index_state *istate,
>   	trace2_region_enter_printf("index", "shared/do_write_index",
>   				   the_repository, "%s", (*temp)->filename.buf);
>   	ret = do_write_index(si->base, *temp, 1);
> -	trace2_region_enter_printf("index", "shared/do_write_index",
> +	trace2_region_leave_printf("index", "shared/do_write_index",
>   				   the_repository, "%s", (*temp)->filename.buf);
>   
>   	if (ret)
> 

Good catch!

Thanks,
Jeff
