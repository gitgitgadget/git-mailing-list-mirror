Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BAB2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcGRSze (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:55:34 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35728 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbcGRSzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:55:31 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so200667pad.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 11:55:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4FP+lq7lefdm7ydefjWjo1ToNEd55eiMzB+hwx84x3U=;
        b=CQPwaQcOvBG9yTKA30mQ0wv10/uBOFSbLmlzg9FFvx1AZx8pEv5O7t0tuTsawuhMvm
         xCA/VBKIG2zVerUZYU4K9BZm4JwToRAWq1b1gAzlFgR/qJref5dLgjZriAV+4Y283NaM
         ua8rv8lZ5bYvGhNHWGtyR7wz84fAFDMNMkxKLM6YAEIdFuYqDxoK5g6JUtjEbh8AE2E1
         7ZEP7JtskNiKJZDGNAdxXlA3JDf+VaCGV0rt6eigcbRkoitilFkNdPBAywV22+H6h51L
         zsy/Bpq0IveWSlR0Sbg23LGjYqqtdQiYrA5rwXQfcNihyF+lhGCFElfrqMewusbIacDP
         G0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FP+lq7lefdm7ydefjWjo1ToNEd55eiMzB+hwx84x3U=;
        b=HbC6B7D95vObDY6/ESJgwn4s3bRUudHWO9KIkOYwGJZukxmO5xgc8eEY2cEZcSfuqH
         +H0LZE4WSs4Xt2aKS2f+z0OdRkpPQqZ9eQp44pL4LTvgksVPtIha0BpHIDJyixgtWuYh
         TweS8yCBGMNYU+KfTsxnkHOOxxppAujHH+iV2/zIQJrYyph/qZFwDeszvCCZoVRAOMYO
         kRyI8lx51enT+Uit53PcnQ0Ssa4kzHOIwnyLUXfdr+K0l9lY3NJs2+z1BliQMQwoRbLB
         Y/4UcCRvmEzmlTJ1lUwxo0EV4kIxy1csOk3c+CV86O4RAWYlRz1maeJciJnUGkUzhhkW
         tNBg==
X-Gm-Message-State: ALyK8tIFacXg2UCoZir89fVHpnMC4KgCEX+IX7ZzMQ5DBZHRr7GpDWfuxduUxCFJNXYBEw==
X-Received: by 10.66.7.199 with SMTP id l7mr58457997paa.136.1468868130765;
        Mon, 18 Jul 2016 11:55:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9154:f831:1491:8d12])
        by smtp.gmail.com with ESMTPSA id e68sm6755754pfk.1.2016.07.18.11.55.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 11:55:29 -0700 (PDT)
Date:	Mon, 18 Jul 2016 11:55:28 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
Message-ID: <20160718185527.GB29326@google.com>
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When updating large repositories, the LARGE_FLUSH limit (that is, the
> limit at which the window growth strategy switches from exponential to
> linear) is reached quite quickly. Use a conservative exponential growth
> strategy when that limit is reached instead.
>
> This optimization is only applied during stateless RPCs to avoid the
> issue raised and fixed in commit
> 44d8dc54e73e8010c4bdf57a422fc8d5ce709029.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 2 ++
>  1 file changed, 2 insertions(+)

Yay, thanks for this.

When this condition triggers (count >= 10240), we have already
experienced 10 rounds of negotiation.  Negotiation ought to have
finished by then.  So this is a pretty conservative change to try to
salvage an already bad situation.

The condition ensures that the exponential growth will go faster
than the previous heuristic of linear growth.

Memory usage grows with the number of 'have's to be sent.  Linear
growth didn't bound memory usage. This exponential growth makes memory
usage increase faster, but not aggressively so and the unbounded
memory usage is already something we'd want to address separately to
handle hostile servers.

All in all, this looks likely to allow negotiation to finish in fewer
rounds, speeding up fetch, without much downside, so for what it's
worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I'd expect us to need more aggressive improvements to negotiation in the
end (e.g. finding a way to order SHA-1s sent as 'have's to finish in
fewer rounds).  But this is a good start.  Thanks for writing it.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index b501d5c..3fcbda2 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -251,6 +251,8 @@ static int next_flush(struct fetch_pack_args *args, int count)
>  
>  	if (count < flush_limit)
>  		count <<= 1;
> +	else if (args->stateless_rpc && count >= flush_limit * 10)
> +		count = count * 11 / 10;
>  	else
>  		count += flush_limit;
>  	return count;
