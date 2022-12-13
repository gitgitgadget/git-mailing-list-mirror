Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56809C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 20:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiLMUQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiLMUQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 15:16:04 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90F25285
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 12:15:25 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 74C31CA124E;
        Tue, 13 Dec 2022 15:15:24 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4A950CC833E;
        Tue, 13 Dec 2022 15:15:24 -0500 (EST)
Message-ID: <b9dc32bb-628c-4056-4c16-21bd51ad94fc@jeffhostetler.com>
Date:   Tue, 13 Dec 2022 15:15:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] http-fetch: invoke trace2_cmd_name()
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20221212224630.2553391-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20221212224630.2553391-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/12/22 5:46 PM, Jonathan Tan wrote:
> ee4512ed48 ("trace2: create new combined trace facility", 2019-02-
> 22) introduced trace2_cmd_name() and taught both the Git built-ins and
> some non-built-ins to use it. However, http-fetch was not one of them
> (perhaps due to its low usage at the time).
> 
> Teach http-fetch to invoke this function. After this patch, this
> function will be invoked right after argument parsing, just like in
> remote-curl.c.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was discovered at $DAYJOB after we noticed that there were command
> names missing in the trace whenever a user did a fetch that involved
> packfile offloading.
> ---
>   http-fetch.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/http-fetch.c b/http-fetch.c
> index 31bc5c7767..258fec2068 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -5,6 +5,7 @@
>   #include "walker.h"
>   #include "strvec.h"
>   #include "urlmatch.h"
> +#include "trace2.h"
>   
>   static const char http_fetch_usage[] = "git http-fetch "
>   "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
> @@ -137,6 +138,8 @@ int cmd_main(int argc, const char **argv)
>   	if (nongit)
>   		die(_("not a git repository"));
>   
> +	trace2_cmd_name("http-fetch");
> +
>   	git_config(git_default_config, NULL);
>   
>   	if (packfile) {

LGTM

Thanks for catching this.
Jeff
