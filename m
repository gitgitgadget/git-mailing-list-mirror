Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A66C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAE760EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhKBPwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhKBPwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:52:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5272BC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:49:48 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i12so16164566ila.12
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VLni4pg454iEnrvi7NghHmz88CbOhPKXXhByasU+vXs=;
        b=ghbuRHAuD3xv9be/gg0KAET2NZ3fCg3yOt6ndYmDXkRFIGie8X1fCB7sxqD3RaNEl+
         Ydomj+jOEfheJ2lINTuk2JXkOedl5c/ZNfYDunyXB1wvwxnSypIgrv/6dZgYEi3w8Fmh
         RaID1lO1BIYCS8gQ6U8OI56A9mWwDCozbuRVHmH6FjHHdikUmvGCmNc3gzXYwqkSv7QC
         NcDfVkqtc1iRTWQtcrTkl5NM5K5N9CVIWtux7jObjouppEyhE3OVSbIvkFVKtEdu9lOp
         +fV5qDluzJUKtXNR8TsPwM2+1bVVz/5dVhMQlWyb91HZLN/tllFWpbWc8r6FPpuwcwY1
         5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VLni4pg454iEnrvi7NghHmz88CbOhPKXXhByasU+vXs=;
        b=0hX/102Ubmrm8gqr6uBX48QxkHYRP8iZtRPY2/bZ3gjY6W0WZ2F/JKDop7O49+bxFN
         ZRBPlxCpIbeZ+l9J7u/CincixaRKQBNAJRCVRtKB0ByKxrAPpZfg/xzB+SuBIant+Sxs
         L8ppS94RhdRmXnzX0XIRoctAAGExndP8v33DYK3LL8X7jpSFplbTKkRDyO9BfInB7uYy
         kAdAZscaR2AkSF5Sf28WsWVZ1UCLxgTe1MlxVxN+JLgOewvBhsTgHlrFQLzf+MurfWNc
         rQ3Ht1iXOFDfWy5JqwudxBBd3LIBER6qBibqAhi2E5c8rt1OAZe9E2DtHBYl4foKJPtY
         aeJQ==
X-Gm-Message-State: AOAM532ElbKobM6K/IVvU7/dRu4HwzrRCxccpTgclDxTYloEDU7kLSIU
        coo3JnX/WAE7ohvSF2JNY7C2/Q==
X-Google-Smtp-Source: ABdhPJw7999vG/vUY06bKB0yrNjQkQyRsnIK1dPF19m6nLixpOHHXIOVc8lQKYIqmSt91R38PvNXqQ==
X-Received: by 2002:a05:6e02:158c:: with SMTP id m12mr25604271ilu.132.1635868187756;
        Tue, 02 Nov 2021 08:49:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q7sm10648583ilv.48.2021.11.02.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:48:15 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:48:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: disallow directional formatting
Message-ID: <YYFdu/+j8ba+hjCF@nand.local>
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
 <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 04:01:57PM +0100, Ævar Arnfjörð Bjarmason wrote:
> There's a parallel discussion about doing something to detect this in
> "git am", which for the git project seems like a better place to put
> this.

I don't think that one impacts the other necessarily. Having `git am`
guard against this would probably be sufficient to protect Junio
accidentally apply something containing directional formatting to his
tree unknowingly.

But the idea that we rely on the import mechanism to protect against
this doesn't sit well with me. Ultimately, we should be relying on a
static check like below to ensure that directional formatting hasn't
entered the tree by any mechanism (not just 'git am').

> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 6ed6a9e8076..7b4b4df03c3 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -289,6 +289,13 @@ jobs:
> >      - uses: actions/checkout@v2
> >      - run: ci/install-dependencies.sh
> >      - run: ci/run-static-analysis.sh
> > +    - name: disallow Unicode directional formatting
> > +      run: |
> > +        # Use UTF-8-aware `printf` to feed a byte pattern to non-UTF-8-aware `git grep`
> > +        # (Ubuntu's `git grep` is compiled without support for libpcre, otherwise we
> > +        # could use `git grep -P` with the `\u` syntax).
> > +        ! LANG=C git grep -Il "$(LANG=C.UTF-8 printf \
> > +          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\|\u2067\\|\u2068\\|\u2069\\)')"
> >    sparse:
> >      needs: ci-config
> >      if: needs.ci-config.outputs.enabled == 'yes'
> >
> > base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
>
> It would be easier to maintain this if were added to
> ci/run-static-analysis.sh instead, where we have some similar tests, and
> if it lives there we could do away with the double-escaping, then it can
> also be run manually.
>
> Also, can't we just pipe "git ls-files -z" into "perl -0ne" here and use
> its unconditional support for e.g. unicode properties in regexes.

I agree that the double-escaping is ugly. I think that this would be
easier to maintain if it lived in ci/run-static-analysis.sh or its own
script like ci/check-directional-formatting.sh.

And yes, constructing a byte pattern is a little odd as well, but I
think that it's the best you can do if you're limited to running 'git
grep' without libpcre. I wondered if we could depend on perl being
around during CI, but as far as I know we can since install Perl modules
in ci/install-dependencies.sh and use Perl extensively through the test
suite.

Thanks,
Taylor
