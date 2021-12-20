Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F7C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhLTQYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLTQYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:24:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D3C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:24:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so12121929edc.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iRxa0pjOY/f4MZsrgdsSQ84jUJY9/uh3nyybmmWGEZE=;
        b=R3RpdLJHeB1c1YQAPAMPxghzSc9Ea1OX90qpCd+NgcdoA3jFDXtIUCfwykcncPzHB0
         tgRmqzgtJrcjDXqK9HnFH60STA1lVz63dHnefbPS0NiQM284T3KRKeShc7SZvMQV7TFZ
         iRS/95j3ryxBM7OpyR89dwNlOKf+Cxw9klCTJpFrSm8VrOnF5TJFs5mvPXvaWXcygtsu
         Sv0Zb75YuIlQHYRAWedkyYbvABf3XTgDdxD9JmMpJc87oDCEO6mqv+tk4w2Y0fMeEHc5
         rp/0/3mC7QfX8py88DZMrWb9ACucL/igKNpR4ts7uOed3h/cT7eB86CHB512JGRETx+K
         vI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iRxa0pjOY/f4MZsrgdsSQ84jUJY9/uh3nyybmmWGEZE=;
        b=vInUzFegJgw9W1zbE40h0U3p7ir0bF5IWQFtf3zR7rd8TuX+XMrteJSuITuHUQXSBH
         Jr+F/TcNhkLIUXwKiU9z2hHvzc8dRG0msWisAgIn29MfAMxK+Jzdx9+mTTwQoptT48O4
         LPNgsrr0135BzbyRkv0tsoQW4yUC6C04fpRS2kKi1Dn82OyKAhG+mhZumCNvGZ5Aq6/E
         X5bvT542HKlhIuKjtYPhs0p2PvHSwOu5yinCEVZmGuauc134CbB8OF9NQmTzF6s3CmYT
         EfIkt2Lb13Z2MpjhMyX8BQejkNezW8437sNAuQEQ4HJ3db2HM3jN1d/h1FqtQrNgjjoP
         Ot0A==
X-Gm-Message-State: AOAM532+r1SajoBmMCIN5XekDbBMA+tfHChQrVnkb5Gkim3BIb6KRdoa
        AtD11IHtCa+DENntimF/84GMF00eABNvyg==
X-Google-Smtp-Source: ABdhPJy+SOe/r39kDrawghGFg/fEmhbIk6iycM/ZnILeItPmKoNk6a4I3UL2iyOlnYCifm/tJQF+Fw==
X-Received: by 2002:a17:906:7f81:: with SMTP id f1mr13951936ejr.569.1640017483214;
        Mon, 20 Dec 2021 08:24:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y5sm3320096edm.39.2021.12.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:24:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzLSs-000SuV-7O;
        Mon, 20 Dec 2021 17:24:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Mon, 20 Dec 2021 17:13:19 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
Message-ID: <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Derrick Stolee wrote:

> On 12/12/2021 3:13 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> In preceding commits the test suite has been taught to run without a
>> template directory, but in doing so we needed to fix code that relied
>> on the "hooks" and "branches" directories.
>>=20
>> The "hooks" code was all specific to our own test suite. The
>> "branches" directory is intentionally created, but has been "slightly
>> deprecated" for a while, so it's not created when not using the
>> default template.
>>=20
>> However "info" is different. Trying to omit its creation would lead to
>> a lot of test suite failures. Many of these we should arguably fix,
>> the common pattern being to add an exclude to "info/excludes".
>
> This would be painful to add because of the impact on the test suite.
> That I understand.
>=20=20
>> But we've also grown a hard dependency on this directory within git
>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
>> subcommand, 2019-11-21) released with v2.25.0 the "git
>> sparse-checkout" command has wanted to add exclusions to
>> "info/sparse-checkout". It didn't check or create the leading
>> directory, so if it's omitted the command will die.
>
>> Even if that behavior were fixed we'd be left with older versions of
>> "git" dying if that was attempted if they used a repository
>> initialized without a template.
>
> This, I don't understand. Why can't we add a
> safe_create_leading_directories() to any place where we try to
> create a sparse-checkout file?
>
> This would fix situations where older versions were init'd with a
> different template or if the user deleted the info dir. The change
> you've made here doesn't fix those cases, which is what you are
> claiming is the reason to not do the other fix that seems like it
> would.
>
> What am I misunderstanding here?

I'll clarify that a bit in any re-roll.

Pedantically nothing changes, i.e. you can create a repository with an
empty template now, and it'll break on both the sparse-checkout on that
version, and any previous version that had that un-noticed issue.

But in practice I think it wouldn't have been a big deal, because while
you could omit or specify a custom template it was somewhat of a hassle,
and even somewhat undocumented.

Whereas with this series allowing you to easily configure it with
init.templateDir=3Dfalse it becomes trivial. That was another motivation
of mine for adding this, I'd like to not have N copies of that template
crud all over my systems.

So I think in practice we need to be more conservative about
cross-version interaction here. It's not just a matter of "if", but also
of a new "how" making that "if" more common. I.e. needing to interact
with an empty-template .git directory.

We also have non-git.git code to worry about, e.g. us breaking any
user-custom script that might do:

    #!/bin/sh -e
    git init "$1"
    cd "$1"
    # *Boom* under init.templateDir=3Dfalse, unless we keep ".git/info"
    echo <my ignores> >.git/info/excludes

So I just don't think it's worth it. Let's just create .git/info
unconditionally like we create .git/objects/{info,pack} now.

It's unrelated to this, but if this gets in I would eventually like to
submit a change to make some version of init.templateDir=3Dfalse the
default. That's a bit more untandling, but I think ultimately
beneficial. E.g. the sample hooks are documented in "git help githooks"
along with general hook documentation. Such a change would ideally
involve splitting that out (maybe to a a
"gitrepository-sample-hooks(5)"). That's another reason for why I'd like
to make init.templateDir=3Dfalse play nicely with existing in-tree and
out-of-tree expectations.

>> So let's just bite the bullet and make the "info" directory mandatory,
>> and document it as such. Let's also note that in the documentation
>> that this doesn't apply to the "hooks" and "branches" directories.
>
> I have no objection to this approach, but we should still do the
> other thing.

All that being said I don't really mind not creating a .git/info if the
consensus sways that way.

It's a bit more painful when it comes to the tests, but not *that*
painful. I had it mostly working before abandoning it for this approach.
