Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BBC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113AD6117A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhELJIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhELJIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 05:08:10 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F52C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:07:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso19975688otm.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JqcEBb5KixoJ6fPKn2lUmgau7znn1v+6edy/H9l+J90=;
        b=t75YiU20R4XRfx0k0fvh03SK1mUJCQUKnRvq2xcO9o/tQkyC+OoS0QrLpmJ/VxPi/2
         HRiTtSyOJ/p63d68hy+Ca4snbZlZTepSHqdp513RKxAWvmkxz2bzl+QB6xw5EmEnxxjL
         pOtzvtFBQqiY57fn+He7UEu739bmExbK6MuqgmFdqTjSBRBZ1j/mBnXgILl9u+tV7FJs
         EY1gcqtIFxb6o4WV4R60BJUB+xGSqTAGJae1BK4ldKPhUFY5DofbqtIFPkGxjHCL/rqW
         KaxOd4I+m6xTdpx6puECojfhbFQ0sYkqN+snb6ClaF15wqzQbYoFVDhAK3/oUV110h7V
         l56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JqcEBb5KixoJ6fPKn2lUmgau7znn1v+6edy/H9l+J90=;
        b=mhrduB2IEXeb+RiC1XPqAUQm+KzHe9b73HNRJhPISYXlS66VrQ/+54Zo0zpQNpv6tr
         nfAzoCQlFp0HPZO0tox/GMdQ69E2oVaFM4z8X0WxMTt+R0hzv/C0TZKRgdexrky29IP4
         8qxaU2WPjtHCBIYx/mDqivbMJI2XN3dj6aDkUjyvyPKKXlGskkXByYGF/nIAIGb1Sj6+
         Q4ZFiw2Hv13WLUa9dBdYe+2X+qRBHDaxeG81OVYiLnrdPxJLRYNGpZM44dKMxjyAUmQR
         SfDofzFOAHtT1tPECTuVIB9rJmhA9GHEvqHOX1bDKVWIWjV/DSggIv7XwG6ju+lJfTxZ
         yjmg==
X-Gm-Message-State: AOAM533dREPRFQfZSmwsMPQkfxxmSWoJW8gggjKtUugz4T+klgwxwt9J
        bTI4efhC5lcupd6mNk8ZgvE=
X-Google-Smtp-Source: ABdhPJzqApqr79S7MmBxIZcaFl/NBDCSvyPzrYTmJAGTd+x/Si2eI2Mwd91cCiQaJ7kGmBuStx2HVw==
X-Received: by 2002:a9d:8cf:: with SMTP id 73mr2790660otf.180.1620810421462;
        Wed, 12 May 2021 02:07:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x2sm3845865ooe.13.2021.05.12.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:07:00 -0700 (PDT)
Date:   Wed, 12 May 2021 04:06:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609b9ab0b1120_6e4e9208cc@natae.notmuch>
In-Reply-To: <20210512064733.GP12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:

> > > You can use 'affect' or 'impact' and it generally conveys the same
> > > meaning.
> > =

> > That's clearly *your* opinion, but that's not my opinon.
> > =

> > I'm not arguing between blue and red; I'm arguing between water-based=
 and
> > lead-based paint.
> =

> No, you are not. There is no clear problem with 'impact', either.

There's no clear problem *to you*.

> So if somebody comes along later and says that they find 'affect'
> confusing and impact should be used does that need to be accepted as
> well, back and forth ad nauseam?

No. When that happens we start a new discussion, and see where that
leads.

> > The difference may not matter to you, but it matters to me.
> > =

> > If it's bikeshedding to you, and it "gnerally conveys the same meanin=
g",
> > why are you arguing against?
> =

> So if 'for' loops and 'while' loops generally convey the same meaning
> should we accept patches that replace some 'for' loops with 'while'
> lopps or vice versa?

You are not answering my question, and you are providing an irrelevant
example.

I don't see any general difference between 'for' loops and 'while'
loops. But I do see a difference between 'impact' and 'affect'.

You are starting from the premise that $a is no different than $b.
That's your opinion, and I'm not disregarding it. But other people (e.g.
Varun and me) do have a different opinion.

Again, to make it crystal clear; you opine that $a and $b are equal, we
opine that they are not. We don't disregard your opinion, you do
disregard ours.

I don't know how much clearer I can make this.

> In the COCA corpus there is around 200k instances of 'effect', around
> 100k instances of 'affect', and around 100k instances of 'impact'
> which makes effect/affect about 3 times more frequent than 'impact'.
> That's not even an order of magnitude - clearly not enough to claim it
> obscure.

I don't think you understand the point.

The word "impact" is not obscure by any means.

The Chicxulub impactor (probably an asteroid) did create an impact on
Earth that probably killed all the non-avian dinosaurs. In that context
the word "impact" is 100% valid.

And you can find many such valid instances in those 100k COCA corpus
instances...

But not all.


The way the word "impact" is used in the git documentation is different
than the COCA corpus. Not all the instances of the word "impact" in the
git documentation refer to an event so drastic that it destroyed
thousands of species.

The point is very simple; there's valid ways of using the word "impact",
and there's invalid ways of using it. The git documentation for the most
part uses the word "impact" in an invalid way.

How many times the COCA corpuses uses "impact" in $b manner is
irrelevant to the number of times the git documentation uses the same
word in $a manner; the same word can have completely (and sometimes
opposite meanings).

The word "literally" sometimes means the exact opposite of the word
"literally". So if you find 1 million instances of the word "instance"
used in some way, that doesn't matter, because you might be using it in
a different way.


So... Can you answer my question?

Do you have anything against the word "affect" in *any* instance?

Cheers.

-- =

Felipe Contreras=
