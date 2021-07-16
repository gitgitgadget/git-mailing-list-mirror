Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E3C636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905A9613DF
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhGPBbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGPBbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 21:31:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865EC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:28:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s193so7172460qke.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XohWtG1Rou+ev4ooDEV/GBYobee7lS/Ox0o9/fMkxXM=;
        b=ixA8n/5PXfI1gqgtRbduipYnwQ0KLMps1OjcUydX/hR3bUC39ceX1WI6XUeTlVN1Qs
         d6hkpy5tk0xX6hihYmrVLlr7dOUN2/FNqaAxloSfhUx49KOXPcuJdiCL/3VxEurulsq5
         sxL1Lr794o3ylwk8WTips8n3sVPpHmq/mvfSRD2OvIY97GGhmqcOZG0/WwPB3OVHkb+a
         donM0sofOhiuGurAtgwoAhgY3tAjeElKF9OAAz5d95CjVe/sFrFBGy3R82DWvh6zmeCy
         MiIFjonD2MzXxU63EL142dK83LcGVUSufJVpkROF+5UAj06mUPrXN1lkVmg4JW8f8RWp
         6xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XohWtG1Rou+ev4ooDEV/GBYobee7lS/Ox0o9/fMkxXM=;
        b=Npy7bYBSWCb9WV8HUHsCf0bBCDPkSOawcoOnnBTYIsuMhjxZjbXJSGkLkuoZCRB6un
         7h4PK9CyTdil/B7woHL9a/a63a4YSQwgv1hTM2nGG9aMNlCyohuXhIk29ZVR+DKEzopJ
         PhzXOZkEhBmxObk7nxuXXCIMFLMpau9RYEMxmCy1FnWbFOxebJt/c+oI8z0SqDoGEaSH
         2E6fwJRKof7e3bhZLp4rS2Y0xmJDdPod6UrnEClY0w+IgBWzvEss2uxxTV2aVj32Rs+O
         smVKKTRwZgHwuAcQr3ky30utUTEXcFBvAsxW9QESfuobxNTJTuySA2Zl7O20WKLupBTS
         Gsbg==
X-Gm-Message-State: AOAM531OQ+MDne6b56MEQDZgYn2Qx+vbc3skgM+yga72D2Dlr9qwxehH
        VdRVcOAKqrGI5Oe7rtBWAjA=
X-Google-Smtp-Source: ABdhPJxkejq7XPMW9qTF8mpE/SCus4D45mBZTYeuoTdr/xPGbvcwKpgzi1MM5aeX+ddZOzkgF9sZyw==
X-Received: by 2002:a37:a358:: with SMTP id m85mr7263956qke.285.1626398897817;
        Thu, 15 Jul 2021 18:28:17 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g4sm3281057qko.89.2021.07.15.18.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 18:28:17 -0700 (PDT)
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
 <8735sfzgkg.fsf@evledraar.gmail.com> <xmqqy2a7s8vh.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f85969ca-48e0-b2f1-6a42-7e4cc41a3639@gmail.com>
Date:   Thu, 15 Jul 2021 21:28:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2a7s8vh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-07-15 à 14:57, Junio C Hamano a écrit :
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> I'm a bit biased here since I like --recursive better, but let's not
>> drag that whole argument up again. I don't find the argument in
>> bb62e0a99fc (clone: teach --recurse-submodules to optionally take a
>> pathspec, 2017-03-17) convincing enough to have moved such a prominent
>> use-case to a longer option name.
> 
> I do agree that it is a separate topic to pick one or the other as
> the primary.  I think this change means that the users no longer
> need to stop after hitting a tab:
> 
>      clone --recurs<TAB>
> 
> and instead get to "clone --recurse-submodules" right away, which is
> a positigve change.  

This is indeed the goal, I'll update the commit message to make that
clearer.

Of course, if the separate topic swaps which is
> the canonical and which is the alias, the same user would get the
> new canonical one right away from the same state.
> 
> So it does look like a good change to me.
> 

Thanks,
Philippe.
