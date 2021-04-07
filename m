Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14884C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD957601FE
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355148AbhDGSSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344500AbhDGSSy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 14:18:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE87C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 11:18:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a6so12956229wrw.8
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkUwQZjGJwM0d9gpemFaCV1Ol7z7oTp3gBzNo8HS2gI=;
        b=tJAT5uo35joMmy9LEq0j6ZHeW4KCWYZW1JHuMSlt5TXB+rDiIon1IvJz/mk7Z0OJUc
         XLOvfHwZ0ViXtVSLoL3q+yiAr+g/OUNzeY6UhQu2E4lguwUeYQbBpmiCs/fMFjoW7fdr
         1zzgOwYev7DzjfK/IVRszvCg6EuFkdJZKPMJ98ROkJIwgwCY8mqz2ZRvjvnEA7yNh9a7
         /8EohN5csf1v3+kZ54EnJLRmieg1FFXStKSslHMzQM/r9emKnCPaFtXmy64vH9bvB8Oh
         yTuoN9/VZgo4i4pRcCZughUl62SYgpO4yrDMHOQbPJGp26Sta9FAl/LIadlGSYAYNywn
         cB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkUwQZjGJwM0d9gpemFaCV1Ol7z7oTp3gBzNo8HS2gI=;
        b=Eo940mn1GYvq7kLFtJdtiGh22W0rsm3DrrTJw9OM3LhLmsx/H7mDLFSDPj+XsG65/u
         cByMTSFSjqLraSWqqRvPEKnTaxWaUPKIcHfub5f+UmH2DiLTdzBjzd5wXuANG7AAFXlK
         HXES9nDypogjtHTlnUkFiR2juKFw0CKYWBg3tx873+Eh3KVotbSMoUoY2hUgi4oh6gSb
         7A8rkYrqNfcC6Br2bWhQPCJoc7ntsI3VpUmMVsLh9WssKrDYsqMf/xkFSzscW4idw5tI
         GPCR9ITB7d7WiSBsaKgSBTdVzNuTFHGiAeG52M3SDlE8T3jPG5y7Bgp6iJCzH7T1s/Zg
         097Q==
X-Gm-Message-State: AOAM532T+Kaxzf2wha6Ltr38atMXGoayXb3Xap1JLv/hRKilXCQsoTNu
        6CuhngJkkiP1Uv4AemolHNQ1wCZhFdLRKS/53FYykHKu5khSHQ==
X-Google-Smtp-Source: ABdhPJzpn+ipqYHdApc7WOc21FduJM9eOC4Kmp15mr8ealBpHT9vI2IFPXlfU7We4p369WwVDnU/hjW7UofHg6Ggcd8=
X-Received: by 2002:adf:f60d:: with SMTP id t13mr5784053wrp.86.1617819522494;
 Wed, 07 Apr 2021 11:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJxd1DPcCD96NSqzXvh3cgA93d1nCNFQbFWduTCqfx1zi_1o=w@mail.gmail.com>
 <YGEMMyAYVlzgv79G@meme-cluster>
In-Reply-To: <YGEMMyAYVlzgv79G@meme-cluster>
From:   ama bamo <pythoncontrol@gmail.com>
Date:   Wed, 7 Apr 2021 20:18:31 +0200
Message-ID: <CAJxd1DNB=OGgNkLHg=2TpQxgWKp1dTcg5vvFXG7+2MS0KyXjJA@mail.gmail.com>
Subject: Re: exporting git commands in parsable format for constructing
 language-specific API for git CLI
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Santiago!

Sorry for not being more specific - it's my first time in such a mailing list.

libgit2 and it's language-specific API looks interesting but
its not the solution to the problem i am trying to solve.

I believe that git CLI is the most stable,reliable and tested way
of actually using git. Most of the tools using git that i know
are actually using your underlying git cli binary - not the bindings.

By following the definition of CLI and API; the CLI is human readable
while the API is machine readable. If we were able to expose CLI
in a machine-readable format then would it be an API?


On Mon, Mar 29, 2021 at 1:07 AM Santiago Torres Arias <santiago@nyu.edu> wrote:
>
> On Sat, Mar 27, 2021 at 01:42:09AM +0100, ama bamo wrote:
> > While using git commands in my applications and reimplementing the
> > same stuff i found out i can just parse git docs then generate
> > structures and classes based on that; i have done similiar for
> > wordpress and its `wp-cli`, for example see:
> > https://github.com/bukowa/gowpcli/tree/master/generated
> >
> > But `wp-cli` allows exporting all of the commands in a json format,
> > see: https://github.com/bukowa/gowpcli/blob/master/generate/dump.json
>
> I'm not entirely sure if something like this exists in git, and I'm
> alsot unsure of what exactly is the benefit of doing so vs an actual API
> (e.g., git2go[1]). Could you help us by elaborating what this is meant to
> achieve? Maybe that way we can figure out if something exists...
>
> Cheers!
> -Santiago
>
> [1] https://github.com/libgit2/git2go
