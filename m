Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06CC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5684A2396E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxSZ42pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIXKq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXKq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:46:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EDFC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:46:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z23so3737658ejr.13
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9v4MxBG0nIcEZVN0ENK2ea/EeEsH2SIdvlTT+WBDPoo=;
        b=TxSZ42pi3kLT0UmWbBxkYkGNREqgowVetebAB5OkXa6RHJCWUGIV4rWlyVcqYis7bD
         IjbBbnrOrzxZuZGm7V6b3S9B/JwEAn41q9sOlmMztNcz1pSc1Tx4DOwbQVx8kCf7SLLz
         rhwtjhD4rnSkl37r4wAoJ7rXhd9+sFM6C2EpStLuuRi9Rh2otGy/0adpBQ0t7prk7ce9
         r1HuTO1/4xJO8FgNkqTBZgx5vuz4PRpUlHXgfx/L1JfsYpIxP1hCu4/SksOvj8hIO9jj
         THcqgW0OJDzIJaJU6GrwKlq1Tw6bVCVBrTdiJFAHy/9czc+KCoEJzdHMCg7876irpvFn
         F0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9v4MxBG0nIcEZVN0ENK2ea/EeEsH2SIdvlTT+WBDPoo=;
        b=PDWSkp1vE7QZxquBY1x9pHuNBM8yGRvQZuXMsQhfuA+6iTOVRWFJSaaj0xweTgic9h
         gDuofoIw8JiNvCZmSarSzuAteB20MNdFg6NV27+gWeYgogZGB2TjLIEYYtkv9ZDvBTVk
         xQMK2dJFhP8Mod9eGCrRs+WJAckr+C2KDi9icPD4HNYTdL9aD+iTFw6PuXFz6B6TY6q3
         oM3pCFELoNSlG/fxdA97hx/OUpf/dA5IqsIl6KtI0x4gpKGIg7i/jUFafiHh9zsHzs2/
         N20nhoiqws0JFIMhHzi4VEcehU9OmxWDfxXIjYAjASTmbTxMGO76zyimuPko/u7UFEsc
         tR7w==
X-Gm-Message-State: AOAM530YNgoZbq/THWvE44qHDuIJTF+O01S8R/56tr6X8bzG6CJN7mHW
        yZecC07c3kUhGLlifI97XSUMM0Qv64yf3tW/INA=
X-Google-Smtp-Source: ABdhPJy/eGZi9d2L1ug1TRzFyYC9cJotc/4Z0+xgePYgmpFxzh2khZTtme9wYCa5PnyBW6EQIvZJAFMcmL/SjymLC8M=
X-Received: by 2002:a17:906:3791:: with SMTP id n17mr336828ejc.216.1600944387525;
 Thu, 24 Sep 2020 03:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
 <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
 <CAP8UFD1fXBChG3691HrKmbN-4vThCE7=0bL+Ty8-u4FFGTn2tQ@mail.gmail.com> <nycvar.QRO.7.76.6.2009240952300.5061@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009240952300.5061@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Sep 2020 12:46:16 +0200
Message-ID: <CAP8UFD3rLTLkbq+gYPSD3dmGituWr1g8ZtQDQmPYDdEBtHkU0Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 24, 2020 at 12:06 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Thu, 24 Sep 2020, Christian Couder wrote:
>
> > On Wed, Sep 23, 2020 at 11:26 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:

> > > Instead, those `eval` calls are required because the arguments are
> > > provided in quoted form. For example, during the execution of t6030.68,
> > > the `eval` would expand the call
> > >
> > >         eval "git bisect--helper --bisect-start $rev $tail"
> > >
> > > to
> > >
> > >         git bisect--helper --bisect-start '--term-old' 'term2' '--term-new' 'term1'
> >
> > Yeah, that was also what I found (along with the bug I sent a patch for).
>
> I suspected that you had found that out, but I really wanted a record on
> the Git mailing list about our findings.
>
> It might be a good idea to add a paragraph to the respective patches,
> along these lines:
>
>         Note that the `eval` in the changed line of `git-bisect.sh` cannot be
>         dropped: it is necessary because the `rev` and the `tail`
>         variables may contain multiple, quoted arguments that need to be
>         passed to `bisect--helper` (without the quotes, naturally).

Yeah, sure. Hopefully Miriam will send this in the commit message of
the right patch which is in the subset of the patch series she hasn't
sent.

> > > Therefore, the `eval` really needs to stay in place (also the other `eval`
> > > I had originally suggested to remove, for the same reason).
> > >
> > > I would still recommend appending `|| exit`, even if it just so happens
> > > that we will eventually abort when the `bisect--helper` command failed
> > > anyway, because the next command will then fail, and abort. But it's
> > > cleaner to abort already when this invocation failed rather than relying
> > > on that side effect.
> >
> > Yeah, I think it's a good solution.
>
> Excellent. I think we can actually move forward with the entire patch
> series now, not just the first subset, right?

Yeah, I think so too.

Thanks,
Christian.
