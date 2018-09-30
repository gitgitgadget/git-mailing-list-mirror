Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B761F453
	for <e@80x24.org>; Sun, 30 Sep 2018 04:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeI3LMu (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 07:12:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45782 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeI3LMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:12:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id l2-v6so10729710qtr.12
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 21:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyYVHEcClbTOIQkcn5lR+solOo8OKFHbP2bnM6i1xGQ=;
        b=Ob7TNfWlvFxE7D/PsaPHxZ1nLqmJmilbjdA+5KZzP1HyDOsupWmx7GQf2KJeOvbgBl
         rzpISZAPIrVXgRbjTo3xzd2QDfYA5a+t4iwjgZkJb6F2FJe8dztPRGU2oxYN8YeKxSXk
         VvYtCffRFm+joMfxueHCDy9+wQ8GIkqdvX8ew2sDgOpthode6ZPknQLsdK3eC2yV2gpk
         95K6FtCAgVmxqJnl8rABOsl5g1KMiTTsbML/cBpQAC70wq8ih+BwRiFpgr2d26dVW1zQ
         d9DAI9SpvudQ1XSYAhqidXMYvP3bG7om32QZF/x/E64YBu1Csvb4/V/JQKnYTFTnzD3z
         Li3w==
X-Gm-Message-State: ABuFfojos1oR/yEEI472rS1n4jEyLsWdJCcCczOvyShuJBCkk5Yxg1qU
        khEL9yWi2DfAawC1+K8PsZfvjXLKlJvjBI40uGk=
X-Google-Smtp-Source: ACcGV60mAck9xtuRlJwcsic9g1FRKtRl6ODFRypYsAI0LjbtNdv5qvwrSqUXyrf0BlqldV+8WHFd37e7O9ra5t3t0x4=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr4357535qtc.50.1538282485184;
 Sat, 29 Sep 2018 21:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4le9cvy6.fsf@gitster-ct.c.googlers.com> <20180929185539.4144-1-ischis2@cox.net>
 <20180929185539.4144-2-ischis2@cox.net>
In-Reply-To: <20180929185539.4144-2-ischis2@cox.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 00:41:14 -0400
Message-ID: <CAPig+cTm_Fb9xFend5UF2TAx+5M6+siseRDVEAVGYUodjBAMRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] roll wt_status_state into wt_status and populate
 in the collect phase
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 2:55 PM Stephen P. Smith <ischis2@cox.net> wrote:
> Status variables were initialized in the collect phase and some
> variables were later freed in the print functions.
>
> A "struct wt_status" used to be sufficient for the output phase to
> work.  It was designed to be filled in the collect phase and consumed
> in the output phase, but over time some fields were added and output
> phase started filling the fields.
>
> A "struct wt_status_state" that was used in other codepaths turned out
> to be useful in the "git status" output.  This is not tied to "struct
> wt_status", so filling in the collect phase was not consistently
> followed.
>
> Move the status state structure variables into the status state
> structure and populate them in the collect functions.
>
> Create a new funciton to free the buffers that were being freed in the

s/funciton/function/

> print function.  Call this new function in commit.c where both the
> collect and print functions were being called.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
