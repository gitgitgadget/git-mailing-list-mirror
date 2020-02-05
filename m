Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD3C35249
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646F621582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjvMb2ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgBEDTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:19:24 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37791 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgBEDTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:19:24 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so1148773ywd.4
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l9sbhNVcvT6HiCL9F3sZyuH5hjZUCDA3ZHNYOPD5raE=;
        b=HjvMb2ay0KNyDWRzAazgjTWPQOcWn1huaT8F3YrXucgG4diNd6vTZz3SaXoH2exH6P
         RwVfSfnSsOMXXkp/FsZWadnKtyjptlJ6URamMcg10x3iR8ZOspwShavheT93gU/IPX+2
         CJcHsyZVSIgp2Cm/5G9f3xBrmGeutkOyLxWPftsmiiYjt69cW0mwaAtSJevWy6qn+TX/
         BwtjocaOl/kZWrKZPXcj6cdKbnKp6/bLRfT0qD0GP1xY7pcG3CINaceeppFJO1JOKeAX
         Ko1VCuLhSVAiCOyh93jJkSLZS4dzK43moo/LoqWitf07Uegvfc8Ndifbw4TUrZ61Bj5M
         Y2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9sbhNVcvT6HiCL9F3sZyuH5hjZUCDA3ZHNYOPD5raE=;
        b=cr344Gy6XH5j4Ix+2uzKiP8/D+pCFln87jWzzI3Eo46E2LMTGmIEPZcDpts1BlLAg7
         UzSwJuMsg7xS5Yif7ASk/Ob77rro3N0v/kc+8Tw/2g3x9PAgUYhMYzMKiKgngnhemmoW
         /QwxoOVn/S1hrXtdNktmbddzxPqgIPdQrSyi+k6b8DGJjkwGL2Fts/5wyHPStK63BL7L
         4kbxN1tbzUyLVSmSKTrmGYzYSCphobA2pr46H9AmJsP/xKbwD/r5CWXwAIsw3IKfgqc/
         CUzCjAGbDIhoqSde7MELXlMtYE21QHik9qyXYutSr9NM/5/J4A0upAZLhg9L/QzkCHkf
         vk9w==
X-Gm-Message-State: APjAAAVVckCs3CAIpi4JZVbkSM4eJZG/P5chUQ4D2uqiUZLC5m2vCloN
        CLqVjOxIVtsULRtzcojvr/A=
X-Google-Smtp-Source: APXvYqzsTXwOtjqlqlEA45DxETPw/BoV9LXNQxldKzJfOwQoK5dsQCDqeSsHLRKr1/VfKzOD9xjVLQ==
X-Received: by 2002:a81:5dc1:: with SMTP id r184mr8714979ywb.433.1580872763231;
        Tue, 04 Feb 2020 19:19:23 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q130sm11287629ywg.52.2020.02.04.19.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 19:19:22 -0800 (PST)
Subject: Re: [PATCH 08/10] name-rev: pre-size buffer in get_parent_name()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <c7f22d8d-10f8-0c97-672e-0a50182901e0@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9b98835d-d94c-19f5-42ba-d583a33306cc@gmail.com>
Date:   Tue, 4 Feb 2020 22:19:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <c7f22d8d-10f8-0c97-672e-0a50182901e0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:24 PM, René Scharfe wrote:
> We can calculate the size of new name easily and precisely. Open-code
> the xstrfmt() calls and grow the buffers as needed before filling them.
> This provides a surprisingly large benefit when working with the
> Chromium repository; here are the numbers measured using hyperfine
> before:
> 
> Benchmark #1: ./git -C ../chromium/src name-rev --all
>   Time (mean ± σ):      5.822 s ±  0.013 s    [User: 5.304 s, System: 0.516 s]
>   Range (min … max):    5.803 s …  5.837 s    10 runs
> 
> ... and with this patch:
> 
> Benchmark #1: ./git -C ../chromium/src name-rev --all
>   Time (mean ± σ):      1.527 s ±  0.003 s    [User: 1.015 s, System: 0.511 s]
>   Range (min … max):    1.524 s …  1.535 s    10 runs

Nice!

> +	if (name->generation > 0) {
> +		strbuf_grow(&sb, len +
> +			    1 + decimal_width(name->generation) +
> +			    1 + decimal_width(parent_number));

Just curious: these strbuf_grow() calls are what _really_ improve the
performance, right? If you dropped them, then can we expect the performance
to be similar to the old code?

> +		strbuf_addf(&sb, "%.*s~%d^%d", (int)len, name->tip_name,
> +			    name->generation, parent_number);
> +	} else {
> +		strbuf_grow(&sb, len +
> +			    1 + decimal_width(parent_number));
> +		strbuf_addf(&sb, "%.*s^%d", (int)len, name->tip_name,
> +			    parent_number);
> +	}
> +	return strbuf_detach(&sb, NULL);
>  }
> 
>  static void name_rev(struct commit *start_commit,
> --
> 2.25.0
> 

