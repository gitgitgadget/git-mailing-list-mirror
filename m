Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A6C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B43564E56
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 10:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBHKko (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 05:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhBHKid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 05:38:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B23C06174A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 02:37:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so16515007wrz.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rWCQs2oHscjWzD4FTv6bPnWs0qA5RtyYL0bAgGTkHWA=;
        b=YiqDULj7Ws1OOoXSvyuq64zjhifPil5al9wrqVHG3mxjH2u9nBVsC0aPrWqoCASM/P
         afz+HJQehsGj1Weh1HwwovE593rV1rhPFszzMfNhfbS/Ft7RDZy7b9eRShPOxFa+oelx
         tWDjZnm5+wFfU18/7wRz9fgYmDYBYYuNc+q97BEDyhT9drESUy1mIyOtmN80lhzqZCSR
         vGaz11i6ozfV8RBAyG3Ni6rZ8WJ9rGFleIU4eDp92vRPx7K2ATyzmhSkSGsiTMQ+blag
         aFKidhLQV0xgZipL8vKA5C0nkYQtqRldM5AEbSzetJ+LNbXWVhE2RcP9RiPcYoccttHX
         fFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rWCQs2oHscjWzD4FTv6bPnWs0qA5RtyYL0bAgGTkHWA=;
        b=Oai7K911ZlZGU15hgUgE6FLJB9tVDi6GT7Pmb44ATDDplOmNZU3uPZKC6pnfOka2l0
         TdK8KRQOLP7LMzKKGHV8Qi8yQ8o8lMEZwIy4wugFgPXOztQtdNco56Y8BtMILCOJtrRj
         ijm6tCgKdonjCER9+VRz5nnQOm6CnZTt7X584AWwXKdqINPUIrOjxDoWZjxgfS2fRqD3
         G4cd0GOVfz+ZOwi3Z3UeGPBvk+f3KT3W8gvkwDsDU0WmPfWWYoaY4EnvxzH/jiSzT7Pr
         pmx7Xmxeg3XRAWjNHP8uliK9FpSefFSu8EWCJIxcrDFXEJ035APqX575zO30oTKiwu4M
         mmhg==
X-Gm-Message-State: AOAM533Ez9vy9+qMmTvUDvOqUcKfNjdeHKPUD9Jgm0zunCaQovewlUX7
        pP1OaPz2Fme/dVGnfqUDywM=
X-Google-Smtp-Source: ABdhPJzVRdLiVCVCcB2/sgpGS/AwHTDMSfaI/AM11zWrQBuz+zgJ/YaBwXDMQzKVAcdMRwNhwXjWcA==
X-Received: by 2002:adf:ed45:: with SMTP id u5mr19061119wro.358.1612780670039;
        Mon, 08 Feb 2021 02:37:50 -0800 (PST)
Received: from [192.168.1.240] (14.16.7.51.dyn.plus.net. [51.7.16.14])
        by smtp.gmail.com with ESMTPSA id c5sm28771771wrn.77.2021.02.08.02.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:37:49 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] t3437: fix indendation of the here-doc
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20210207181439.1178-1-charvi077@gmail.com>
 <20210207181439.1178-6-charvi077@gmail.com>
 <CAPig+cQ+_neX_FLCQawG44US6Rtu_4wgVe+HMNseh7AvjTu=Qg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d000c590-728b-6105-db4d-eed57975fcbb@gmail.com>
Date:   Mon, 8 Feb 2021 10:37:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ+_neX_FLCQawG44US6Rtu_4wgVe+HMNseh7AvjTu=Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chariv and Eric

On 07/02/2021 18:54, Eric Sunshine wrote:
> On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
>> In the test scripts, the here-doc body and EOF are indented the same
>> amount as the command which opened the here-doc. Let's remove
>> one level of indendation.
> 
> s/indendation/indentation/
> 
> I found "In the test scripts" ambiguous. It isn't clear if you are
> talking about all test scripts or the script(s) this patch is fixing
> up. Sp, if you happen to re-roll for some reason, perhaps clarify by
> saying something like:
> 
>      The most common way to format here-docs in Git test scripts is for
>      the body and EOF to be indented the same amount as the command
>      which opened the here-doc. Fix a few here-docs in this script to
>      conform to that standard.
> 
>> Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> I don't think this new patch is based upon Phillip's, so you can
> probably drop this attribution.

Good point - well spotted as ever Eric

Thanks

Phillip
>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
