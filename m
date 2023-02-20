Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FFC05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBTNhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 08:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBTNhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 08:37:14 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF31A640
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 05:37:12 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id ks17so1124200qvb.6
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 05:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjLnfQx6KjtzY6zszEG1nFZseWla1WEMngSPDfBifyc=;
        b=WNeIpzB6s0srD9ZD7ghQuwHLE8iU3rDN/wYFJi0jHPeMl/CiahkisKAtntcYsJT7Ox
         YhtZOUp+mlkziSdBXy/Y3kBtEAKldjWpWf85Au6b2EV3xCHbyFGAQfIeKKqHGQNEidkg
         75m90mV7uKC9RIlWEGKHtjQ1TOd4f9AkxY4zgPQsi35Kbck2wRYixfcLB5wt2vZbokSb
         80CIinrECRy7nkpSBvxXdkntig6YG/KGUb8IEOzO56ESXjLqTWwRmbw02J17IiQSUTnE
         4Qim423H5nTithf7GTZzJW8xva6TvxMEWYoafw3Y4Wz/+GVID7hXYj54mj9ij1ET8aVo
         lWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjLnfQx6KjtzY6zszEG1nFZseWla1WEMngSPDfBifyc=;
        b=M18duAfZnbNL7jZB1voAanfFNTLWJGke/bHcDYI9tiaMUxX1yaI+cwPEjJKPeLAlgP
         QlqqgZSfcNaKds1YTbC2oHfE+8dRogLMYkHp8uN3kqbnFbXyzmraXVOHVeVJmqIt+OVj
         kfsrRAEbA19sUR0piT4nUTjhLDtfd5Uj0I8zV2RFmfVlZng3EkKZWxqKYWecRn4dHElM
         L2XbG3HL53qd0Dkl79VzWih+KdQihYWdQPGxI+67fDlgRS9g6HHowTwBAPEgxMoNOvqx
         oWVeWsPU2c9RnRo9W2/wh0rv+L3HF+FWxX5cguqtH3tKOL5h2jezk6x7SGr/68wShGq+
         yoXA==
X-Gm-Message-State: AO0yUKXSQ7QzvpE7AqNtqVLJkTBRai21hIlhALsBPoLM4pmRFDxJzRTC
        vuTkw7NeC7XdUSUWENs38OxgcTnUtkU=
X-Google-Smtp-Source: AK7set/JE6UVsZVNxWB+vgq7fakoD+kzMf2VW+/8dLnjKqRPWZ+bJ9nATs9ZwwWd3Sic8IEWnLYgDQ==
X-Received: by 2002:a0c:aa19:0:b0:56e:99ea:966c with SMTP id d25-20020a0caa19000000b0056e99ea966cmr1206780qvb.4.1676900231678;
        Mon, 20 Feb 2023 05:37:11 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:8905:dad0:53aa:3ab7])
        by smtp.gmail.com with ESMTPSA id d127-20020ae9ef85000000b0073ba92629e1sm7151095qkg.23.2023.02.20.05.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:37:11 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] Teach diff to honor diff algorithms set through git attributes
Date:   Mon, 20 Feb 2023 08:37:10 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <9C99CD32-79B4-4754-AE9A-267C29ECE19D@gmail.com>
In-Reply-To: <CABPp-BH4042YS7yjXGpaD=1vZOLnTZQY7L2qqpdOvsGmCxO6Dw@mail.gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <CABPp-BH4042YS7yjXGpaD=1vZOLnTZQY7L2qqpdOvsGmCxO6Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 17 Feb 2023, at 20:16, Elijah Newren wrote:

> On Fri, Feb 17, 2023 at 12:21 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> When a repository contains different kinds of files, it may be desirable to
>> use different algorithms based on file type. This is currently not feasible
>> through the command line or using git configs. However, we can leverage the
>> fact that gitattributes are path aware.
>>
>> Teach the diff machinery to check gitattributes when diffing files by using
>> the existing diff. scheme, and add an "algorithm" type to the external
>> driver config.
> [...]
>> To address some of the performance concerns in the previous series, a
>> benchmark shows that a performance penalty is no longer incurred, now that
>> we are no longer adding an additional attributes parsing call:
>>
>> $ hyperfine -r 5 -L a bin-wrappers/git,git '{a} diff v2.0.0 v2.28.0'
>> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0 Time (mean ± σ): 1.072 s ±
>> 0.289 s [User: 0.626 s, System: 0.081 s] Range (min … max): 0.772 s … 1.537
>> s 5 runs
>>
>> Benchmark 2: git diff v2.0.0 v2.28.0 Time (mean ± σ): 1.003 s ± 0.065 s
>> [User: 0.684 s, System: 0.067 s] Range (min … max): 0.914 s … 1.091 s 5 runs
>>
>> Summary 'git diff v2.0.0 v2.28.0' ran 1.07 ± 0.30 times faster than
>> 'git-bin-wrapper diff v2.0.0 v2.28.0'
>
> I'm sorry, I don't understand this.  What are you measuring?  I
> presume bin-wrappers/git refers to the version of git built with your
> changes, but what version of git does "git" refer to?  Also, do you
> have any .gitattributes or .git/config changes present when you are
> testing to trigger the new functionality you have written?
>
> Also, doesn't this benchmark demonstrate the opposite of your claim?
> You said there was no performance penalty, but the benchmark shows a
> 7% slowdown.  We've battled hard to get smaller improvements than
> that, so this is still worrisome, even if it's no longer a factor of 2
> or whatever it was.  But, again, I'm not sure what is being measured.
> If the difference is because patience diff was used for some files,
> then it's not an apples-to-apples comparison, and a 7% slowdown would
> be no cause for concern.
>
> Since I was curious, I compiled both a version of git from directly
> before your series, and directly after, then added a '*.[ch]
> diff=other' line to the end of .gitattributes, then ran:
>
> $ hyperfine -L a ./older-git,./newer-git '{a} -c
> diff.other.algorithm=myers diff --numstat v2.0.0 v2.28.0'
> Benchmark 1: ./older-git -c diff.other.algorithm=myers diff --numstat
> v2.0.0 v2.28.0
>   Time (mean ± σ):     870.2 ms ±   4.4 ms    [User: 755.2 ms, System: 109.8 ms]
>   Range (min … max):   861.0 ms … 876.8 ms    10 runs
>
> Benchmark 2: ./newer-git -c diff.other.algorithm=myers diff --numstat
> v2.0.0 v2.28.0
>   Time (mean ± σ):     876.9 ms ±   4.8 ms    [User: 758.0 ms, System: 113.1 ms]
>   Range (min … max):   870.7 ms … 884.1 ms    10 runs
>
> Summary
>   './older-git -c diff.other.algorithm=myers diff --numstat v2.0.0 v2.28.0' ran
>     1.01 ± 0.01 times faster than './newer-git -c
> diff.other.algorithm=myers diff --numstat v2.0.0 v2.28.0'
>
> I specifically specified 'myers' to match what we'd get from the
> default anyway, so I would only be testing the slowdown from the
> .gitattribute parsing.  So, I think the performance overhead comes out
> to just 1% rather than 7% (and further that's when I make it only
> print overall stats about the diff rather than the full diff, since I
> know that's faster.  If I didn't do that, the perf hit might appear to
> be less than 1%).

Thanks for taking the time to do this! I should have been a bit more careful
about this benchmark, and more explicit about what it was benchmarking. I just
ran it again and made sure that the same algorithm was used, and I got results
similar to you.

Will update the cover letter, thanks!
