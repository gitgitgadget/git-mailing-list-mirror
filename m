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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31423C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23DE64E83
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBXRx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhBXRw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:52:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09FC06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:52:18 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x124so3032832qkc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+ehMkEyVmfVjKTS0gEMkmKJzU0ND4CR4n46+fiG3ar4=;
        b=Ha6i2sfbjptjsPv2M2RzU7e5Hqh8yovR1C/6H/TVsb3nfQEu0QAMS9Jk9yxnaS6GD+
         Y7XKh/5eAN15Py1AJ5nuywhxtD8ld30qr5e2TLsODDm6Cw2I1gTrEaEbCd8HpyGgGtk7
         hA7rlWcEAFBqw4szUdCYj/E0igYdU5fIPJfHwbkmOZ9ic8TFGA1UU21amd9VL35NRLBq
         cXBgbMO2UC7bqRtSMWI4tehWimdbgPMtQhd8AxidroFxGPs55UWJzpqUd4UrQHzsiXR1
         YXNtCJkDG9hsl5i77753/GJXz0V8aunA9ul+nVwoJRSp88GkgRjdOiNJhsVejZIXHSLD
         ilew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ehMkEyVmfVjKTS0gEMkmKJzU0ND4CR4n46+fiG3ar4=;
        b=jL80pVwDZleqcVi5opbeghGpj0eMlJJguK3b10Pz/EzSMj9qsd9lQbGxQZIbBWDZZP
         0iN59sgdOFLRkM94Ur5zmm3wY9Tk7d29O/+mDonCk9BMu02aPOwg7xyN1+VXyb9Gr/i0
         CrxfF9J1LnXFaqv5M7wACKzynAsXfMYU9Nwp/0ceC9VFRp59cTRUsoSBFtyT1TDLleYc
         ELJCzFq/R4153oOtZYBj8Y/URzk09v3MBFAejwZLR+gXwSLVlTPBIVVH8CaJn/kYw/uI
         JHZ1ULAkst87eRoMO5y1/EGS0yfYAmQOlZ5Kta3NkKcHE2rVX4ETQBPbuobdoh1fMenu
         c5CQ==
X-Gm-Message-State: AOAM533NvvSrsbLDrcGBcVqy2KY9v6oZz6teyWtMmIEtrVlErOFRNrPy
        71zI59Yz66NPhKCnnXNjIOc=
X-Google-Smtp-Source: ABdhPJwytr/ZxGs6ktqlWBVqnkUBudvwDJadhtHFdWepBF4ohF+p/yYELsIyZfccinLCprnvmCiDMQ==
X-Received: by 2002:a37:9a84:: with SMTP id c126mr31528746qke.399.1614189137580;
        Wed, 24 Feb 2021 09:52:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id x6sm1970009qkj.118.2021.02.24.09.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 09:52:16 -0800 (PST)
Message-ID: <bb2ca73b-f60b-0030-2b28-753da48bf7a5@gmail.com>
Date:   Wed, 24 Feb 2021 12:52:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v4 03/17] commit-graph: use chunk-format write API
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
 <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
 <20210224165242.GB3590451@szeder.dev> <YDaI9pVzW5wkK1aT@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YDaI9pVzW5wkK1aT@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2021 12:12 PM, Taylor Blau wrote:
> On Wed, Feb 24, 2021 at 05:52:42PM +0100, SZEDER Gábor wrote:
>> On Thu, Feb 18, 2021 at 02:07:25PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The commit-graph write logic is ready to make use of the chunk-format
>>> write API. Each chunk write method is already in the correct prototype.
>>> We only need to use the 'struct chunkfile' pointer and the correct API
>>> calls.
>>
>> This patch series messes up the "Writing out commit graph" progress
>> display, and starting at this commit I get:

Thanks for the report and identifying the exact place that caused the
mistake.
 
> I can confirm. It looks like we never dropped the 'num_chunks' variable,
> which should have happened in this patch.

Yes, makes sense. Hard to see that 'num_chunks' wasn't used because it
_was_ being used, just not as intended.

> @@ -1887,11 +1886,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  		strbuf_addf(&progress_title,
>  			    Q_("Writing out commit graph in %d pass",
>  			       "Writing out commit graph in %d passes",
> -			       num_chunks),
> -			    num_chunks);
> +			       get_num_chunks(cf)),
> +			    get_num_chunks(cf));
>  		ctx->progress = start_delayed_progress(
>  			progress_title.buf,
> -			num_chunks * ctx->commits.nr);
> +			get_num_chunks(cf) * ctx->commits.nr);

This is obviously correct. Thanks for the quick patch!

-Stolee
