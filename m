Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277EC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B1020897
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKFeo2mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIOA7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOA7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 20:59:30 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78DC06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:59:30 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c18so1945116qtw.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gCqkhjtuo6WJ3z74sPyGkNSMIi9KeJ2CU94dRqTF74=;
        b=CKFeo2mtTG54OwNNLUj6bqHKpSwZtSbo6f/mnLD8ephfigkdnRudcMbOXZhKX7NpaK
         TIZiyJynvCoNqPx+fkk+L7rSorDOBd8ca1tDLm7BpwEf4dEFyAvZx1flgigWM6FzIm0Q
         ysnBeJjT5jJxXTqcFYrXJSS73jnPVyu6R+dJNAV+5BhvVlBHbX2keSD994aLQKW6DLNQ
         e2+JqCRnav0NYFyNHljS0lDOq2YeE5Io7+EhLsjwRBO+YLVXjwyqUQH/X+81xO4b+dgL
         HI8xus9jO0VKnUEnviQcQwsFFIewIFOOjt9ZqGn3hFQhFCEWs66D5NOzqUsTpn7/7YDr
         ZUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gCqkhjtuo6WJ3z74sPyGkNSMIi9KeJ2CU94dRqTF74=;
        b=RBYtIXkVpe3SmvV/YCRyoRaNDFsIBcaqnDGPfHuGHGV94brK5DvW2sXqudWcRlyoka
         MoenO3pwQ0RWV+6HhbxJKhEdxWhdmQ0a19rNp9uroFHHPnWoMpmgkgxgAW2X9+H8ug3K
         PtWDorW8KnvzpCIl4yTABnWT3kSBrasmJAsW8ydOxXnd8N6v4HqwT77gq/nN2i4NLJC6
         53SdjQ07d/3VnQMJnEB4j9AKcFqH7CPWytmr962QKd+CCSjlVs0bbYDAcEzRjF9DfTnA
         V9Ln7g0DDamiyoLZd/rFb2uzKP430LodzFnDPOk6TUkKn2TbFk4M3RunP0NvJ0qy5vDB
         P8Vg==
X-Gm-Message-State: AOAM530hHtxneX+XRGmpVtrVIdq4Jkaj2d0mAE+stVdqz1Wy8CLnPNiS
        S+tMiuLAGMOsOACESilhxag=
X-Google-Smtp-Source: ABdhPJzbnaUZJjShqLPTUVIkVy0pk20BGIlh+ZT7ev4ZTI2S/eRIy7Nqw7MdX0MnlaCDI/1g3s9UHw==
X-Received: by 2002:aed:398a:: with SMTP id m10mr3648554qte.143.1600131569327;
        Mon, 14 Sep 2020 17:59:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6091:313a:250c:77ff? ([2600:1700:e72:80a0:6091:313a:250c:77ff])
        by smtp.gmail.com with ESMTPSA id 76sm15664588qkl.127.2020.09.14.17.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:59:28 -0700 (PDT)
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan> <20200911192555.GA3612@nand.local>
 <20200914201258.GA12431@nand.local>
 <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
 <20200914203659.GA12855@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa53f17a-6e48-f4e7-821c-1db35cf48652@gmail.com>
Date:   Mon, 14 Sep 2020 20:59:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200914203659.GA12855@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2020 4:36 PM, Taylor Blau wrote:
> On Mon, Sep 14, 2020 at 04:31:03PM -0400, Derrick Stolee wrote:
>> On 9/14/2020 4:12 PM, Taylor Blau wrote:
>>>   - This patch (attached below the scisors) instead of 12/12, and
>>>
>>>   - This [1] patch instead of 10/12.
>>>
>>> [1]: https://lore.kernel.org/git/20200910154516.GA32117@nand.local/
>>>
>>> Let me know if you'd rather have a full re-roll.
>>
>> It's getting a bit difficult to track all of these "use this instead"
>> patches. But, I'm not the one applying them, so maybe that's not actually
>> a problem.
> 
> The above list is the only changes that I've made, so I'm happy if Junio
> wants to follow what's written there, but I'm equally happy to send a
> new reroll.
> 
>> You might need a re-roll, anyway, as I have a few comments here:
> 
> Let's take a look...
> 
>> You also introduce commitGraph.maxNewFitlers here, which is not
>> mentioned in the commit message anywhere. In fact, it might be
>> good to include it as a separate patch so its implementation and
>> tests can be isolated from the command-line functionality.
> 
> I could go either way on both of these, to be honest. I don't think
> there's anything interesting that isn't said in the documentation
> changes introduced by that commit that is worth convering there, so I'm
> not sue 'commitGraph.maxNewFilters' needs the additional call-out.

This is fine. Adding an option along with the config version of it
is easy enough. Just a thought for future series.

I'm fine with the series as-is. My nits are just that.

Thanks,
-Stolee
