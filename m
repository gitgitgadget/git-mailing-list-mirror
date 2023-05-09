Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B9C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEIBDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIBDc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:03:32 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378DE7D
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:03:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-195ee1be41aso2011932fac.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594208; x=1686186208;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWYPXHpZGgrNSC0B1/pjAyhWicpIT1aWYoD2AtHFr0o=;
        b=kzYavD8QxZD2tLPvUvuAZJEems+l3f8RrGNWbs0yQyEQJi751XmKhBF6/ursDOcLiC
         64in9SiDtsmg25DbwVNaWN7Btdto9LNS3q9LouO/MY2beop1dXijHBH2ms3YLPb1yAmu
         n+rcx4FqpElNVwXEbJ0I3wu+IsuLBnaxgY9wQrdLroCcuU3NCRcX81EsTeh2jaGGEQUb
         l8pclncXAnV4gLyCgfw5u9/yJjD0IZ+IVkpkOHNuu3RGgMUl/FG6f0WYDuqSQM2+gA8d
         3UedNywNsza72eFgTRdEHlA3gSh/kW6mcYqvf03FLt0UwBEUiG1P2uI2I4w8OuTR5HEx
         Lunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594208; x=1686186208;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWYPXHpZGgrNSC0B1/pjAyhWicpIT1aWYoD2AtHFr0o=;
        b=fzN2xjnzS8yi86Ul3z906qzyU2w6fnzPy8RytoNctapZF/ZaG2jGvLmrrSTH/bNZ3F
         lESFe56kqWyUr5ULGNBmYvB0CdXdpmCHL4DDP8wFx14obMhDWtlT0SRzI37IMA+L901Y
         8rMXWG3ok7fK6UAR5KlRyoGyYiEeZgTVOXrUwAYWaC8l6Byn5T2k18cyNyJq+vp4vshn
         e1xOtC49LFOIhB+aUmg1LQXWQkBKVaALzgLVYVJREnWaRnJYITUslokljEZdGMlEI7pY
         yFHGx5owp8b/aSKpm8CPBCwDKKvTd4nQy4s9G4wmNk6HMpBVN1MuDZeVGJRQrwC3Ng0s
         HCBA==
X-Gm-Message-State: AC+VfDyrcrzsdoPWtp0wq/2bDOa0n4izxoovCvy683jEz4Lpy2JJDl4K
        TyWMOrSH438vegHm/n56IAi80zUQHkw=
X-Google-Smtp-Source: ACHHUZ54DilxhuK6tDkLOVH3C0s1IWQJ8vTA2nWofRrrFljy81mL5UMghy7gmOfXqRhhJDdAy1IB3w==
X-Received: by 2002:a05:6870:7712:b0:18e:afcc:60bd with SMTP id dw18-20020a056870771200b0018eafcc60bdmr6941814oab.47.1683594208132;
        Mon, 08 May 2023 18:03:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y17-20020a056870381100b00187d06465edsm5523118oal.43.2023.05.08.18.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:03:27 -0700 (PDT)
Date:   Mon, 08 May 2023 19:03:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <64599bdee22b4_7c6829422@chronos.notmuch>
In-Reply-To: <xmqqttwskse5.fsf@gitster.g>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <874jote2zl.fsf@osv.gnss.ru>
 <xmqqmt2lqofb.fsf@gitster.g>
 <xmqqttwskse5.fsf@gitster.g>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Sergey Organov <sorganov@gmail.com> writes:
> >
> >> No problem from my side, but are you sure?
> >
> > Absolutely.
> >
> > I've seen people just say "we document a failed one" and leave it at
> > that, without attempting to fix.  I am trying to see if pushing back
> > at first would serve as a good way to encourage these known failure
> > to be fixed, without accumulating too many expect_failure in our
> > test suite, which will waste cycles at CI runs (which do not need to
> > be reminded something is known to be broken).  I will try not to do
> > this when I do not positively know the author of such a patch is
> > capable enough to provide a fix, though, and you are unlucky enough
> > to have shown your abilities in the past ;-)
> 
> I ended up spending some time digging history and remembered that
> "--no-patch" was added as a synonym to "-s" by d09cd15d (diff: allow
> --no-patch as synonym for -s, 2013-07-16).  These
> 
>     git diff -p --stat --no-patch HEAD^ HEAD
>     git diff -p --raw --no-patch HEAD^ HEAD
> 
> would show no output from the diff machinery, patches, diffstats,
> raw object names, etc.
> 
> And this turns out to be a prime example why the approach to ask
> contributors do more, would help the project overall.

It would also help the project to reward the contributors who actually
do more.

Otherwise why would a contributor feel incentivized to do more, if that
work is simply going to land flat on the ground?

> It hopefully would have been "ah, the intent is not documented
> correctly, and here is a documentation patch to fix it."

That would be assuming that the intent of a developer is all that
matters.

I disagree.

What a reasonable user would expect also matters.

> When a command does not behave the way one thinks it should, being
> curious is good.  Reporting it as a potential bug is also good.  But
> it would help the project more if it was triaged before reporting it
> as a potential bug, if the reporter is capable of doing so.

This entirely depends on one's definition of "bug".

To me a bug is unexpected behavior. Some people think documenting
unexpected behavior makes it not a bug, but to me it's just a documented
bug.

"It's not a bug, it's a feature!"

> Those who encounter behaviour unexpected to them are more numerous
> than those who can report it as a potential bug (many people are not
> equipped to write a good bug report),

Is it just unexpected to them? Or is it unexpected to most users?

So what would a reasonable user expect `--no-patch` to do? I think a
reasonable user would expect it to negate the effect of `--patch`, and
nothing more.

The fact that a minority of users expect `--no-patch` to disable all
output--not just the one of `--patch`--would not make it not a bug in my
book.

> Those who can come up with a solution is even more scarse.

And those who can come up with a solution that the maintainer deems
worthy of merging are way, way scarcer.

-- 
Felipe Contreras
