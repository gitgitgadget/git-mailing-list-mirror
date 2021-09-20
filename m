Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0D61264
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbhIUCV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbhIUBqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:46:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE99C05BD38
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:20:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r75so6425129iod.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rxZSN/uopjDIwCOpss3sQLlGHBLslerRHV9SpYIGP6g=;
        b=K2sPsJ0L2xRBWDZVCBuwzcEAIg/KFYPasBLF6nDAsFQnqlrRYz52UOOFpA8xuO1CvF
         M1lqOxoU5V3xej2MNmYLp00vvyeukQCOBRVAexzd2bjzeRw6o3khWIZyVBDynEb4JkSZ
         fcKqOnURbMHaWEbbyyF5WwFjMQ7Po8dZgomegWwnOHKOTacO51fnH5xYXJBBy0anfakl
         6weay36FBdfn60YtB9EKfQOON15iuqqWwg/5oCpShUog3YU6qirTcWpxU2EwWVcP9nVL
         0hnHB1rlfCq9uTYaA8+s6Vgqo8WjkEtxGZTY42mlRcRaFKeMqRwLslYhZamPXPeaGIgH
         kCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rxZSN/uopjDIwCOpss3sQLlGHBLslerRHV9SpYIGP6g=;
        b=ytKnBP0iawLj4l9kwrSwWB3zy7YrvUKudwkAFu9X79eYaQa0gQyWWKGjDb4rZ9776O
         RazSSZ1chdVeCzXPfiqgVGlZ6mRYp8zSEe5HKY5kGz8mEWin42mMpwIBX5AGL5E66Ydm
         lvH/iylgiLV0nVJIP54voZfKuIzF6sglD2Q9mBaznZ75Agww/9HhIP+z6/RG4YTTNzkz
         U1ddbTh1jU4nS15ahnoBsSawiXyYk67sqkTqDK81sgHZ3yRRYU5i8JCOwyfwNA5n/pgh
         i9QCtW3qRMyF218FWkZYzwPZF7729U8a0tILJ/cKUblSNpbTCF8y5/5x9tgoQz4Kzvb8
         bFkg==
X-Gm-Message-State: AOAM531MROBgu5Qmhm+FaWSuzNVcVDFf9pyqSKi0rv9M/ytrvM/SabCq
        sy7ko+lrnzV3tAib9VLg53cg5mglYcYL0w==
X-Google-Smtp-Source: ABdhPJzufo786PlZC1UgzjARcItW1dUAhWbofAJ1B4quSY9bzbEomge3WfiX996agCyHveAiioeCgQ==
X-Received: by 2002:a05:6638:25cd:: with SMTP id u13mr20659009jat.114.1632172827139;
        Mon, 20 Sep 2021 14:20:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g28sm4084965iox.32.2021.09.20.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:20:26 -0700 (PDT)
Date:   Mon, 20 Sep 2021 17:20:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUj7GN/qWhw67jyk@nand.local>
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 04:56:47PM -0400, Derrick Stolee wrote:
> >> I double-checked this to see how to fix this, and the 'list' subcommand
> >> already notices that the patterns are not in cone mode and reverts its
> >> behavior to writing all of the sparse-checkout file to stdout. It also
> >> writes warnings over stderr before that.
> >>
> >> There might not be anything pressing to do here.
> >
> > Hmm. I think we'd probably want the same behavior for init and any other
> > commands which could potentially overwrite the contents of the
> > sparse-checkout file.
>
> Could you elaborate on what you mean by "the same behavior"?
>
> Do you mean that "git sparse-checkout add X" should act as if cone mode
> is not enabled if the existing patterns are not cone-mode patterns?
>
> What exactly do you mean about "init" changing behavior here?

No, I was referring to your suggestion from [1] to add a warning from
"git sparse-checkout init --cone" when there are existing patterns which
are not in cone-mode.

> > Those may already call list routines internally, in which case I agree
> > that this is already taken care of. But if not, then I think we should
> > match list's behavior in the new locations, too.
>
> "list" interprets the 'struct pattern_list' in two different ways,
> depending on the use_cone_patterns member. They are static methods in
> the builtin code, not used by anything else.

Ah, bummer. I was hoping that they'd be used internally by init so that
it would automatically emit a warning in the case where a user's
existing patterns are not in cone mode.

Apologies for any confusion.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com/
