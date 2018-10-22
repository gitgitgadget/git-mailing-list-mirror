Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A711F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeJVJ2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 05:28:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJVJ2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 05:28:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18-v6so1242403wrw.6
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1ScnTKOWxIzkAOe4c3/Y0HWMXADJSMuQ3FgsEgZQ+Rs=;
        b=gp7RDPcvcbQsUZ6yhBCI8VqYn73ehX0l/0fpd6Y6BphrUXrwCdozAnErVHTcznFUnC
         /NpIhMB7WBjDqaawxfcRtbbwGGakbYNWKuWK/bML5KmyPCGSbA0htmMcKtMxp4Jnvp8U
         KFnJLb6P6bQvgH0ZAIqadTcSusuFWQWVGLCQEbhWJbAdhifhN+h8EDk9yGaew8TvrL22
         q+GjJbBOrkbpszKM2rQhFCNsk8aG2oHDGAwg7ioz+MIVCyajQum7yP9li5PuY07tfOk2
         BaPFQ1VOLmUK+w0nb7RoxXTCTtkU1q2/kngGWAhLYx6zNblD6PT8ilu4Ag/k1dSEjx4+
         C5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1ScnTKOWxIzkAOe4c3/Y0HWMXADJSMuQ3FgsEgZQ+Rs=;
        b=JZ0Z6tEGkrZk2g/DS/ajDiIbkb03Zq7JnZn+XUw8sXRoVDoFf3ds0VhK5qXFEIRV8c
         2eM50oKBpDMoUlmgkHo9CnKlqM8snRLkdaCut/Wb8pbw6YnBqygAbv0XApi9iBhywAVz
         xq760v8l+GxLRUAbAh6QP4iwxPMdUnF600RS2vbrRYUU4DQKOeg+L35zFR/C0i6kgkaO
         xCd7D1L/m9YS5/BzSCcpezFsnBS3+lFWaGmDpco445fV3bJqi5Z46J/dMsYNiRh3TeNm
         igqnlMLEUiPnBfN9j2qpeUVvcfvazHWPuaVdIj3YZMhO4mvNgUBbI3gYpqgjryCpu8H0
         DjqQ==
X-Gm-Message-State: ABuFfoiOTX8zoW1u3aWqGDRfb+T83sQrpX/96gF+dKSlFy0mWN98kDoW
        UkES9vocKDD1QZ0REEUVIzI=
X-Google-Smtp-Source: ACcGV60ZsMRqR8aRLtTHJBPEpGNYZHrLEiR3jtbcAvSADeAZXKLl43O8inQSAUg0rs0mPZxnRVRjUg==
X-Received: by 2002:a5d:4e87:: with SMTP id e7-v6mr18458024wru.115.1540170732235;
        Sun, 21 Oct 2018 18:12:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d6-v6sm12425208wrq.27.2018.10.21.18.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:12:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
        <86h8hfguqc.fsf@gmail.com>
Date:   Mon, 22 Oct 2018 10:12:10 +0900
In-Reply-To: <86h8hfguqc.fsf@gmail.com> (Jakub Narebski's message of "Sun, 21
        Oct 2018 17:55:23 +0200")
Message-ID: <xmqqa7n6zswl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> So if revs->limited is set (but not because revs->topo_order is set),
> which means A..B queries, we will be still using the old algorithm.
> All right, though I wonder if it could be improved in the future
> (perhaps with the help of other graph labelling / indices than
> generation numbers, maybe a positive-cut index).
>
> Do you have an idea why there is no improvement with the new code in
> this case?

I didn't get the impression that it would not be possible to improve
the "--topo A..B" case by using generation numbers from this series.
Isn't it just because the necessary code has not been written yet?
In addition to what is needed for "--topo P1 P2 P3..." (all
positive), limited walk needs to notice the bottom boundary and stop
traversal.  Having generation numbers would make it slightly easier
than without, as you know that a positive commit you have will not
be marked UNINTERESTING due to a negative commit whose ancestors
have not been explored, as long as that negative commit has a higher
generation number.  But you still need to adjust the traversal logic
to properly terminate upon hitting UNINTERESTING one, and also
propagate the bit down the history, which is not needed at all if
you only want to support the "positive only" case.

