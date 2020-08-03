Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93FC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036FC2076C
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fmMAq92a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHCWqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCWqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 18:46:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF2C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 15:46:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b25so29564004qto.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OMo6m13Mhmnsxnyas+b872mFZqbkTisBVwgQuGuHN+Y=;
        b=fmMAq92a2mRUSwaZDTyZ3kcZN/a9Bt+z5KZhQKTomSGer3VIPil6QNpIhJ+T6DXxlw
         R5y2IMbss2CPlD4e/Lox1G+rGJ1pLI1HbJyHa4tdDVrpE+ydWgDTLD4vGVQkKpa94UyX
         Pu6ncYmc/6jc39Mu1TTz+zEhfogAMgsFZG7CySKFUIXQv2zN9QpPKWS5jwIw/7yqREN9
         /zV4CpfcV+/AFw0Ttsn9oNPwloVsxjI10FA9DOF4w2zVArkpFtiVNJXUR8NvUG4mPPqv
         Lsu8mUC1at1AuWn4cyn4WEzcagDYfhD7OfmGvxVSzXvXhTGY/eIKs7Dur1eqy2JBYodL
         7+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OMo6m13Mhmnsxnyas+b872mFZqbkTisBVwgQuGuHN+Y=;
        b=ewZvI1K9Hfd2FBpuJGB8UUw+qqPf6JU+NRfzPV8moUu1762hGK3zFqMUbm6dYDfylT
         dYb2Op1yD/OVz2iZuz3HtHk0gWs71ea86ZzMiWByTc/aUb6kz5TXROvHwkVJqTPpUSiI
         e1xGIATZMB4Jkz4b+z0rvHwcUrgf/OmMSnHn9WvWdabyBcbpVEzqPkZmoknKjKKc7Hpf
         nHbx9yOhmDu0KAl4CHMeb7dA/nnaTFk0GmcQLQHauUEXcT7wqEoctVvy+vrb/ZcccQ28
         KiR70t2puaAGi37tuI5UgPZSi1ovC54lOUTOr/VSatfwaKZZKceRpLFHpvwcxrWjOsMG
         X+MQ==
X-Gm-Message-State: AOAM533iAn4Im1no9i4wJjq/IWJf/NYNOwh339vSuOQ8k/PB/AmRNCoN
        aoxiZHhR4P13saRmvh3uLsd3ww==
X-Google-Smtp-Source: ABdhPJxYNGOyVBgxA5p3BMa05iOxLG8hM3dZTLmYzrvbLn037+jMzp8D5d6pvgHy4MpaDS1QVxTa1Q==
X-Received: by 2002:ac8:3894:: with SMTP id f20mr16129942qtc.243.1596494794439;
        Mon, 03 Aug 2020 15:46:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 9sm22429859qtg.4.2020.08.03.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:46:33 -0700 (PDT)
Date:   Mon, 3 Aug 2020 18:46:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803224631.GA73022@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803174654.GA2473576@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 10:46:54AM -0700, Jonathan Nieder wrote:
> Derrick Stolee wrote:
> > On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
> >> Derrick Stolee wrote:
> >>> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:
>
> >>>> [jrnieder] How do I supply the tasks on the command line?  Are they
> >>>> parameters to this subcommand?  If so, it could make sense for this to
> >>>> say something like
> >>>>
> >>>> 	run <task>...::
> >>>
> >>> Hopefully this is documented to your satisfaction when the ability
> >>> to customize the tasks is implemented.
> [...]
> > I mean that there is only one task right now. Until the commit-graph
> > task is implemented, there is no need to have a --task=<task> option.
>
> Ah, that wasn't clear to me from the docs.
>
> You're saying that "git maintenance run" runs the "gc" task?  Can the
> documentation say so?
>
> [...]
> >>>>> +static struct maintenance_opts {
> >>>>> +	int auto_flag;
> >>>>> +} opts;
> >>>>
> >>>> Packing this in a struct feels a bit unusual.  Is the struct going to
> >>>> be passed somewhere, or could these be individual locals in
> >>>> cmd_maintenance?
> >>>
> >>> This will grow, and I'd rather have one global struct than many
> >>> individual global items. It makes it clearer when I use
> >>> "opts.auto_flag" that this corresponds to whether "--auto" was
> >>> provided as a command-line option.
> >>
> >> That doesn't seem idiomatic within the Git codebase.
> >>
> >> Can they be locals instead?
> >
> > Which part do you want to be idiomatic? The fact that the parse-options
> > library typically refers to static global values or the fact that the
> > data is not organized in a struct?
>
> parse-options has no requirement about the values being global.  Some
> older code does that, but newer code tends to use locals when
> appropriate.
>
> Putting it in a struct is fine as long as that struct is being passed
> around.  What isn't idiomatic in Git is using a global struct for
> namespacing.
>
> [...]
> > The natural thing to do to "fix" that situation is to create a struct
> > that holds the information from the parsed command-line arguments. But
> > then why is it a local parameter that is passed through all of the
> > local methods instead of a global (as presented here in this patch)?
>
> I'm having trouble parsing that last sentence.  You're saying a global
> is preferable over passing around a pointer to a local "opts" struct?
>
> [...]
> >>> If there is a better way to ask "Did my command call 'git gc' (with
> >>> no arguments|with these arguments)?" then I'm happy to consider it.
> >>
> >> My proposal was just to factor this out into a function in
> >> test-lib-functions.sh so it's easy to evolve over time in one place.
> >
> > This is a valuable suggestion, but this series is already too large
> > to make such a change in addition to the patches already here.
>
> Hm, it's not clear to me that this would make the series significantly
> larger.

I think what Stolee is trying to say is less about a change that would
make the series larger, it's about changing an already-large series.

> And on the contrary, it would make the code less fragile.  I think this
> is important.

I'm not sure that I see your argument. What we are really discussing is
whether or not we should have a static struct outside of 'cmd_gc()', or
a zero-initialized frame local struct within 'cmd_gc()'. I fully
understand the arguments in favor of one or the other, but I struggle to
grasp that this is worth our time to debate in this much detail.

> https://chromium.googlesource.com/chromium/src/+/master/docs/cl_respect.md#remember-communication-can-be-hard:
> if you'd like to meet out of band, let me know, and I'd be happy to go
> into this further.

I assume that the part of this document you were linking to was about
meeting out-of-band to discuss an issue instead of emailing back and
forth.

I appreciate your willingness to resolve this expediently, but I would
much prefer if these discussions (that is, the ones about the technical
content of this series) happened on-list for the benefit of other
reviewers.

> Thanks,
> Jonathan

Thanks,
Taylor
