Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F6C001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjG1NTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjG1NTo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 09:19:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E361219BF
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 06:19:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so21273605e9.3
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690550381; x=1691155181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRLyLQuJHDDvmWQ8aBWa2raJ2yoXK+/1HTR2MyAn3T0=;
        b=h3sm2hRCSDIDqjdVAKApjM0CZr1rejD7e2R+7aQLFOqDl/POyTYz6Ki43Fy6Ce3XSV
         88vevAOW3gOzSGOB2NGUvIqco/UsFNoBxa8kWYa/i1yQ7pzfEfhF5g0RbTtpphHtslcS
         dT6NtGx3T4Ep1Z4b4ebcuC/VZ2Dy7Obn6JGrP6Z4m2X7h2KCfO8f2fFYFBf0zfk+8Qj3
         HluUNSft3HSUhVrdTpeBXASGwy/Xbhzv/O/Rf1q6rN1vwm2LQEkfiyzzrcYp5I0+7ksh
         rG8Mi4LmcdVDj2t9JVoKhcI7YLxopQi1bZ9LbhIA4CafoRh5d3PQncza8+pxpZgBVZ3i
         clLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550381; x=1691155181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRLyLQuJHDDvmWQ8aBWa2raJ2yoXK+/1HTR2MyAn3T0=;
        b=KeB5gfkG053RbtpvPOqbr0zsVP1VEiVuckYRal7n6RRYbL+bzojYPkNwlCyYzbUUAn
         +Czz2FT1EzsAvtnjmjDUePRs2Pt5g+d3Fr6lynTYtlLQla5UMWhbctEa1f3SNaa3izU0
         KHrjIw2YkxqtNieyVpY/sTIfK/PQvfiJK+KWtExYqDxKG5wT/1OkxSptTyCFxLBeCjrS
         noqhfFC/+VwwV5TJLAYUhi/IZhHn81knKONTtlw2B4xkL8teNIYVMy0l/KQJLZSkyaL9
         p0CqLauGcoLSNloAOeeXkjwmdmZQFxAyj/EUCHDVv5EVAuc97Lsck9WreWzTu/zbx/JS
         JBlw==
X-Gm-Message-State: ABy/qLaGmckMedVAumEyB43zsx8u3yYnAkNzcUG19d27//kQCztc2S7p
        BlpLCjL8X6BApaYqpI4uMQs=
X-Google-Smtp-Source: APBJJlGPLN869I8Fe0cvbwOZ39iF1qDN8OjSpCvFTg0JPg3+UGwvq3Ca13qi1WWGGR5O9c4GBNNs9w==
X-Received: by 2002:adf:f0c1:0:b0:313:efed:9162 with SMTP id x1-20020adff0c1000000b00313efed9162mr1451761wro.59.1690550380863;
        Fri, 28 Jul 2023 06:19:40 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id k13-20020a056000004d00b003176bd661fasm4736877wrx.116.2023.07.28.06.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:19:40 -0700 (PDT)
Message-ID: <fd7ffcfd-288c-7f17-565d-7633ab507d51@gmail.com>
Date:   Fri, 28 Jul 2023 14:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
 <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
 <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com>
 <kl6lo7k0ym57.fsf@chooglen-macbookpro.roam.corp.google.com>
 <a3526864-dd3a-f95c-72e6-44995a9a460f@gmail.com>
 <kl6lfs5azhqd.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lfs5azhqd.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

On 26/07/2023 18:48, Glen Choo wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> Unfortunately, it's been a while since I reviewed this patch, so forgive
>>> me if I'm rusty. So you're saying that this test is about checking
>>> invariants that we want to preserve between Git versions.
>>
>> Not really. One of the reasons why testing the implementation rather
>> than the user observable behavior is a bad idea is that when the
>> implementation is changed the test is likely to start failing or keep
>> passing without checking anything useful. I was trying to say that in
>> this case we're unlikely to change this aspect of the implementation
>> because it would be tricky to do so without inconveniencing users who
>> upgrade git while rebase is stopped for a conflict resolution and so it
>> is unlikely that this test will be affected by future changes to the
>> implementation.
> 
> Ah, I see the difference. I think that's it's fair to assume that the
> names of the files will be fairly stable, though this series has made it
> clear to me that what each file does and when it is written is quite
> under-documented,

That is certainly true

> and I wouldn't be surprised to see some of that change
> if we start to try to explain the inner workings to ourselves.

I agree. In the end I've removed the state file checks from the tests in 
favor of adding explicit checks that we refuse to commit staged changes 
and adding more cases to the test for the "post-rewrite" hook. I think 
it would probably be useful to add some assertions to the sequencer in a 
future series. We can assert things like "if this state file exists then 
so should these other ones" and "if this state file does not exist then 
these others should not" without relying on the logic in the sequencer. 
The sequencer assertions wouldn't know if the message file should exist 
but know what other files should exist if it does and the tests for 
committing staged changes then effectively check if the message file 
should exist.

Thanks for your comments on this series, I'll send a re-roll next week

Best Wishes

Phillip

>> Yes this patch adds a test to t5407-post-rewrite-hook.sh to do that but
>> it only checks a failing "pick" command. The reason I think it is useful
>> to add these test_path_is_missing checks is that they are checking
>> failing "squash" and "merge" commands as well. Maybe I should just bite
>> the bullet see how tricky it is to extend the post-rewrite-hook test to
>> cover those cases as well.
> 
> Yes, that would probably be a good idea. Maybe if we combined them into
> a test helper that checks all of "pick", "squash" and "merge", which
> also has the added benefit of being able to hide implementation details
> in case we decide to change them.

