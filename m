Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA113C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiBURdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:33:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBURdF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:33:05 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E131B787
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:32:41 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c14so13124831ioa.12
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J8FllCj7ax3zqDPzxBxCynLALjKx+C0aRa9ZELnJmuA=;
        b=JUr0z/DYUO9Ti65G+MYZt0MZmJAA0Te09Digk0JqzXXi+p8CYEvsBjommadnF/zHgN
         SDqrgy9U5QWAf/mheXhsV/VCRyLXVEWwR2PbP9b5DxUiN8uzHSNxgtutwOsSWyzQtN6L
         w/3TbF/P8RsC8oLT/ckKQMhNGIoaXsmHzj9NqIryuZ7PvjY5iiuoCUwFr7mfG6gd3dz5
         OT10XHXyaXQC9Z6IsM6hR5dHz44zNE+m/gWiIWn1mOn/iWa2rhwo5gz5hN1QoSeJN8PL
         8QHwmGYc/FHTwPSc/IvmCWRz7VNIby5txoPZq/gp9qvGeHe04x5bmIyGJt1mb9lOBj0i
         BsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J8FllCj7ax3zqDPzxBxCynLALjKx+C0aRa9ZELnJmuA=;
        b=7+ACUxoAzWyeKPdQ1GU43jSSl4h2vn8jBpqpCfoc1MZ7URt/SXPIrhKIU3RX4+1qil
         IVm+WqUoT9pOFbMiggvEx9aXNeT/xLozJTrscVDdgl0++oM9nOwc+73VvevHtXXvcUck
         8ejIghjtkkWn3GlZWLG6fowEMPNUH+OrnELxDrTUMm/IAuRORLlQn6w9C6zmCxFp0lv+
         s/Iw0EGifJkzFeWqlycde02a2GaUj5LCVMMnGkmeUJiuHNiPYkYhWPbs9xJqqp8jfH5i
         Jdjm9Vz5dJu4t8NwkrBTTI/1EOwMNIcVGICkdJwWL11EBXwOpWOV0pOBVxBsr3j15yIz
         A6qQ==
X-Gm-Message-State: AOAM532iK2efLIStcPJTJFaTy+8//iKSo7IaoO3thzLqouM3TNb4g9j5
        rm82fuWQU5gCa0lVJzBTV2uFM0Afcg5gDycU
X-Google-Smtp-Source: ABdhPJznwUFV6BWeInbUhUlmKLasbex9ZpValbbEmw09Frv8uottyUnqzdszdEWAJQU/NJIhKYsvSg==
X-Received: by 2002:a5e:9b14:0:b0:5f0:7be3:bc10 with SMTP id j20-20020a5e9b14000000b005f07be3bc10mr16589537iok.78.1645464760337;
        Mon, 21 Feb 2022 09:32:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16sm361318ilk.14.2022.02.21.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:32:39 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:32:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] test-lib: add "fast_unwind_on_malloc=0" to
 LSAN_OPTIONS
Message-ID: <YhPMt3HwSsErvM0l@nand.local>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-4.4-d212009e517-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-4.4-d212009e517-20220221T155656Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 04:58:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Add "fast_unwind_on_malloc=0" to LSAN_OPTIONS to get more meaningful
> stack traces from LSAN. This isn't required under ASAN which will emit
> traces such as this one for a leak in "t/t0006-date.sh":
>
>     $ ASAN_OPTIONS=detect_leaks=1 ./t0006-date.sh -vixd
>     [...]
>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>         #0 0x488b94 in strdup (t/helper/test-tool+0x488b94)
>         #1 0x9444a4 in xstrdup wrapper.c:29:14
>         #2 0x5995fa in parse_date_format date.c:991:24
>         #3 0x4d2056 in show_dates t/helper/test-date.c:39:2
>         #4 0x4d174a in cmd__date t/helper/test-date.c:116:3
>         #5 0x4cce89 in cmd_main t/helper/test-tool.c:127:11
>         #6 0x4cd1e3 in main common-main.c:52:11
>         #7 0x7fef3c695e49 in __libc_start_main csu/../csu/libc-start.c:314:16
>         #8 0x422b09 in _start (t/helper/test-tool+0x422b09)
>
>     SUMMARY: AddressSanitizer: 3 byte(s) leaked in 1 allocation(s).
>     Aborted
>
> Whereas LSAN would emit this instead:
>
>     $ ./t0006-date.sh -vixd
>     [...]
>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>         #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
>         #1 0x7f2be1d614aa in strdup string/strdup.c:42:15
>
>     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
>     Aborted
>
> Now we'll instead git this sensible stack trace under
> LSAN. I.e. almost the same one (but starting with "malloc", as is
> usual for LSAN) as under ASAN:
>
>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>         #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
>         #1 0x7f012af5c4aa in strdup string/strdup.c:42:15
>         #2 0x5cb164 in xstrdup wrapper.c:29:14
>         #3 0x495ee9 in parse_date_format date.c:991:24
>         #4 0x453aac in show_dates t/helper/test-date.c:39:2
>         #5 0x453782 in cmd__date t/helper/test-date.c:116:3
>         #6 0x451d95 in cmd_main t/helper/test-tool.c:127:11
>         #7 0x451f1e in main common-main.c:52:11
>         #8 0x7f012aef5e49 in __libc_start_main csu/../csu/libc-start.c:314:16
>         #9 0x42e0a9 in _start (t/helper/test-tool+0x42e0a9)
>
>     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
>     Aborted

This is great, by the way. I have often hit that bug in LSan and been
incredibly frustrated by it. I'm happy to see it getting fixed here,
thank you.

> As the option name suggests this does make things slower, e.g. for
> t0001-init.sh we're around 10% slower:
>
>     $ hyperfine -L v 0,1 'LSAN_OPTIONS=fast_unwind_on_malloc={v} make T=t0001-init.sh' -r 3
>     Benchmark 1: LSAN_OPTIONS=fast_unwind_on_malloc=0 make T=t0001-init.sh
>       Time (mean ± σ):      2.135 s ±  0.015 s    [User: 1.951 s, System: 0.554 s]
>       Range (min … max):    2.122 s …  2.152 s    3 runs
>
>     Benchmark 2: LSAN_OPTIONS=fast_unwind_on_malloc=1 make T=t0001-init.sh
>       Time (mean ± σ):      1.981 s ±  0.055 s    [User: 1.769 s, System: 0.488 s]
>       Range (min … max):    1.941 s …  2.044 s    3 runs
>
>     Summary
>       'LSAN_OPTIONS=fast_unwind_on_malloc=1 make T=t0001-init.sh' ran
>         1.08 ± 0.03 times faster than 'LSAN_OPTIONS=fast_unwind_on_malloc=0 make T=t0001-init.sh'
>
> I think that's more than worth it to get the more meaningful stack
> traces, we can always provide LSAN_OPTIONS=fast_unwind_on_malloc=0 for
> one-off "fast" runs.

I completely agree. I am almost always run ASan / LSan tests a single
script at a time (often focusing on just one script that I know
demonstrates some bug).

At GitHub, we use both a sanitized and un-sanitized build when running
CI. So we'll probably feel the effects a little more during the "run
make test under a sanitized build" CI job, but we could easily set
fast_unwind_on_malloc=0 if it becomes too big of a problem for us
(though I suspect it won't matter in practice).

Thanks,
Taylor
