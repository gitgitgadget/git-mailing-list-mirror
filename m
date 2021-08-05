Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC31C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC3B60F58
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 09:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhHEJ4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 05:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhHEJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 05:56:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C202C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 02:55:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so5708065wrv.11
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a6kYsp9HtdA/Tv8uLW6kAv+toRkkEegGIVQdAYCBR2M=;
        b=H1mc8AmKcsfTF2xyxAfIMnDoKuiBNGQquppH6Swb73+80QskUohutWCuKwdk3xjDW3
         SypBIwiBsPppfMsTCKmGTKGTx07yj/iAYt+cR1vqYdhA8MYuFIBbtXc/BC6oSqQJYyUw
         f1jvYovczpy1NivABNOJ8gwR+5qBoG7xQpllQDIvpgRL8S5RB4g4V0yg1ntosmmihIuW
         TVAYwULG/eldaPF36ee6X3iHTe56vauAjkbMNO9yD/68PLa/ptJnVwhidINmcsMWSd7L
         XW/6H0v+pcFgCucmOBRyKV2jvSqzWJeF8jIfjriSRTFYkC1mbesqGOXAUBWPjKxisot8
         58SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a6kYsp9HtdA/Tv8uLW6kAv+toRkkEegGIVQdAYCBR2M=;
        b=BPsSgAeCPizGnSZh3E9OngrUpCFc9Cz8Z/TgLKU0/4HDwsa/i96CthDzU8zpc9jCbE
         n3fOFQNgCJx2rOSe1b+GrqmKkv2ERyFxVIP79Uur8HwHeWoT+eUHSnvTKFIRxh1IlZXj
         fsnOkguMXwIyN6O+639VZt0k39tuIsAe2kb6RSTDPgF/zXOznEokkeBrVRpnD+VUf8c/
         Qh+rKdcNvCxumepgNh7D3csoFIxeNUJZ7nBezTFrlsTiYQ/XH4rvG/arSSVx/V5401FC
         xAq2A6/MqBdCMr8OpqaTaCliL/Q48V+MYsyP+1HJrg06wwif8A1vgmyEvUKfqlfkHUoc
         6CKQ==
X-Gm-Message-State: AOAM530B6bLibLQHm1PAmUNTsLh0vZcDCCFN5mHK5IiLwOLpzj5rra0Q
        j73I7+5aA/VrOEx9/Bu11/qMEn4rowc=
X-Google-Smtp-Source: ABdhPJxXv+RSf7/xz4/aPZP/vZcPHP44mcm1Ob6iR+TZBBbY//YCB5npVIj82cnvZJEQlebiFyYcDA==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr4027217wrm.327.1628157357895;
        Thu, 05 Aug 2021 02:55:57 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id c2sm5533844wrs.60.2021.08.05.02.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 02:55:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1a3e2551-a6b3-2628-f21f-f9281e581871@gmail.com>
Date:   Thu, 5 Aug 2021 10:55:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08/2021 15:22, Derrick Stolee wrote:
> On 8/4/2021 3:03 AM, Junio C Hamano wrote:
> ...
>> --------------------------------------------------
>> [Stalled]
> ...
>> * lh/systemd-timers (2021-07-02) 3 commits
>>   - maintenance: add support for systemd timers on Linux
>>   - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>>   - cache.h: Introduce a generic "xdg_config_home_for(…)" function
>>
>>   "git maintenance" scheduler learned to use systemd timers as a
>>   possible backend.
>>
>>   Waiting for reviews.
> 
> I just took another look at this series and see that there were a few
> items that have yet to be addressed. CC'ing Lénaïc and reviewers to
> see if those items will come in a v8. Here is a quick summary of my
> understanding:
> 
> * There are some non-ASCII characters in a code comment that are a
>    bit non-standard and could be replaced with ASCII representations.
>    (nit, but if re-rolling already this might be worth doing.)
> 
> * There is some discussion about using string_list_split() instead
>    of hand-rolling a string splitter. Discussion decided that we
>    should _not_ use strbuf_split_buf(). It would be nice to later
>    create a version of strvec_split() that takes an arbitrary
>    delimiter, but isn't necessary for this series.
> 
> * There was some discussion about using #ifdef to make certain
>    logic be compiled in or not. This seems (to me) less important
>    in the case of returning 0 or 1, but in the third patch there
>    is a large set of logic that is only compiled on Linux, which
>    seems like it should match the pattern of the other methods,
>    if possible.
> 
> Again, this is just my drive-by summary, but hopefully it renews
> work on this topic.

I think that is a fair summary, I'd be happy to see us take this series 
as-is, the code is fine and any small warts could be cleaned up in the 
future. I think Eric expressed a similar opinion in [1]. Lénaïc has been 
responsive to fixing bugs as well as taking on board other comments, I 
think we've reached the stage where it is not reasonable to keep asking 
for small changes.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com

> Thanks,
> -Stolee
> 

