Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA3C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 12:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4108B610A3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 12:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhIJMIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhIJMIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 08:08:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DCC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 05:07:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e18so1078617qvo.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XL6GwTTzr2pavu2E30/yBUARPLhvEU5Xk+TlH/RQLYc=;
        b=R8hKoS3bFjKJFy8wQDI+nw70xPBBJ/MbRq9CtTqatb3+L+s/oBeTfuBENXmH/hVM/c
         psS/PI5WqgzCwAoMevmu2sm3yszXU+zKfUXKjr4MTSaC4EZVmzwmg7rNiiYXJuOZL4m+
         buUdTiWjyglwrjTdWw2cG55pn83tHZt5+zIilDKYF4mfYgeG2GcXhtyjMBVd9SwwJ/IV
         jFdKRJbf/DS9u7iwT7eWMB02SeA5NcwMqmJvXsptaMtlzJMxVjRzDedxhXav+h/06hf8
         kx8staeieC05GlBcOdKRU7npP6RkLjX8t3yERbhspxrRAM7dWkcYVZwON5ElE5M02h5u
         /OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XL6GwTTzr2pavu2E30/yBUARPLhvEU5Xk+TlH/RQLYc=;
        b=JwTs6wHMuZwC5ttCOkvlnzd8vWntuaKofq/1+kIzLwv3kSCeFxaRfzwhjqd78z4oMF
         EnxNgev7tsSdiV7Wulw89W8g1FE9waaOhgfPepKIDIEaULpoBxJcjvC2C13gLIOKMeQ8
         KmgFVIXNxTWuPXQi4p/SCxP5HRyto+zH1HQI7WfYfxMogtw335gdUvfwxbp7v/W58OQ5
         +/qLdx9yX3C6rFbB7413yNJUdIiwQeoZ6md3nyBC38qLwf7C963tari7irDmSy0pJ3qD
         756MlUX7x1M6Wk3MhyH/K7pdh0Sz9mEbm7fU+SN7ANlL40jMiPa0OfuV1Bm5sz+5SApg
         KoWQ==
X-Gm-Message-State: AOAM5311dYRY75kSVZEY+sZCI/opG0L/zfePvuPepKaglXy/UauNz+BG
        RQKI2ws1oqmQvhkSrr+Z5Q8=
X-Google-Smtp-Source: ABdhPJzz+0ZyaAmVtTUagJnrLTqGzd4rrb4YCVcijGrsl/Lah9tKE3luLuBExlQEx4pArH5xnFNZfQ==
X-Received: by 2002:a0c:de02:: with SMTP id t2mr8083698qvk.54.1631275625396;
        Fri, 10 Sep 2021 05:07:05 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y29sm3203691qtm.4.2021.09.10.05.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 05:07:04 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
 <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com>
 <408dc1d3-44b8-a955-4d7b-94f23fa8a6bc@gmail.com>
 <CABPp-BEbY0BqkBP4r-6XpGk46J+Y+W8+7cVZXQg5fuJXYOntDQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d4eff812-374a-0523-a490-ea3058db585f@gmail.com>
Date:   Fri, 10 Sep 2021 08:07:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEbY0BqkBP4r-6XpGk46J+Y+W8+7cVZXQg5fuJXYOntDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 2021-09-09 à 11:01, Elijah Newren a écrit :
> Hi,
> 
> On Thu, Sep 9, 2021 at 6:57 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
<snip>
>> merge-recursive.c:update_file_flags() does this
>> when updating the work tree
>>
>>          if (S_ISGITLINK(contents->mode)) {
>>
>>                   /*
>>
>>                    * We may later decide to recursively descend into
>>
>>                    * the submodule directory and update its index
>>
>>                    * and/or work tree, but we do not do that now.
>>
>>                    */
>>
>>                   update_wd = 0;
>>
>>                   goto update_index;
>>
>>          }
>>
>>
>>
>> so it looks like it does not update the submodule directory. Given
>> merge-ort is now the default perhaps it's time for rebase (and
>> cherry-pick/revert) to start reading the submodule config settings (we
>> parse the config before we know if we'll be using merge-ort so I don't
>> know how easy it would be to only parse the submodule settings if we are
>> using merge-ort).
> 
> I'd just parse any needed config in all cases.  The submodule settings
> aren't going to hurt merge-recursive; it'll just ignore them.  (Or are
> you worried about a mix-and-match of rebase calling both checkout and
> merge code doing weird things, and you'd rather not have the checkout
> bits update submodules if the merges won't?)
> 

Thanks for your input. I agree that reading the config in all cases would
be simpler. We could even decide that since ort is the new default, the
submodule support will not be "backported" to merge recursive (that would
be way simpler to implement, I think) This way we can just document it as
such and be done with it. But anyway, I think this is kind of
orthogonal to this here series and should be done separately.

Cheers,
Philippe.
