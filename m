Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D03C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475FF613F8
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhD0Tcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbhD0Tck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:32:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E264C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:31:56 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v20so6320443qkv.5
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W1K7WZQdeDaaUUWN/R4gAwM1gBQv2TCk3LRUROPE9Rs=;
        b=MjNmjSl7Oy6MqWnxcfceYqZ6gliUE3Q+vnVVNqPwuugNLlgAETZxPReCaNo/0MF+XP
         iYZzY1m/hryeEuk4EiMXbBCH6azqSHizM+LL+9YxLnvl7Dh6I6MnA+KfTnGIfNv+04i8
         F0PpX4/DZHZQBVKgZRwm29ek20VuThNhHdokSL2kZL99C1ogZz2ZJIYb7EzO8y5Z3/Bn
         BjVb7mxpNjlCkITiVugBFHhuAFYhewC8S8+zE4q3xnr+nsJy04q/p0UaC37sGLWbjdZY
         JBkm0xRSi+VK2Pan8NBeMQ1OMYwq6iMM3wzphe58Wawfgu1XkOo0J8JX+5MJ6GhAoCfQ
         LlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1K7WZQdeDaaUUWN/R4gAwM1gBQv2TCk3LRUROPE9Rs=;
        b=PjghlPdWA5+T96UdO9Yj3svi9tVQASMZH+crdU6grbuUDSWnSyiiruHoNnXSTyGqtu
         pcWu8O8DmoMcRbPca+nf9gfnNiANY05mebJV8X+A1FQ70UHEexsBh9ZVBYAi/v2nqAlu
         SZiRIXISQxkZGKqJqpbdhN+Ho0F497tFrvsmcTQe5K67eW0H+DACDU8LB1gT874oPJwm
         w6JkM3UbXF/0+qwxz9EJGGBHkhJ+LR7nBJxGyUa4MLJUqliXKvXgbImaPRlfWQM6KkCf
         L2Ypde5fZ48n7fc0impPZW1E/iq1z73jSXP6//qiFMOItDaFn0J7cOwt/Wb2VB644CP/
         w+XA==
X-Gm-Message-State: AOAM531kOiPUDw2ZAs3NnlNrvRoD08ABy3HCrS2K80rRDcEo92JHzTVo
        ChXd2CVuf4qihS0Kn/IUb6c=
X-Google-Smtp-Source: ABdhPJx5HDwrbcxQnvHWn4QzlsReA50rwhyfURPoGBfoNd6e72DtOrh31DWfodSwXIKdZRiBWtToSw==
X-Received: by 2002:a05:620a:2296:: with SMTP id o22mr15233977qkh.132.1619551915665;
        Tue, 27 Apr 2021 12:31:55 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:cdf6:999f:6779:61eb])
        by smtp.gmail.com with ESMTPSA id f5sm3533275qkk.12.2021.04.27.12.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:31:55 -0700 (PDT)
Subject: FS Monitor macOS Performance (was [PATCH 00/23] [RFC] Builtin
 FSMonitor Feature)
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa7ab292-f574-f960-c270-79e298046fef@gmail.com>
Date:   Tue, 27 Apr 2021 15:31:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> This patch series adds a builtin FSMonitor daemon to Git.
> 
> This daemon uses platform-specific filesystem notifications to keep track of
> changes to a working directory. It also listens over the "Simple IPC"
> facility for client requests and responds with a list of files/directories
> that have been recently modified.
...
> This RFC version includes support for Windows and MacOS file system events.
> A Linux version will be submitted in a later patch series.

Similarly to my message about testing the Windows performance, I
repeated those tests on macOS.

The same testing procedure was used, except now I'm on a MacBook
Pro laptop instead of a desktop, so the CPU power is likely to be
significantly less.

However, I am pleased to report that the FS Monitor feature is
a clear winner in all scenarios. Using the untracked cache is
still highly recommended, but not necessary in order to get a
speed boost from the builtin FS Montiro.


Sparse Index Disabled, Untracked Cache Enabled
----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      3.980 s ±  0.026 s    [User: 919.1 ms, System: 1891.8 ms]
  Range (min … max):    3.940 s …  4.028 s    10 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):     477.9 ms ±   6.6 ms    [User: 772.9 ms, System: 379.7 ms]
  Range (min … max):   468.1 ms … 489.5 ms    10 runs
 
Summary
  'builtin (clean)' ran
    8.33 ± 0.13 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):      5.411 s ±  0.199 s    [User: 2.993 s, System: 4.120 s]
  Range (min … max):    5.026 s …  5.756 s    10 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):      2.588 s ±  0.025 s    [User: 3.752 s, System: 2.853 s]
  Range (min … max):    2.540 s …  2.628 s    10 runs
 
Summary
  'builtin (dirty)' ran
    2.09 ± 0.08 times faster than 'none (dirty)'

Sparse Index Disabled, Untracked Cache Disabled
-----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      2.993 s ±  0.115 s    [User: 1.562 s, System: 2.289 s]
  Range (min … max):    2.741 s …  3.167 s    10 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):     939.4 ms ±  10.1 ms    [User: 1.452 s, System: 1.519 s]
  Range (min … max):   925.1 ms … 961.0 ms    10 runs
 
Summary
  'builtin (clean)' ran
    3.19 ± 0.13 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):      8.245 s ±  1.118 s    [User: 3.204 s, System: 5.684 s]
  Range (min … max):    5.927 s …  8.985 s    10 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):      2.969 s ±  0.034 s    [User: 3.832 s, System: 3.160 s]
  Range (min … max):    2.927 s …  3.023 s    10 runs
 
Summary
  'builtin (dirty)' ran
    2.78 ± 0.38 times faster than 'none (dirty)'


Sparse Index Enabled, Untracked Cache Enabled
---------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      1.250 s ±  0.050 s    [User: 216.9 ms, System: 1836.9 ms]
  Range (min … max):    1.177 s …  1.300 s    10 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):      89.3 ms ±   2.9 ms    [User: 51.3 ms, System: 22.6 ms]
  Range (min … max):    81.9 ms …  93.5 ms    31 runs
 
Summary
  'builtin (clean)' ran
   14.01 ± 0.72 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):      2.087 s ±  0.095 s    [User: 320.9 ms, System: 3327.5 ms]
  Range (min … max):    1.943 s …  2.242 s    10 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):     233.5 ms ±   2.7 ms    [User: 165.5 ms, System: 74.1 ms]
  Range (min … max):   227.8 ms … 237.1 ms    12 runs
 
Summary
  'builtin (dirty)' ran
    8.94 ± 0.42 times faster than 'none (dirty)'


Sparse Index Enabled, Untracked Cache Disabled
----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      1.277 s ±  0.101 s    [User: 215.5 ms, System: 1877.9 ms]
  Range (min … max):    1.138 s …  1.458 s    10 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):     300.0 ms ±   6.1 ms    [User: 119.4 ms, System: 183.1 ms]
  Range (min … max):   293.0 ms … 313.2 ms    10 runs
 
Summary
  'builtin (clean)' ran
    4.26 ± 0.35 times faster than 'none (clean)'
Benchmark #1: none (dirty)
  Time (mean ± σ):      2.488 s ±  0.088 s    [User: 432.6 ms, System: 3631.6 ms]
  Range (min … max):    2.328 s …  2.601 s    10 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):     636.4 ms ±  12.8 ms    [User: 266.2 ms, System: 374.0 ms]
  Range (min … max):   624.4 ms … 671.0 ms    10 runs

Summary
  'builtin (dirty)' ran
    3.91 ± 0.16 times faster than 'none (dirty)'


Here are my results for the Git repository:

Untracked Cache Enabled
-----------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      51.2 ms ±   4.0 ms    [User: 12.9 ms, System: 61.2 ms]
  Range (min … max):    46.2 ms …  65.7 ms    54 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):      38.6 ms ±   1.7 ms    [User: 9.9 ms, System: 9.7 ms]
  Range (min … max):    28.6 ms …  42.4 ms    75 runs
 
Summary
  'builtin (clean)' ran
    1.33 ± 0.12 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):     108.1 ms ±   7.2 ms    [User: 27.2 ms, System: 126.9 ms]
  Range (min … max):    97.6 ms … 130.4 ms    25 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):      91.7 ms ±   3.8 ms    [User: 25.4 ms, System: 27.0 ms]
  Range (min … max):    88.5 ms … 105.1 ms    32 runs
 
Summary
  'builtin (dirty)' ran
    1.18 ± 0.09 times faster than 'none (dirty)'


Untracked Cache Disabled
------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      59.5 ms ±   4.0 ms    [User: 15.2 ms, System: 67.7 ms]
  Range (min … max):    55.5 ms …  71.6 ms    46 runs
 
Benchmark #2: builtin (clean)
  Time (mean ± σ):      48.9 ms ±   1.0 ms    [User: 12.5 ms, System: 17.3 ms]
  Range (min … max):    46.7 ms …  51.3 ms    58 runs
 
Summary
  'builtin (clean)' ran
    1.22 ± 0.08 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):     124.4 ms ±   6.8 ms    [User: 31.5 ms, System: 140.2 ms]
  Range (min … max):   116.8 ms … 140.0 ms    24 runs
 
Benchmark #2: builtin (dirty)
  Time (mean ± σ):     104.1 ms ±   1.7 ms    [User: 27.4 ms, System: 37.8 ms]
  Range (min … max):    99.7 ms … 106.6 ms    27 runs
 
Summary
  'builtin (dirty)' ran
    1.19 ± 0.07 times faster than 'none (dirty)'

I think it valuable to point out that in my initial tests I had forgotten
to disable the Watchman-based FS Monitor hook, and the results looked even
more impressive (on the small Git repository). Dropping the hook overhead is
a huge benefit here.

Thanks,
-Stolee

