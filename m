Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94798C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 19:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA622CF6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 19:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbhAXTMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 14:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbhAXTMh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 14:12:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92CC061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 11:11:57 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 63so10681729oty.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=907mDphqMx3/Oral6MK6lgWDqW6BhiIbOFxPNRw/UrM=;
        b=bzlmkrYUk60A7p0OfV85VqCNuiR+iqfYOXVR7uoeI8KanMINVt1oEp1qTgbZqt6NDm
         J+iV5kiFNPCW127QNnhgpRzPcUa3ynd6USx5HSGs5xbSr8TiavzB3b9Z1RnvAwjkTxF2
         YnckTZm/RZa6/3TeaO23AFgtARme9ebf9IECmiuAcxuucLy+KClFDA4ycfoaJO0908av
         MfioXN5rojrwxkif+W3yTqNyXRaqOhIdggMZasy81xFiMX5N2cripownykxlobWKVMCz
         EtxzBqljeRAY7erWCKaiXvE8QOWqzfnz61ZuytqRP9z1xoRXy7hnhkLHGydeWgjuaVRi
         z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=907mDphqMx3/Oral6MK6lgWDqW6BhiIbOFxPNRw/UrM=;
        b=nZXqWk88iCNVggUcH1vAhPax3qrR4ZmytP4+ueeyQ0PDd/shYZEwDzKEh8WRH3G6JR
         /m7vCdhJgCORuvN4NLDG7iJB+/c0oRgi/8TF8kpHOOeeXtnz8MBmr+8jQC2lfF5XCkcr
         IUmYXQqhAlEvWMXo6w5YNRylKUIX2K0jOAAsbWyNwqFDJxdm9o/8/469cdOO2cjgZiTm
         kGboj1L7JnwdJri7YoYhWqyo7f1r13lfRIyfnE0gzz2C/Nx1AQ8efpCWce3Zpy8CKUUo
         CyUZxxOjHiUtJ8ZTib7Gc4dSc82rVqOkzoGtJ1VTFIhj5sD43NT6BecmZlHcbj/p+CMd
         Oolg==
X-Gm-Message-State: AOAM533Cr6zcvLzK3VeJCl2LeyXOx28TTZzia529ma2k/1cvyp1IgSge
        zrcq4AcQPOS6HtqTD9PDxc8=
X-Google-Smtp-Source: ABdhPJztO76JClRfmf8iCu32W4d7ciclV2UrJqrLSOGAChKCRSPbydvs3TErIwgtlyaG/vjJlyeVWg==
X-Received: by 2002:a05:6830:148a:: with SMTP id s10mr114820otq.323.1611515516564;
        Sun, 24 Jan 2021 11:11:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:2848:4da0:c807:60aa? ([2600:1700:e72:80a0:2848:4da0:c807:60aa])
        by smtp.gmail.com with UTF8SMTPSA id g13sm2987467otl.60.2021.01.24.11.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:11:55 -0800 (PST)
Subject: Re: [PATCH v4 1/3] merge-ort: fix massive leak
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
References: <20210115192958.3336755-1-newren@gmail.com>
 <20210124060112.1258291-1-newren@gmail.com>
 <20210124060112.1258291-2-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e1c184f-4745-530d-8aca-879319786845@gmail.com>
Date:   Sun, 24 Jan 2021 14:11:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210124060112.1258291-2-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2021 1:01 AM, Elijah Newren wrote:
> When a series of merges was performed (such as for a rebase or series of
> cherry-picks), only the data structures allocated by the final merge
> operation were being freed.  The problem was that while picking out
> pieces of merge-ort to upstream, I previously misread a certain section
> of merge_start() and assumed it was associated with a later
> optimization.  Include that section now, which ensures that if there was
> a previous merge operation, that we clear out result->priv and then
> re-use it for opt->priv, and otherwise we allocate opt->priv.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 05c6b2e0dc..b5845ff6e9 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3227,11 +3227,28 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
>  	assert(opt->obuf.len == 0);
>  
>  	assert(opt->priv == NULL);
> +	if (result->priv) {
> +		opt->priv = result->priv;
> +		result->priv = NULL;
> +		/*
> +		 * opt->priv non-NULL means we had results from a previous
> +		 * run; do a few sanity checks that user didn't mess with
> +		 * it in an obvious fashion.
> +		 */
> +		assert(opt->priv->call_depth == 0);
> +		assert(!opt->priv->toplevel_dir ||
> +		       0 == strlen(opt->priv->toplevel_dir));
> +	}

So instead of simply leaking result->priv, we re-use the
data for the next round.

>  
>  	/* Default to histogram diff.  Actually, just hardcode it...for now. */
>  	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
>  
>  	/* Initialization of opt->priv, our internal merge data */
> +	if (opt->priv) {
> +		clear_or_reinit_internal_opts(opt->priv, 1);
> +		trace2_region_leave("merge", "allocate/init", opt->repo);
> +		return;
> +	}
>  	opt->priv = xcalloc(1, sizeof(*opt->priv));

and here you reset the data instead of reallocating it. OK.

-Stolee

