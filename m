Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2CC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 23:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9730061019
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 23:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhISXst (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISXss (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 19:48:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3AC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 16:47:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v24so53861659eda.3
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Eqbc2n2lVh3vlNMzeEoisD9x/hd158VtPeonxIHMBnE=;
        b=kBdXtc9EGeyHFCFXGE2oxOqxY7UZgheXHuRBVT2buLppg6KmPdsYK/tdHE5Sfgw3iz
         fweXNUgkGEhZE7Ai6rPs1EJ1kAFPwwW2AHZ/MrOVN6+/6iavFurzb+rbXn8mO8lpjBeW
         Mzz2A4aeByt0t0wvlvZKgzDAzyuVQx9TEx/F0vn2kZgFpdwj7Y8StPoY6tv1ZhglASVk
         fYuQ0BzqgO5++LFjyhf28K2cdsv/OGSqdUKCoC9YTmk8vbS5boDjDckHb2s/5UlgmjXV
         xcLl2+WH8++FAIoyoY3vtSEmg25Am/3jvIfDNysa3We7m1DnZHra6x1O5tzbzx/6ShQI
         s/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Eqbc2n2lVh3vlNMzeEoisD9x/hd158VtPeonxIHMBnE=;
        b=rFwU4S8jpjz8rc9iVLKPA4LxDsn8/QWjTtxyciUmmaWoAtGSEWn/45B4q4MhGwS3rR
         QtFrNo9DEWdLaXMLhr8PLN8a4eU0q2F+WG8/b1iQ2MIW8wgJmXRBx/9mc85cIVyAE4VS
         O03dR5WDqPcEUcR+1siMLy8C7cyDjotLxG/USEkPMoiK5VtEtkiJzTiLs6MgBfcN7lWS
         4ED614VS+8551Li4g+egtRW2dPHlat8Hpo+6Rxe1H5yY+QSD9/tlfqB8HaicdycGQKJZ
         n4YFv8hOVZZTaTDAueItcP1ARcVpJCBBxsCClag6VW54FjOtGVJGRwQPFLFn23X/SydE
         ECXg==
X-Gm-Message-State: AOAM530BpdEvBxzfIM4ZG8xQrGOK3tFACqH55Sgyq67DCNJDDKMwwLUb
        lK+RFtgZuHn4uEIHUQEMqHzdgrzJti4TGw==
X-Google-Smtp-Source: ABdhPJyZ0qe3cxcvVPBhvqnHrmMEvaYWEtHhaVo5O2JPJ/SwExPRhCZX5rDg1l4mOstTcDjpTxKD+A==
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr25409935eji.177.1632095240813;
        Sun, 19 Sep 2021 16:47:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj21sm5382347ejb.42.2021.09.19.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:47:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
Date:   Mon, 20 Sep 2021 01:44:23 +0200
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
Message-ID: <87k0jcb01k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 19 2021, Jeff King wrote:

> On Sat, Sep 18, 2021 at 03:18:47PM +0100, Philip Oakley wrote:
>
>> Is there a method within `git rev-list` to trim side branch merges where
>> the merge's tree is identical to the first parent's commit-tree?
>> [...]
>> From my reading of the `rev-list` manual this is similar to the <paths>
>> TREESAME capability, but without specifying any paths (maybe just `.` ?).
>
> Yes, I'd just do "git log ." for this. I don't think there's another way
> to trigger simplification. In try_to_simplify_commit(), we bail early
> unless revs->prune is set, and that is set only by the presence of
> pathspecs or by --simplify-by-decoration.
>
>> * Is there a proper term for the treesame condition of the commit-tree
>> (as recorded in the commit object)?
>
> In a one-parent commit, I'd just call it an empty commit. For a merge,
> it is really I'd probably call it an "ours" merge, since one obvious way
> to get there is with "git merge -s ours" (of course you can also just
> resolve all conflicts in favor of one parent). I don't know of another
> name (besides treesame, of course, but that generally implies a
> particular scope of interest given by a pathspec).

Isn't it a "theirs" merge, not "ours"? Per the description Philip has:

    In the Git-for Windows repository, the previous releases are
    'deadheaded' by merging with the upstream git, and simply taking the
    upstream's tree unconditionally[...]

I.e. if you're taking your tree unconditionally it's -s ours, but -s
theirs for theirs. Except of course for the small matter of us not
having a "-s theirs" yet.

I had a WIP patch a while ago for a "-s theirs -X N", for what sounds
like a similar use-case:
https://lore.kernel.org/git/87sh7sdtc1.fsf@evledraar.gmail.com/
