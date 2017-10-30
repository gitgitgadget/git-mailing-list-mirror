Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516141FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdJ3Msx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:48:53 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:51845 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdJ3Msw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:48:52 -0400
Received: by mail-qt0-f180.google.com with SMTP id h4so16129490qtk.8
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pl1isGPJnwD6/v1ahsZIWLS5NWm8lzCQvWiVRqsG4XA=;
        b=DDMrG/c4vNyrG7AUh2Po+hlfO3dCTkA60HzEtQqw7gKvmbn3Aywjk33S616wQo1y14
         sn9RQyCRoZSfc17WQk0/ZGSRKjxc4euFzXNWfV9IQGGTFb1LNnUAeKp7j7wtdPRVhYMh
         Ec/XgsbIZdo687OPHyvB+2OOdsbnuhL7FhGt4Iq9X3gk3s2XGw2yaR33cTnKa1fIlAC+
         Ohpwr5fAtk+NYZPeozfs84g4vDvVawtFpKvEQQYM57s4xKFdYlZe2BYvAYkkGU8/rkCK
         iJKv/k4dGmbbPA2XoJR2k8iuDSzGcADbj65kBmsHVOKO4M/xX89nr8WMOaYLpQ7zsyVJ
         6fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pl1isGPJnwD6/v1ahsZIWLS5NWm8lzCQvWiVRqsG4XA=;
        b=Iho8FmzQTagjyZvw1NpBv5aoLfXLyTP+MKispbApFfLZVRtBFCT47LOYZAicOAeuMF
         JezGsEHiuaZsaNIh57450qPeOrm1LH8lxsL/eyXRpDfAOt/cPHPrsfnNvRpUm6TMZy8S
         NExEPQPhjSZsp3zOso7gIOZ0i3/obA1xAXQNlpuEGGYRPGkGyrX746QF5sG1gCZnsN30
         hTs6VK31CCfxLxVXE5MPtPFkzX+Sq9gFaz2G3HwWHMgpdwkrGmhfzeN8yMRyZ9Ivm/0G
         Rah53VyVuKcCO0i/SqP76a/78liJDEN6wmuqHH8CNNU6PEplLzGvmpWhDswMO2KypmQJ
         h+FA==
X-Gm-Message-State: AMCzsaWqP/PgotolUM5Fre7pP01OIXw/XkUkW3ko5zGgQB/s/01TlJGj
        LDkSYseel/JdEgvEe5Drzg8=
X-Google-Smtp-Source: ABhQp+S9tvJr0XPlXjxym67VSbKYiLWcf9Ru4GsYig8Vp55sLC/o93ne0i0cMoDz9wUKK4NwYph9XA==
X-Received: by 10.200.19.11 with SMTP id e11mr13592689qtj.68.1509367731771;
        Mon, 30 Oct 2017 05:48:51 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d5sm6163036qkf.44.2017.10.30.05.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2017 05:48:50 -0700 (PDT)
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com
Cc:     chriscool@tuxfamily.org, t.gummerer@gmail.com, l.s.r@web.de,
        jsorianopastor@gmail.com, peff@peff.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <20171024144544.7544-1-benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
Date:   Mon, 30 Oct 2017 08:48:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171024144544.7544-1-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any updates or thoughts on this one?  While the patch has become quite 
trivial, it does results in a savings of 5%-15% in index load time.

I thought the compromise of having this test only run when DEBUG is 
defined should limit it to developer builds (hopefully everyone 
developing on git is running DEBUG builds :)).  Since the test is trying 
to detect buggy code when writing the index, I thought that was the 
right time to test/catch any issues.

I am working on other, more substantial savings for index load times 
(stay tuned) but this seemed like a small simple way to help speed 
things up.

On 10/24/2017 10:45 AM, Ben Peart wrote:
> There is code in post_read_index_from() to detect out of order cache
> entries when reading an index file.  This order verification adds cost
> to read_index_from() that grows with the size of the index.
> 
> Put this on-disk data-structure validation code behind an #ifdef DEBUG
> so only debug builds have to pay the cost.
> 
> The effect can be seen using t/perf/p0002-read-cache.sh:
> 
> Test w/git repo                       HEAD            HEAD~1
> ----------------------------------------------------------------------------
> read_cache/discard_cache 1000 times   0.42(0.01+0.09) 0.48(0.01+0.09) +14.3%
> read_cache/discard_cache 1000 times   0.41(0.03+0.04) 0.49(0.00+0.10) +19.5%
> read_cache/discard_cache 1000 times   0.42(0.03+0.06) 0.49(0.06+0.04) +16.7%
> 
> Test w/10K files                      HEAD            HEAD~1
> ---------------------------------------------------------------------------
> read_cache/discard_cache 1000 times   1.58(0.04+0.00) 1.71(0.00+0.07) +8.2%
> read_cache/discard_cache 1000 times   1.64(0.01+0.07) 1.76(0.01+0.09) +7.3%
> read_cache/discard_cache 1000 times   1.62(0.03+0.04) 1.71(0.00+0.04) +5.6%
> 
> Test w/100K files                     HEAD             HEAD~1
> -----------------------------------------------------------------------------
> read_cache/discard_cache 1000 times   25.85(0.00+0.06) 27.35(0.01+0.06) +5.8%
> read_cache/discard_cache 1000 times   25.82(0.01+0.07) 27.25(0.01+0.07) +5.5%
> read_cache/discard_cache 1000 times   26.00(0.01+0.07) 27.36(0.06+0.03) +5.2%
> 
> Test with 1,000K files                HEAD              HEAD~1
> -------------------------------------------------------------------------------
> read_cache/discard_cache 1000 times   200.61(0.01+0.07) 218.23(0.03+0.06) +8.8%
> read_cache/discard_cache 1000 times   201.62(0.03+0.06) 217.86(0.03+0.06) +8.1%
> read_cache/discard_cache 1000 times   201.64(0.01+0.09) 217.89(0.03+0.07) +8.1%
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> Notes:
>      Base Ref: master
>      Web-Diff: https://github.com/benpeart/git/commit/95e20f17ff
>      Checkout: git fetch https://github.com/benpeart/git no_ce_order-v2 && git checkout 95e20f17ff
>      
>      ### Interdiff (v1..v2):
>      
>      ### Patches
> 
>   read-cache.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 65f4fe8375..fc90ec0fce 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1664,6 +1664,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>   	return ce;
>   }
>   
> +#ifdef DEBUG
>   static void check_ce_order(struct index_state *istate)
>   {
>   	unsigned int i;
> @@ -1685,6 +1686,7 @@ static void check_ce_order(struct index_state *istate)
>   		}
>   	}
>   }
> +#endif
>   
>   static void tweak_untracked_cache(struct index_state *istate)
>   {
> @@ -1720,7 +1722,9 @@ static void tweak_split_index(struct index_state *istate)
>   
>   static void post_read_index_from(struct index_state *istate)
>   {
> +#ifdef DEBUG
>   	check_ce_order(istate);
> +#endif
>   	tweak_untracked_cache(istate);
>   	tweak_split_index(istate);
>   }
> 
> base-commit: c52ca88430e6ec7c834af38720295070d8a1e330
> 
