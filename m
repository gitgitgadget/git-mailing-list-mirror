Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCABC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E01961452
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhDVFAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhDVFAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 01:00:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 21:59:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g9so27376930wrx.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w9V6WaK/Sac1AEjrLTdBQQqPFTpOBvLRpxS9lR8ML08=;
        b=gR8QLz52B0VOeg0vPwFqjqFLsrZpEUW7C1Vipp/7PDy7g+j9gFTeRxI84j9+Q1W4s6
         iiitqWREsGPbhL0S2clzYjq4fT0IEZbum50A1873fqbI5jIU+kr5RUrcFVDwHeiObl8H
         JxFbR2fAcAEVQ8lyAOlzEcqJja9FixRgWwAYlX3JGms+grHSmNyi4L/aPhF820Xk1LHp
         cy8OMKaFg5JhqV7prc87icCFqtmqVW6Qxerj1aBvDYnm7wAIsGAgiNqIQGv2eejjfrgW
         WtFbPLi4IO3UF/6i+kyrLg5VES9sMiSbWN43D0XZttOklegk7gQjVTGKg16nCPu4CDgj
         BkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w9V6WaK/Sac1AEjrLTdBQQqPFTpOBvLRpxS9lR8ML08=;
        b=Uiv4Xr4AS62xq/1t1rPIRslPN+oGE+XHPcVE9AmG6TsQNu+SAe64v/ifD7EeZEknyd
         hjYCQrbQ46xr4EY8F8/wAaqUtUNGmpg4PhrkHaaNvSt+3xK0FQbjYc3HFHzodGc6JEj9
         HzWRMkvzZHh2LpGQjMOU3LrkxyrBg5b6ti66PK9t8ci4/PXzOzzDKYYZtxDwkmy2tKeO
         p74UNhDFqA37TSGELkKGYUmEpADl0bduKXgMHlDU0/aBWSC8oJyKhd4A9c1xyJA2yQMX
         K3vRhRF1PYeYTLTqT6Ax77GwIn/sH2Orhz8uhNw4UhfhQFoVZ/CgJHTz2DaMrVMMr0Wp
         YfuQ==
X-Gm-Message-State: AOAM531JLXuZQP2brlZoksqjc5Z/fwBf4TlrGxj2SwCevOAwg/xgovXh
        7ICX3kLLcYOw20j2029DOhxASqqnQfY=
X-Google-Smtp-Source: ABdhPJzmNtgv/7/ETEPceg++R8o43pKfJ6j/bnTuf9XaFyiHznsY/02vPVqonmBTLbRql5zYZOuEyA==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr1570701wrp.231.1619067595689;
        Wed, 21 Apr 2021 21:59:55 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id r24sm4334262wmh.8.2021.04.21.21.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 21:59:55 -0700 (PDT)
Date:   Thu, 22 Apr 2021 06:59:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
Message-ID: <20210422045953.GC2947267@szeder.dev>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com>
 <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 11:09:07AM +0200, Han-Wen Nienhuys wrote:
> > > diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> > > index a4ebb0b65fec..fd5980d3fb40 100755
> > > --- a/t/t1401-symbolic-ref.sh
> > > +++ b/t/t1401-symbolic-ref.sh
> > > @@ -7,18 +7,13 @@ test_description='basic symbolic-ref tests'
> > >  # the git repo, meaning that further tests will operate on
> > >  # the surrounding git repo instead of the trash directory.
> > >  reset_to_sane() {
> > > -     echo ref: refs/heads/foo >.git/HEAD
> > > +     git --git-dir .git symbolic-ref HEAD refs/heads/foo
> >
> > Isn't that "--git-dir .git" entirely redundant?
> 
> See the comment above the changed line: we don't want auto-detection
> to clobber the surrounding git repo.

Indeed, but then this is not a faithful conversion of the original.
That 'echo' will write sane content to HEAD no matter what state the
repository is in.  That 'symbolic-ref' command, however, won't,
because 'git --git-dir .git' turns off only repository discovery, but
not repository verification, and in case of a corrupt '.git/HEAD' it
will bail out.

  $ cd test
  $ git init 
  Initialized empty Git repository in /home/szeder/src/git/test/.git/
  $ git commit --allow-empty -m initial
  [master (root-commit) ec0df0b] initial
  $ echo "foo bar baz" >.git/HEAD
  $ git --git-dir .git symbolic-ref HEAD refs/heads/master
  fatal: not a git repository: '.git'


