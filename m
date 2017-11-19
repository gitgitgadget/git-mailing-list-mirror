Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CE8202F2
	for <e@80x24.org>; Sun, 19 Nov 2017 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750784AbdKSI1G (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 03:27:06 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:43592 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbdKSI1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 03:27:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yflMC6GK2z5tlF;
        Sun, 19 Nov 2017 09:27:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 403642113;
        Sun, 19 Nov 2017 09:27:03 +0100 (CET)
Subject: Re: [PATCH 2/2] Reduce performance cost of the trace if trace
 category is disabled
To:     gennady.kupava@gmail.com
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
 <20171119004247.22792-1-gennady.kupava@gmail.com>
 <20171119004247.22792-2-gennady.kupava@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d9076fef-c90c-63f2-5e0e-37293810e3d9@kdbg.org>
Date:   Sun, 19 Nov 2017 09:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171119004247.22792-2-gennady.kupava@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.2017 um 01:42 schrieb gennady.kupava@gmail.com:
> +#define trace_printf_key(key, ...)					    \
> +	do {								    \
> +		if (trace_pass_fl(key))					    \
> +			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
> +					    __VA_ARGS__);		    \
> +	} while(0)
> +
> +#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__);
> +
> +#define trace_argv_printf(argv, ...)					    \
> +	do {								    \
> +		if (trace_pass_fl(&trace_default_key))			    \
> +		       trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
> +					    argv, __VA_ARGS__);		    \
> +	} while(0)
> +
> +#define trace_strbuf(key, data)						    \
> +	do {								    \
> +		if (trace_pass_fl(key))					    \
> +			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
> +	} while(0)
> +
> +#define trace_performance(nanos, ...)					    \
> +	do {								    \
> +		if (trace_pass_fl(key))					    \

The token "key" here looks suspicious. Did you mean &trace_perf_key?

> +			trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos,\
> +					     __VA_ARGS__);  		    \
> +	} while(0)
> +
> +#define trace_performance_since(start, ...)				    \
> +	do {								    \
> +		if (trace_pass_fl(&trace_perf_key))			    \
> +			trace_performance_fl(TRACE_CONTEXT, __LINE__,       \
> +					     getnanotime() - (start),	    \
> +					     __VA_ARGS__);		    \
> +	} while(0)
>   
>   /* backend functions, use non-*fl macros instead */
>   __attribute__((format (printf, 4, 5)))

-- Hannes
