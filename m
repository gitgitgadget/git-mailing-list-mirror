Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F173C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D546123442
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbhATUO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbhATUOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 15:14:14 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C0C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:13:24 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id k193so5492013qke.6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yPMZUiYkT5eyf19skDJGb2ZWnyeepCf/AMrE0axU90Q=;
        b=D+P8EJS6HRIj/QrmNxg1Aur37zPRN4PJfgUTuP9k59WvsNXVzDfVPO66cVHUJ3+RvI
         YSCMUXXYHvFvnfVYGJnRMEHlSUy9CVh/ggqEthXyPkWkt2VS05sE2e/ocSTXpzQmhVsm
         TnGPSNuOfiyYt6jmuBXdcFmlE5jPFcCW8ZxesahMyhxY033AhW3ZbOHBX7sBMGzG+fE7
         ifKxnuEDi9MJ3veEgEW8t1Uy956JLEwn9XtrX0GO0srbT3lpRLlmsafvSjmQrDOQQk4q
         PTG8E8KeOu8/wFYBfnI52sbyX+2bmj8vH8zHEVdNL+N5CgnSRksyAijKF66wgbq2Y9Dq
         6Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yPMZUiYkT5eyf19skDJGb2ZWnyeepCf/AMrE0axU90Q=;
        b=g4SHqNxnp2LPzluB1iNqD1TeZ2RsV9vQ1TusNctpka6NK1+/vGDQz8XQRqRmShCJI+
         J+Qa30tz09a3lpAqyzypLnN1TCfKLHgyRmihvg7pxHQt6G/L0a+Qyf7NTypm2vLZTHJW
         Nd4smMzA9wbSi2XbA+C5ZmKCkAklLVsCLOdy6SFR/pZPNGitW+cFQGJJksH0+8tFWgOX
         UjazQd/d79xVpY/6YJ8nVI8eWDB1i921kaNHP34bCc4x4tX9VfflBdYbs5wpW39R8RSb
         AmLvjpdoLMWVQBrhTA5hIWcxkUFSkcA8ciHdlxLP/241/9CbI9gInF2RTA1TW9fyllOU
         xxaQ==
X-Gm-Message-State: AOAM531l1OIrOIPJGyBCGUzoaLkTOURZtCvXgv/A1ReVeaBR+vGPn1Tk
        Mb99QMFmbEYPePZBKfCpPthgDg==
X-Google-Smtp-Source: ABdhPJyFK8LrUwR0w+66DzYMUgO9qOQKXce+eVxRUkngzq15MTiiH5NC5QJUYlgsBt5KtesjaFcHJA==
X-Received: by 2002:a05:620a:2104:: with SMTP id l4mr10725148qkl.35.1611173603898;
        Wed, 20 Jan 2021 12:13:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7d49:7932:5c79:ddd4])
        by smtp.gmail.com with ESMTPSA id c12sm1898814qtq.76.2021.01.20.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:13:23 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:13:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@gitlab.com
Subject: Re: [PATCH v2 2/3] ls-refs.c: initialize 'prefixes' before using it
Message-ID: <YAiO4Ez5x/ycZ5l+@nand.local>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
 <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
 <YAiLXUDTdMpdGG5b@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAiLXUDTdMpdGG5b@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 02:58:21PM -0500, Jeff King wrote:
> That nit (and the one I mentioned in the previous patch) aside, these
> patches look good to me (and I am OK with or without the nits
> addressed).

Thanks, as always, for your review :-).

Thanks,
Taylor
