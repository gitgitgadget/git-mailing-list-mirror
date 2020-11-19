Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280BC2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 04:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D2E246BC
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 04:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="npEiWdGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKSEB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 23:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgKSEB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 23:01:29 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB932C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 20:01:27 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n132so4238148qke.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 20:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLVewwy7/zFy5wD0Gv26d/MDyNBH+gsk1q9ZFoww7V4=;
        b=npEiWdGKNfI5Q6tmxlewSSp+ZC0HATq0i2WK7qbtENnkHSdRyXeT7ih4bPSr6i/r/e
         XSEUTOTGxqSPKFNbCBqz/iK+8yPBRp0Spcdy9nuj2pYO4OqEif6pyYAd1G3VjeqCahLC
         7+Z70TIXRD1Lx06OvnoLudPNwLo3MnuOF7UP/kqTo7HQAagPwQ5o4oqABRZx0XUDZEeL
         rHrj4smPiUZlsTZvpbV4xQXgu/o3q3eM8rkP1rNALDyS42RBeLdzYleOYX90+2O+xelk
         I+p+TkmPRPcHwoeWZXX9CZY0j0s93gHyUJzca0tsMJAiNrK6lqYvSPvVwYvhcd5f+4zH
         1J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLVewwy7/zFy5wD0Gv26d/MDyNBH+gsk1q9ZFoww7V4=;
        b=eCP+6FQ6yjRh+5TEa0akalYkMagKIJgLG6MLckiFqc93ZkEwA5WgrXw/VA4Q6ED5wN
         KC5WU/Wd5w/y51cvnr3wd6lqJMlqpjXPKTPGpN/Gc0WW7+s15gCqBd2Dl6C799Bb3Yrm
         PkgbYG47c0EryQTJsPAElAmgB6W0Bcws9dr4Lw+0c3ki9Hr6P6JdcknOi4bhR1/E4Oel
         PC2jk+RS0GB9oKPsatzOzHKrGdvyf2WtY7a8uiSsYK8xXV5XrLF2J0pBTi/UTAgRwy6a
         iswElOE8S1TiJTqm8qtF0T/5Ai2dPfqbj4qtTDelQewdvRMdokzBfZrSgbc8k5U8ZrxN
         74pQ==
X-Gm-Message-State: AOAM532lgqHvhUhcdO9oK87Y7JpwjCiN7mkIcAfA+RT7S7zcblMfq/1S
        /FWXepYZpVNOf6jYNVCCBjdjwT2kFu92AQ==
X-Google-Smtp-Source: ABdhPJzEMqp4PPA7wSkLd4zdmvhRBVTwvlzA4DKijshGdCOcHOJyuuDCrvIODvn/848saknTntf0Aw==
X-Received: by 2002:a37:a915:: with SMTP id s21mr9684560qke.38.1605758486938;
        Wed, 18 Nov 2020 20:01:26 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l46sm18132776qta.44.2020.11.18.20.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 20:01:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@jeffhostetler.com
Cc:     gerardu@amazon.com, git@vger.kernel.org, matheus.bernardino@usp.br
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
Date:   Thu, 19 Nov 2020 01:01:17 -0300
Message-Id: <20201119040117.67914-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com>
References: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Jeff

On Mon, Nov 16, 2020 at 12:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> I can't really speak to NFS performance, but I have to wonder if there's
> not something else affecting the results -- 4 and/or 8 core results are
> better than 16+ results in some columns.  And we get diminishing returns
> after ~16.

Yeah, that's a good point. I'm not sure yet what's causing the
diminishing returns, but Geert and I are investigating. Maybe we are
hitting some limit for parallelism in this scenario.

> I'm wondering if during these test runs, you were IO vs CPU bound and if
> VM was a problem.

I would say we are more IO bound during these tests. While a sequential
linux-v5.8 checkout usually uses 100% of one core in my laptop's SSD,
in this setup, it only used 5% to 10%. And even with 64 workers (on a
single core), CPU usage stays around 60% most of the time.

About memory, the peak PSS was around 1.75GB, with 64 workers, and the
machine has 10GB of RAM. But are there other numbers that I should keep
an eye on while running the test?

> I'm wondering if setting thread affinity would help here.

Hmm, I only had one core online during the benchmark, so I think thread
affinity wouldn't impact the runtime.

Thanks,
Matheus
