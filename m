Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31514C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1100C60F6E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHBNQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbhHBNQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:16:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA706C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:16:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d2so11563536qto.6
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bERWw3VUZ352YUYOmASgUztFfYdyIySgcFqjJl4GXX0=;
        b=ZMoIEfVroaG0/YPRaZgeOUjcssqxC7CKWPlBYbHMoGXfTNL5HD5wM9nJCh6fQEOohu
         G6UHNT/fdxli2lv7lIVC+fDjI61wa2ZTomoBcCfF20BS8aTHkZnghzHX9qJ+PvipNTBD
         Flo8LukP8Rgmix8lRIcDh7RCbOL5zvcDD7ovq1dzPbQ8BRqASvsozo88xhZAgmubohUn
         GuKvHzJ904gwHVvQF6QdE/yhS6IrNHKYAo5d0R895D8R0NZ0ZUU8uKg8hwmPInM7jxfc
         ehV/blfDZXCH81vn5bYm2OUVpZVSmv/G04BgQk37/67Sms6ize7K5g9AoHvYnaC8zGbf
         yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bERWw3VUZ352YUYOmASgUztFfYdyIySgcFqjJl4GXX0=;
        b=qZBQTIfPl4aJu9YtAKQ49Sx0tB4Yo7W7zck6lnOG/IT4PbNruiT0Ijm1nvltW7+N2o
         Ie/TRBgZ4siDJlB34SRZ1JEhyzye8aOfEaOe073+zfuQVghQKrosQzlOOhQoIhpSllF0
         +yr2teuSyTxEv2SlBOw7Vcgkznc7U9xHMJPOkT8NuIFhiS8G5dW+uR1SgOD5QNG4eIx4
         RS6w+ixc4SN6vd8/49YWYkcwSpL21fIiyFSc8P49TT5U5l9JaXHW9Eg4kKpbtH7JZqnc
         mmpgfO5tUaDOmLU8YLnhWFTYuR9n8XaMOsG/9XlL8vLEA3yx8CEALoCwP3QfgZ8DX7wa
         uAUw==
X-Gm-Message-State: AOAM533ATPRu8jxbz8vF379j06aeaFr7/Ry/Nf8QI7yPMuBpPGLiv+wr
        XvqenUtY0inwooAdYtbvbxA=
X-Google-Smtp-Source: ABdhPJzPdsLocUilJqJ+9pZQVPLjR76Woe18PoQk+bZ2HBgjgx7pimnI3DnqIb8mFN4vGoPvMOdrog==
X-Received: by 2002:ac8:6886:: with SMTP id m6mr3959022qtq.255.1627910181983;
        Mon, 02 Aug 2021 06:16:21 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id t64sm5870950qkd.71.2021.08.02.06.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:16:21 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:16:20 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup upon
 branch creation
Message-ID: <YQfwJOxlBOUWiH1V@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <20210729020125.746206-2-mathstuf@gmail.com>
 <87sfzsngad.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfzsngad.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 15:02:41 +0200, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Jul 28 2021, Ben Boeckel wrote:
> > The `branch.autoSetupMerge` works well today for setting up tracking a
> > local branch, but there is no easy mechanism to automatically set up a
> > remote tracking situation for workflows which use a single set of
> > branches for integration without specifying `--track` to every branch
> > creation command or branching directly from the remote ref. This patch
> > adds the following configuration values:
> >
> >   - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
> >     otherwise given;
> >   - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
> >     otherwise given.
> 
> Not a new issue per-se, but what if you've got a branch called
> defaultRemote? It seems to me that any new branch.<name>.* config closes
> the door for a <name> we squat on.

It doesn't seem that shadowing is actually a thing:

    % git init
    Initialized empty Git repository in …/git-shadow/.git/
    % git config foo.bar true
    % git config foo.bar.baz true
    % git config --get foo.bar
    true
    % git config --get foo.bar.baz
    true

> Given that we have checkout.defaultRemote and this also affects
> switch/checkout it seems better to continue in the checkout.* namespace
> even if it wasn't for that, but given the config squatting issue
> especially so....
> 
> For what it's worth I usually use the checkout.defaultRemote option
> (which I added) and:
> 
>     git checkout master &&
>     git branch -m master <topic-name>
> 
> See 8d7b558baeb (checkout & worktree: introduce checkout.defaultRemote,
> 2018-06-05). It seems to me from that patch diff that you could modify
> some docs / tests for this, no? E.g. how it interacts with git-worktree.

I think it would be weird for `checkout.*` to affect `git branch` which
does no checkout at all. I want it to set up for simple branch creation
as well, so this would be a hole in my use case.

> I like this direction, but just have a concern that this is a place
> where we need to consider all the UX in the area overall, and that any
> options/config don't overtly interact in a bad way.

I'll have to look at adding test cases as to how it interacts with
`checkout.defaultRemote`.

Thanks,

--Ben
