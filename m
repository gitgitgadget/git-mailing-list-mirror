Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81664C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjARSIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjARSIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 13:08:06 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF874ED09
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:07:41 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4e9adf3673aso143297747b3.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqCs4HFSdiRWAq2pJ2A+AIpSgBMSsxmpkc3SqDfSEeA=;
        b=DVFckkYSoMZ6RBt6F8XjqSL0fy5kwQe8W7J30Pxm1t3RtIBXLApMOjLV9sxPTqqdzI
         /jKZSXwhpCqN2VCE6vFrWZjK6AOg+gB16fjMk3w/iyQPrP7dlzC2GySpO+hX5aE4hD8Z
         m22CCDAyVlYd3HRVXmTDpHBfpJSeAACUZtKTEvA8B8NDlEDwUjmORXuttqoS6vneo9kc
         SiAZY0rtC2r5eHD1NKOqm1xqDifxHZN03KOIIMYZhlNKdcXmEEQl1qqyK8/MtvPgo4Cw
         4fZeAkRvhjxVGDfK1DuPSQdfOUZSZKd/e3CYaBGo4P0Rat/nuGbQKs0r6PYPV0qDT0Ys
         EMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqCs4HFSdiRWAq2pJ2A+AIpSgBMSsxmpkc3SqDfSEeA=;
        b=RnxDvqghZ+haDX3vamSGizJjHtX+s7CdoQ84SrMfiikxs5zdCNHZBnrbRlPhBj3eRv
         BD6D0KXTpTcCyt89VQNmrJAYrnrlfUxKCiJTQcYbX8QvpQHzueld/VTGVyEcoNZQLhOa
         GjlDXs+NNvZ6wn5uGwUJv6cvQg5LFVVCbMGvuIo+ai0gPbyiHJyVZNyzcdxJYiX8uQVN
         dArbzaIqBP4B7uzhCtal2N9zfOxFuEuAukE03ESq5B8+SE/xrshJ/3/DsrHwsxZDic4S
         n0qUDb6MkRj68nEE6HgCoq05FRMA3Lv568jTi2IHkMe7A7TSEXinvEoEXK5Bq5c7U7nX
         ap0Q==
X-Gm-Message-State: AFqh2ko9HwIwTQX8vS6mJtSEu3OaYIru8xVdTlt24JDP7bvzo7OfSvh/
        YS9pddUfZSAwK5+6YkDJX/I=
X-Google-Smtp-Source: AMrXdXty/Tl6kWHz0SvHax/JlvTAAZ9RUCf3T/I0qMBFatR8p2JCiTvMlGvkQkOVAXlc83GiqnzqkA==
X-Received: by 2002:a05:7500:2b23:b0:f1:9010:cafd with SMTP id dm35-20020a0575002b2300b000f19010cafdmr660141gab.73.1674065260211;
        Wed, 18 Jan 2023 10:07:40 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05620a468800b00704c9015e68sm5782366qkb.116.2023.01.18.10.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:07:39 -0800 (PST)
Subject: Re: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible,
 but not enforced
To:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
 <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
 <CABPp-BGLVMoGiCeBMvyRhQmUSDEv8U7_U8=4B=Fh94=p_=QJVQ@mail.gmail.com>
 <58a70c93-22ed-901c-44f2-3224734c27c3@github.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e16c6bd8-41b2-8912-c327-7b903f6644ef@gmail.com>
Date:   Wed, 18 Jan 2023 13:07:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <58a70c93-22ed-901c-44f2-3224734c27c3@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2023-01-18 à 12:03, Derrick Stolee a écrit :
> On 1/18/2023 11:24 AM, Elijah Newren wrote:
>> On Wed, Jan 18, 2023 at 7:51 AM Derrick Stolee <derrickstolee@github.com> wrote:
> 
--- 8< ---
>> I have both changes over at
>> https://github.com/gitgitgadget/git/pull/1466; it doesn't include the
>> "--no-update-refs" hint, but maybe that's good enough?  If so, I can
>> submit it.  If not, do you want to alter or adopt some parts of my
>> patch and submit a v2?
> 
> It sounds like you have a better handle on this and should take it
> from here. I look forward to your patch.

Thanks both for your quick answers and patches. I do think that the hint
about '--no-update-refs' could be valuable.

Cheers,

Philippe.
