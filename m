Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0991DC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B9F61213
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKDQeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhKDQef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 12:34:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A4DC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 09:31:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso7654465wmd.4
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETTy+B61XH+vw/bTujAQn6xfI1XesnosXtLCsApVCGs=;
        b=VE1XhPiINKBjNNZPXi84HA50H0ch5I91teWJvQbHUtoukfVq+JEK151foNFL+Gt2YH
         s+Qmur0bLZROhR6+K3L8xwu14rNlinvt4kJpu1trM+nRQW9bRnYrQCnrsvFEpukX71hX
         sqKJqZFpqHiT3PN0mVa9rgU8YOUo4w979PIlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETTy+B61XH+vw/bTujAQn6xfI1XesnosXtLCsApVCGs=;
        b=S+oc4HcaCP4Mdu7od9/JhoA6/rZvlwQFMwxYW9S1ei4SVw5MFA0sGphRSuDad/6rhh
         PEWw0Yl8S0/57gVGPxYsJGni92SJ1l28TrW2Hu40KzyqVROR5gQyI+aZdkCVM/VnDNfb
         Oe1Mmm38huDYsCy2N0BN3oN1mE/qaql0jXv60tmyKPgSnHD0DjdLww67TvW61H2DxTGF
         Vve0bXkKZo/nnbc3yI8NmQ6If0qii1IeO3mVaQFJ979FKQEdqFmj449670aCJnB+qN94
         9NLMf/cHtBFFlOkpKeaqWVpcJ7tEXCNbEGObSTmfwyN3N2hSWTvenP7eMz5hMRHoNVeg
         lLxQ==
X-Gm-Message-State: AOAM532mZTRziu3Xf3mEaZuFA/Bx23Pq6v1OKXpq8Uz3ahrHF+OBmxgn
        /+qy1hb9XS1uSjEfhzp9reBzDw==
X-Google-Smtp-Source: ABdhPJwo7JkdieJ9Os62bZYfj5vINZbgWNOyUYFdH/liCL7gSKLEj8fUHw8OwsipdKIwY4N2B1D7Dw==
X-Received: by 2002:a7b:cc1a:: with SMTP id f26mr24150178wmh.39.1636043515794;
        Thu, 04 Nov 2021 09:31:55 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id h17sm5652268wrp.34.2021.11.04.09.31.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Nov 2021 09:31:55 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:31:42 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] ssh signing: verify key lifetime
Message-ID: <20211104163142.GA1419@dinwoodie.org>
References: <20211027080616.619956-1-fs@gigacodes.de>
 <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
 <20211103194558.xqcsaljvcoontnal@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103194558.xqcsaljvcoontnal@fs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 November 2021 at 08:45 pm +0100, Fabian Stelzer wrote:
> On 03.11.2021 19:27, Adam Dinwoodie wrote:
> > On Wed, 27 Oct 2021 at 09:06, Fabian Stelzer <fs@gigacodes.de> wrote:
> > > This series adds key lifetime validity checks by parsing commit/tag
> > > dates from the paylod and passing them to the ssh-keygen operations.
> > > 
> > > changes since v1:
> > >  - struct signature_check is now used to input payload data into
> > >    check_function
> > >  - payload metadata parsing is completely internal to check_signature.
> > >    the caller only need to set the payload type in the sigc struct
> > >  - small nits and readability fixes
> > >  - removed payload_signer parameter. since we now use the struct we can extend
> > >    this later.
> > > 
> > As part of testing v2.34-rc0 on Cygwin, I've found this patch series
> > is breaking t4202, t5534, and t6200.
> > 
> > Specifically, bisecting points to f265f2d630 (ssh signing: tests for
> > logs, tags & push certs, 2021-09-10) as breaking t4202 and t5534,
> > while responsibility for t6200 seems to be 9d12546de9 (ssh signing:
> > fmt-merge-msg tests & config parse, 2021-10-12).
> > 
> > I've not yet done any investigation into the specifics of these
> > failures, but I wanted to report them early so other folks could get
> > on with investigating as appropriate.
> 
> What exactly are you testing?

I was initially running the tests using the Cygwin packaging
paraphernalia, as I want to check the full build infrastructure is
working as expected.  When this failed, I reproduced the problems on a
clean checkout of the main Git repository.  In particular, I identified
the failing commits with the following bisect command (subject to
obvious modifications to select the correct script):

     git bisect start v2.34.0-rc0 v2.33.1 && git bisect run bash -c 'make -j 20 || exit 125; cd t || exit 125; ./t4202-*.sh'

> This patch series is not patch of the rc
> and will not be in v2.34. I even have a small reroll of this for after
> the release.

That's odd. `git tag --contains 9d12546de9`, with a fresh pull of the
Git repo, lists v2.34.0-rc0 and v2.34.0-rc1.  It sounds like that's not
expected?

> I assume the breaking tests are the new ones added in these commits.

For t4202-log.sh, the failing tests are "72 - setup sshkey signed
branch" and "75 - log ssh key fingerprint".

For t5534-push-signed.sh, the failing tests are "8 - ssh signed push
sends push certificate" and "12 - fail without key and heed
user.signingkey ssh".

For t6200-fmt-merge-msg.sh, the failing tests are "3 - created ssh
signed commit and tag", "7 - message for merging local tag signed by
good ssh key" and "8 - message for merging local tag signed by unknown
ssh key".

> What openssh version are you using? (ssh -V)

    OpenSSH_8.8p1, OpenSSL 1.1.1l  24 Aug 2021

> Either the feature detecion for the lifetime checks is not
> working in cygwin or maybe you have the broken openssh 8.7 version.
