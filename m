Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16AC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5580461278
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbhDMMMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbhDMMMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:12:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7EC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:12:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so4630742otl.11
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ1S67eG9/esg3pr6ZDAM8navcmsvH/hYxolnZ6uPgU=;
        b=FSWrpACfEwP3Lu6Q5a80HUf6+5jCMTpGR66dyH/4h1IX7JSQ1aG3KZH/ExJS1AKtzh
         5DEshqETFT2bOncV2ha93g+zKTUs1m/cSEABbydc8kTlg6+CtT0cCIO5viTV1WoM+r/f
         9DyoYKfSO2yf7VEAc7rF5nTa2M/521sPYRlkUJRsMXNhtlUqlwsZ7kbQxILOhjFXnKhi
         UVtBFuoUpbbud8d9rfvY5nifQMYvtHgaC5VSTd2yqmptkU9Gy4TTIYHVXRwqPpZNvd0w
         X7CsS+vwOowq8C9rdREuqNzHaNwvUO6YUSmgVLWkHULCzG0hb2Um3goidIt7NfG7PReL
         GMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ1S67eG9/esg3pr6ZDAM8navcmsvH/hYxolnZ6uPgU=;
        b=PiqHx8vhLAFnloUZ6qRW9Ho1ogpKhA9ePI9QZeNv6T7q6mgV49hecHPZuUgw4c/neL
         Nc+pbKsMhnZ+5FzwS9PyPMxOyQLhkM3KQ6HdJyZRWH8ntU1SeV4r+VOah4JPtQP5rMIF
         P++aZ9uSa54h6PQ/sYFRDnanhebrgMbdkND5bot6jzEThrUrPJXPnkSWy6arcBx47ZQ1
         ZqLpwSzX3dzkPa2y08MItdKkdQ7UfA27t9ocwtO+S2vB2rpryJQbVE3wMMCH+nEjFMGf
         TUIbxWYeoGwjeMHPWYbNCy2Ffbe3zF7hdPkqC3yKNV8RdHNYCTl3puDaCYdaF/nObiMQ
         G4Jw==
X-Gm-Message-State: AOAM530S+0O5UoINnQ4I/VaP4ZAtxhwNbZuEOJ5oT68L5q8nM8qqSFSW
        NFXWnF0Tsjz+hAeEkzKArZkK0Xxgnb2jPA==
X-Google-Smtp-Source: ABdhPJyT+uK7Rw60NceUHDaZrmAwwv/HCMuoXnCwiSXxgOm9fBnyysd9qKE2yjolMIVk65P4dcp18A==
X-Received: by 2002:a9d:7699:: with SMTP id j25mr28140926otl.177.1618315943260;
        Tue, 13 Apr 2021 05:12:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d9df:73fc:aa55:75a7? ([2600:1700:e72:80a0:d9df:73fc:aa55:75a7])
        by smtp.gmail.com with ESMTPSA id 93sm2475805otm.2.2021.04.13.05.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 05:12:22 -0700 (PDT)
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38f48634-077b-6351-5285-f8ecc6f552d0@gmail.com>
Date:   Tue, 13 Apr 2021 08:12:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210410152140.3525040-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2021 11:21 AM, brian m. carlson wrote:
> Now that we're working with multiple hash algorithms in the same repo,
> it's best if we label each object ID with its algorithm so we can
> determine how to format a given object ID. Add a member called algo to
> struct object_id.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hash.h b/hash.h
> index 3fb0c3d400..dafdcb3335 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>  
>  struct object_id {
>  	unsigned char hash[GIT_MAX_RAWSZ];
> +	int algo;
>  };

What are the performance implications of adding this single bit
(that actually costs us 4 to 8 bytes, based on alignment)? Later
in the series you add longer hash comparisons, too. These seem
like they will affect performance for existing SHA-1 repos, and
it would be nice to know how much we are paying for this support.

I assume that we already checked what happened when GIT_MAX_RAWSZ
increased, but that seemed worth the cost so we could have SHA-256
at all. I find the justification for this interoperability mode to
be less significant, and potentially adding too much of a tax onto
both SHA-1 repos that will never upgrade, and SHA-256 repos that
upgrade all at once (or start as SHA-256).

Of course, if there truly is no serious performance implication to
this change, then I support following the transition plan and
allowing us to be flexible on timelines for interoperability. It
just seems like we need to investigate what this will cost.

Thanks,
-Stolee
