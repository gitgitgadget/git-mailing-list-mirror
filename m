Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DBC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCAD221F0
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQD1G7S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIVXPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgIVXPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:15:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77ADC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:15:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p13so17904682ybe.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=14D6mc22jXwCBwa01o9C4542I/sEPiH1dPUTn7cxd8E=;
        b=hQD1G7S5R5FKWdfhVDjlu6tVElF5Dp2R4ZnBW/0b7r0+vOuRDNUjLJZENAhFkqaDAF
         hpwmRT5qDcbPd+NluIMv25tfotvkOz8m1pZiP2ZB9QbAjse0NVDTZLav3WsteYM0n/3q
         iqjnCq1ldHxaf+2NmupI0r1yFMsAqEI3YqYJSFX2YITX1O5y6LRsTJrn2PLKNuGkDleg
         SEX8De/d0ECDxyubW7iPwoQa4Po3ykv72vW+/j5lPrsM+GjdqfC6WOtozsNoFj1u39DI
         XDclLVugESZkJfe8JclI4N3qHtPhRO+Icku/E7UTAsItqIMUA6JyonX+Z7oCXtdCwBXy
         pVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=14D6mc22jXwCBwa01o9C4542I/sEPiH1dPUTn7cxd8E=;
        b=ACAHobQ0l1RpakMaMR7T1Q4H3lqnzv50QuYiNFO+hFIMtoxBsBIo74Dqy53NTYUoGU
         P3p0LpeVVbS6iixLOGUm93tA/62tSHh4wLHdxrNrFMumG1K5J1lzNn8Z3k07+S11u1N9
         aSfxZgMHYRaC2zfsd3GQWD/fdD+QdqGVwzi9qplC0KHgNfOGLh3upKCF4xsTXwsPyfPR
         9U6MDN78NUxq4dI7i3ji2K9D/I/MNUrVWWM4PwvuDJJCsLZZDPQtUpzrBg3x/xY26J4b
         DqlJcFuwu2pP8h+yJEn23ZT79TlQ1prBebe7mH2iGuULs2FgFxyg9BDeJo6t9GFWsbQl
         v6eg==
X-Gm-Message-State: AOAM532pMM2X86cB3ulb0vm9zILD529/xOAgGJvmfb+bzwXWI1KVep5H
        jYoNP2FqeufmBaSO5HVRZijfzElU1pZ1V1SWnXBE
X-Google-Smtp-Source: ABdhPJyTekqVVOi8IZODpqDEj8Do9c6p4Jfyl7JxndMtVKITDIFeG5DHkXdWz48VIqIHLtOP1ifWj2/UzaXggpPBW5+u
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ae16:: with SMTP id
 a22mr10285149ybj.117.1600816504191; Tue, 22 Sep 2020 16:15:04 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:15:01 -0700
In-Reply-To: <d6e382c43effe063fb1137659f616d414ee52682.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922231501.908887-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d6e382c43effe063fb1137659f616d414ee52682.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 3/8] maintenance: create auto condition for loose-objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'maintenance.loose-objects.auto' '
> +	git repack -adk &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
> +		git -c maintenance.loose-objects.auto=1 maintenance \
> +		run --auto --task=loose-objects 2>/dev/null &&
> +	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
> +	for i in 1 2

Any reason why this is run twice?

> +	do
> +		printf data-A-$i | git hash-object -t blob --stdin -w &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace-loA-$i" \
> +			git -c maintenance.loose-objects.auto=2 \
> +			maintenance run --auto --task=loose-objects 2>/dev/null &&
> +		test_subcommand ! git prune-packed --quiet <trace-loA-$i &&

OK - there is only 1 loose object so the loose-objects task doesn't
get run.

> +		printf data-B-$i | git hash-object -t blob --stdin -w &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace-loB-$i" \
> +			git -c maintenance.loose-objects.auto=2 \
> +			maintenance run --auto --task=loose-objects 2>/dev/null &&
> +		test_subcommand git prune-packed --quiet <trace-loB-$i &&

OK - there are 2 loose objects so the loose-objects task gets run. But
we need to remember that the first time it is run, only the packfile
gets created - the loose objects aren't deleted. "prune-packed" here is
to show that the loose-objects task is run, but it has no effect.

> +		GIT_TRACE2_EVENT="$(pwd)/trace-loC-$i" \
> +			git -c maintenance.loose-objects.auto=2 \
> +			maintenance run --auto --task=loose-objects 2>/dev/null &&
> +		test_subcommand git prune-packed --quiet <trace-loC-$i || return 1

OK - the 2 loose objects still exist, so the loose-objects task gets
run. "prune-packed" here shows that the loose-objects task is run.
