Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF65C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B5623602
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgLPWcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgLPWcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:32:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D15C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:31:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v3so13768539plz.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q7X7CC7/kVH4LlSVgk7SRuzQoAW8PXliAXE1xflIWE0=;
        b=LtOy/+RpqGmcrw2YC0Sc1v4TtIh3grdT/3v3XpZcOKUpaLbudXabmWTrFC82HGvixS
         B/BbekIPZBz7R6LMHGqIDtD+ipqvWiKXJUm51xFow5jB+Q6gR8lAgLOmQ1+gGMzUW2us
         VYrPQy057GpxhAH45/XuSqI4mMQQ6stKu0waQFnc6GzpkMhBX9afUCzix0JPcfYSQ4Up
         bTovk735xYBdYc2SWIqG8brfI/lPv2H2aLmF3RWN8GmOomPi8/mDsyZ9JXRzbkhVfvvP
         XQRl44F1rPwxtyZqjgFalls3Bq01VGpjoIcNv9yNMITDL//WSg9x+UyWN0dFqORg3ep9
         y0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q7X7CC7/kVH4LlSVgk7SRuzQoAW8PXliAXE1xflIWE0=;
        b=JoQAepwr4XCpZ+IHlWAeOGlymRh2AAvj22rXAP9n31Kb4KjUr6BK4Buqblg3aFoE7y
         Z+59CYJ4bs1yAeqrjS4upR+Kq/BKOvBirLG27ymq9P56hzLSGs0IuT3U3vNwqngy4Nf4
         JtjVqMwfJUU5g9Zz6Kziq0GazfUdRuFA0VsQo8MhnD7XnvF4h/EbUovbBKN7O5+v214D
         G+EEPaZi0acGPSE9z7ELUn2uq5yc4zJWr3eQWPExBy95eqUcIq37eKKmah2HGI6DC5cV
         gNyoHkhBiJW2CHpM1yIIzHCcp+crdSpQTeEtiMpiILUpJiohsRx+OpNwmncDBC0n23dW
         +hWA==
X-Gm-Message-State: AOAM533j6QYeji/87UK1vVDhLaEFZX/+dTyMaUv6KrYmaETi6mSQNjqr
        usqxDq8X1rEf+cXSQjJmRnXo3Q==
X-Google-Smtp-Source: ABdhPJyNASnI7cC0swtaBqFibou3T/QfmAIGG7zUjGDbPkRWrpvjjqF9HuY13L0kYYVC76fnsxxm7g==
X-Received: by 2002:a17:90a:970b:: with SMTP id x11mr4950149pjo.16.1608157888959;
        Wed, 16 Dec 2020 14:31:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id s29sm3738571pgn.65.2020.12.16.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:31:28 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:31:23 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v4 11/19] parallel-checkout: make it truly parallel
Message-ID: <20201216223123.GH3783238@google.com>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <815137685ac3e41444201316f537db9797dcacd2.1604521276.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <815137685ac3e41444201316f537db9797dcacd2.1604521276.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 05:33:10PM -0300, Matheus Tavares wrote:
> 
> Use multiple worker processes to distribute the queued entries and call
> write_checkout_item() in parallel for them. The items are distributed
> uniformly in contiguous chunks. This minimizes the chances of two
> workers writing to the same directory simultaneously, which could
> affect performance due to lock contention in the kernel. Work stealing
> (or any other format of re-distribution) is not implemented yet.
> 
> The parallel version was benchmarked during three operations in the
> linux repo, with cold cache: cloning v5.8, checking out v5.8 from
> v2.6.15 (checkout I) and checking out v5.8 from v5.7 (checkout II). The
> four tables below show the mean run times and standard deviations for
> 5 runs in: a local file system with SSD, a local file system with HDD, a
> Linux NFS server, and Amazon EFS. The numbers of workers were chosen
> based on what produces the best result for each case.
> 
> Local SSD:
> 
>             Clone                  Checkout I             Checkout II
> Sequential  8.171 s ± 0.206 s      8.735 s ± 0.230 s      4.166 s ± 0.246 s
> 10 workers  3.277 s ± 0.138 s      3.774 s ± 0.188 s      2.561 s ± 0.120 s
> Speedup     2.49 ± 0.12            2.31 ± 0.13            1.63 ± 0.12
> 
> Local HDD:
> 
>             Clone                  Checkout I             Checkout II
> Sequential  35.157 s ± 0.205 s     48.835 s ± 0.407 s     47.302 s ± 1.435 s
> 8 workers   35.538 s ± 0.325 s     49.353 s ± 0.826 s     48.919 s ± 0.416 s
> Speedup     0.99 ± 0.01            0.99 ± 0.02            0.97 ± 0.03
> 
> Linux NFS server (v4.1, on EBS, single availability zone):
> 
>             Clone                  Checkout I             Checkout II
> Sequential  216.070 s ± 3.611 s    211.169 s ± 3.147 s    57.446 s ± 1.301 s
> 32 workers  67.997 s ± 0.740 s     66.563 s ± 0.457 s     23.708 s ± 0.622 s
> Speedup     3.18 ± 0.06            3.17 ± 0.05            2.42 ± 0.08
> 
> EFS (v4.1, replicated over multiple availability zones):
> 
>             Clone                  Checkout I             Checkout II
> Sequential  1249.329 s ± 13.857 s  1438.979 s ± 78.792 s  543.919 s ± 18.745 s
> 64 workers  225.864 s ± 12.433 s   316.345 s ± 1.887 s    183.648 s ± 10.095 s
> Speedup     5.53 ± 0.31            4.55 ± 0.25            2.96 ± 0.19
> 
> The above benchmarks show that parallel checkout is most effective on
> repositories located on an SSD or over a distributed file system. For
> local file systems on spinning disks, and/or older machines, the
> parallelism does not always bring a good performance. In fact, it can
> even increase the run time. For this reason, the sequential code is
> still the default. Two settings are added to optionally enable and
> configure the new parallel version as desired.
> 
> Local SSD tests were executed in an i7-7700HQ (4 cores with
> hyper-threading) running Manjaro Linux. Local HDD tests were executed in
> an i7-2600 (also 4 cores with hyper-threading), HDD Seagate Barracuda
> 7200 rpm SATA 3.0, running Debian 9.13. NFS and EFS tests were
> executed in an Amazon EC2 c5n.large instance, with 2 vCPUs. The Linux
> NFS server was running on a m6g.large instance with 1 TB, EBS GP2
> volume. Before each timing, the linux repository was removed (or checked
> out back), and `sync && sysctl vm.drop_caches=3` was executed.
> 
> Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

Only having done a quick skim, is there a reason that you are doing the
workqueue handling from scratch rather than using
run-command.h:run_processes_parallel()? The implementation you use and
the implementation in run-command.c seem really similar to me.

 - Emily
