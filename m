Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D32209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdFFSCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:02:01 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34899 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdFFSCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:02:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id k71so4396341pgd.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sga/1ZzKocGUrJnLDNslsPuw7zQKr2LzV1Ir6e29ip4=;
        b=CqG0ybq2+ISteFiSwz6vgmiZMxf4nNdidITV2cbRBN34u9vNDrLJIGhsveLnQBrekI
         8BY4Uice76meZTq/oYEkOy9minjBSAw/64sthN41znbYKuSyNo8sZ5OV5xPu2/gSoW6U
         5Rd4mAkLSYeGBpS6xho73/vDEl4vrm4hadvtHbDiPlHooBCnCRE8plC1CL7ZEEhEGug2
         F3L26mNghheBP3P6HbH/J/KSxdIctVFGBFeHHn9MzOuILPio5DWL7b1bXkfAK1PcPT2L
         0KmViYLxzYZjWbRgYNQ807gnlhiMC/6tTS3sFL6K1dojysWrwkLN2S4Y02IN7twzDrFI
         7d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sga/1ZzKocGUrJnLDNslsPuw7zQKr2LzV1Ir6e29ip4=;
        b=Q222b5AxIhG3WWLFEyptBhwQIisLqUPzDDBDA9NCd+ecobhECIl5J9AWlkAwadCQe8
         ciYlHPXcdSNbqZAQhFF4g9eSXL1/Xk1Xus+gqhGJoyNsZBUJ0i8K7BsETDO4UzoFuQmE
         WF2F7ZDmQJlwtwOGFUTS05yhkIlTj7s48OahHGKj4qDSsofikG+dzYzS5UDQ17gyLJwC
         VrFTu43aENOgq/+eN8A1X3Swyh9ybtsOeW4pMKllEQobgcsg4AWtJSGsmRjI3lGdgJKN
         JDnIA//xBCekcMH/F949SeNDJeKkwc4vPQyhsSLOxUn36M3up1kKxPA4KrxqAe1K8nLM
         nJwg==
X-Gm-Message-State: AODbwcAPglwyE59fhc83Nk6n64S8kIh5iFYxZ31EmnBAAtk+GieO3TIg
        2FJ3XJp5NwWZEJJ0wtoa+FCjhYMMgY3W
X-Received: by 10.101.76.201 with SMTP id n9mr28344269pgt.40.1496772119507;
 Tue, 06 Jun 2017 11:01:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 11:01:58 -0700 (PDT)
In-Reply-To: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 11:01:58 -0700
Message-ID: <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive clone
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 8:56 PM, Jeff King <peff@peff.net> wrote:
> While running some regression tests with v2.13, I noticed an odd
> behavior. If I create a repository where there's a gitlink with no
> matching .gitmodules entry:
>
>   git init repo
>   cd repo
>   n10=1234abcdef
>   n40=$n10$n10$n10$n10
>   git update-index --add --cacheinfo 160000 $n40 foo
>   git commit -m "gitlink without .gitmodule entry"
>
> and then I clone it recursively with v2.12, it fails:
>
>   $ git.v2.12.3 clone --recurse-submodules . dst; echo exit=$?
>   Cloning into 'dst'...
>   done.
>   fatal: No url found for submodule path 'foo' in .gitmodules
>   exit=128
>
> But with v2.13, it silently ignores the submodule:
>
>   $ git.v2.13.1 clone --recurse-submodules . dst; echo exit=$?
>   Cloning into 'dst'...
>   done.
>   exit=0
>
> This bisects to your bb62e0a99 (clone: teach --recurse-submodules to
> optionally take a pathspec, 2017-03-17). That patch just sets
> submodule.active by default, so I think the real issue is probably in
> a086f921a (submodule: decouple url and submodule interest, 2017-03-17).

It's a feature, not a bug, IMO.

When starting out the journey to improve submodules, one of the major
principle was to not interfere with gitlinks too much, as they are used in
ways git cannot fathom (cf git-series storing patches in gitlink form).

And building on that: You asked for recursing into *submodules*, not
into *gitlinks*. And submodules in the new Git have stronger requirements
w.r.t. the gitmodules file. (You have to tell us exactly how you want your
submodule to be treated, and we do not want to half-ass guess around
the shortcomings of a user not telling us about the submodule)

> I also wasn't sure if this might be intentional. I.e., that we'd just
> consider gitlink entries which aren't even configured as not-submodules
> and ignore them.

I think this is what we want to do, and we should do it consistently.
The only downside for this is that more unintentional gitlinks may be
added to repositories as Git will be very good at ignoring them.

> I couldn't certainly see an argument for moving in that
> direction, but it is different than what we used to do. But I couldn't
> find anything in any of the commit messages that mentioned this either
> way, so I figured I'd punt and ask. :)

Yeah, yesterday we had a big discussion if we want to publish our
roadmap and long term vision (as a team, as a company, or as a
community?) This would help newcomers and outsiders to see where
e.g. submodules are headed and people could speak up early if we miss
their use case.

Thanks for asking,
Stefan

>
> -Peff
