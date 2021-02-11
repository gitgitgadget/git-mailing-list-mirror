Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A3C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BE464E6B
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 18:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBKSix (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBKSht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 13:37:49 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36821C061786
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 10:37:09 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r75so7183704oie.11
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YJmIPpaJsOHTlVd7WsUNQRsV0WzCOuWwgc+Ku+8VNiE=;
        b=Jkp47pc7RWiETUfJgrcHJ+wN5aNjvevMTMUFAMtU9Hckb+82VNc9dd1YMkeuia5jbm
         ii7CiUNmfXXmxrMtWitekn1xKaWHjSqAItXyaeJjk4wdYXVsNMblRtNx7dMEVAIgIJMJ
         t774F6b2iVRlBFfnbuCYn8WBO925Zrx8WqwtD12BpSdup7WJwigITsZeZ89oek54VWbd
         K3xy2rO9wHwcotG3REMpPTKGwUWcg+bdw6GR1Jrsahsu+eTBKD8UDNenh2FFlOleI54L
         LlS7KKZgEDCw/hn+EOlwQYK4pouamiS8A3bjunql+BTW9eS1pp9wBEDCitogaZlQohtK
         q7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YJmIPpaJsOHTlVd7WsUNQRsV0WzCOuWwgc+Ku+8VNiE=;
        b=IoU5eMO1s9wZrhE09Y3Yr3UXEPATmlRpPQO2MkxmzOFbACGCQblGfa8xyDK+FRIhRU
         /OwIwMY6fyUXsIFY1r2hUjJo4OigT0SFDGddZ1EVkcISuE/xH9f8aVwVelZlVUmrqteG
         B08v91fuGOsOG/Rmci0ImmbYc/NF4ZVj+Rr7SpV2rxms6egFRA10RzK7EeIWY3spgAka
         PiBLmRspoxWGJxMGLKHk4Do7uWDhDWUsTwEE838SYwQ2cyNUDV4VzOyK0pb7zoCMBmGe
         rndvsWLwvS38TOnn6vGeCX3yMG3Ux9Xj6+CQhVT64StUFE275zwuoxpwru5JgfzLslK0
         qFoA==
X-Gm-Message-State: AOAM532RO3zBfMZ1qooQAEOVeFRjSHMFC3vOBgHix/CjHuRfBbckO9i3
        RPOnz8q/s4ZtzLjRLAs1008=
X-Google-Smtp-Source: ABdhPJx4GYoAgF+rFCqTVJOiC+kroV27hoE24+uwsvArLyt/o7ldRNx+QItrgrr5kT7JUFyzGg3k3Q==
X-Received: by 2002:aca:da83:: with SMTP id r125mr3757638oig.127.1613068628382;
        Thu, 11 Feb 2021 10:37:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c997:9386:930b:6f6b? ([2600:1700:e72:80a0:c997:9386:930b:6f6b])
        by smtp.gmail.com with UTF8SMTPSA id q7sm1344290oif.1.2021.02.11.10.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:37:07 -0800 (PST)
Message-ID: <10c76063-f6b9-d88e-cb2e-731dec204bba@gmail.com>
Date:   Thu, 11 Feb 2021 13:37:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 0/9] midx: implement a multi-pack reverse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <xmqqlfbvxbrc.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqlfbvxbrc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/11/2021 3:13 AM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> Since tb/pack-revindex-on-disk is queued to be merged to 'master', but hasn't
>> yet been merged, this series is based on that branch.
> 
> This seems to have a light conflict with Derrick's chunked file
> format work in midx.c where pack_info is renamed and extended so the
> new pack_order variable now needs to become a member in it.
> 
> I think I resolved it OK, but without any callers that actually
> utilize the new code or tests, it is almost impossible to have any
> confidence in the result of the conflict resolution X-<.
> 
> Could you two please look over to see if I made any silly mistakes,
> when I pushe it out later?

I reproduced your merge and got very similar results. The differences
that happened between my result and yours are not meaningful in any
way.

Definitely a very subtle merge, so thank you for doing that!

-Stolee

