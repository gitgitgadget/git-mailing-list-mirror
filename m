Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73EC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131A564E64
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhCQU04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQU0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:26:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B117C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:26:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso3054975otd.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VNTn+pWHfW7UTaIX3pzneecuH9Gz2hqExmf2iSH580s=;
        b=nEBeokWlu8907aBfNK0hUGvoK5hoHfnCzllqb2VpBfG29RDY7+bA8EeQ32pFEJnJjm
         0OKRMOOWoWXTkYSSzgBdvzSZPBJq/HSzxy4aHHpVKGzStr85VuZLu365PpLgSJnGg2XN
         XkodolkpqZUxwtX0aryFlRrJYxRnN7j73xkSObKK8AxwsWW1OcyffC7IetRxJl25uoAs
         6LsvSVWIbnDi2vLFSSl8htU3nf/SW33wDusaktgVmA8K/Of5Uf4xh4OcoiulukNGACQY
         rpQFkeX7qduZeL6B64YABB+dklMD7ocfhEK3n5xLywXP0XitrHaHmCSSJtcMvDgHpxYN
         C0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VNTn+pWHfW7UTaIX3pzneecuH9Gz2hqExmf2iSH580s=;
        b=XEOKgPuUWcAsaTBcvkx2w+gf7VKbb/8h25FK9IRB2I+JbDTVrhYbHxqdI5K2kEFz2J
         j6EQiiYU0zpowia6gc3OR4fhEwBjvBMUXy+j5+T0VOzngdWrWZGfeizKU41jMdA5gxBl
         IhC73eS0aC4Kfvnrbj/z/L8uys5pHvP3kxLOkNwY1uojJp0X5UWKs3QwGZ2gW3LvZIiC
         F0qmwuGUu6q810uADNLFB5F/6a84xBnVf9KWHDHiI5x+zObM+5Hu0n/Fia2yCeLFvB9z
         2d1lQaZq/tO+0TtzCZIxM8MWfmWKw4zsMqgECwH+dlG7ucjosFSywrnTYbukwhlu9E86
         LRiQ==
X-Gm-Message-State: AOAM5315/c0cAyaBts+OeaDpOmUrNSbu6Hi+bOiwVa7b/gcJJhgIzVtM
        VLKmk1sl33dKBivs92pQ7CBYBbEVF7iGI2cOLiE=
X-Google-Smtp-Source: ABdhPJw6tAzpmDQxfR55af48AypJAj4IvLZienKPOu/dmQLFve+XDebDJ4IV4yo5FyGcSkfkKXW+GtySZ6312QvLpFo=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr4606125otf.316.1616012800505;
 Wed, 17 Mar 2021 13:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-1-avarab@gmail.com> <CABPp-BGS7BxbxiPvk7zoO1XdbZSkpyrfYLuyiNnR+d6orPn+rw@mail.gmail.com>
 <d93300ad-9a3b-6de4-c497-acd56eff30dc@gmail.com>
In-Reply-To: <d93300ad-9a3b-6de4-c497-acd56eff30dc@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 13:26:29 -0700
Message-ID: <CABPp-BHh_QgF8xej8=xUJh+mYfKTB_d-7Su+xwcfRyaHEPz1mA@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Re: [PATCH v3 07/20] test-read-cache: print cache
 entries with --table
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 12:46 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 2:28 PM, Elijah Newren wrote:
> > On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>> From: Derrick Stolee <dstolee@microsoft.com>
>
> >>
> >> So we have a test tool that's mostly ls-files but mocks the output
> >> ls-tree would emit, won't these tests eventually care about what stage
> >> things are in?
> >>
> >> What follows is an RFC series on top that's the result of me wondering
> >> why if we're adding new index constructs we aren't updating our
> >> plumbing to emit that data, can we just add this to ls-files and drop
> >> this test helper?
> >>
> >> Turns out: Yes we can.
> >
> > I like the idea of having ls-files be usable to show the entries that
> > are in the index; that seems great to me.  I very much dislike the
> > --sparse flag to ls-files, as noted on that commit.
>
> I don't like this idea. I don't think exposing internal structures
> like this is something we want to do so quickly.

Not sure I follow; ls-files was already about exposing three bits of
internal structures for index entries: mode, hash, and stage number.
These are quantities that are well-defined for sparse directories too.
It would not be exposing any new or different internal structures, nor
changing the output format.  (=C3=86var changed the tests to not look for
"tree" but to look for the "040000" mode number.)

>  Further, I intend
> to use this test tool in the future to _also_ show the stored stat()
> data, which would be inappropriate here in ls-files.
>
> I would prefer to continue using the test helper here and leave
> functional changes to ls-files be considered independently.

Well, I was okay with it being in a test helper regardless of whether
it could be done with ls-files, and then just circling back and fixing
up ls-files later.  But perhaps it's worth calling out in the commit
message about your plans to add stat() data and how that future piece
can't be done in ls-files (without functional changes of some sort)
just to make it clearer why we're using a test helper instead of
front-loading the port of ls-files over to sparse-indexes?
