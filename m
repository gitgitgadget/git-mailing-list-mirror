Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4994C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A83564EB8
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhBSMm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhBSMmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:42:50 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7003C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:42:09 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q186so5640077oig.12
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jhO0owUNaTNUtBotioFRXGplXibDi7UE5M2eYTf0yoc=;
        b=RXPWQe+R6c3KGE6ubVaX16HdUQLEzpLTr6IixJ+cDX3iqsiaOLahurbBSIyFhz8e82
         ODHeOjxbHo0dHslYoW/SGxJKl/9DvNNWMn4f0Vmt+UTJ/ZSwYJyIO6KLqgu0Ng22ofZJ
         FvVzMCdsWlJ/6aJfThd/7xebBtJJPlkR9MAU7aGCcGsLlkpGisIe68zg1+f1aHuCV1mu
         ETiz4AkP4n36TvALT/ZK138Dq5wuboh3B+UBuDV7c4m9H15EXtd2bWe42Vo1//AjYVW0
         2Fs9mf2UaQAVJMyalN/6dDHaiuRrtq1piv0I3CH1vSaCKXd9gOcISVA2kSsPM+g1Of8g
         wOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jhO0owUNaTNUtBotioFRXGplXibDi7UE5M2eYTf0yoc=;
        b=DEkklNVWgoXMGCb00wN6kYeCkDyylImxaKCHISAW2eYd7n/U/4mH78douFV9mHTqDf
         yYhNKVfxIR08WLtxJb7G0jWb93eICTxyrFratE+YEEcJLfVWbLaBwbZu8hugJAXGufA5
         weiBEi7y/+ZnIxFHxT/TdRmX4spfVPmKt58evKrsArDtHm0MNvaWuSLUzqahnEurBzTc
         B4YGOND55q5EadrqiisdbSlsqEJ9f0/GhdDx19cbpnDxGahg2R3VfqCv/260TTj4oS5W
         7cZ/SfiMFEK4H9G2DIptzP7XB7r5uAjdl4o60dHm4RPv3vBpzkjIylxszyyD5du43qgB
         oCVw==
X-Gm-Message-State: AOAM532GU06YWkDZ7SyK2HlpKzKvjgZmmIVLJs2KnsQqe0RTs51JZn1T
        V/TpmMI+t6LZh+2WCznnmb8=
X-Google-Smtp-Source: ABdhPJxaqQDbHcBRzc+EHPx1EjNoCFdzqAGnt81Hg9iBGIFBKAyq7Z2TSJ+Xl8GD7zupQw+iumG9Sg==
X-Received: by 2002:aca:3354:: with SMTP id z81mr6106639oiz.2.1613738528948;
        Fri, 19 Feb 2021 04:42:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d41:9e8a:93a7:91b5? ([2600:1700:e72:80a0:8d41:9e8a:93a7:91b5])
        by smtp.gmail.com with UTF8SMTPSA id l4sm1597533ooq.33.2021.02.19.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 04:42:08 -0800 (PST)
Message-ID: <e16a548f-8070-e4be-b0b1-f36a259d0df1@gmail.com>
Date:   Fri, 19 Feb 2021 07:42:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v4 17/17] chunk-format: add technical docs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
 <84bf6506dc12163b37f46192b3742c8fb234322f.1613657260.git.gitgitgadget@gmail.com>
 <xmqqft1tdp4o.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqft1tdp4o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/18/2021 4:47 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +Chunk-based file formats
>> +========================
>> +
>> +Some file formats in Git use a common concept of "chunks" to describe
>> +sections of the file. This allows structured access to a large file by
>> +scanning a small "table of contents" for the remaining data. This common
>> +format is used by the `commit-graph` and `multi-pack-index` files. See
>> +link:technical/pack-format.html[the `multi-pack-index` format] and
>> +link:technical/commit-graph-format.html[the `commit-graph` format] for
>> +how they use the chunks to describe structured data.
> 
> I've read the doc added here to the end; well written and easy to
> understand.
> 
> I wonder how/if well reftable files fit in the scheme, or if it
> doesn't, should the chunk file format API be updated to accomodate
> it (or the other way around)?

I'm not sure that reftable can work with this format, especially with
its design to do most updates as append-only (IIUC). And to change the
format to work with the chunk format would violate the compatibility
with the JGit version. I would be interested if something like the
packed-refs file could use a minor update, but only if there is a
realistic benefit to using chunks over the current format.

The files that are on my radar for adopting a new file format using the
chunk-format API are:

* reachability bitmaps: using a similar approach to the commit-graph,
  we could avoid parsing the entire file before checking if a specific
  commit has a bitmap. (Requires a commit lookup chunk, a bitmap data
  chunk, and an offset chunk to connect them.)

* index v5: I'm trying to collect a bunch of information about how to
  update the index for better compression, and the chunk-based approach
  can provide some fixed-width columns that can vary in length depending
  on the required data (presenting the interesting behavior from v2 and v3,
  along with possible approaches previously presented as a potential v5).
  The paths could be presented as a chunk, giving the interesting options
  between v2/3 and v4 (prefix compression). I haven't even started the
  actual work here, but I've been thinking about it a lot. I'll have time
  next month to start prototyping.

Are there other interesting files that could use a new version here?
What other pain points are known to experts in the area?

>> +Extract the data information for each chunk using `pair_chunk()` or
>> +`read_chunk()`:
>> +
>> +* `pair_chunk()` assigns a given pointer with the location inside the
>> +  memory-mapped file corresponding to that chunk's offset. If the chunk
>> +  does not exist, then the pointer is not modified.
> 
> I think it is worth adding:
> 
>     The caller is expected to know where the returned chunk ends by
>     some out-of-band means, as this function only gives the offset
>     but not the size, unlike the read_chunk() function.

True. I suppose that could be more explicit, although it can be gleaned
from the omission of any size information.

Thanks,
-Stolee
