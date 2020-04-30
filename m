Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B669C47257
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADBA2082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRyYb5h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgD3UNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgD3UNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:13:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF81C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 13:13:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m67so7133764qke.12
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3CEXbyv2iuZO2zPev4/1oKpnYzrgtunaClCFDO3Pwy8=;
        b=HRyYb5h/nJ0IvoQaxoGbgp+92jZWtywm1JwFzuEQ8VC5O5v3WxcC7V/666hZQQvcfG
         7upLzZ3adQez0jp1imDm/i7mSmSFGPPb3jRkZnCZi/HYBIM5a79857nrfnd4ec7ZMPlo
         +VK15omxseRN5ulPP1Fb5UnN+99I2tkHdZl3C6gm6S6Gs18xs0dGb8JIkQoVfxud8ekF
         9Go1xP/T6UotJ3nelMa4tC0ndZ+I6JFicKDHcoFQdzLBD50YDfvo2d4jGGDWW0+J2PzS
         Ww7Pdvym7GI0UeGUey8bUG/yelC0bGccRZk3ymQc16rOBK5TJ1DshA3UJS3uk9//KMGk
         arNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CEXbyv2iuZO2zPev4/1oKpnYzrgtunaClCFDO3Pwy8=;
        b=SjHPoOYpQVFs54e/bTEHlwkZfGbYoxFBmkAX2PdYj9wdjDQDmuC46hNz57/R0Lbtre
         HCjHb7XIYVAUuvhZjGEq/5OifTDWQIqPwMczyN4da1pmM97kL9Xx+L1l09SoKLqwpPxZ
         r3CclyrJE37Q49mkgC8BXEM2OnP3JXZP2xqiG/fCtx4J/4lbuvR+ueIllS0Y+NDtVd0y
         2CbbGWE213fXJxJ3ny8mnFJOIZgUUtvN96ILU9HE788CotmMQtO0k7dBGtkRaKmX6WOz
         kI91iZ8jJecHQaU6UdXBg7saB2SvMR9r1NLx/1ODzDLJvlkFAgJKfKHuxufZXrvy5nUn
         P1Wg==
X-Gm-Message-State: AGi0Pub7x49lz3y55W83l+7qhHWf0mbjxILa+AtaUKaynH3dC82tdk/c
        St5oqJsloPjZbuNf15u/pPlmEBtUYOE=
X-Google-Smtp-Source: APiQypJleMIaJ/wgAH+48/B1HTVZF9jt2q2Ybaolesn99COPyavU4k/SFy8UQfBZPDxaVd8LFfxg/A==
X-Received: by 2002:a37:4955:: with SMTP id w82mr245435qka.240.1588277630861;
        Thu, 30 Apr 2020 13:13:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p4sm907030qkg.48.2020.04.30.13.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:13:49 -0700 (PDT)
Subject: Re: [PATCH 06/15] run-job: auto-size or use custom pack-files batch
To:     Son Luong Ngoc <sluongng@gmail.com>, gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net
References: <CAL3xRKcsa_P6X5Y+c2LWoftfjqEw9eheikrxfwXU=y6KuFHjtQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f7a193f8-8d5f-3f71-45b1-e117742df8f9@gmail.com>
Date:   Thu, 30 Apr 2020 16:13:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CAL3xRKcsa_P6X5Y+c2LWoftfjqEw9eheikrxfwXU=y6KuFHjtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2020 12:48 PM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
> I have been reviewing these jobs' mechanics closely and have some questions:
> 
>> The dynamic default size is computed with this idea in mind for
>> a client repository that was cloned from a very large remote: there
>> is likely one "big" pack-file that was created at clone time. Thus,
>> do not try repacking it as it is likely packed efficiently by the
>> server. Instead, try packing the other pack-files into a single
>> pack-file.
>>
>> The size is then computed as follows:
>>
>> batch size = total size - max pack size
> 
> Could you please elaborate why is this the best value?

The intention was to repack everything _except_ the biggest pack,
but clearly that doesn't always work. There is some logic to "guess"
the size of the resulting pack that doesn't always reach the total
batch size, so nothing happens. More investigation is required here.

> In practice I have been testing this out with the following
> 
>> % cat debug.sh
>> #!/bin/bash
>>
>> temp=$(du -cb .git/objects/pack/*.pack)
>>
>> total_size=$(echo "$temp" | grep total | awk '{print $1}')
>> echo total_size
>> echo $total_size
>>
>> biggest_pack=$(echo "$temp" | sort -n | tail -2 | head -1 | awk '{print $1}')
>> echo biggest pack
>> echo $biggest_pack
>>
>> batch_size=$(expr $total_size - $biggest_pack)
>> echo batch size
>> echo $batch_size
> 
> If you were to run
> 
>> git multi-pack-index repack --batch-size=$(./debug.sh | tail -1)
> 
> then nothing would be repack.> 
> Instead, I have had a lot more success with the following
> 
>> # Get the 2nd biggest pack size (in bytes) + 1
>> $(du -b .git/objects/pack/*pack | sort -n | tail -2 | head -1 | awk '{print $1}') + 1
> 
> I think you also used this approach in t5319 when you used the 3rd
> biggest pack size

The "second biggest pack" is an interesting approach. At first glance it
seems like we will stabilize with one big pack and many similarly-sized
packs. However, even a small deviation in size is inevitable and will
cause two or more packs to combine and create a "new second biggest"
pack.

> Looking forward to a re-roll of this RFC.

I do plan to submit a new version of the RFC, but it will look quite
different based on the feedback so far. I'm still digesting that
feedback and will take another attempt at it after I wrap up some other
items that have my attention currently.

Thanks!
-Stolee


