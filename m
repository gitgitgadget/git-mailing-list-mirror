Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE2C63697
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 19:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CCF22384
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="dzPQghU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKOToJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 14:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOToI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 14:44:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A106C0613CF
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 11:44:08 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v11so11176436qtq.12
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 11:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCMDh1xLcdQOsrCndLtFpySU0ROgkJeQT1fyqFQ83Eo=;
        b=dzPQghU8KMvwRgWfz23EzSmx+mpQAnv9jkdPuYH7ScBSMZkn8UkdMOywodzO4SXEHX
         Bq2o1e1UO+fLBO7ULFHHm0ynW/2MPXtwTQO+tdR9hVoTqq4D3489c43Bt+FIcfcEPi9p
         GqSAbPtQeylRxkYwDc2BhqtG8lyLn8b/0Ym6zZgJwmJlw8+TijZdTw473IG1h3rHSuXO
         ZAVW/AzQLhnNhaFi0+XLijLy9B158VIkydpYW9QI+/wn002SOg6v+LEiIQ+Ap4LtT0Te
         9xcjp8OCCHNPfRx4i3JnRkexYp4ymQU/2j/sWqJidfftkj6Vn/dL0Bi/J8ObyblaZO3o
         dP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCMDh1xLcdQOsrCndLtFpySU0ROgkJeQT1fyqFQ83Eo=;
        b=PsAWqSguy0QW4al82n4TYwc2P0daFbtp/SSSNT+k1YJxpaQLGAIjm5uj4t0tgAU+om
         Ltm0YJcS1z8dm8wM/Lm4RWfTveX5/j0n51H4Yo4RPhYrM0ow8s0BnsgWXj5G1QyrvF/z
         JZTLbhNE9lkdndWRTuGgI2LeiOuzmESi4v/AJwPGW5bQAaaSSf997EOxrN0jGToC4mTn
         ZFwHMu5qt8s/BOXjH6YDaGSwlVhKwrXSU9x7LmL98rfrbjUYPAe6qmu1WcxSPWFSJb8C
         ijWYjOAkxSkU/oslWE2XZ/ISOaCr6rvewNb7pmigwCje1wktDqph9skwHshhEc2Qx6n1
         VyPA==
X-Gm-Message-State: AOAM533t6z5tlOinfMajpfGmtvDeKFjFudD1m8A1Bc5ul1pVWEzqXfN9
        ACdJvXLy2C1B6K9gF+2+mK0keZ+jGjYw9w==
X-Google-Smtp-Source: ABdhPJxa5SXRdgeY9TbHnQktjNW7yJQwROV7ftF7jTtpsOIrd+SOpoTRZbut4Tq4zwUTFax5ucUbJA==
X-Received: by 2002:aed:2e23:: with SMTP id j32mr11465478qtd.132.1605469446605;
        Sun, 15 Nov 2020 11:44:06 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id a20sm10190935qta.6.2020.11.15.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:44:05 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gerardu@amazon.com
Subject: RFC: auto-enabling parallel-checkout on NFS
Date:   Sun, 15 Nov 2020 16:43:59 -0300
Message-Id: <20201115194359.67901-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been testing the parallel checkout code on some different machines,
to benchmark its performance against the sequential version. As
discussed in [1], the biggest speedups, on Linux, are usually seen on
SSDs and NFS volumes. (I haven't got the chance to benchmark on
Windows or OSX yet.)

Regarding NFS, I got some 2~3.4x speedups even when the NFS client and
server were both running on single-core machines. Here are some runtimes
for a linux-v5.8 clone (means of 5 cold-cache executions):

    nfs 3.0              nfs 4.0              nfs 4.1
1:  183.708 s ± 3.290 s  205.851 s ± 0.844 s  217.317 s ± 3.047 s
2:  130.510 s ± 3.917 s  139.124 s ± 0.772 s  142.963 s ± 0.765 s
4:   89.611 s ± 1.032 s  102.701 s ± 1.665 s   94.728 s ± 1.014 s
8:   68.097 s ± 0.820 s  104.914 s ± 1.239 s   69.359 s ± 0.619 s
16:  63.999 s ± 0.820 s  104.808 s ± 2.279 s   64.843 s ± 0.587 s
32:  62.316 s ± 2.095 s  102.105 s ± 1.537 s   64.122 s ± 0.374 s
64:  63.699 s ± 0.841 s  103.103 s ± 1.319 s   63.532 s ± 0.734 s

The parallel version was also faster for some smaller checkouts. For
example, the following numbers come from a bat-v0.16.0 clone
(251 files, ~3MB):

     nfs 3.0             nfs 4.0             nfs 4.1
1:   0.853 s ± 0.080 s   0.814 s ± 0.020 s   0.876 s ± 0.065 s
2:   0.671 s ± 0.020 s   0.702 s ± 0.030 s   0.705 s ± 0.030 s
4:   0.530 s ± 0.024 s   0.595 s ± 0.020 s   0.570 s ± 0.030 s
8:   0.470 s ± 0.033 s   0.609 s ± 0.025 s   0.510 s ± 0.031 s
16:  0.469 s ± 0.037 s   0.616 s ± 0.022 s   0.513 s ± 0.030 s
32:  0.487 s ± 0.030 s   0.639 s ± 0.018 s   0.527 s ± 0.028 s
64:  0.520 s ± 0.022 s   0.680 s ± 0.028 s   0.562 s ± 0.026 s

While looking at these numbers with Geert (in CC), he had the idea that
we could try to detect when the checkout path is within an NFS mount,
and auto-enable paralellism for this case. This way, users in NFS would
get the best performance by default. And it seems that using ~16 workers
would produce good results regardless of the NFS version that they might
be running.

The major downside is that detecting the file system type is quite
platform-dependent, so there is no simple and portable solution. (Also,
I'm not sure if the optimal number of workers would be the same on
different OSes). But we decided to give it a try, so this is a
rough prototype that would work for Linux:
https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba185b7cd208603de9

Any thoughts on this idea? Or alternative suggestions?

Thanks,
Matheus

[1]: https://lore.kernel.org/git/815137685ac3e41444201316f537db9797dcacd2.1604521276.git.matheus.bernardino@usp.br/
