Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46451EE7FE3
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjIHNL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIHNL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 09:11:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFB19B5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 06:11:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so23165645e9.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694178712; x=1694783512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nhNWJKh1zglDyBe2yWe33tDL+szuZRrsbu7m06HU7Zg=;
        b=GnLpnvPlAtSu6Vf4KYJUiX27kkbDagfsmYb6eE7d2FOStOyP2gckSF1yvbQVP1BhMl
         QG8KCiVPnWHDNFoIpVN7iz7G0r9HL3XGYFdiMV55GbhKncE31CAedVbpeSlPhiU+skQe
         5iGorB65S1slsWv3B6nPZSI4BOHfUlREYV/LRKGtax4zF4vLVZP2bMsfvNs4lvwwDgEY
         DO4c9kKQmbJCICW5kXbj1qrJ3lZ1n0uPblp2/HPH24um5q2zDLXT0VVNRSjxkqw5R6yw
         uFoT4ZvlgcPFR2R9m4+irv93Z2mkpv+yQxQSQZPTW2PdKUqXiSXgZundSxXMF7zaZxfc
         4+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694178712; x=1694783512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhNWJKh1zglDyBe2yWe33tDL+szuZRrsbu7m06HU7Zg=;
        b=FOAG72vy9yZVt3mBIrcNOENPudClZLs89QBvDEjjvXzX5hJkhn5SqOeg19U+yAh/nV
         33WHQsYGxkn1X9mPPlUJPlNKkBnGl54mg9LhBXFHTZyM2udz6C0mLg0MpQ0x9X6C5EtO
         Z46IvaIyAXR08Zcxie5KKRFqWDDtjnJAoVRSU9e/dLKHGC00tMCjfL+3GwDnKOu3rWpN
         uBg/f5CrHKa9/lvh+Mge6FyfrvWjUI1weZnfKtrsj8tZN9IJM8n2DOy5r+9/ZkXdnYU1
         Z1kEsqc+cir48e1BMfDXiWFqusl82XhhXXR6Wpzap1qitGebrk4qzA23KQP/9vzLCi6a
         JdgQ==
X-Gm-Message-State: AOJu0Ywbvp7gE92Qj5Ss6ALI89TNUkJT4LbQY34kl751SWmheOfUXVrB
        hTLzaeR/soOmVLKE7C0Xwnk=
X-Google-Smtp-Source: AGHT+IG+Ii/4yYSwP6wT9Pp4Ygpq5a1vRfwvjasoWDf13MKyr0Xv0vk07iozgZ92FVBd/hg/fbrmgA==
X-Received: by 2002:a7b:cb8d:0:b0:401:bdd7:49ae with SMTP id m13-20020a7bcb8d000000b00401bdd749aemr2114328wmi.18.1694178712264;
        Fri, 08 Sep 2023 06:11:52 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id m7-20020a7bce07000000b003fee8793911sm1935198wmc.44.2023.09.08.06.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 06:11:51 -0700 (PDT)
Message-ID: <159c16ae-4dbf-4669-bd9d-2f7c52107a68@gmail.com>
Date:   Fri, 8 Sep 2023 14:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
 <20230907210638.GB941945@coredump.intra.peff.net>
 <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2023 10:59, Phillip Wood wrote:
>> But I think the right
>> solution is actually to start the editor in its own process group, and
>> let it be the foreground of the terminal. And then a ^C while the editor
>> is running would not only not hit git-commit, but it would not hit any
>> sequencer or other intermediate processes above it.
>>
>> I've never done it before, but from my reading we basically want to do
>> (in the forked process before we exec):
>>
>>    setsid();
>>    open("/dev/tty");
> 
> Do we want a whole new session? As I understand it to launch a 
> foreground job shells put the child in its own process group and then 
> call tcsetpgrp() to change the foreground process group of the 
> controlling terminal to that of the child. I agree that would be a 
> better way of doing things on unix.

It is better for handling SIGINT and SIGQUIT when we don't want git to 
be killed but in complicates the handling of SIGTSTP and friends. We'd 
need to pass WUNTRACED to waitpid() and then do 
"raise(WSTOPSIG(wstatus))" to propagate the signal up to the shell. When 
resuming we'd need to call tcsetpgrp() again if git is resumed in the 
foreground before sending SIGCONT to the child.

>> But of course none of that probably has any meaning on Windows. I'm not
>> sure if there are analogous concepts there we could access with
>> alternate code, or if it would need to be a totally different strategy.
> 
> Lets see if Johannes has any comments about that.

I had a quick google and it looks like cygwin somehow manages to 
implement tcsetpgrp() but the windows terminal does not have any concept 
of a foreground process group

Best Wishes

Phillip

