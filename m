Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C680C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5982123E54
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgLKCEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388577AbgLKCEH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 21:04:07 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DAC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:03:27 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id d8so6913949otq.6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6qNueoxTq3A0VO0PYlnc1jHGVkrFQ2SgB/MtaZK3F/8=;
        b=B4mf2rqA4HakasYn98sDoixpktFLHk/a6ChmqTm/DFU54k2PtEuu2YKpTeYjVvPi7F
         JqpS+msYSSK4fxzDJbeW6ozaawZJTR0Ky1jqaWaiwLeAhNlhox2+yZ/nR4SgmpSxqWBO
         wURMNBTD5LWGoJTzX/YiBF9Re+GnVGlH9BF+UCOIpJ2xzbCoTZZYuimoMjidKBl3eIU4
         dYC1AXj54NzqvXlzpEe/K8D7LadQI59BKVUNKIej+jNq0GWOvgwRwgMM55Rn00fnsytT
         6JlsmkHmYSnJLw0Smy6vWmcLxPs9I/SHSSoPakZ3e1JKccG4OV+Ew12ckJ0syYnLHM/n
         YQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6qNueoxTq3A0VO0PYlnc1jHGVkrFQ2SgB/MtaZK3F/8=;
        b=nFEtybe/GmKlrFGb0t6WrW843Q86CMj/AlkmaeZ06KrmP6oHyZytUDwtCgxTbc5FYE
         RmHdnd8oAIyWSIQZg5C2z6GX+9zJNwokpTAsV4mvh5wkhZNeXbjL4GXn/sKkm4f0yQpH
         NFjKPOj1Y0VqzObYfOk292bRFMNzTPF8he8/VDaqODlmPAFfdOBGlOyM4Mt9DALzY+80
         CS9FgdaQTJFreLkNgv2ymO5TiWegaPJSrYEs2C92NgZoLXGszCFysdRqr4xvTQYnfGfq
         DLo2XP9+EH1tkL0dR39SiuI3kOd488AJlrvOo6fvOpUgI1iC4IvyO+2Buth+Kd16BMUg
         DvzA==
X-Gm-Message-State: AOAM533YEcPBMglBvP2J8FlVK5Tok5u9knWj2T2tF2ERsRj/Dr4bwvg9
        /EqZIp+z3Le/OmoKAraZRlM=
X-Google-Smtp-Source: ABdhPJyJXBgUkEwkY+k1ftWckjflp9fq5XXSAPgBRZFQkdAvU2xr/n7kWF8PjVEy/MJgxquShvcJIQ==
X-Received: by 2002:a9d:1b29:: with SMTP id l38mr7025265otl.159.1607652206558;
        Thu, 10 Dec 2020 18:03:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id h62sm1548616oia.9.2020.12.10.18.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 18:03:25 -0800 (PST)
Subject: Re: [PATCH 01/11] merge-ort: add basic data structures for handling
 renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <ef8f315f828319a3390fde14e3aee6c5e587405e.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38f68a01-4d22-d88d-dfda-c85f67340819@gmail.com>
Date:   Thu, 10 Dec 2020 21:03:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <ef8f315f828319a3390fde14e3aee6c5e587405e.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> This will grow later, but we only need a few fields for basic rename
> handling.

Perhaps these things will be extremely clear as the patch
series continues, but...

> +struct rename_info {
> +	/*
> +	 * pairs: pairing of filenames from diffcore_rename()
> +	 *
> +	 * Index 1 and 2 correspond to sides 1 & 2 as used in
> +	 * conflict_info.stages.  Index 0 unused.

Hm. This seems wasteful. I'm sure that you have a reason to use
index 0 in the future instead of just avoiding instances of [i-1]
indexes.

> +	 */
> +	struct diff_queue_struct pairs[3];
> +
> +	/*
> +	 * needed_limit: value needed for inexact rename detection to run
> +	 *
> +	 * If the current rename limit wasn't high enough for inexact
> +	 * rename detection to run, this records the limit needed.  Otherwise,
> +	 * this value remains 0.
> +	 */
> +	int needed_limit;
> +};
> +
>  struct merge_options_internal {
>  	/*
>  	 * paths: primary data structure in all of merge ort.
> @@ -96,6 +115,11 @@ struct merge_options_internal {
>  	 */
>  	struct strmap output;
>  
> +	/*
> +	 * renames: various data relating to rename detection
> +	 */
> +	struct rename_info *renames;
> +

And here, you create this as a pointer, but...
>  	/* Initialization of opt->priv, our internal merge data */
>  	opt->priv = xcalloc(1, sizeof(*opt->priv));
> +	opt->priv->renames = xcalloc(1, sizeof(*opt->priv->renames));

...unconditionally allocate it here. Perhaps there are other cases
where 'struct merge_options_internal' is allocated without the renames
member?

Searching merge-ort.c at this point does not appear to have any
other allocations of opt->priv or struct merge_options_internal.
Perhaps it would be best to include struct rename_info not as a
pointer?

If you do have a reason to keep it as a pointer, then perhaps it
should be freed in clear_internal_opts()?

Thanks,
-Stolee
