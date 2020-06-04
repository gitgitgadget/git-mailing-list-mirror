Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C998C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB0B206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T15yvdl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFDHJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDHJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:09:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C0C05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:09:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p30so3037082pgl.11
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HG5tt1Es22AJjiqZTeLCuPK03f7BnC8mn0qGT3UTaiU=;
        b=T15yvdl+9yGwnOCd4dZs7V0fhbu7Agva/oinP5EqHVHu0uKCXZlRbI/J7111w2mO3i
         iiJ3MTjhovVKfmoG1P+9JWzAk+4T5vMd8hOgmTeGIWuhw+wjNHDgCkV8B4VN+fg8Days
         Ev0V/9UCnJVrTiRoNhNx4tNpGIV3cmqXWCiliWsNbCMS4u0tJoNZZBMRlgNeC8PZxqSu
         mQhnWn0ZN/jQbtjtsFPo+ymPWzlQdpc9tliBRMwG0hTM7XJaUlaFjZ9Vos+3VKXzn7NH
         D547cnSUEURI/6RBrtrI/+w0Wu+rKA/zFjjCgDOiBlcooXtZc+ZxWEdqZH60mnflE7eC
         e+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HG5tt1Es22AJjiqZTeLCuPK03f7BnC8mn0qGT3UTaiU=;
        b=G6gKvme9ywhzazHLQkY7BI2h7fVYhMLKwKHwNFPamdyD5s/d8MW0NGlzpVXbd98Bm0
         ug6kbh8TN0rsXUSgEZzSmanrVNqr3xnBUH9xiRCivTcBJfQCQy4Uu2vqj2mY9Xl94CBX
         IXAQ6uJMw9y49Lsm98EJCsvzQFwXyZm21lltzR/hHrCY/fVyXNZnT63n2qDAzwvkBOjw
         1wfbseNubZKP6/v7SLws8xijPqCWSuCHedQZklr+lUlWTRw+IwKK523rDgw1DbU1CoDJ
         zn60XH2eyGaVMsgryG91+3zCakpTLkTdh3408gLjtwzBmumi5elm0KprkzwcwtA7DICt
         yP8g==
X-Gm-Message-State: AOAM5320g52G1TeRk6BXojbNTm9MGvzudGZTK3F6pFcK/mEfxZbHOhyt
        WHIuPEuJ98bMY7kzAUsNEjA=
X-Google-Smtp-Source: ABdhPJxgprztvCdTQr2c7vD4bFNS6Glq7qE0Xe1TPEKvqzzorIV0/h5NRCjL/A4nyutWvA0iCIgRkg==
X-Received: by 2002:a62:1885:: with SMTP id 127mr2934283pfy.258.1591254577700;
        Thu, 04 Jun 2020 00:09:37 -0700 (PDT)
Received: from konoha ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id nl11sm1375844pjb.0.2020.06.04.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:09:36 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:39:30 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, gitster@pobox.com, liu.denton@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
Message-ID: <20200604070930.GB8686@konoha>
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com>
 <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
 <CAP8UFD3Qe3iDe+ymKsqv9HarFLYDohXmUGbkNwZ4MdVQ=XP7yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Qe3iDe+ymKsqv9HarFLYDohXmUGbkNwZ4MdVQ=XP7yQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06 09:45, Christian Couder wrote:
> >
> > I'm having second thoughts about my suggestion[1] to include
> > the short option for '--quiet' in the usage. This is the only
> > usage in submodule--helper that mentions that '-q' is a short
> > hand for '--quiet'. That seems inconsistent. I see two ways but
> > I'm not sure which one of these would be better:
> >
> > A. Dropping the mention of '-q' in this usage thus making it consistent
> >     with the other usages printed by submodule--helper.
> >
> > B. Fixing other usages of submodule--helper to mention that '-q' is
> >     shorthand for quiet. This has the benefit of properly advertising
> >     the shorthand.
> >
> > C. Just ignore this?
> 
> The `git submodule` documentation has:
> 
> -q::
> --quiet::
>         Only print error messages.
> 
> even though the Synopsis is:
> 
> 'git submodule' [--quiet] [--cached]
> 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
> 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
> ...
> 
> So I prefer B, and maybe updating the synopsis, as I think most Git
> commands have '-q' meaning '--quiet'.

Yep, (B) sounds good! Junio in one of the previous mails stated that
this thing will need to be done for all subcommands when the shell
script is to be demolished i.e., `git submodule` becomes a builtin
completely. Actually, vrious usages might need to be fixed, for many
subcommands because almost none of them have any info about the
shorthand usages of options in their `options` array.

