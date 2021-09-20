Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D9C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A8361050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350331AbhIUDA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349753AbhIUC1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:27:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919FFC1E51AB
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:08:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m11so23611812ioo.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBQRTIfQPyddZc1Ywn/NPAmC2rWD/hnJMWbZ3bqZwK0=;
        b=Ja6bO0oVAQISP/u1cs5TlB6Kbih3ei9Ao6U5efwe7SRfPkjsayxxJAHvQxb9Eyi7W7
         L1JFK4uPOvoXOTzafMeCxEwk9JBtE1GLvddMF28QlG57kLWQZ6FlQ5QKxB5oAyTj5blJ
         h6AS4MTW0ThsJ1Yq8ZaX7TibqVzK/220V9oySwn1vSniBO4swZdeiltwp/b0bTB72oje
         L4U+lS5BKded2yBTMev0MszxI7YmovqOI2QWqGVm04eRBzfNI0PqDZYepd50a/sqmB3L
         Jl55jZfuXz/E0FnafvZdKx8eY0vBV23QguHTLfAi63M0gKX46lx6RDCn2fsrSA+i1wrI
         huzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBQRTIfQPyddZc1Ywn/NPAmC2rWD/hnJMWbZ3bqZwK0=;
        b=frvkLacd+1ZM9d7VKbUAaU1P+MI/pEX4Z07i2ioDvtqIWzpe3uAtw60+YwrKswil6j
         Qq4W668ujY+8dfTtLWdHyOGWx6abro8P/EFmEmwjvHod516dEloK9hIejmsQSjBZ4ceQ
         hEwKg2ChqxghUlYQ4miW0cFi/yr875mkB59sQTsOg/bpM6PAxsgJgeWq3DHdyBjTMNeq
         ZfyRpCCqbR9X895gxCXbiZGWXZJBrN/Sk42X7hHFe3UcDS4D79l6RJRlI283h4qKuQ50
         U7pVxF9S9N5e32Iz7+yZXH8BiJJcPma+93KRL46oKQbgCdE3ph85GywXFrQ0dl+SnG9j
         70Lg==
X-Gm-Message-State: AOAM531UndzSKkzlVAJ4WeEwyNNeCGNuAX3I54qrAGijqQPhzGh9QfXm
        5m+CXJesP5jTMA6gshVimH8LLh+zHwFygA==
X-Google-Smtp-Source: ABdhPJyURg6E2F8x1FEOhbRrZK+DrxINsiQtSDttLXAiERZ0wb22I0lC+Pr9F+mER2wBOKDJOE9NDQ==
X-Received: by 2002:a05:6638:408f:: with SMTP id m15mr20628232jam.94.1632164914959;
        Mon, 20 Sep 2021 12:08:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z25sm271568iow.48.2021.09.20.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:08:34 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:08:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUjcMu7Z094eaFRA@nand.local>
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 01:27:25PM -0400, Derrick Stolee wrote:
> On 9/20/2021 1:25 PM, Derrick Stolee wrote:
> > On 9/20/2021 12:42 PM, Taylor Blau wrote:
> >> We would probably want to perform this check both during initialization,
> >> and when adding patterns in cone mode. It may also be worthwhile to
> >> check the validity of the cone before running 'list' or 'reapply', too.
> >
> > 'list' definitely seems like a good idea, since it is expecting different
> > output than the literal patterns when cone mode is enabled.
>
> I double-checked this to see how to fix this, and the 'list' subcommand
> already notices that the patterns are not in cone mode and reverts its
> behavior to writing all of the sparse-checkout file to stdout. It also
> writes warnings over stderr before that.
>
> There might not be anything pressing to do here.

Hmm. I think we'd probably want the same behavior for init and any other
commands which could potentially overwrite the contents of the
sparse-checkout file.

Those may already call list routines internally, in which case I agree
that this is already taken care of. But if not, then I think we should
match list's behavior in the new locations, too.

Thanks,
Taylor
