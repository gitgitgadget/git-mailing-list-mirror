Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBD11F406
	for <e@80x24.org>; Tue, 19 Dec 2017 14:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964878AbdLSOTP (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 09:19:15 -0500
Received: from siwi.pair.com ([209.68.5.199]:35995 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934930AbdLSOTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 09:19:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 60FF6844E2;
        Tue, 19 Dec 2017 09:19:14 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 449A4844CB;
        Tue, 19 Dec 2017 09:19:14 -0500 (EST)
Subject: Re: [FYI PATCH] t/helper/test-lazy-name-hash: fix compilation
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20171218214947.210042-1-sbeller@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
Date:   Tue, 19 Dec 2017 09:19:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171218214947.210042-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/18/2017 4:49 PM, Stefan Beller wrote:
> I was compiling origin/master today with stricter compiler flags today
> and was greeted by
> 
> t/helper/test-lazy-init-name-hash.c: In function ‘cmd_main’:
> t/helper/test-lazy-init-name-hash.c:172:5: error: ‘nr_threads_used’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>       printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           nr,
>           ~~~
>           (double)avg_single/1000000000,
>           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           (avg_single < avg_multi ? '<' : '>'),
>           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           (double)avg_multi/1000000000,
>           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           nr_threads_used);
>           ~~~~~~~~~~~~~~~~
> t/helper/test-lazy-init-name-hash.c:115:6: note: ‘nr_threads_used’ was declared here
>    int nr_threads_used;
>        ^~~~~~~~~~~~~~~
> 
> I do not see how we can arrive at that line without having `nr_threads_used`
> initialized, as we'd have `count > 1`  (which asserts that we ran the
> loop above at least once, such that it *should* be initialized).
> 
> I do not have time to dive into further analysis.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   t/helper/test-lazy-init-name-hash.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
> index 6368a89345..297fb01d61 100644
> --- a/t/helper/test-lazy-init-name-hash.c
> +++ b/t/helper/test-lazy-init-name-hash.c
> @@ -112,7 +112,7 @@ static void analyze_run(void)
>   {
>   	uint64_t t1s, t1m, t2s, t2m;
>   	int cache_nr_limit;
> -	int nr_threads_used;
> +	int nr_threads_used = 0;
>   	int i;
>   	int nr;

Agreed. It should not be a problem.  Explicitly initializing it is fine.


Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>


