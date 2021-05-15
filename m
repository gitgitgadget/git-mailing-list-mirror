Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A2C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0685961404
	for <git@archiver.kernel.org>; Sat, 15 May 2021 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhEOGx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhEOGxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 02:53:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F5C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 23:52:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p17so937927pjz.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tPKrJ3q6qnt/lQwm4uefmBXD5+4ZxlCZXd7iExc/Zmk=;
        b=HiM/KJOxV5C8e+4nT+gAJ4UnDYZigpUHLwsIQKrW4aBRHFkyc2xC8syFPuYHZO43Cv
         RyzuaOwR9I8+Pt4goC0syiep01x4cRuZyYLJyUBuPLwFDEq5pwXVDThBM+avAiCn0hhZ
         C5qckUfqsKxC/QaP4m0Huxdbv08xvaqq9JAb7cpDhyUcbGxKWwY7XHnVOmwmCwzBhWNv
         2uVRnq+se80Y9TuQidAzlcYlDeHG4wnq7fb0RhKeBUHSsVUfFC2/sc9+pg8PHfX45LAr
         Wra4Et6McyJkQoFsHgiXW9qLntwalU35QpFc/AHoq4j0Rbb2SWOLeoCo2ky68pgnsyyK
         YKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPKrJ3q6qnt/lQwm4uefmBXD5+4ZxlCZXd7iExc/Zmk=;
        b=O1bxqtq7f/GayV4nelVQu1Wk9x3VVq9bshaOQxIsYxpUJoNQCHM8tqLFppwiqFxtXE
         dsb+coRzC/OVzX67AEOcmV5xD2Ip2hXjfAFox2ACVkE183GgzvEBe21fLE8HDP3Wz7Hz
         UMdu0Awy2zYaZcGsmWyvT4UvsY1QwXhglK+gt5uZivnDrtuDn68iZF3Owic7fv1kR6Iy
         UG59ss7UiAMEOg3v40KY5IX1DEzJvB/KIVvu9GSvxzc576d5NXZ30S3Fkuj9dio7dHhY
         9kzJXq2zV1UJxjOgQZb+Mp5Y3gfqpzfaPddjetFmHHE9CP0a7PKCzkd8XX3p58LqeS8L
         7GUA==
X-Gm-Message-State: AOAM533bO5aR8EZyTbeNt1WpZkTdwfvIDusSoBFOeTLFQtNEhgN73uQm
        eiQtjEzJlUBditd5WWu4LbjR+d6jjh6P6Q==
X-Google-Smtp-Source: ABdhPJxUX3N7yPSz6xWXYSsjPbPHOPEJuSsFxl77oVRNbUQXkpKP7DpcxQaGbIgQfYnAb+e5WG/1GQ==
X-Received: by 2002:a17:90a:1588:: with SMTP id m8mr15567379pja.226.1621061530116;
        Fri, 14 May 2021 23:52:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-33.three.co.id. [116.206.28.33])
        by smtp.gmail.com with ESMTPSA id i5sm5300131pfd.159.2021.05.14.23.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 23:52:09 -0700 (PDT)
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
To:     Jeff King <peff@peff.net>, Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2bd7a4d7-0278-1ab6-9867-a158cd08613f@gmail.com>
Date:   Sat, 15 May 2021 13:52:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/21 16.57, Jeff King wrote:
> I think it is actually a bug with pack-objects not sending the object,
> but it only seems to trigger with bitmaps. This works:
> 
>    git init repo
>    cd repo
> 
>    echo content >file
>    git add file
>    git commit -m base
> 
>    git config uploadpack.allowfilter true
>    git clone --no-local --bare --filter=blob:none . clone
> 
>    cd clone
>    git fetch origin $(git rev-parse HEAD:file)
> 
> But if I add a "git repack -adb" in the parent repository before the "cd
> clone", then I get:
> 
>    remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
>    fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
>    error: /home/peff/tmp/repo/. did not send all necessary objects
> 
> So presumably this is a bug in the bitmap-aware filtering code that is
> not present in the regular filter-traversing code. But what really
> puzzles me is that the result seems totally broken. Yet the test
> coverage in t5310 passes, and nobody has noticed on major sites like
> GitHub (which supports partial clones and most certainly has bitmaps
> enabled).

I can reproduce using your test case above, thanks.

Anyway, for the moment being, I clone using "git clone --depth <N>" and
then deepen the clone by "git fetch --deepen <N>" iteratively until
complete. I do that because of quota constraints on my network.

-- 
An old man doll... just what I always wanted! - Clara
