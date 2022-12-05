Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC8C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiLEPBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiLEPBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 10:01:45 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017FDFCE
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 07:01:44 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1FC41CA1268;
        Mon,  5 Dec 2022 10:01:44 -0500 (EST)
Received: from [192.168.1.88] (124.sub-174-216-8.myvzw.com [174.216.8.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AE8E9CC8324;
        Mon,  5 Dec 2022 10:01:43 -0500 (EST)
Message-ID: <b90fb6ba-a94d-144c-a209-d3544c8b2ec6@jeffhostetler.com>
Date:   Mon, 5 Dec 2022 10:01:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] maintenance: use xcalloc instead of xmalloc where
 possible
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
References: <pull.1390.git.git.1670251713061.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1390.git.git.1670251713061.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/5/22 9:48 AM, Rose via GitGitGadget wrote:
> From: Seija <doremylover123@gmail.com>
> 
> We can avoid having to call memset by calling xcalloc directly
> 
> Signed-off-by: Seija doremylover123@gmail.com
> ---
>      maintenance: use xcalloc instead of xmalloc where possible
>      
>      We can avoid having to call memset by calling xcalloc directly
>      
>      Signed-off-by: Seija doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v1
> Pull-Request: https://github.com/git/git/pull/1390
> 
>   remote.c    | 4 +---
>   submodule.c | 3 +--
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 60869beebe7..75315f3563f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2741,9 +2741,7 @@ void apply_push_cas(struct push_cas_option *cas,
>   
>   struct remote_state *remote_state_new(void)
>   {
> -	struct remote_state *r = xmalloc(sizeof(*r));
> -
> -	memset(r, 0, sizeof(*r));
> +	struct remote_state *r = xcalloc(1, sizeof(*r));
>   

We have a macro to make this easier and hide the messy details:

	struct remote_state *r;

	CALLOC_ARRAY(r, 1);


Jeff
