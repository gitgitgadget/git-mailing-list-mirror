Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0468C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 00:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706D62080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 00:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InYQSDsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgDAAJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:09:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37208 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgDAAJa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 20:09:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id x3so25261864qki.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DbYyqmN2rTqdZQYGPXQN4ukf5Tcsvtc/M9JAmiCmGU=;
        b=InYQSDsyL7f8ZyH6CPHYtl+Jb2VJcVvRJ7ELfYn3QQrxO+4ZRDHPynmmDhZueyuMB5
         uO96NQNdoB3BzoOA+qqnmikGJRtvPrm6FFZ5EOV/SGXlHYbmfxUiDpy4eG8cb2v+O3oE
         5Yd6/IK3Hd85IdHqVFpKUoqhi97ayLdqsD8lAvEJbIOT5/bRFKzr3Y9WGNwooAcuhH9H
         EksWDhsXf6G1oVI0KsvZjB4zMEJv6YliBaw7lLEdXDgkuMa3laicqoCLsIZ3JgT1s6i8
         7teQXJKWN4kyBLg0RDrCmHfx0Z9arICnCXEiw96Tym3KjbdYieUgegdNyfxDJOB1PsPn
         /CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DbYyqmN2rTqdZQYGPXQN4ukf5Tcsvtc/M9JAmiCmGU=;
        b=HJ9HtIyDnUMJZvCGusV+007QgDqkyHxiU0SfUhd5zJQcc7oDIOAVp3BNXXwiJhOaON
         8A3+lv9o3bc93EAGxAjByHN8FKgSeqhjdbimGuQssp2oLRD+w40NjuBpNIO8UazEUWgO
         JX8VX4fmQcvzjFf8j80SJQ+BEsvWdzhUMDda87roySXAxiQ0HLRJby2vWcsJ9wSH0LNE
         TkpF5sX1xWi4G4euvK/QqqgXEniOUZfPHksr331fg1z2HsXraq7s87ZMfXiFUrqK3jFE
         9+x33RL9rTNElQrnqk33cWsMpe1Pwqo7JBCbRwTpAmXMhapxU1fgXTNNj8DpzoawgnKP
         yATg==
X-Gm-Message-State: ANhLgQ0HrEuMHDmatQ48vbwbcnflr9PUfGk5Yc+LZg19GN9KW40959zx
        X9qSEB5GGqnVDWFJ+ni4CF/pe0znkZw=
X-Google-Smtp-Source: ADFU+vvNvyXE0HLw6Hfx2bSaJ+FhbDRtxpMZUtFa0PhGEFLNaY7Oc3IATuDt331HRYloSsK3VaM3KA==
X-Received: by 2002:a37:4bd1:: with SMTP id y200mr7946203qka.205.1585699768289;
        Tue, 31 Mar 2020 17:09:28 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l16sm352837qtc.73.2020.03.31.17.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 17:09:27 -0700 (PDT)
Subject: Re: Inefficiency of partial shallow clone vs shallow clone +
 "old-style" sparse checkout
To:     Konstantin Tokarev <annulen@yandex.ru>, Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
 <20200328144023.GB1198080@coredump.intra.peff.net>
 <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
 <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
 <4872731585693023@vla5-c5051da8689e.qloud-c.yandex.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0bf763ad-5f1d-65e2-bf3a-a4b7d5a7b3e3@gmail.com>
Date:   Tue, 31 Mar 2020 20:09:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <4872731585693023@vla5-c5051da8689e.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2020 6:23 PM, Konstantin Tokarev wrote:
> 01.04.2020, 01:10, "Konstantin Tokarev" <annulen@yandex.ru>:
>> 28.03.2020, 19:58, "Derrick Stolee" <stolee@gmail.com>:
>>>  On 3/28/2020 10:40 AM, Jeff King wrote:
>>>>   On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:
>>>>
>>>>>   Is it a known thing that addition of --filter=blob:none to workflow
>>>>>   with shalow clone (e.g. --depth=1) and following sparse checkout may
>>>>>   significantly slow down process and result in much larger .git
>>>>>   repository?
>>>
>>>  In general, I would recommend not using shallow clones in conjunction
>>>  with partial clone. The blob:none filter will get you what you really
>>>  want from shallow clone without any of the downsides of shallow clone.
>>
>> Is it really so?
>>
>> As you can see from my measurements [1], in my case simple shallow clone (1)
>> runs faster than simple partial clone (2) and produces slightly smaller .git,
>> from which I can infer that (2) downloads some data which is not downloaded
>> in (1).
> 
> Actually, as I have full git logs for all these cases, there is no need to be guessing:
>     (1) downloads 295085 git objects of total size 1.00 GiB
>     (2) downloads 1949129 git objects of total size 1.01 GiB

It is worth pointing out that these sizes are very close. The number of objects
may be part of why the timing is so different as the client needs to parse all
deltas to verify the object contents.

Re-running the test with GIT_TRACE2_PERF=1 might reveal some interesting info
about which regions are slower than others.

> Total sizes are very close, but (2) downloads much more objects, and also it uses
> 3 passes to download them which leads to less efficient use of network bandwidth.

Three passes, being:

1. Download commits and trees.
2. Initialize sparse-checkout with blobs at root.
3. Expand sparse-checkout.

Is that right? You could group 1 & 2 by setting your sparse-checkout patterns
before initializing a checkout (if you clone with --no-checkout). Your link
says you did this:

	git clone <mode> --no-checkout <url> <dir>
	git sparse-checkout init
	git sparse-checkout set '/*' '!LayoutTests'

Try doing it this way instead:

	git clone <mode> --no-checkout <url> <dir>
	git config core.sparseCheckout true
	git sparse-checkout set '/*' '!LayoutTests'

By doing it this way, you skip the step where the 'init' subcommand looks
for all blobs at root and does a network call for them. Should remove some
overhead.

Less efficient use of network bandwidth is one thing, but shallow clones are
also more CPU-intensive with the "counting objects" phase on the server. Your
link shares the following end-to-end timings:

* Shallow-clone: 234s
* Partial clone: 286s
* Both(???): 1023s

The data implies that by asking for both you actually got a full clone (4.1 GB).

The 234s to 286s difference is meaningful. Almost a minute.

>> To be clear, use case which I'm interested right now is checking out sources in
>> cloud CI system like GitHub Actions for one shot build. Right now checkout usually
>> takes 1-2 minutes and my hope was that someday in the future it would be possible\
>> to make it faster.

As long as you delete the shallow clone every time, then you also remove the
downsides of a shallow clone related to a later fetch or attempts to push.

If possible, a repo this size would benefit from persistent build agents that
you control. They can keep a copy of the repo around and do incremental fetches
that are much faster. It's a larger investment to run your own build lab, though.
But sometimes making builds faster is expensive. It depends on how "expensive" those
four minute clones per build are in terms of your team waiting.

Thanks,
-Stolee
