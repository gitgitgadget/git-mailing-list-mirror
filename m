Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A3C43617
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E511A6199B
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhEQOZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbhEQOXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 10:23:07 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260CC0613ED
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:10:12 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l25-20020a4a35190000b029020a54735152so1497873ooa.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKWXVLVqmyW5df0KOMiWd2irFiK/a1fhfq7sVjh9ub8=;
        b=gFiUoHou3KksnMgGmkzGjUQEr9o0HJEoPSV/o3JgJg8sfZm7Uydw91XMuBGp8ZQYrf
         pkN94nK+a2e98cWTzDYKzPdveAlrT7ZakJ27Xai0jn/njv14pGePTMA1nH3/O7CsD2fX
         tdRtrUlbJitwv3y02+vcxVvnQHYqU7cDsdZmcYly1BvrznLFidNcRrZ1YZ2qDi+tg9uS
         Nwt9YXeS4GFy7uV9B/8XkQ1+W3wJaLWTUASf+SAMdu0DXV471646Q8CfGs+PLhUzN/ZW
         2ExRw5hf8Z3iclAmivFR7rsYqdkjtD3c20O4+t3lMT4ASmATmgBwdxAGOKFLAGhRwhN8
         VWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKWXVLVqmyW5df0KOMiWd2irFiK/a1fhfq7sVjh9ub8=;
        b=pkPiuodC2I83r9+0ITCOy078EWidGutakn+tG/GsBKV+yuXk4Rw+doc88UJLWUEhOz
         WEvdrXM95570fTvhFcQJf67IQ+IU+Hn5LR/W+/SLkVzJwtrRI2n6gnRp1sEEzuPDpteF
         sPm55sSVhuOQRbC3fLl6815EYq5sWTCV1R2vWsm5Zk6ZBDmBrmkNhSSFacaN0cMvgHKH
         ipnjCgX1bHipeiOgbV1orC3DMNolciQdC2R7Jg5BTL0DKpjkWeFqUI6mRJgfz4TiUxSi
         QBhlFwqEYwijdFbvsuKs4Q2Jxd2tOqQ22AYfL2m36O6nAhR40MX/gUlzpbOfyMcWXocK
         3mEA==
X-Gm-Message-State: AOAM533vcR2jMrSMSihu+BUhTX/gSNO1JtsFqhMnX/r2pxuoSqdVLugj
        08oOSatldf+dvA536kkcxjY=
X-Google-Smtp-Source: ABdhPJyPGi39IuHvGsJH9dhnrxpOFGjj/wsE70thJiRTvItTEbLsH+HVvAr5YV0VXNhl7pKAwUY8Gw==
X-Received: by 2002:a4a:8e04:: with SMTP id q4mr102174ook.28.1621260611128;
        Mon, 17 May 2021 07:10:11 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:20ee:d66c:315:bb13])
        by smtp.gmail.com with ESMTPSA id k21sm3129233otr.3.2021.05.17.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:10:10 -0700 (PDT)
Subject: Re: [PATCH v2 09/13] merge-ort: avoid accidental API mis-use
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <becd451030183e6271646a4bf006c2466822326e.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <27adacaa-741b-b738-bba9-4d9131aace21@gmail.com>
Date:   Mon, 17 May 2021 10:10:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <becd451030183e6271646a4bf006c2466822326e.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Previously, callers of the merge-ort API could have passed an
> uninitialized value for struct merge_result *result.  However, we want
> to check result to see if it has cached renames from a previous merge
> that we can reuse; such values would be found behind result->priv.
> However, if result->priv is uninitialized, attempting to access behind
> it will give a segfault.  So, we need result->priv to be NULL (which
> will be the case if the caller does a memset(&result, 0)), or be written
> by a previous call to the merge-ort machinery.  Documenting this
> requirement may help, but despite being the person who introduced this
> requirement, I still missed it once and it did not fail in a very clear
> way and led to a long debugging session.

I empathize with your frustration here.

> Add a _properly_initialized field to merge_result; that value will be
> 0 if the caller zero'ed the merge_result, it will be set to a very
> specific value by a previous run by the merge-ort machinery, and if it's
> uninitialized it will most likely either be 0 or some value that does
> not match the specific one we'd expect allowing us to throw a much more
> meaningful error.

This approach is an interesting pattern to follow for future
efforts, too.

> +static unsigned RESULT_INITIALIZED = 0x1abe11ed; /* unlikely accidental value */
> +
>  struct traversal_callback_data {
>  	unsigned long mask;
>  	unsigned long dirmask;
> @@ -3746,6 +3748,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
>  	assert(opt->obuf.len == 0);
>  
>  	assert(opt->priv == NULL);
> +	if (result->_properly_initialized != 0 &&
> +	    result->_properly_initialized != RESULT_INITIALIZED)
> +		BUG("struct merge_result passed to merge_incore_*recursive() must be zeroed or filled with values from a previous run");
> +	assert(!!result->priv == !!result->_properly_initialized);
>  	if (result->priv) {
>  		opt->priv = result->priv;
>  		result->priv = NULL;
> @@ -3905,6 +3911,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
>  	result->clean &= strmap_empty(&opt->priv->conflicted);
>  	if (!opt->priv->call_depth) {
>  		result->priv = opt->priv;
> +		result->_properly_initialized = RESULT_INITIALIZED;
>  		opt->priv = NULL;
>  	}
>  }
> diff --git a/merge-ort.h b/merge-ort.h
> index d53a0a339f33..c011864ffeb1 100644
> --- a/merge-ort.h
> +++ b/merge-ort.h
> @@ -29,6 +29,8 @@ struct merge_result {
>  	 * !clean) and to print "CONFLICT" messages.  Not for external use.
>  	 */
>  	void *priv;
> +	/* Also private */
> +	unsigned _properly_initialized;
>  };

Will work as intended. Thank you for reducing developer friction.

Thanks,
-Stolee
