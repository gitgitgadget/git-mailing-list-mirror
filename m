Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E51C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9140C206A2
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXTdL13W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgDNRlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728863AbgDNRk6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 13:40:58 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02830C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 10:40:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r25so1282488oij.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Y19qdHHuhK3MRMAAmx024TB7qBkoHd/YS1g1N7rh5w=;
        b=CXTdL13W8qvBFdXZJWF96X+sAGi5Cp6+iI+aI+ksJIKj+TDPzkDhL/BT1xRY4GiqMV
         mH5RndusMD4C1++la36CoWA+BOtVFFovdOS+hLmJ3F8rnsCLxb/jvMSI9U+br8e2sQe2
         IFjiLKvMihl0pO0I7X2SFDVS8d1OvD7pYNlSkXIO+XdCbwgQouGQviO5/+22WzMBwmi3
         s7ee0AMEsDOTYLepbOp0NPcmee6MrvHVOmRRUBjt96toD6R8ejtUGd+GtG8RysAaLTJZ
         HeG3nARLX4hFtXZ7U4ZoMjgIH62cm7Rz9vpvlKDraGlCJ8zu0UDBr5MJo9p9JoLSh12+
         hdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Y19qdHHuhK3MRMAAmx024TB7qBkoHd/YS1g1N7rh5w=;
        b=dt1piQ+QJnY75UX7o+Lo6AOgMCvKfv0/HtbTMbSi67bsHHYUiNoEFZFSDbnQlW3SdZ
         cjEhowBLyAXZa57AvrRn3/r7r8Nxxvik6rVKuhxN4y7TJRPEdtxKYXFgRxb3vc/uvI1j
         kq/2Ahrmz+T54KO84Qr2AHe7fy+VQuLQtW+a+Iq/VHeWzlR42fcGrtpbRQaYvhsgmmAq
         wUlGR0fQCvRXn2NC0iocQQXr4CqCNSDrrC3Usqf1CTvluO+37QXGdbO8DMpDGd6eHx2u
         mYzegWQWypKWdoaZKGXeAvSR/BSFY8isJJO9hcyKnt0g5l1+5gRcgz2iFAgRqdoBVbnF
         sm4A==
X-Gm-Message-State: AGi0PuaBMvFsQxBKLd3oW0C9LV34Dx+Vy5L7X87vhevgMz0ANh+Ph4vh
        PUVo1cH89qPCMYfE7Wm8X/M=
X-Google-Smtp-Source: APiQypLZ0pVtBsUVjCDhJaEkLpiE5KWyayx20qmJtpy1kSkFE2IvxAjxZpSe17ESzLP20gYqjR8gEg==
X-Received: by 2002:aca:6056:: with SMTP id u83mr16826914oib.95.1586886056944;
        Tue, 14 Apr 2020 10:40:56 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k4sm5653302otl.13.2020.04.14.10.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 10:40:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
 <20200413161245.GE59601@syl.local> <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
 <74e4e8d6-d401-081d-14cc-c4b6087bdeda@gmail.com>
 <xmqqa73e9dws.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36f321b9-e2ff-60c3-637a-38682ee5d9f0@gmail.com>
Date:   Tue, 14 Apr 2020 13:40:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqa73e9dws.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 1:26 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 4/13/2020 6:21 PM, Junio C Hamano wrote:
>>> Taylor Blau <me@ttaylorr.com> writes:
>>>
>>>> Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
>>>> environment variables and potentially ignoring its arguments, but given
>>>> the discussion we had in v1, I don't feel strongly enough to recommend
>>>> that you change this.
>>>>
>>>> For what it's worth, I think that 'write_commit_graph' could behave more
>>>> purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
>>>> 'flags' appropriately from the outside,...
>>>
>>> Yeah, I agree that it would be a lot cleaner if that is easy to
>>> arrange.  I have a suspicion that Derrick already tried and the
>>> resulting code looked messier and was discarded?
>>
>> Perhaps I could fix both concerns by
>>
>> 1. Use a macro instead of a library call.
>>
>> 2. Check the _CHANGED_PATHS variable in the macro.
> 
> I am not sure how use of a macro "fixes" purity, though.  And what
> is the other concern?

The concern was (1) checking the environment and (2) die()ing in the
library.

> How widely would this "if we are testing, write out the graph file"
> call be sprinkled over the codebase?  I am hoping that it won't be
> "everywhere", but only at strategic places (like "just once before
> we leave a subcommand that creates one or bunch of commits").  And
> how often would they be called?  I am also hoping that it won't be
> "inside a tight loop".  In short, I am wondering if we can promise
> our codebase that 
> 
>  - git_test_write_commit_graph_or_die() calls won't be an eyesore
>    (and/or distraction) for developers too much.
> 
>  - git_env_bool() call won't have performance impact.

I could add a comment to the header file to say "this is only for
improving coverage of optional features in the test suite. Do not
call this method unless you know what you are doing."

My intention right now is to only include this in 'git commit'
and 'git merge'. Earlier discussion included thoughts about
'git rebase' and similar, but those are more rarely used when
constructing an "example repo" in the test scripts.

-Stolee
