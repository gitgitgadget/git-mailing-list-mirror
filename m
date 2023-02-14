Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DCC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjBNVRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjBNVRN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:17:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DF2F7B9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:16:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so19450295qta.12
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676409393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc+XOS0+2InnDxabcRE5HBMR6K/OAstkAXwBsxJ55yM=;
        b=R+d1Cmoy2hiJQLuagbJjBtjwDFl/FnJRa1zsTry2rXLRzFFjleZnkt7R1wDKQzvpfP
         +8mJIfhrpHKdTk4W0wZVN/hzHDMNi7xdYo+rCpAyP1hOEHNRRXF9qiaDqunvCIdHELUH
         duLj6oJQIeUocwoULYgT6jA4BLUKxoJW2Tb7SVuXfNj+txgucDwBymDC2+GNDkZRfIZQ
         TrMLdJRGWDs9dKtJrQfWSf2UfD9LEwiCAClaq5KErNWlwjRAC+cuka2nXe1wxdJRTYVM
         PfNzbE5cgZ6tEfT2mjeHH5SIil6ZOAMw24/tz5Y3Z0ugcnpl5zywow1dYM/L1Oz62si/
         9pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676409393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc+XOS0+2InnDxabcRE5HBMR6K/OAstkAXwBsxJ55yM=;
        b=XgYjrIAfutEgaU0xwRu7EjFlQ3MplVd/443zvJqG99lQatFvlhqe0OjhAr0OcOk3ZY
         xLD9qQNx9YtKHEorGk1E9PSp3Mh5aIvzxcck70iRmobpmV26HKXAZRYX/PoR88CFJxV9
         0CmlQiugteORJvnM1Nw+N53tmvrCKlbzmCBDILlB9kygUWRFdzJzEwQJ3xXtJ/P+EP03
         7kZ5YK06JwI+CgQ6wFKWIcSAcA6BmSOZoYyGfhuJ0Fnwx/eoYBUWzhezKV7EwQkHKCa7
         C+3vovPShSKIdb5Z/FpFrE3ODrbL/olcNUcUpFKmqHyjHQtAfMdq7EZnoqnk6iDErDmg
         yvQw==
X-Gm-Message-State: AO0yUKXdS6RQd7+Vs7ZLlS275/5XONG52NGQO1aRsNbLQN/NL1LHsPes
        HxfwlwZToOEJoyKIXjgESRCQ/mdE1Xg=
X-Google-Smtp-Source: AK7set957HHaClUOtdv1+D1AV3t40Q19c8BLVCpfrSwy+pVDEMz5vZSsHe+4Co5cM39A4+3QXLpsbw==
X-Received: by 2002:ac8:59ce:0:b0:3b8:6bef:61df with SMTP id f14-20020ac859ce000000b003b86bef61dfmr8040751qtf.6.1676409393479;
        Tue, 14 Feb 2023 13:16:33 -0800 (PST)
Received: from [192.168.1.166] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id u128-20020a372e86000000b0073b27323c6dsm7356805qkh.136.2023.02.14.13.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2023 13:16:33 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 14 Feb 2023 16:16:32 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <AF5092D2-A561-4B56-8FB8-25DCFA28F32C@gmail.com>
In-Reply-To: <CABPp-BFKQXe-EJOd9z1TrisL64NuV9A132rf9MwV_7w79QQ9YQ@mail.gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <CABPp-BFKQXe-EJOd9z1TrisL64NuV9A132rf9MwV_7w79QQ9YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 9 Feb 2023, at 3:44, Elijah Newren wrote:

> Hi John,
>
> On Mon, Feb 6, 2023 at 12:47 PM John Cai <johncai86@gmail.com> wrote:
>>
> [...]
>> That being said, here's a separate issue. I benchmarked the usage of
>> .gitattributes as introduced in this patch series, and indeed it does look like
>> there is additional latency:
>>
>> $ echo "* diff-algorithm=patience >> .gitattributes
>> $ hyperfine -r 5 'git-bin-wrapper diff --diff-algorithm=patience v2.0.0 v2.28.0'                      ✭
>> Benchmark 1: git-bin-wrapper diff --diff-algorithm=patience v2.0.0 v2.28.0
>>   Time (mean ± σ):     889.4 ms ± 113.8 ms    [User: 715.7 ms, System: 65.3 ms]
>>   Range (min … max):   764.1 ms … 1029.3 ms    5 runs
>>
>> $ hyperfine -r 5 'git-bin-wrapper diff v2.0.0 v2.28.0'                                                ✭
>> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
>>   Time (mean ± σ):      2.146 s ±  0.368 s    [User: 0.827 s, System: 0.243 s]
>>   Range (min … max):    1.883 s …  2.795 s    5 runs
>>
>> and I imagine the latency scales with the size of .gitattributes. Although I'm
>> not familiar with other parts of the codebase and how it deals with the latency
>> introduced by reading attributes files.
>
> Yeah, that seems like a large relative performance penalty.  I had the
> feeling that histogram wasn't made the default over myers mostly due
> to inertia and due to a potential 2% loss in performance (since
> potentially corrected by Phillip's 663c5ad035 ("diff histogram: intern
> strings", 2021-11-17)).  If we had changed the default diff algorithm
> to histogram, I suspect folks wouldn't have been asking for per-file
> knobs to use a better diff algorithm.  And the performance penalty for
> this alternative is clearly much larger than 2%, which makes me think
> we might want to just revisit the default instead of allowing per-file
> tweaks.

It seems like the performance penalty was because I was adding calls to parse
attribute files. Piggy backing off of the attribute parsing in userdiff.h will
allow us to not incur this performance penalty:

$ hyperfine -r 5 -L a bin-wrappers/git,git '{a} diff v2.0.0 v2.28.0'
Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
  Time (mean ± σ):      1.072 s ±  0.289 s    [User: 0.626 s, System: 0.081 s]
  Range (min … max):    0.772 s …  1.537 s    5 runs

Benchmark 2: git diff v2.0.0 v2.28.0
  Time (mean ± σ):      1.003 s ±  0.065 s    [User: 0.684 s, System: 0.067 s]
  Range (min … max):    0.914 s …  1.091 s    5 runs

Summary
  'git diff v2.0.0 v2.28.0' ran
    1.07 ± 0.30 times faster than 'git-bin-wrapper diff v2.0.0 v2.28.0'

>
> And on a separate note...
>
> There's another set of considerations we might need to include here as
> well that I haven't seen anyone else in this thread talk about:

These are some great questions. I'll do my best to answer them.
>
> * When trying to diff files, do we read the .gitattributes file from
> the current checkout to determine the diff algorithm(s)?  Or the
> index?  Or the commit we are diffing against?
> * If we use the current checkout or index, what about bare clones or
> diffing between two different commits?
> * If diffing between two different commits, and the .gitattributes has
> changed between those commits, which .gitattributes file wins?
> * If diffing between two different commits, and the .gitattributes has
> NOT changed, BUT a file has been renamed and the old and new names
> have different rules, which rule wins?

In the next version I plan on using Peff's suggestion of utilizing the existing
diff driver scheme [1]. I believe these four questions are addressed if we use
the existing userdiff.h API, which in turn calls the attr.h API. We check the
worktree, then fallback to the index.

By using the userdiff.h API, the behavior will match what users already expect
when they for instance set an external driver.

1. https://lore.kernel.org/git/Y+KQtqNPews3vBS8@coredump.intra.peff.net/

>
> * If per-file diff algorithms are adopted widely enough, will we be
> forced to change the merge algorithm to also pay attention to them?
> If it does, more complicated rename cases occur and we need rules for
> how to handle those.
> * If the merge algorithm has to pay attention to .gitattributes for
> this too, we'll have even more corner cases around what happens if
> there are merge conflicts in .gitattributes itself (which is already
> kind of ugly and kludged)

I see this feature as a user-experience type convenience feature, so I don't
believe there's need for the merge machinery to also pay attention to the diff
algorithm set through gitattrbutes. We can clarify this in the documentation.

>
>
> Anyway, I know I'm a bit animated and biased in this area, and I
> apologize if I'm a bit too much so.  Even if I am, hopefully my
> comments at least provide some useful context.

No problem! thanks for raising these issues.

thanks
John
