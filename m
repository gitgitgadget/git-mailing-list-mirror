Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1491F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeBGScs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:32:48 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41850 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbeBGScs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:32:48 -0500
Received: by mail-pl0-f50.google.com with SMTP id k8-v6so540755pli.8
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9oy3FuInJMKCbQGvlBMIIalWafGU27+XjtluUuddtM=;
        b=hoN6/Yl7E8BJXE39qOq7GnkvAKJym4EwIxLksGbWlF9M+OVByqAHfNIJg1yct1UEZp
         04H4aSKe5IxIBtj0X2Afdqe4kxF2Ck0NHNsDOOWnl0h83t0hv5CDTaSg9GqA3SLJlQ1t
         cYuxmseYdx39tixc5yD6X4/0QUg/FZw1+U9RykdCLgut/c25P/BZV85r4v5G0S9D1dJH
         hAUY82isURlXfhs1F3wRoVVJnlmYI0y4AlDPuZK0rKjPyk+N3Uuk1gp4XpvClaIqH5F5
         rmVffqVkpBNPLHr12p6Xr/8LUKMMJIQW/BT+AIaZL1HHKZ1gIYvNUKP8H3z6ZO95VGGi
         R9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9oy3FuInJMKCbQGvlBMIIalWafGU27+XjtluUuddtM=;
        b=D/sDhU8O3B29WwKZ4Po5qF8YoIWJxQV/AKlO40bcjIx51e/WxRgr8SIGHJihqD1AMy
         ZobaO6AZISKPs22T9Se6qe2lgPpj2KoaH9vNmfShofZJtVi4UJN1jPuBisWzm68V7rLH
         mIUgSm9ChS9NfKuejHG0SFlfChYE3WFZTeUqfPYFqyjBkwg7RkK7sKfWBcGftTs7WmOM
         xjIdRbaaFCmPKUk8joot56Ykz4Tkuik6OhsLtYDOxYeHaHc8C5afOonsOnSqFcbfYmWT
         jq7IbnasXNLqVzAK9BNZQsQEUGKGpizLhB660uDTxcl3dNYSyUZ1Uv3dbSy1OW0Wkz96
         i+sg==
X-Gm-Message-State: APf1xPBPlvAmVCefprhslXU168/h3SFojmQKuLpogLX32WI8qGTV5np3
        8x0bja9O6X9fDr7rDGOtemUubbqrcrI=
X-Google-Smtp-Source: AH8x226aK1jgPt/zJt9C67+GRoZW1DeHwQBS33smhX0ZTyjF6mMCB8udGeFxr2B1zBObC0/uHOTWWQ==
X-Received: by 2002:a17:902:b43:: with SMTP id 61-v6mr6959344plq.127.1518028367177;
        Wed, 07 Feb 2018 10:32:47 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t25sm5531819pfk.162.2018.02.07.10.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 10:32:46 -0800 (PST)
Date:   Wed, 7 Feb 2018 10:32:45 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Mathias Rav <m@git.strova.dk>
Subject: Re: [PATCH] files-backend: unlock packed store only if locked
Message-Id: <20180207103245.d500efb67cc73cf31087f4be@google.com>
In-Reply-To: <20180207144251.GB27420@sigill.intra.peff.net>
References: <20180206203615.68504-1-jonathantanmy@google.com>
        <20180207144251.GB27420@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Feb 2018 09:42:51 -0500
Jeff King <peff@peff.net> wrote:

> But this all seemed strangely familiar... I think this is the same bug
> as:
> 
>   https://public-inbox.org/git/20180118143841.1a4c674d@novascotia/
> 
> which is queued as mr/packed-ref-store-fix. It's listed as "will merge
> to next" in the "what's cooking" from Jan 31st.

Ah...thanks, I didn't notice that.

> I actually like this double-label a bit more than what is queued on
> mr/packed-ref-store-fix, though I am OK with either solution.

Same here.
