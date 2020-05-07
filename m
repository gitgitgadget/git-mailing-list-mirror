Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10390C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF54207DD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nban3b3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGMrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGMrD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 08:47:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC5FC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 05:47:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so2020636plt.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VDqWldCcxM2O44+IrzGF6K5iNY4h1Uu88uEdSPSLeOU=;
        b=nban3b3SQ50mJSpkc9hE0l/PXCPJkvaLSSjmO+LscJIRj2Q8XG3RKMZOu9HlEeWcQe
         rbNDA1gTO1qDsZjYxDTT2IgPtWg1GXo1rsGyV+AguaM6ISIrjUAZFai0PIMpSzzusLE/
         Ta2flX0MjKMEAWizlCaBEPESJ+rJ0IkwpRKybqT8cWnAjHlBe2gBIh5XtWBHrb+udqbr
         h988bFhyANC7hAKzuULALTayLuETtBL/J437FWC988RKP8MFpl1aD0oQtYl8sKSzgBYx
         e4UBKg+QqjAAu0iXj9xwfxnT06oebH4qKaDQIU/A0CcwuC2TgOng3nsFfDD1Vn3ugBWF
         BIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VDqWldCcxM2O44+IrzGF6K5iNY4h1Uu88uEdSPSLeOU=;
        b=V75ev9fUNF7Z0W7UTGtKBNbejyP03WQI2whrsMg9q8RN39dt2NIjvEA6GtZvpaevQZ
         6+D1OOfOQ2Ao3g/GDeEaxx7xRDB5QTe2XyRgh+8LxJeiCOdcEYx1sQhDzhOATCB+Q812
         CwIbmQyiQ2FPC65lnggwk2sc+yk+vd0GUouAmrHldJE/T2xpcOjgyZDtJhJxCeDP6FjN
         dr0OKoD5lD4d4/wCZ/eN/eqp0NmtJLtCte56aHIUCNzRxSFHYVO85RlF/q7CZKB5WB92
         ehY34bRM4KkylDRrGBmwpbQTS2vDr30JL/RaaS6VgtCz2Arcvsh1K2TRON1tTqLlonAb
         mjHw==
X-Gm-Message-State: AGi0PuZOeuNfizt/1Xf3+WbcEySH/cqZi/5BowUEvA2kLxSLU2XEBXo9
        QD26Zzqj7YQerzHuhPhYitY=
X-Google-Smtp-Source: APiQypJ1+a7NACtulIgI22oakzbg+HnjI/FGplCcLEl7la5L+M5TOrfAqVZ6Rqhk5TcUbwKXQNmIJA==
X-Received: by 2002:a17:902:c282:: with SMTP id i2mr13017325pld.20.1588855622463;
        Thu, 07 May 2020 05:47:02 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id y24sm4681389pfn.211.2020.05.07.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:47:01 -0700 (PDT)
Date:   Thu, 7 May 2020 19:47:00 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507124700.GA1378@danh.dev>
References: <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <xmqqlfm69il6.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
 <20200507120102.GB32465@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507120102.GB32465@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-07 19:01:02+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2020-05-06 17:09:39+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > The idea is indeed very neat. I think we can do a bit better with resource
> > usage by not even bothering to check this branch out. Something along
> > those lines (sorry, I really would love to have the time to test this...):
> 
> While this can avoid the cost of checking out a whole branch (which
> can be mitigated by using an orphan branch with single file),
> 
> This still spins up an VM, and actions/github-script run (I think)
> nodejs, which is more resource intensive than git and sh script.
> Above statement maybe wrong, I'm not interacting much with nodejs.

I was wrong, actions/checkout is also using nodejs,
So, this actions/github-script actual reduces the total time for
fetching the file ref-whitelist/ref-blacklist/allow-ref

> >       - id: check-ref
> >         name: check whether CI is enabled for ref
> >         uses: actions/github-script@0.9.0
> >         with:
> >           script: |
> >             const req = {
> >               owner: context.repo.owner,
> >               repo: context.repo.repo,
> >               ref: "ci/config"
> >             };
> > 
> >             try {
> >               req.tree_sha = (await github.git.getRef(req)).data.object.sha;
> >               (await github.git.getTree(req))
> >               .tree.filter(e => e.path == 'ref-whitelist').map(e => {
> >                 req.file_sha = e.sha;
> >               });
> >               const list = Buffer.from((await github.git.getBlob(req)).data.content, 'base64').toString('UTF-8');
> >               core.setOutput('enabled', `\n${list}`.indexOf(`\n${{github.ref}}\n`) < 0 ? 'no' : 'yes');
> 
> And this `indexOf` will check if our ref (exact) matchs (full line)
> with some white-list list, which is very limited.
> So people couldn't match by some pattern (grep can work).
> 
> I haven't tested, but we may use part of above script to read a single
> file from a ref, and add another steps for "grep"/"sh"
> I'm not sure if that script will cost more resources than git-checkout
> or not. And is that solutions over-engineered?

But this point still hold, now, I think using part of above script to
read the file, and allow more custom logic in a separated steps maybe
better solutions.

-- 
Danh
