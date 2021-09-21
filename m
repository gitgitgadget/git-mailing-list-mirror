Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3581C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0FE60FDA
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhIUUkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhIUUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:40:13 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:38:44 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x2so258613ilm.2
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FpfDmu6Wu+zMe4ASTEFg2MwNWF+hniU7CFrB3sePG1Q=;
        b=mmcdHRgz4rqLOPhGvZbuP7XMxqCLb20L87gdnSfRqMO1KSJoHp1OfLM9pepCYkAY1T
         4SZtQKKTsG3PzqLT8uT/QOGEt+Vijj+AetJ7IboJp+87EvAeJBLyCo2TPg2oZ+n601wP
         oJJWBwoFrqu0WoRfS4b/RbME2TGjsOuK4trTWvUX+eUk04DNvo3WVy2AknNIwNqAL18C
         GRiOpjcCpU8SX+8lxozTQw2rKfFiSsq6PFE0gBMhVwS2uHUY77KLwJg0yS+rvcWUM+H2
         Xw3Z7QIJ+RQaEbttLXYA4deZwlCF97QIsXdHecRIAIgxF8TXywfeVQ1naIAK+BouDGEz
         XNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FpfDmu6Wu+zMe4ASTEFg2MwNWF+hniU7CFrB3sePG1Q=;
        b=iGpcYREhtbl6cFFFs69L+T1dT2vfeXu1SXCnAtYjOqOkY8Cbuwu6vshs8ZWlghygQX
         Yi9MdQ2WXz7+RCT+bMiZDJmYCjEPD2qBsSUdvzrCOTg7KP4DznVWI6FAMsy81e1Yztu6
         kF4ngb+kjUq1IS9vINh4ZZ4caC+X7uVFGKxXihbtwOZmDIYrl+zU9xlY+k2i64CCDZhD
         IGeqmZ9K3DBeSGlN6fmXbCfwMHmgM15M+5PhXY0N7gnT+p/3Qgczz/P2vS4esYa/MMpL
         K3xPkY3IF5jADGoCcAbNoMvNSpU3AkNiWCjsLrmnCDvfqoXcxqQ4YT0kC+vl/Ldklct5
         gIcg==
X-Gm-Message-State: AOAM530/yS8yQYbjQSiOVY+CtwpM6OLOsZ1gLLYkRvjCCibFLKvvbM6f
        FK0QWVUi6OQGt06eMSe+k0pWaw==
X-Google-Smtp-Source: ABdhPJy0eKJVtqF9hGp1GeAplqB2E3GcloO/wE1m9AVXPVyhIXHJy9R+JU28OTXpz/TP2hWYPXqPQw==
X-Received: by 2002:a05:6e02:ee8:: with SMTP id j8mr21914491ilk.170.1632256723639;
        Tue, 21 Sep 2021 13:38:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k5sm57100ioc.7.2021.09.21.13.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:38:43 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:38:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
Message-ID: <YUpC0moHj4K53Wk2@nand.local>
References: <cover.1631980949.git.me@ttaylorr.com>
 <xmqqr1dj9c0b.fsf@gitster.g>
 <YUj/h3xucy4JR7B1@nand.local>
 <87zgs593ja.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgs593ja.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 08:19:47PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Sep 20 2021, Taylor Blau wrote:
>
> > On Mon, Sep 20, 2021 at 02:24:04PM -0700, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > An open question is whether the same should be done for the multi-pack-index
> >> > command, whose top-level support for `--[no-]progress` was released in v2.32.0
> >> > with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).
> >>
> >> We do not mind too much about "breaking backward compatibility" by
> >> removing the mistaken "git multi-pack-index --progress cmd", I would
> >> say.  It's not like people would type it once every day and removing
> >> the "support" will break their finger-memory.
> >
> > OK; if we don't mind then we could do something like the following on
> > top. But if we're OK to remove the top-level `--progress` option from
> > the commit-graph and multi-pack-index builtins at any time, then both
> > patches become far less urgent.
>
> I think just taking both this and your commit-graph patches is the right
> thing to do at this point. I.e. we almost entirely take:
>
>     git [git-opts] <cmd> [cmd-opts]
>
> Or:
>
>     git [git-opts] <cmd> <subcmd> [subcmd-opts]
>
> And almost never:
>
>     git [git-opts] <cmd> [global-subcmd-opts] <subcmd> [subcmd-opts]
>
> A notable exception is the --object-dir (I think I found out from
> Derrick at some point why that was even needed v.s. the top-level
> --git-dir, but I can't remember).

There's a good explanation in:

    https://lore.kernel.org/git/22366f81-65a6-55d1-706c-59f877127be0@gmail.com/

and a lot of related discussion happening throughout that whole
sub-thread. The gist is that it's to be able to treat directories that
look like they are a repository's object store (but don't actually
belong to any real repository) as if they are an alternate.

> But just as a *general* comment on where our UI should and shouldn't be
> headed, I find your [1] an entirely unconvincing reply to [2]. I.e.:

I think that's a fine argument in the other direction. But to be fair, I
consider the top-level '-c foo.bar=baz' to be different than a
sub-command of the `commit-graph` builtin supporting `--progress`.

Perhaps you consider these the same, and I could even understand why.
But to me, at least, I would be disappointed if we introduced a new
sub-command of commit-graph which didn't generate a progress meter,
while still accepting `--progress`.

In other words, as a user, I would be somewhat confused if I didn't
know any better to have asked for `--progress` in a mode which no
progress will be generated. I imagine it would be confusing not to see
any output *and* not have `--progress` be rejected as an unrecognized
option.

Anyway. To be honest, I find this whole discussion a little too
theoretical for my taste. I think the patch(es) that I wrote for
commit-graph and multi-pack-index seem relatively uncontroversial, and
(at least in the commit-graph case) fix a real problem that we could
avoid leaking out into a release.

Thanks,
Taylor
