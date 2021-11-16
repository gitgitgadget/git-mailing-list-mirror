Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4295563225
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbhKPTjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbhKPTjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:39:44 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8878CC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:36:47 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i12so266236ila.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s6ld0h+LyP9mWiNS9mrcv5a2uNjC3qlBUL39v76c0AE=;
        b=yYMU4atlI51Amyl5SVjz91ir99Ap12ZYdbFyHZddZ0iM+hhsNVD4NUNeGEyBT238Wz
         OGfmFFaadGUPYAlDgMXFxp9zlZb9Ai8N1AvhTgtUeAfEse1lUbcYRbwW+6HHS8lnpj7w
         YXtGvAGglu7BWQYL50VGK7lCEKQFIbcupEIfTYaADJupmhgLz4vkK+AvkGWgLCCUfW/P
         LWJyCN5CS+OGp6XMaV99hvnGt8H7Iz3kq+SCdnNSOR2s/sRD+6Wr06JxaAJTiSsu+258
         J8B8+NZuzueYGC2ESJECx3QRUSpl4qYcIo86bRkRWv/2u0XdwO7HovRi2MaChyM8PSZ1
         THBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s6ld0h+LyP9mWiNS9mrcv5a2uNjC3qlBUL39v76c0AE=;
        b=OoTwLrUkdJE8BgEMN7yoIcA5DEy6/h/Q/E0nqu0X1iooJnaWx9xdt+Ddlg0sU1QeSH
         5QrHql2HUUwp8+p7Qax4tojfkGjBtdjQDQJZAFw/Uem4V+OMnYMbqry9p0JCrIpDlbA7
         XfpjaC5+JjU80eho5q8yga07jr09+TWO2HK/buVHNOAnsBifeYUtU5Qp2LNb3lJWuYj4
         5gqwIxNuehstdaJseRsfEUamjSBcsefHyWsaytikROOMYO5evlYvxW0CDIfVrGHZq0yh
         V9HVJW09hsmrd4FiMKhPPGBd5fkRLxeDekYzP7mRGgTWmmWIsCUlMWu7t7ND3XPIwwXZ
         fYlg==
X-Gm-Message-State: AOAM533NqJ7ApHijOFcT0/BbNeLtjnSTNHgzRki4v7PeZjLNMhMeSnZq
        H7RHL1bqOFqnHGBsbASqSWbyzw==
X-Google-Smtp-Source: ABdhPJwgM1rzaXmAvSprWoTpPBPPMr7EaEDDvpHv9qh7cv4jC37dGYWpL7mpN6i0qcrmx+eW6DwB6w==
X-Received: by 2002:a05:6e02:12e5:: with SMTP id l5mr6419890iln.36.1637091406837;
        Tue, 16 Nov 2021 11:36:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b7sm13338145ilj.0.2021.11.16.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:36:46 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:36:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/21] C99: show meaningful <file>:<line> in trace2
 via macros
Message-ID: <YZQITrlvO7eUZyDN@nand.local>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <YZP771pJl30ujluT@nand.local>
 <211116.86czmzq5w2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211116.86czmzq5w2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 07:58:01PM +0100, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Nov 16 2021, Taylor Blau wrote:
> >> At the end of this series we expose a config variable to have
> >> usage/die/warning emit line numbers. I.e. going from:
> >>
> >>     $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
> >>     fatal: bad boolean config value 'y' for 'core.x'
> >>
> >> To:
> >>
> >>     $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
> >>     fatal: config.c:1241: bad boolean config value 'y' for 'core.x'
> >
> > Just picking on this output change in particular. I agree that this is
> > easier for folks hacking on Git to trace down errors. But I'm not sure
> > that I could say then same about users, who will likely treat this extra
> > output as noise.
> >
> > Now we may find it helpful if they include it in a bug report, but I
> > feel reasonably comfortable saying that the value there is pretty
> > marginal. I don't find it all that problematic to grep for a specific
> > error string, and usually find myself in the right place.
>
> I wouldn't suggest exposing this to users, except perhaps as part of
> some "how to submit a bugreport" instructions. It's thoroughly optional.
>
> I thought it was easy enough to do with the preceding steps since all
> the data is there, and would help my workflow a lot.
>
> If you've got the file/line number like that you can make it clickable
> in your terminal/compile mode, e.g. Emacs's M-x compile. Saves time over
> having to grep manually select the string, grep for it etc.
>
> Anyway, I can certainly live with peeling this patch off the end and
> just stopping at the trace2 data for now, if you/others feel strongly
> about it.

I don't feel strongly, and I was just noting that it seemed like users
would treat this extra information more often as noise than anything
else.

When you talk about making it optional, do you mean through
configuration / an environment variable, or by including / not including
the patch? In other words, the latter seems much more like us making a
decision on whether or not to include line numbers rather than
presenting a new option to users, though I may be misunderstanding.

> As noted in 02/21 we're hard depending on this particular C99 feature
> already fon a few releases now, the only change on that front in this
> series is to stop committing to maintaining the non-C99 codepaths.

> We've already had hard dependencies on various bits of C99 for years now
> without any trouble, and I wouldn't expect any problems on this front
> either.

Interesting; so this and others are likely part of MSVC's kind-of
support for C99 features? In other words, that MSVC supports some
features from C99 (and we are depending on a subset of those) but not
all features so that it could reasonably be called a spec-compliant
compiler for the C99 standard? If so, makes sense.

Thanks,
Taylor
