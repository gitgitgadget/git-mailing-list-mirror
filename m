Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC17BC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9312251F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbhAEEmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAEEmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:42:20 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6384C061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:41:39 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id b9so20159715qtr.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nF4k9jWqewxl0zD37tGXuxnDDcng5hWY+Z6AOK77Y80=;
        b=K0xduufhAhw1YqLIOgLNFxwMERUkwRFpKIG4O9nGIIF5bBi/na3HV9bQXO+U0/zYZk
         QegvLtugcPRDycD2/LXOC+YfiheZOnei9tZn0tH8rURZDiqiLsa1TnhA59Tfv+z5jPtb
         rsrc/4FiNAwoIyXI3FIKq6QczMJYeFgcm6Jtjiklk+/t0zt3/73WIeH/tXMqhl0L0aJH
         aL+oG251ym+A7Uu/lPVQashiPrzoWncx6TyoF6b9zqEBRdDv3nQJ42F95TzySx08sOCE
         knDXo2G+T2n5TfEsys+uC5E/8KbT9fw24RtMs/AKbtHgo1HwPPxiG2zf7tq38tQ+vhYz
         SZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nF4k9jWqewxl0zD37tGXuxnDDcng5hWY+Z6AOK77Y80=;
        b=pi8MFBh8+OQkP64Uccl+jDMrTCJtomqshOVulDe4nTBhGapkaeAc8MiuVSwMHAxuzT
         1sBH3EXgKe8xsQL0yPBh9WYBLIj5ra0wwy3lG3z2hh/0MB/XA91Trrd85xtHb8Eq9LFW
         TH10F6Y+vnhHgRusdYuawhYjvO2iCNK5RW8lgjB+pVf5czW+lOs3sYYk3U9+kTDM19Jv
         X6Q5QPNQNKUoi7ZWz0f00z52Dd5r9blZr7ob9RSyt4mkXjH82DY8f3nJfJpLcSLrbvcO
         n5id7iaEdytTR/5WRxus0M8FArDfS3jvcv1TKBvI78mcsOI7zU+jHfZ9rTV+LQrftZ32
         x5Hg==
X-Gm-Message-State: AOAM531rpEiGzOL3peuBA1IYnmTe5U5KOpb894bekIZF1rC0z8Y2Ygjm
        vC08yOwQBRLGwDEg81RiKDQ=
X-Google-Smtp-Source: ABdhPJwpUHUdgk/XnNOFu8d5/v93ubapgjfIgSNt2V1fTx3h4OMu7+yRv7yzdDWgAXGTzntKfaPzGQ==
X-Received: by 2002:ac8:44c7:: with SMTP id b7mr73720347qto.351.1609821698708;
        Mon, 04 Jan 2021 20:41:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l24sm39016058qkl.46.2021.01.04.20.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 20:41:37 -0800 (PST)
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <CAPig+cS-oDfCX-LaDEW2U+9Aa9VNZUPs54isODoHCv6HxAdZeQ@mail.gmail.com>
 <65af825c-00b1-5852-3a4a-81babfc5040f@gmail.com>
 <CAPig+cTxCLbfsk4D-_Rd=XF=A4zje1_pETyD9CJRtJNyADb=tg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d459a931-049d-f445-2fa7-abb03c962c86@gmail.com>
Date:   Mon, 4 Jan 2021 23:41:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTxCLbfsk4D-_Rd=XF=A4zje1_pETyD9CJRtJNyADb=tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/4/2021 1:22 AM, Eric Sunshine wrote:
> On Sun, Jan 3, 2021 at 8:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 1/2/2021 1:12 AM, Eric Sunshine wrote:
>>> This should allow you to get rid of the globals introduced by patch
>>> [4/12] (assuming passing the index and repo arguments around
>>> everywhere doesn't get overly hairy).
>>
>> Perhaps now that I've removed the compatibility macros, it would be
>> easier to insert the method parameters since most of the lines that
>> need to change would be method prototypes and the calls to those methods
>> (plus the callback function details).
>>
>> Is that a valuable effort? I could give it a try, but I want to be sure
>> that adjusting all of those helper methods in the builtin would indeed
>> have valuable improvements over the static globals used here.
> 
> My impression was that the goal of the earlier work was to pass the
> index and repository to each function specifically to avoid tying the
> function to a particular index or repository. This helps in cases in
> which client code needs to operate on a different index or repository
> (for instance, a submodule). Generally speaking, making the index and
> repository file-static rather than global does not help reach that
> goal since functions are still tied to state which is not local to the
> function itself.
> 
> Would the extra effort be valuable in this particular case? I'm not
> familiar with this code, but given that `update-index` is a builtin,
> such effort may not be too meaningful. If, however, any of the code
> from `buildin/update-index.c` ever gets "libified" and moved into the
> core library, then that would be a good time to update the functions
> to take those values as arguments rather than relying on file-static
> or globals. But that's not something that this series necessarily
> needs to do; the task can wait until the code needs to be shared by
> other modules, I would think.

I tried again tonight, and it started getting messy, but then I
realized that I could group the callbacks that need the repo and
index to use a common struct that holds the other parameters they
need. It's still a bigger patch than I'd like, but it is more
reasonable.

v2 is incoming with my attempt at this.

Thanks,
-Stolee

