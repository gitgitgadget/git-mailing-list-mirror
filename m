Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E54C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F26464FD0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhCJTwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCJTvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:51:43 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98158C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:51:43 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g4so12098259pgj.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=215wMy4DkIR0MEhMNrV/eKoqW1JFGvx00lUvLOu20Po=;
        b=IywqIrbfpKbUepRNsFPE/VKrWMgLegx0CjL2jM/2ESh9X/Nv1XK1MEBHEFehtS82fW
         541a8XHLNhEZb63JvxYVaCXi8BOci+iTf/mmVeloNC81crEVIoKwCgf7p/fn7/zWlla8
         NdAEixI98VT0s/kCclzWMMU8lORhBl5pbxnHJCAKvOjy7fYalRUTPMue6N8Jsf+YmVM2
         k1ujDE6ZbJrE9/X/kMr0bxPidYrEYXJn35PdJ8r7X4QJSjSWkEUllFMIYptCyNhUJlo4
         AuJcHx3NNP/AnBd8tSYwt501UNj4NCGqtG9KKXIE+/UQIhITXGpJwlQkm4T1UBPQ09+0
         igjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=215wMy4DkIR0MEhMNrV/eKoqW1JFGvx00lUvLOu20Po=;
        b=hisw70QPgNCupaNorPkn2w0D1Ok/yoef4fzvWl3aqmIGf3bgQ6pyX50Ezt/UudmXuG
         qRqsi0Ek0y5rf83yjcLGNqDBf2iwzV4xk0fD+dpxMOwbJLrRNfqozbbIxozKikPfolvR
         OxO58KBQDRiWo/r1E+C2ksW57HnTe2tt1uUFDz/krVsj7i1Q0i86G96vVy1b5Cxu03St
         4fIyDfINJUPMHlfBYoVDWodL65iMxmcdkr2I1/Fpo9l/E3w8jQ7HohF34CEwYRnp2pge
         U81khUPoZVGceqoNLtPrjPTOY3A6YXFpDXQ6nU2R8JawISbYQZVgo7tbVuW3Txz8kP6k
         2hnQ==
X-Gm-Message-State: AOAM533QtiZinn9sF2nhdcp11qV2Jv0KHtZTuvNxJOYA7iSCPvKKeBFR
        NKqdTayjejP3SDua7f0AHbnn1Q==
X-Google-Smtp-Source: ABdhPJy1dOC3AF8INPjAlwLzI7EL6DZ5nHtz9FlhIVxm5j79QFp5nULS4iBxpLOqx3JgaEVjsGdsaw==
X-Received: by 2002:aa7:9145:0:b029:1ed:d58b:e276 with SMTP id 5-20020aa791450000b02901edd58be276mr4222341pfi.25.1615405902956;
        Wed, 10 Mar 2021 11:51:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
        by smtp.gmail.com with ESMTPSA id k11sm288856pfc.22.2021.03.10.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:51:42 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:51:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 01/17] commit: use config-based hooks
Message-ID: <YEkjSSuHXk3XI85W@google.com>
References: <20201222000435.1529768-1-emilyshaffer@google.com>
 <20201222000435.1529768-2-emilyshaffer@google.com>
 <xmqqlfc7jv9p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfc7jv9p.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 02:08:50PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Because all but 'post-commit' hooks are expected to make some state
> > change, force all but 'post-commit' hook to run in series.
> 
> OK.  And a sequence of hooks that run in series are expected to use
> the output from the previous one as its input?

Kind of, but phrasing it that way is a little odd (to me). The commit
hooks take as input the path to a tempfile which holds the proposed
commit message, and they modify the contents of that file. They don't
make output via stdout or receive the commit message via stdin. Most
hooks work this way, I think with the sole exception of 'proc-receive',
which is implemented weirdly (I said more about it when you asked about
it in your part I review, here:
https://lore.kernel.org/git/YEkgWDthF7sObtAt@google.com).

I'm not sure how to phrase it better. If I were writing a hook I imagine
the combination of taking a filename as an argument and the note about
not running these hooks in parallel would be pretty self-evident. Hmmm.
Maybe instead of the copy/pasted warning about "will not be
parallelized" I could write:

  Hooks executed during prepare-commit-msg will not be parallelized,
  because the file provided in the first argument is expected to be edited
  by each hook.

> 
> > 'post-commit'
> > "is meant primarily for notification, and cannot affect the outcome of
> > `git commit`," so it is fine to run in parallel.
> 
> Makes sense.
> 
