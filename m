Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE48C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD89F2070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKX1BbXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgETNM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNMz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 09:12:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2313C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 06:12:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r22so1395326pga.12
        for <git@vger.kernel.org>; Wed, 20 May 2020 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ebUbqNaNGb2BWj7mnzTZKmLd0e599BDUa1Amy3O4rgQ=;
        b=CKX1BbXpepEzlHrPmsQzooZ2AncOuIPQuEVtIzYUM5FdNk7T+zLcBsBaWvX6aZFzqZ
         x6ehefXo5rOcIDiu9qHHQNeRbEYnKjz9qo+BJ4GFYY8AoA4WY3JJuPARBP5QRCAqdoky
         PipvZlFkpY927LHZBtj3OgRurZasusRfx80TP2A1kpFcdLsMei3kDYQa1RMPBaJqgQxP
         ilvVglwtBxvEbXNKW5yl8XToEowgKTtjJNx3+n165HMEW3duCPPyg7eq9WcltwNrxfj5
         QglGFPQts30zKWrOme6zr+L3N9kODSoyBID6KUDh0+PfQeTYJ7JTmTpo3DuZO0H8/kRB
         5HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ebUbqNaNGb2BWj7mnzTZKmLd0e599BDUa1Amy3O4rgQ=;
        b=jLf3ivVEGkfpWLMDUUzvqg6TG+rAL56hI3Fb8eUoEwFE9Exj762oRJlfiWQNUQxbZI
         TwJ1vkHjZgZCjuHD8/dgdyyN1OacFpgNfcv3TqWtnfN7aDfsYGOm5VQnNoexyCy5xghl
         E0k0w32v31bDvDp2Kebq4iXw0p4dCUmfS0GDtdzb7EMjyg+6HMbvAH06pkBHOhiP1K0I
         YlN0u7iFRgbuZiv8W1cvTm5Rcb95cSUc+mCFiSc3ZYkcuJMbTgcfo3rZsHB1q439hXQr
         fgeaN6QxcFpZtIKFOFAupK8CyroT1hmMw9/Sb2rnW1+96C2gxZu356EncrYFcNCTXgiq
         FCVw==
X-Gm-Message-State: AOAM530T5OhitxZoEaEi7ci0lSwAKFFs0wAYjwFyE3ktdVLet8ivsxae
        czRf/eVCfobENST+aW7EMhU=
X-Google-Smtp-Source: ABdhPJxm1GKiXbxdvXqmBlqz17QXg2vzDOK7+AAUub3f6ZZSMju9XfFC6RjffvVJ92EpYTmzBj2lag==
X-Received: by 2002:a63:df42:: with SMTP id h2mr4236003pgj.216.1589980374230;
        Wed, 20 May 2020 06:12:54 -0700 (PDT)
Received: from [192.168.43.191] ([106.198.27.32])
        by smtp.gmail.com with ESMTPSA id i12sm2122631pjk.37.2020.05.20.06.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 06:12:53 -0700 (PDT)
Subject: Re: [PATCH v2] submodule: port subcommand 'set-branch' from shell to
 C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, git@vger.kernel.org, congdanhqx@gmail.com
References: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
 <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com>
 <20200520121530.GA7992@konoha>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b96324d4-04bd-8f64-e334-d3613dc3be6f@gmail.com>
Date:   Wed, 20 May 2020 18:42:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520121530.GA7992@konoha>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On 20-05-2020 17:45, Shourya Shukla wrote:
> On 19/05 02:57, Eric Sunshine wrote:
>> On Tue, May 19, 2020 at 2:27 PM Shourya Shukla
>> <shouryashukla.oo@gmail.com> wrote:
>>> +       if (opt_branch && opt_default)
>>> +               die(_("--branch and --default do not make sense together"));
>>
>> A more precise way to say this is:
>>
>>      die(_("--branch and --default are mutually exclusive"));
> 
> Will that be clear to everyone? What I mean is maybe a person from a
> non-mathematical background (someone doing programming as a hobby maybe)
> will not grasp at this at one go and will have to search it's meaning
> online. Isn't it fine as-is?
> 

While "mutually exclusive" might be prominently used in mathematics. I 
don't think it is only understandable by people with a mathematical 
background.

Moreover, I see 183 results in 36 files for "mutually exclusive" in 
git.git (including translation files). So, this isn't anything new.

I agree with Eric's suggestion. It makes the error message concise which 
is a nice side benefit.

-- 
Sivaraam
