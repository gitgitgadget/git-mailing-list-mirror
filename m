Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10DC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiBQLFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:05:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiBQLFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:05:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F020D2256
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:05:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso5858434wmq.4
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C1gBVfF0UupXuPdZ73lyh5DHDCLgYNZc5gMM0eJ7zng=;
        b=FHW7+DoiAhiZYJNlDFL1vsCruancxGp9m4CrGPS1ok8ZVxCrpme9nOxR7l6Cq1S/GA
         kzL8tkksw+ufhZU4yOWnqmP6d7j3b9BvxSgAwrvW7gsyp4cKGiFjEgEkv0trM1mwa2iJ
         wRrE3YyH2VDb2novGItxel6j+gSUcW+3z+TTZo146bJK2Al3NCRQp/RRJZwPcJCdn7SB
         1pXBWT3eaoigNNSvNOIlS/GXXMWK7iKmJuk7rQe1FVCnBzswpOPhsaVmkQaKzEVymjuj
         EH1EaMcoG4c/UJtoyCi2D1yFeAa4b5ZlvE0MdXrSivuc1UolEoAKCYDvl+1ZDO5+76Ua
         Swww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C1gBVfF0UupXuPdZ73lyh5DHDCLgYNZc5gMM0eJ7zng=;
        b=mBHK8ivrzriLo3d9tcSshCoGduEAXRPDW3BhCUhZqvqWaQxlNvAjP3T+kYy9XiNcae
         rMQ8d5EKH78CKjIsx1wNiUG1W87XsaAknzk+3iu4aCpFFRQIVwTaowp5G4FUIH7uxLkE
         92vdoLCEHU1B9ntpzqFAfFjAZcssoPWz45a0YPLFbah606/OpEq9iGyOVLPa5ZEUojsH
         4p8orLvdwOZYfUz56EhRlLfzHe6U3YTxLX3XMviuE1Ca+IacgNbBTkNE0WJcynbdjrlz
         7WjGuzOkiUIKoRnKt69t3wl6johp7O5sPyv45rELzWRfZfb6ZwFDVlbuoyUBPPhy/Ke/
         AAKg==
X-Gm-Message-State: AOAM5325EWadslylA/HGKzpHzlc1+4XtgTlx+vX3mR8cxBLnM8Huegd1
        sSoqCUnRqw8/+Cx7uoEyp4I=
X-Google-Smtp-Source: ABdhPJwJTUs1raVXKCTput0yOedOzGs+nX3GP0HG/pVi5GCWCb07zS0l5sdzAd5mvcWBS6rwttAkkQ==
X-Received: by 2002:a05:600c:4ed1:b0:37b:bb72:9ecd with SMTP id g17-20020a05600c4ed100b0037bbb729ecdmr2126396wmq.177.1645095928128;
        Thu, 17 Feb 2022 03:05:28 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id ay38sm1500136wmb.3.2022.02.17.03.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:05:27 -0800 (PST)
Message-ID: <08f1cc5f-672f-f806-49d9-a6d6be3d2a8b@gmail.com>
Date:   Thu, 17 Feb 2022 11:05:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] xdiff: fix a memory leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
 <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
 <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
 <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
 <10c8dfa8-ab98-4a46-8baa-97857bb914b0@gmail.com>
 <220216.86h78yuar0.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220216.86h78yuar0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/02/2022 14:38, Ævar Arnfjörð Bjarmason wrote:
> [...]
>>> More generally I think this patch is taking the wrong approach, why are
>>> we trying to the members of a stack variable in xdl_do_diff(), when that
>>> variable isn't ours, but is created by our caller? Why aren't they
>>> dealing with it?
>>
>> They are not dealing with it because they do not initialize it - it is
>> an "out" parameter that is used to return data to the caller. This
>> patch changes the logic to "whoever initializes it is responsible for
>> freeing it if there is an error". By doing that we localize the error
>> handling to xdl_do_diff() and can leave the callers unchanged.
> 
> Yes, I'm saying that we're needlessly piling on complexity by continuing
> with this pattern in the xdiff/ codebase. I think it's fair to question
> the direction in general.

I think if there were a lot of these bugs that needed fixing then the 
wholesale changes to the way memory is managed you seem to be suggesting 
would be worth it. However I think the existing code is mostly correct 
so such a change would be a lot of churn and would absorb a lot of 
reviewer time that would be better spent elsewhere compared to fixing up 
the code we have.

Best Wishes

Phillip
