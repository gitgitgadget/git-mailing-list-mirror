Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABBC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BA8206F7
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1HL3FqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgKXCUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKXCUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:20:48 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD097C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 18:20:48 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t143so22071080oif.10
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 18:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5QDI/7VoOckNBUs9hga/Zuwts5bXg8PJUnt2TVMSpg=;
        b=u1HL3FqIsGQE205RgWMINw6I2y/OIbZUuXWcJSh0+AIL6sgoJM0OF9HxCsJNcFBUmi
         GeqDXe+HVl+nCMAuIgYn5f/Pu/EaJ3LRY37pOqm/apB3tx52zbZuYd7+FGi7ag6jAPRQ
         oBy6wKsCoXlDKQFGyYNoupy+48RbrB/zY9WnmIM8+mjOCrfoYZ0z8PQBR3Ksb77dzzaG
         lx0EDFN7kc6GWPOBNyHV77MgPTIUWmFaXxYYV5lMAW2I1XNTFJy2PUgIBJe0WbOq62uh
         h00M6bnWjjcwJzJc+GWMyPvx3MIdZrD0BU3XmLuCmoRabZlD6AIfraQYyyTaTmtvgJ4N
         V+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5QDI/7VoOckNBUs9hga/Zuwts5bXg8PJUnt2TVMSpg=;
        b=YfWdXkQm+rPQBfGl+sARLX0GqFhHHHC4GoyWfawTDJBYV3mlhj/AiUrE9GhOrzHxSt
         Aejrl5KZZ83KQ31nDdjccAAio5pwVWJfr3pW5w243ljs+LpVS8kHfJ795Gs65T93L8OO
         E3bu2fNjZ2uMuftLIC43yj4L0/CHp8cmQcvHC5gGuLQ2jFHghD76ANP3VqsrOiMfCh+P
         zCcfv5oS+gWin8bBeH82sV60Sb06bSmm/o2eGGXWWyTWieBap6IXtV8ClpRll1BLvqM1
         W0z3zmHjwYSw0to5EgFpFDvLCPp2WpPQrsciKt3uJ+4v6rZPzYe/cLrKFEKkk62DXSFb
         fxAw==
X-Gm-Message-State: AOAM532bSE9ujMnNo2wlGZFFHSFi7qpMYCQQFajAU0RHJUvNoit3HCH3
        fEBY6LJZ2HNgmnOk2yAKRNBhyVF72+/9tA==
X-Google-Smtp-Source: ABdhPJz2UgkQGZdZV6Binb2qzmo9zukaIe4ue4nd+XIKSphAB2LGs0amWn3I6qeVLiJLPhXVppFMTQ==
X-Received: by 2002:aca:4950:: with SMTP id w77mr1247253oia.79.1606184447937;
        Mon, 23 Nov 2020 18:20:47 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o29sm8134001ote.7.2020.11.23.18.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 18:20:47 -0800 (PST)
Subject: Re: [PATCH v4 0/4] Maintenance IV: Platform-specific background
 maintenance
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <X7ReZXuwAaAZzMSU@flurp.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <80762efd-c71b-4485-a2bb-f0577d90ff48@gmail.com>
Date:   Mon, 23 Nov 2020 21:20:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X7ReZXuwAaAZzMSU@flurp.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2020 6:36 PM, Eric Sunshine wrote:
> On Tue, Nov 17, 2020 at 09:13:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Updates in V4
>> =============
>>  * Eric did an excellent job providing a patch that cleans up several parts
>>    of my series. The most impressive is his mechanism for testing the
>>    platform-specific Git logic in a way that is (mostly) platform-agnostic.
>>    
>>  * Windows doesn't have the 'id' command, so we cannot run the macOS
>>    platform test on Windows.
> 
> This is easy to resolve. Drop in the following patch and then replace
> the `$(id -u)` invocation in the test with `$(test-tool getuid)`.
> This way, the test should work on any platform since both
> launchctl_get_uid() and `test-tool` will retrieve identical values for
> UID.

I was giving your 'test-tool getuid' idea a try, and found that _also_
the $HOME environment variable differs from the format we expect in these
subcommands:

                   $HOME: C:\...
  argument in subcommand: /c/...

So, there is another reason why these tests don't work on Windows. I'm
of the opinion that maybe it's not worth _that_ level of cross-platform
testing.

Unless I'm missing something simple about a $HOME alternative here, this
seems to be more work than the resulting value. Personally, I'm happy
with the benefit you've already provided in allowing Linux to test all
platforms.

Thanks,
-Stolee
