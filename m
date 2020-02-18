Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F0C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E121D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jng8w0gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:05:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33069 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRSFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 13:05:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so8401782plb.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvWOcGC3eNMmkC3usm1CE0OfyPoe3A6Q06Bj13gq8so=;
        b=Jng8w0gSmUuyYzy/geUx0nvzw3hXOJbLm8MgoYlDGpZ0Jtfg252VK4cDwSPIFomfnq
         htxDx1qr3WQJVdXEoRo48nJz4qr5IzBZZTJO1aboIfjQiaGGkagFBYnStHDKlKPaGks7
         XMaChd6h5m5JvX6fyBqH24Nur198FbjafKsmUUgr+9Fx5irUBWqbRiwVSG9tGtpTbAmf
         JtEcwXVV8uAdWjZLRKWDukEvGCyhyBkU9V0tkwzhMD7cg9i63kDB8AkpXmDUB5T0Y9CJ
         kuLXjshxRMdJp/GP5cV3X/aoUUCwmxCwklqwo8bjGAkFTiqGg4RTM0YjzYOHpt5mOLZe
         mU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvWOcGC3eNMmkC3usm1CE0OfyPoe3A6Q06Bj13gq8so=;
        b=E/s9zsCSXu5uE5OEFRZl4ThVO2hxZEbNPg28QvxplqrtUr0zS4kQNeqf2SpWd8YQgL
         vVtquzesOwVDUdCrNmsmhRyqHMze3VDxvJfw+iFzMOTEfOhLplZY9u/9ceaS5SDu98fQ
         R06MFILGHqspeqNafDGCkhu5D8qLBas5eXhw6EFyXZnZy2e9c8MMjfDRbk3CddAVkh1J
         I0x0Suhz8DMiBmE2Rfhe/u2j0NMUropMcbjc75sOcgX/3BeIbfkkYEnXvAWioUtEFq+p
         G6ULnT7MOvE9oS5nyOPFv1hsUHzXWQxpr9z1t4c/lbLI+ESi79DndZVd8uqbbYgYV+28
         5tFg==
X-Gm-Message-State: APjAAAVC4Y4uGJISlFnwo2RVQeMl+0PEmu3EVZovVEPLCMy1mTIuO0LU
        XdJahSINfR7KtTXi3yiliDDEi7nNJcM=
X-Google-Smtp-Source: APXvYqx+mWMPE86EBFYxjnlEcFF79br+90P99Cg4SRCobBstQrMTJzKcH5sUlCFopI4VnEUpDjzjdA==
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr20272267plb.275.1582049138575;
        Tue, 18 Feb 2020 10:05:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:e008:3:d278:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id k63sm4166895pjb.10.2020.02.18.10.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:05:37 -0800 (PST)
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182220.GF150965@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3230c8c9-5208-3161-324e-c0ce948ee5b3@gmail.com>
Date:   Tue, 18 Feb 2020 13:05:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200214182220.GF150965@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2020 1:22 PM, Jeff King wrote:
> +test_expect_success 'rev-list --count' '
> +	count=$(git rev-list --count HEAD) &&
> +	git rev-list HEAD >actual &&
> +	test_line_count = $count actual
> +'
> +
> +test_expect_success 'rev-list --count --objects' '
> +	count=$(git rev-list --count --objects HEAD) &&
> +	git rev-list --objects HEAD >actual &&
> +	test_line_count = $count actual
> +'

I suppose these tests work, although I would probably
prefer precomputed explicit expected counts instead
of asking rev-list for the correct answer to a
rev-list command. This is still fine, because we test
that the non-count versions return the correct results,
but I would hate for a bug to affect both modes equally
and cause these tests to pass.

Thanks,
-Stolee

