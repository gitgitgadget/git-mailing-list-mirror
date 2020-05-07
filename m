Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D0C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ECF2073A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXdsvDbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGMBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGMBG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 08:01:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D1C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 05:01:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so2727464pgb.7
        for <git@vger.kernel.org>; Thu, 07 May 2020 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKN4m3qaF3NBH5ckPFZcyBaSQMGUrgzHUrSTh7nIHVs=;
        b=fXdsvDbI94QBtf/d3WzCuXff8h8eiGnWkVjwFR2ja0JKCmi0/gPq+OCCbPZ/rP/O0l
         EFzq+I8khy5jxcqqU63mDlhKdDtOD6woRiz6QLFri9K3Rm5W/NFqvXGIsKgaf5BvBBwm
         tOrst832u3fSNqjOrHkGwLy0tKQvgGTRT6NXl3BnGFjl6VwsQQKYux8inOWAQhWgPpnT
         UN4GWC+dkvTVbTprYkzgj3WD14Xo92uBwCtarA6/qSIugdap/SV5CbVi+piiNwU+Piqu
         nqe52eoCWT8qJF74EGGKB54rhFlEKpKxwmize/cBgoL9JFjiK6nfpG+z4j+8oLyZ+7yh
         mrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKN4m3qaF3NBH5ckPFZcyBaSQMGUrgzHUrSTh7nIHVs=;
        b=TIs8BHIjn8YMQPH8PCp/YuNV6if3UYTpIpj+qgkQAybQJkBmK3lIXvPg6BiQZ+bV25
         7lDr+1/PSuHmCwj/RfvliOiyc/8BkP0qx0jsc9zBPhixbUk4TLzjbi+EP2FSYoQ0gWoy
         M/g07aylSHFnUgi2DjCSmrcj451iffG9WGQYUVacx2Yw1NMet++0TecUFxZ/HQHEG4jR
         jZ6txn1QK6Dqqg7zBA8jwvgRP6y74fHfwVQAlskY+4C2ZNKrIP7yWEsRD395TqQs6s3a
         gukQNH4uPttOC1H8S9h+koAiycBdYGzFc0FjyzOYX48XmPiam5A+Ae56kQdz36CGPzRH
         rdYw==
X-Gm-Message-State: AGi0PuYpm8a81eYs/5ifiJo3jqgoX9vTu1KV7xs6+i0PVeHR98fQG3rW
        qG5f1TOyqGeJ9MWqP7BWU8M=
X-Google-Smtp-Source: APiQypKPD+Nb0LBCAOPh1TyNjaLEhOIfG521fkaEQDlC3oCFPjz2d2QdJc7RXJyqEYZla1UkYuEWAQ==
X-Received: by 2002:aa7:97a6:: with SMTP id d6mr13397951pfq.92.1588852865919;
        Thu, 07 May 2020 05:01:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 71sm4798036pfw.111.2020.05.07.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:01:05 -0700 (PDT)
Date:   Thu, 7 May 2020 19:01:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507120102.GB32465@danh.dev>
References: <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <xmqqlfm69il6.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-06 17:09:39+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The idea is indeed very neat. I think we can do a bit better with resource
> usage by not even bothering to check this branch out. Something along
> those lines (sorry, I really would love to have the time to test this...):

While this can avoid the cost of checking out a whole branch (which
can be mitigated by using an orphan branch with single file),

This still spins up an VM, and actions/github-script run (I think)
nodejs, which is more resource intensive than git and sh script.
Above statement maybe wrong, I'm not interacting much with nodejs.

>       - id: check-ref
>         name: check whether CI is enabled for ref
>         uses: actions/github-script@0.9.0
>         with:
>           script: |
>             const req = {
>               owner: context.repo.owner,
>               repo: context.repo.repo,
>               ref: "ci/config"
>             };
> 
>             try {
>               req.tree_sha = (await github.git.getRef(req)).data.object.sha;
>               (await github.git.getTree(req))
>               .tree.filter(e => e.path == 'ref-whitelist').map(e => {
>                 req.file_sha = e.sha;
>               });
>               const list = Buffer.from((await github.git.getBlob(req)).data.content, 'base64').toString('UTF-8');
>               core.setOutput('enabled', `\n${list}`.indexOf(`\n${{github.ref}}\n`) < 0 ? 'no' : 'yes');

And this `indexOf` will check if our ref (exact) matchs (full line)
with some white-list list, which is very limited.
So people couldn't match by some pattern (grep can work).

I haven't tested, but we may use part of above script to read a single
file from a ref, and add another steps for "grep"/"sh"
I'm not sure if that script will cost more resources than git-checkout
or not. And is that solutions over-engineered?

-- 
Danh
