Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB2C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840862067B
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Zfo2jOPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgFOQqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgFOQqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 12:46:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D08C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:46:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 64so8047040pfv.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZGk3lPw/cP/U68A/k7WOiv724j3v9jl1XnPvKyw2v20=;
        b=Zfo2jOPR8w/gzx3Spf8lICsyMA/KA/qr6Et20tdK8TTP+7oYsjtsGwcA6539tQrspH
         7CP2NybiqefszJjTdLtM0NWe78PaemhPXuZudOXiQANdRE0teo7FkoOveLK+YQ1TZclC
         yoqthiWBVyJmuQxWRDbwxh0T/vnZ0TKTtSgxul0giPVVtTkfsvChkGCBKPNRiQbZ5FXD
         UZtdxWEW9n4+Dy1oDvvUgoKIgmZGjO+mheqHgrqU/SlTRWrns6guy9o7uAxivY7eFDES
         5zjOX/HIaa8zkDJHwS70pMPazLsCWGTI+2DW8Y1eqOJLN27lGglRTx+Zoi+bZzjocVjD
         IuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGk3lPw/cP/U68A/k7WOiv724j3v9jl1XnPvKyw2v20=;
        b=psWQHYQfnZaeAhxrxgSv1Uc3xz/OPIPiQLdANkvh4O9FhSvdecoT3acJKGLJZGZ/dP
         9fwgYBRwmZ7nngMbsyh00pMppEGhDzeL+3ShHbf3sN86euXlqQjgMy/YLTYHDwa3slZj
         I1pBTe97jBrlihFtOaPN5S1I8eanFV9c6qYwJRpuej8sI7ipe1m/0ZSuz2IeLqT6M8UZ
         nEgZQ6Lo+iu7u3CPCBc9AhEluKRQX3euKp+FTllbUFAMaouXx/5UtAlovn5iDhlX/wbz
         9DEe2sUMXRG3md9CpVoTLP61SdDuBjbBt7zdVXf2RmvQYoQVthK4ed3IAdmAY+83vvVn
         KbAA==
X-Gm-Message-State: AOAM533s2Vl6NMGWW00BMUhbeIA2cP0fOkn5vP24AfZtJu+8+s+Fl6MK
        lbr/CRi7pFL2piw26ZlrviCDIw==
X-Google-Smtp-Source: ABdhPJwY1hLvKEwJd6bdutPqr07OvaS/sLUrTCdou9hXIdVyujhGPl/gHpjbWK1Tq9oNjIm8izSY6Q==
X-Received: by 2002:a62:25c5:: with SMTP id l188mr24042723pfl.178.1592239601764;
        Mon, 15 Jun 2020 09:46:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b4sm14621214pfg.75.2020.06.15.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:46:40 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:46:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
Message-ID: <20200615164639.GD71506@syl.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
 <20200603165142.GA24049@syl.local>
 <20200604073632.GA498923@tanuki.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200604073632.GA498923@tanuki.pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

Sorry for the slow response. I was out of the office last week and am
only just now getting a chance to catch up on the backlog of emails that
I missed.

On Thu, Jun 04, 2020 at 09:36:32AM +0200, Patrick Steinhardt wrote:
> On Wed, Jun 03, 2020 at 10:51:42AM -0600, Taylor Blau wrote:
> > Hi Patrick,
> >
> > On Wed, Jun 03, 2020 at 02:27:50PM +0200, Patrick Steinhardt wrote:
> > > In order to test the impact on the case where we don't have any
> > > "reference-transaction" hook installed in the repository, this commit
> > > introduces a new performance test for git-update-refs(1). Run against an
> > > empty repository, it produces the following results:
> > >
> > >   Test                                   HEAD~             HEAD
> > >   ------------------------------------------------------------------------------
> > >   1400.2: update existing reference      2.05(1.58+0.54)   2.08(1.58+0.57) +1.5%
> > >   1400.3: create and destroy reference   1.79(1.38+0.49)   1.82(1.39+0.51) +1.7%
> > >
> > > So the overhead is around ~1.5%. Given that git-update-refs(1) is a
> > > near-direct wrapper around reference transactions, there likely is no
> > > other command that is impacted much worse than this.
> >
> > This is a serious performance regression that is worth considering. For
> > example, a 1.5% slow-down on average in reference transactions would
> > cause be enough for me to bisect the regression down to see what
> > changed.
> >
> > What are ways that this could be avoided? I bet that this would work
> > quite well with Emily's work on hooks, where we could check in the
> > configuration first whether a hook is even configured.
> >
> > Could this be integrated with that? If not, could you cache the result
> > of whether or not the hook exists, and/or implement some mechanism to
> > say something like, for eg., "only run reference transaction hooks
> > core.blah = 1" is true?
>
> I wasn't aware of her work until now, so I'll take a look.
>
> Meanwhile, I toyed around with performance and tried out two different
> caching mechanisms:
>
>     - map-cache: `find_hook()` uses a map of hook names mapped to their
>       resolved hook path (or `NULL` if none was found). This is a
>       generic mechanism working across all hooks, but has some overhead
>       in maintaining the map.
>
>     - reftx-cache: `run_transaction_hook()` caches the path returned by
>       `find_hook()`. It's got less overhead as it only caches the path,
>       but obviously only applies to the reference-transaction hook.
>
> In theory, we could go even further and cache the hook's file
> descriptor, executing it via fexecve(3P) whenever it's required, but I
> didn't go down that route yet. This would also solve the atomicity
> issue, though, if the administrator replaces the reference-transactions
> hook halfway through the transaction.
>
> Benchmarking results are mixed, mostly in the sense that I can choose
> which run of the benchmarks I take in order to have my own work look
> better or worse, as timings vary quite a lot between runs. Which
> probably hints at the fact that the benchmarks themselves aren't really
> reliable. The issue is that a single git-update-ref(1) run finishes so
> quick that it's hard to measure with our benchmarks, but spawning
> thousands of them to get something different than 0.0s very much depends
> on the operating system and thus fluctuates. On the other hand, if we
> only spawn a single git-update-refs and have it perform a few thousand
> ref updates, overhead of the hook will not show at all as it is only
> executed once per prepare/commit of the transaction.
>
> The following timings are for the case where we execute
>
>     git update-ref refs/heads/update-branch PRE POST &&
>     git update-ref refs/heads/update-branch POST PRE
>
> respectively
>
>     git update-ref refs/heads/new POST &&
>     git update-ref -d refs/heads/new
>
> a thousand times:
>
> Test                                   master            ref-hook-no-cache       ref-hook-map-cache      ref-hook-reftx-cache
> ------------------------------------------------------------------------------------------------------------------------------
> 1400.2: update existing reference      1.96(1.50+0.53)   2.00(1.54+0.53) +2.0%   2.02(1.54+0.55) +3.1%   1.98(1.52+0.52) +1.0%
> 1400.3: create and destroy reference   1.74(1.33+0.49)   1.77(1.38+0.47) +1.7%   1.77(1.36+0.48) +1.7%   1.76(1.35+0.49) +1.1%

Huh. It is super interesting (to me, at least) that caching the set of
hooks that are on disk and should be run makes this *slower* than
without the cache. What's going on there? In p1400.2, I'd expect to see
'ref-hook-map-cache' attain at most a 2.0% slow-down, plus a little bit
to process the hook when it is there, but not much more than that.

I think that this just seems a little contrived to me. I can understand
why server administrators may want this feature, but the general
user-base of Git doesn't seem to stand to benefit much from this change
(in my own mind, at least).

So... I'm not sure where this leaves us. Maybe a 2.0% slow-down on an
already fast 'git update-ref' invocation for the average user won't be
noticeable. It certainly *will* be noticeable to administrators who
processes a much higher volume of such transactions.

> For such a short-lived program like git-update-refs(1), one can see that
> the overhead of using a map negatively impacts performance compared to
> the no-cache case. But using the reftx-cache roughly cuts the overhead
> in half as expected, as we only need to look up the hook once instead of
> twice.
>
> And here's the results if we use a single `git update-ref --stdin` with a
> thousand reference updates at once:
>
> Test                             master            ref-hook-no-cache       ref-hook-map-cache      ref-hook-reftx-cache
> ------------------------------------------------------------------------------------------------------------------------
> 1400.2: git update-ref --stdin   0.21(0.09+0.12)   0.21(0.07+0.14) +0.0%   0.21(0.07+0.13) +0.0%   0.21(0.07+0.13) +0.0%
>
> As expected, there's nothing much to be seen here because there's only a
> single transaction for all ref updates and, as a result, at most two
> calls to `access(refhook_path, X_OK)`.

Better, but I have to imagine that real-world usage will look much more
like a thousand tiny transactions than one large one.

> Patrick

Thanks,
Taylor
