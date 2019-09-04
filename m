Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86701F461
	for <e@80x24.org>; Wed,  4 Sep 2019 09:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfIDJOH (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 05:14:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:52325 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbfIDJOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 05:14:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8CC5D3F4095;
        Wed,  4 Sep 2019 05:14:06 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 618BF3F4051;
        Wed,  4 Sep 2019 05:14:06 -0400 (EDT)
Subject: Re: [PATCH] trace2: use warning() directly in
 tr2_dst_malformed_warning()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <2492824a-6aff-8b82-801a-808ee944a99e@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <04604b38-73c1-23e2-77a0-cb716beb507e@jeffhostetler.com>
Date:   Wed, 4 Sep 2019 05:14:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <2492824a-6aff-8b82-801a-808ee944a99e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/25/2019 1:44 PM, René Scharfe wrote:
> Let warning() format the message instead of using an intermediate strbuf
> for that.  This is shorter, easier to read and avoids an allocation.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   trace2/tr2_dst.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index 5dda0ca1cd..c69857515f 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -215,13 +215,8 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>   static void tr2_dst_malformed_warning(struct tr2_dst *dst,
>   				      const char *tgt_value)
>   {
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
> -		    tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
> -	warning("%s", buf.buf);
> -
> -	strbuf_release(&buf);
> +	warning("trace2: unknown value for '%s': '%s'",
> +		tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
>   }
> 
>   int tr2_dst_get_trace_fd(struct tr2_dst *dst)
> --
> 2.23.0
> 

good catch!  thanks!

Jeff
