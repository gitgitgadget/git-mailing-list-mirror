Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D9C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341596144D
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhD2Wj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhD2Wj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 18:39:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF649C06138C
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 15:39:08 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso40340604otl.0
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uNuzpbXvz2cTQz3HsiLiwnH0icw9EeSdCuPEiHmpIQ=;
        b=C33hqXkT0/yDyDdoE8zHh6l0OIJIpSdFfn8NO3nIoxUBEx5r8NJ2SdM4EXFYJX95yQ
         KCKssgE1V2nf34N6NhvxDg5z0RwOtVhnaJTkvnRnRsbEqfMqwlNi0HCFGLy334oTaSUa
         xr4nbiWRMq/4qk6ABSZEHyG3kmQrK7ASif0PKWRf7EQkhYR/0kwtiM9slH1meXuqX7tn
         W7QlUldbvLSjgI7EzAC/XUyI5bY70OkoEj3mREYJyCl0HuJRkSc0m7SXtJSiiJ6JJn9T
         +pz83KTVY2n1nFq7NuD53qm19+W25SbOa6Wa982XSvkOZpvF7Cp+MRnhn8tkM0RkPwRD
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uNuzpbXvz2cTQz3HsiLiwnH0icw9EeSdCuPEiHmpIQ=;
        b=rPknDUCefRjpXrTBuZ83JYMdJ8gAdnZSdV/McB3yqNn5u0lQ6vpLJZFzazlRgjrrHe
         Cb3dki+nUubLELzsKsBJ8+6tXTMuu7N3rfRay8vu4am/sNyXcYWGTa9gRLPh6UrXuiCR
         ThQUBa/fS0dqK3iNpp2dhzPEZ0cPY+kYFXKRwOgRrC5Ptj8y80eKSdAzNQeFQL+l2JWe
         XABITwuyE8vgN0K0nAt4BLUof/S+Vaq/QH7ZDve0wzonDAhPTkORhN/4iPNG4Uq/ncVh
         J8C7x/DTHuWp2we95jCrDfwR2WTl/O4VpKfYvgoiaAibMt1DoDdCk0k2JyLbpVsExdOM
         9VYw==
X-Gm-Message-State: AOAM533El+3aML/rgP4ex/oT4yLuNU+Fd+3NgDaXlU2IGprG3jMrbOMJ
        1pu/vwjIbls9O9gqV29f5TS+GQ/nt4p+tYr2aGA=
X-Google-Smtp-Source: ABdhPJxS1DN/iGc08w93sXnaV5ubkiyYRrJi4OFD4/2jB8x8z9S+wgQphAmXHKQXVmKaRffxcxYNxh/ek+o04JYlrMA=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr1312781otf.316.1619735948215;
 Thu, 29 Apr 2021 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210422002749.2413359-1-lukeshu@lukeshu.com> <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210423164118.693197-4-lukeshu@lukeshu.com> <xmqqfszbcazc.fsf@gitster.g> <87o8dwq2hv.wl-lukeshu@lukeshu.com>
In-Reply-To: <87o8dwq2hv.wl-lukeshu@lukeshu.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Apr 2021 15:38:57 -0700
Message-ID: <CABPp-BHhfT3b=UyWOXACrBb6nw86n74thNAx7DUDF0YNOcA-yA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 1:06 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
>
> On Tue, 27 Apr 2021 22:02:47 -0600,
> Junio C Hamano wrote:
> >
> > Luke Shumaker <lukeshu@lukeshu.com> writes:
> >

> > > +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > > +   Specify how to handle signed commits.  Behaves exactly as
> > > +   --signed-tags (but for commits), except that the default is
> > > +   'warn-strip' rather than 'abort'.
> >
> > Why deliberate inconsistency?  I am not sure "historically we did a
> > wrong thing" is a good reason (if we view that silently stripping
> > was a disservice to the users, aborting would be a bugfix).
>
> I *almost* agree.  I agree in principle, but disagree in practice
> because I know that it would break a bunch of existing tooling,
> including git-filter-repo.

I understand that fast-export's behavior in the past matched what
--signed-commits=warn-strip would now do, and thus you wanted to
select it for backward compatibility.  But throwing an error and
making the user choose when they are potentially losing data seems
like a safer choice to me.

I do get that we might have to use warn-strip as the default anyway
just because some existing tools might rely on it, but do you have any
examples outside of git-filter-repo?  Given the filter-repo bug
reports I've gotten with users being surprised at commit signatures
being stripped (despite the fact that this is documented -- users
don't always read the documentation), I'd argue that changing to
--signed-commits=abort as the default is probably a good bugfix for
both fast-export and for filter-repo.

Clearly, it'd probably make sense for filter-repo to also add an
option for the user to select to: (0) abort if commit signatures are
found, (1) strip commit signatures, (2) retain commit signatures even
if they are invalid, or (3) only retain commit signatures if they are
valid.  In the past, we could only reasonably do (1).  Your series
makes (0) and (2) possible.  More work in fast-import would be needed
to make (3) a possibility, so I wouldn't be able to add it to
filter-repo yet, but I could add the other options.
