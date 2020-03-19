Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1CC43332
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C2B207FC
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZr0Lf1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgCSReV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:34:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43106 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgCSReU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:34:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so1781735pfa.10
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7iu7YVw3Zo2BDYTeFg0xiBGmvqHPB/CJ1oaJ0Qffzxk=;
        b=gZr0Lf1MPLIoGdcKgCVDqL/QeKTeDrmO2Vc1p+jAUVEtt05GKAxL6M+M8a1bUwLouC
         3ubpEdKMaupO6dIUEwiAc+9PqjCfxl7XaH8ZjRwvCy1pkv3CyKH7EUYOWXa0rGbcZusR
         xG66OzjlqNYLmP3+yo0QowwLaUp6uF4nnhqwDOoeAF7l3fxJSu0TtcUIDnHPU4Pagxy3
         OtuiZpJ9cDZzEykgaODZauv7O3SsqzY0J+uny7ujBxhkRE6a2LDbne6Xmwng5gReNa6G
         wBKK+Hezy5WhB/dOL+7ijr7r7rndPCXFQOdgZMgqes4gFSX3w5I3WyioFthJXvgq82JC
         qA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iu7YVw3Zo2BDYTeFg0xiBGmvqHPB/CJ1oaJ0Qffzxk=;
        b=FPFxE/AIVOaJoOWcCSHGyg3+yHhEGe1L0LBnfleJmfPV14bBvcaAzdMdxEM7WabCG1
         /8mNzfXwCtlZEsG1usORHc1cU4w/dAdhwxwfLFcGcMFqL1PfnTa3cXs9rAqop4RrT0cY
         MyfUdqncX9SjO+ZCqAh4DL7EcSF/p2vVL6diu6UwNeZd7HsOSVUC7Wcd+zWE1Fgvr/L4
         G4YVUQ1wXRLMi5CnDYm5/HcZCDUs+Qc8p31VBRON2hUTJnJXYTwU9UmgCSEjdB98fnnw
         98bP1k+0ULtWhdaURyxysq4wvfBS4DZkDdcoSzLN38wyBXPMgnsY2E/HYIdgyAV6Kgo7
         PlEQ==
X-Gm-Message-State: ANhLgQ3wRgUD3EUCIpoVmd9WbBomuqW32O8XXz4zqbq/7RetsbV0dq8M
        mKENI6cKpTF9ycb/j2IRYYajRQiR
X-Google-Smtp-Source: ADFU+vvpTEO/aFc6KjDWXqpttXaMrSxTTx3goSGE0SDCUkEkwX/J4SHVbBjedhuA4TbAJki+y5rp7A==
X-Received: by 2002:a62:16d2:: with SMTP id 201mr4842738pfw.295.1584639259458;
        Thu, 19 Mar 2020 10:34:19 -0700 (PDT)
Received: from [192.168.206.100] ([223.182.205.212])
        by smtp.gmail.com with ESMTPSA id k3sm2875060pgh.34.2020.03.19.10.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:34:18 -0700 (PDT)
Subject: Re: [GSoC][PATCH 2/2] t4131: use helper function to replace test -f
 <path>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        harshitjain1371999@gmail.com
Cc:     git@vger.kernel.org
References: <20200319132957.17813-3-harshitjain1371999@gmail.com>
 <20200319164234.4441-1-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <555da203-0740-3d79-15cf-83c5a8d5dbae@gmail.com>
Date:   Thu, 19 Mar 2020 23:03:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319164234.4441-1-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-03-2020 22:12, Shourya Shukla wrote:
> Hello Harshit,
> 
>> Replace 'test -f' with the helper function 'test_path_is_file' as the helper function improves the code readability and also gives better error messages.
> 
> Again the same thing, you may follow what I stated before regarding commit messages.
> 
> The commit title can be of the form:
> 
> t4131: use helpers to replace test -f <path>
> 
> <<commit description>>
> 

Just curious, isn't the commit title already like that in this patch? 
The subject does read:

   [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>"

What am I missing?

-- 
Sivaraam
