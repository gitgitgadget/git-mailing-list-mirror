Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B64C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717D464E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhBXRpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhBXRpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:45:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16856C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:44:56 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b24so2007342qtp.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/2dXybKSeBpoKza8/yGznBNVvlRjS/TLxphwrDCFBJ0=;
        b=X5v/O+8LfE2sEs2fWBSW9xMCOFU4d9pJYO5GiC252xGtayzcQio1rYI4tjMm1ZNgbB
         7AEIeGP6DbnSlPu14cujiCRMCJBhEkrppRUv5TCKTpXAjM265+WVtDZSN5pmvflma8VN
         eJ3s7j/JaxwVA2+Ud6pO0k1JyuAVeAoqZyAmPLXqXuYp/t6etR0B44jGTpT8zJvd2AGJ
         kukFHRblI5AlO4m+6BBVbPfYrav7gdWX5OSJmeExuf1wmirnjZzZKoUSXbHP0E2BHf7m
         m1C/ckMUgGfPYe1fzKImTcg5UhDketUsIT5p+yKb8CVTf5JzCxeb121pgS643cvGIo5S
         steg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/2dXybKSeBpoKza8/yGznBNVvlRjS/TLxphwrDCFBJ0=;
        b=GOSzjOFJ5ELzodLGd07ZiqYbkr5y8heH3sDj7NhPngbc9R3f1/kTLm+8f+j8hlZwz6
         VntCY243nimI74NsSdjyM+RExjswAo0X++UjrZyn20QCq1jXp79tF3lRNKUgkgvuOSr3
         PPD4mQAMIepF6JFO2t/SyffkIIEtfPq4qfYJeZ8RGHyZsumXVcX/aNZmIK9CYV7UbGfp
         AzJYRJ/nvVLXDEH2w0LcMwKTsW/TBToEoeWwWJZBzNqg35GCuSba5LoKs9AHR/FO2IGb
         OP5P1m/NQH72JmHqTvEuva0h26RSG7i6AWrEgJzenrt+jcp7IAwIRwW+hrLIn8Y0M2LV
         0znQ==
X-Gm-Message-State: AOAM5321v0ZHX8L5YFbOS4606QpvgoMmIyeTmH7WXL5fIOv4rC6VACYi
        V05+TEk28FAfxY/M80N8VOu2lSdAPfrIcA==
X-Google-Smtp-Source: ABdhPJyKm65IVlbhChowdMBNA248Dz75c4rvux8+NdhjM1/9BFPzjlZrVCJQhTdcXZCspGo1LDwwVA==
X-Received: by 2002:aed:3647:: with SMTP id e65mr29676631qtb.43.1614188695274;
        Wed, 24 Feb 2021 09:44:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id h4sm915188qkl.14.2021.02.24.09.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 09:44:54 -0800 (PST)
Message-ID: <9286ffba-7927-d12f-988f-36e67fcb882d@gmail.com>
Date:   Wed, 24 Feb 2021 12:44:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 10/10] diffcore-rename: use directory rename guided
 basename comparisons
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <805c101cfd849db3a5defb30775c7abbfec99f68.1614123848.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <805c101cfd849db3a5defb30775c7abbfec99f68.1614123848.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:44 PM, Elijah Newren via GitGitGadget wrote:
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28),
> this change improves the performance as follows:
> 
>                             Before                  After
>     no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
>     mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
>     just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s

Hooray!

> +	for (i = 0; i < rename_src_nr; ++i) {
> +		char *filename = rename_src[i].p->one->path;
> +		const char *base = NULL;
> +		intptr_t src_index;
>  		intptr_t dst_index;
>
> +		/* Is this basename unique among remaining sources? */

This comment sent me down a confusing direction. Perhaps, we can
instead say:

	/*
	 * If the basename is unique among remaining sources, then
	 * src_index will equal 'i' and we can attempt to match it
	 * to a unique basename in the destinations. Otherwise, use
	 * directory rename heuristics, if possible.
	 */

> +		base = get_basename(filename);
> +		src_index = strintmap_get(&sources, base);
> +		assert(src_index == -1 || src_index == i);
> +
> +		if (strintmap_contains(&dests, base)) {
>  			struct diff_filespec *one, *two;
>  			int score;
>  
> +			/* Find a matching destination, if possible */
> +			dst_index = strintmap_get(&dests, base);
> +			if (src_index == -1 || dst_index == -1) {
> +				src_index = i;
> +				dst_index = idx_possible_rename(filename, info);
> +			}

It is important that 'src_index == i' from this point on, no
matter whether it was unique or not.

> +			if (dst_index == -1)
> +				continue;
> +
> +			/* Ignore this dest if already used in a rename */
> +			if (rename_dst[dst_index].is_rename)
> +				continue; /* already used previously */
> +

This seems to match all of the complicated special cases.

Thanks,
-Stolee
