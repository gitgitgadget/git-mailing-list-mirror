Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A0C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 10:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FB2206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 10:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gswThcuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgGGKYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGKX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 06:23:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A8C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 03:23:58 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so24414370lfd.10
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3C0Uf3UOp3FZlIlmHcloOWTkJZJEzJ8i9y8sel038JQ=;
        b=gswThcuAqAO3MnMx/er4UDqtqKRgxY3ryNJgml8jDSVoOWLcJoSVMKy8RuSZfRQTxw
         Z6qk+lSKh/38N1GjqQ4hV/d4K23WI+EPG7jw7r5qtuoLVPUovJLnDAuX5Uj4d6hVCgH9
         0ilGUNOQcpUJw9QcH0U+6n2a81M4osshiwym/RNVmqvQEN2c4MSxQLk8WA1s1FRi6noV
         ESD6EDfcgerpmvgH03HQx7VmART2yUN+26Kk5zF9ETCusPHf51MSXMZGx+qEbXleWodb
         tDjGvxnSMwqdgvR84LID1SA0LM8Hr/LuboxRO11BEvItEV2dS3K5UkET2S7mWoNA1stv
         5xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3C0Uf3UOp3FZlIlmHcloOWTkJZJEzJ8i9y8sel038JQ=;
        b=Hmrl0oZWDbNObnOl74Hewy4RXakMmrGJ6rAiOnP6E1E5twpZIpB88UB6hVNQstj+wy
         E7YfPsjygBgh9tpC4kSfQUWmN9YU9nDxHcgQAiuagSEW/u5vPcYlt6tSCl6iHaPtPHLX
         h3bVIsF/m/XCjd7UIg5hm9mm9BAs3wZH4fBSm9Z/1qS2aD7rXylPbKLMEey0UdEPDj9G
         NBSH+gsnb13HVXhbYB1/q2QTm0jPcX79jfRQE3SUWUIOzpJ6cvFs+HIwsKdg9poc6nQF
         sS6YuTnxLECL6h7vnXFtfhB2hkdFIE1JpnOVa0F2TnrajxKVMPGArA90rMLtA49+qfXM
         g2BA==
X-Gm-Message-State: AOAM530LkyAIQs30t8fBuylEHdYwP2/VldKOYroCTCkQs+MAJxAnqK+k
        TyCcIrotJTPXPxffDfvt/Q4=
X-Google-Smtp-Source: ABdhPJwDL7o+f5Uzbp+eJlTP2cGaAqrwQoSNuMpE8HsznIx+ZKyjqtsMBvjC62SWFHVC3RPvBDfR4g==
X-Received: by 2002:ac2:4889:: with SMTP id x9mr32779244lfc.162.1594117436854;
        Tue, 07 Jul 2020 03:23:56 -0700 (PDT)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id t4sm74396ljg.11.2020.07.07.03.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 03:23:56 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:23:55 +0200
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/2] Wait for child on signal death for aliases to
 builtins
Message-ID: <20200707102355.2kukfzxt7vhhenfy@aaberge.net>
References: <20200704221839.421997-1-trygveaa@gmail.com>
 <20200706204106.GA85133@coredump.intra.peff.net>
 <xmqqwo3g6qlu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo3g6qlu.fsf@gitster.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 06, 2020 at 18:50:05 -0700, Junio C Hamano wrote:
> True, as Dscho also mentioned.  I'll just do "b914084007" =>
> "ee4512ed48 and b914084007" while queueing.

I noticed that I was missing a word in the message, and I'm sending a new
patch with a better commit message for the second commit, so I'll update this
in the first commit and send a new patchset.

> > A test would be nice, but I don't think it's very feasible for the same
> > reason mentioned in 46df6906f3.

Yeah, I don't think I have a good enough grasp of how to test this, and I saw
that there wasn't any existing tests for it, so that's why I dropped it.

-- 
Trygve Aaberge
