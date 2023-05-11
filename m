Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC6C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbjEKSgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKSgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:36:13 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F8926B7
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:36:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1962e7284baso2996607fac.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830171; x=1686422171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOGFQj2eACm+XyW5KATPHKq1Ya7ll/DvFVro/0xUweA=;
        b=LEsA1qMser3BHXLA4ITd5q0wRdFuNhKDZQJYvFVSMMjjH0dzrkHV1QCmkU6zME4pqH
         JfeZ/pXXOLb3EiLZ/ciuH0sI/OTmlF/iJ47YVXfDepo7y+VpGuBK8PgXayHGbzXFv7w6
         jmk6d5RHaEJcia20gSC8uvGod/5vQ8xSUhWSaLZgjytzG2RjsQzh0WVRQsrsbDsxhJju
         LuO0la252LkysXkXlbXPCpzI7cLga9+NIeb+P93ujGKDdwdKBqYEhaKlft0ioYdqeXcL
         cYFR0q4tM1pXDXKAROKi2f8q9uI8T+VKXGnWiFGIIYjjyhJETALhFP5hydJdMaItcLD4
         8X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830171; x=1686422171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOGFQj2eACm+XyW5KATPHKq1Ya7ll/DvFVro/0xUweA=;
        b=hNA67ccxOFnVQT16Kg6ABtrn5DbinLiq7KNEPsaesDau30i7XcJdmUrd8PmdVXFsXY
         /6kcp8hbB0vwkSFpWLoIpvQheXi7TCjZ0oswcBrKkrY+L6QGYRK+ejKqYFgcHksLmoGR
         A6fU3tn/EeYe3bTfs/hx66Kl/riyKi/fD4V6JJ8ZIx2wWPgE2RtyRPsdftLFK+iHh/Np
         vQGt271iVdCYj3N+/7AC7wTht4qk4Y0yjxzM3LttnXPwQpP+X6w/y5x4/lMmSFHpBdwZ
         6ZuOu367TdvpC9w1MfGxMT6plNqJn6TnCvpTcSAjaPdedlkhlscLtjPlLzk90AFFwMHi
         k1Dg==
X-Gm-Message-State: AC+VfDw/vYDcOLFK6OFHf1/4gmKovRnCVfAIF4ncbSUVPqcP46AXw/sE
        YmAzuuPNPGtwVipGAgO2j70=
X-Google-Smtp-Source: ACHHUZ5yN92V4Gg1T65KHRntDoV345ah43ySi+B1wPZjVnsQ6x4lohMpv5yny126rScvhIAmophvqQ==
X-Received: by 2002:a05:6870:3a07:b0:18b:12ce:f5d4 with SMTP id du7-20020a0568703a0700b0018b12cef5d4mr11380111oab.41.1683830171300;
        Thu, 11 May 2023 11:36:11 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ds22-20020a0568705b1600b0018045663fc5sm8176724oab.48.2023.05.11.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:36:10 -0700 (PDT)
Date:   Thu, 11 May 2023 12:36:09 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d3599e037c_2606922948b@chronos.notmuch>
In-Reply-To: <87lehu219c.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <xmqqwn1ewyzx.fsf@gitster.g>
 <87lehu219c.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Sergey Organov <sorganov@gmail.com> writes:
> >
> >> I entirely agree with your conclusion: obviously, -s (--silent) and
> >> --no-patch are to be different for UI to be even remotely intuitive, and
> >> I'd vote for immediate fix of --no-patch semantics even though it's a
> >> backward-incompatible change.
> >
> > I forgot to write about this part.
> >
> > tl;dr.  While I do not think the current "--no-patch" that turns off
> > things other than "--patch" is intuitive, an "immediate" change is
> > not possible.  Let's do one fix at a time.
> >
> > The behaviour came in the v1.8.4 days with a series that was merged
> > by e2ecd252 (Merge branch 'mm/diff-no-patch-synonym-to-s',
> > 2013-07-22), which
> >
> >  * made "--no-patch" a synonym for "-s";
> >
> >  * fixed "-s --patch", in which the effect of "-s" got stuck and did
> >    not allow the patch output to be re-enabled again with "--patch";
> >
> >  * updated documentation to explain "--no-patch" as a synonym for
> >    "-s".
> >
> > While it is very clear that the intent of the author was to make it
> > a synonym for "-s" and not a "feature-wise enable/disable" option,
> > that is what we've run with for the past 10 years.  You identified
> > bugs related the "-s got stuck" problem and we recently fixed that.
> 
> I wonder, why this intention of the author has not been opposed at that
> time is beyond my understanding, sorry! What exactly did it bring to
> make --no-patch a synonym for -s? Not only it's illogical, it's even not
> useful as being more lengthy.

That's because it's not true.

The intention wasn't to make `--no-patch` a synonym, the intention was to make
disabling the patch output of `git diff` more accessible.

The cover letter makes it clear [1].

  "git show" will show the diff by default. For merge commits, it shows the
  --cc diff which is often empty, hence the behavior you see.

  You want to use "git show -s", which suppresses the patch output, and this
  "git show -s" is extraordinarily hard to discover, as it is only documented
  in "git log --help". Google has been my friend here, but we should really
  improve that.

The code at the time did not allow turning off only one output, using
DIFF_FORMAT_NO_OUTPUT was easy, so that's what they did.

> > But "git diff --stat --patch --no-patch", which suddenly starts
> > showing diffstat after you make "--no-patch" no longer a synonym for
> > "-s", has a much larger potential to break the existing workflows.
> > And I do not think asking the users who followed the documented
> > "--no-patch is a synonym for -s" to change their script because we
> > decided to make "--no-patch" no longer a synonym is much harder.
> 
> Why somebody would use --no-patch instead of -s when she means -s? Is't
> it obvious that
> 
>    git diff --stat --patch -s
> 
> is not only shorter but dramatically more clear than
> 
>    git diff --stat --patch --no-patch
> 
> ???
> 
> Taking this into account, I'd predict no breakage at all.

I agree.

I bet there's very few people relying on this behavior (if any), which is
precisely why nobody noticed the bug until now.

If we are going to break backwards-compatibility, we should break it correctly:
split `--no-patch` from `-s`, and make it only negate `--patch`.

> > So, no, I do not think we can immediately "fix".  I do not think
> > anybody knows if it can be done "immediately" or needs a careful
> > planning to transition, and I offhand do not know if it is even
> > possible to transition without fallout.
> 
> This has been expected, and this is one of the things that stops me from
> trying to "fix" anything in the Git UI recently. I think that perfectly
> legit carefulness from the maintainer to be conservative in accepting of
> such changes goes a bit too far, sorry!

And you were correct.

I did write a patch series that actually fixes the problem correctly, and the
maintainer completely ignored it in favor of his partial solution.

So you would have wasted your time trying to fix this correctly, as I probably
did.

Cheers.

[1] https://lore.kernel.org/git/1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr/

-- 
Felipe Contreras
