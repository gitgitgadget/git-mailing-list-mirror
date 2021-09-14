Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A36C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D82F61108
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhINBKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbhINBKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 21:10:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC52C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:09:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b7so14721615iob.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKs7pb99cowh766MX1tCoqqg+E2Q8ISWMu3WD2gqDjk=;
        b=bdFiynwGsse6AgrGQ/33GTzDwHwssCSv+cn0m9k9XA+z2IRCo0PwPVv7ltc6R56VPq
         OZdegJ9F7CoGZVpem/l34VOvWUZB2J/wyC4qRFxJY6Q9q+eVoFTDqikjaas3KAW7G8sl
         mcaKPRS6PR9zRNFtJRY94G/H5HR+r0hjcCBBF1mgBtd0nZk5hweugI6+pxAHd1Ra2qvh
         KkNNloK4m90kEvTSqTR7KVOHmr9/uIDC4aGLMw5aZsOkJGRU0yYBWLA5DGGZDbyrv38a
         r0Ybk2NJr9bHE3a0gimMu6/kfqCmi0qVumpmmbQ51ftQE3pcZS20iDYcXL0s956MnEjd
         F7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKs7pb99cowh766MX1tCoqqg+E2Q8ISWMu3WD2gqDjk=;
        b=qA9XU1u4UiTvEyLG73SXd+2S/GjQICFY0voCgE6UfEb+H0Mu4TqhaBZujtwB22C0Jt
         m5LHzAC3DuMqCakwJajEFi4t6FmkO2rJwQK0xEJd4LXltRu4HhvJdRXlw6YhgovV6z1Y
         6cpspSmHmS154w0QoKl6a4SEq5+Ige7HPEbSb3V0w2GtWgeDUUHW0b1A+KVbKnTf5EdU
         u4ZUumeO6eJEEm5oDCyFnyx0Q3cOPuAOV2BN+YKEg8uAr3sH0tiC0sEEhugJomqLREoX
         L3ILxLf20rCRxen4+NFlnXx5BduHgpRKa3LUyb+ZzELSSzZWAzDp1cpJu6e+qcjP7kH+
         Q8ng==
X-Gm-Message-State: AOAM531M9IC1vCdXdIc3sfofXlDj5YPSGFpEZIXQrZ0066/rSBF9fBJV
        uBpehjGzmaTsSGUiVh/qvOxdhlXnzaBrtcHV
X-Google-Smtp-Source: ABdhPJwp4eFjEnf6+ZTZiqpMuXYMKmxhCQA4Ri2RFmGdOF/xdz47J8tiW9BKfoXxo6z+MZK6d+P47g==
X-Received: by 2002:a05:6638:2509:: with SMTP id v9mr12284577jat.95.1631581760265;
        Mon, 13 Sep 2021 18:09:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j5sm5769967ilu.11.2021.09.13.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:09:20 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:09:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
Message-ID: <YT/2PzbfE2p6TZ9r@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local>
 <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
 <CAPig+cS2E6c9YYKTThPSVpyBkouoL+nK2rgpsZxNODPmTr2hzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS2E6c9YYKTThPSVpyBkouoL+nK2rgpsZxNODPmTr2hzQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 07:32:07PM -0400, Eric Sunshine wrote:
> On Mon, Sep 13, 2021 at 7:19 PM Glen Choo <chooglen@google.com> wrote:
> > On Mon, Sep 13, 2021 at 03:29:25PM -0400, Taylor Blau wrote:
> > > > +        git config --unset core.commitGraph &&
> > >
> > > But I'm not aware of a way to temporarily unset a configuration variable
> > > for the duration of a test, so here I would probably write:
> > >
> > >     test_must_fail git -c core.commitGraph= fsck
> > >
> > > which Git interprets as "pretend this variable is unset in-core".
> >
> > From my testing, I suspect that git does not pretend the variable is
> > unset, but rather, it pretends that the variable is set to the empty
> > string. It seems that git behaves as if the variable is set to "false".
> > This is called out in Documentation/git.txt:
> >
> >   Including the equals but with an empty value (like `git -c
> >   foo.bar= ...`) sets `foo.bar` to the empty string which `git config
> >   --type=bool` will convert to `false`.
> >
> > If the variable really is set to false, how might we proceed here? Shall
> > we stick with test_when_finished?
>
> That's probably reasonable, however, for robustness, you should
> probably use test_unconfig() rather than raw `git config --unset` to
> clear the variable.

Hmm. I'm not so sure, do other tests rely on the value of that variable?
If so, test_unconfig() won't restore them.

Even if we don't have any such tests now, it seems like we should err on
the side of leaving it alone (although I suppose that future tests could
set core.commitGraph to whatever value they need as long as they use the
test_config function).

> Aside: This certainly makes one wonder if we should have a new
> function in t/test-lib-functions.sh which unsets a variable for the
> duration of a test only. However, that's outside the scope of this
> submission.

:-). I thought the same thing to myself when reviewing earlier today.
That's why I recommended using test_when_finished upthread, but either
approach is fine (my comments are definitely cosmetic, and don't matter
to the substance of this thread, so ultimately I am fine with either).

Thanks,
Taylor
