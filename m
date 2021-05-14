Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCBC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C9461442
	for <git@archiver.kernel.org>; Fri, 14 May 2021 22:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhENWIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhENWIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 18:08:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF4C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 15:07:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p17so552894pjz.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HtrrLrw+1OknCOOx+zNJupqTwVX9f2e2DEw49FV2XWo=;
        b=FKp1WL47SITntis/nvGJ4mRtBPMSHWJlgOmkITWkex5UtwonM0yVn6DFpuTVSPKg5t
         mN4bgvuyW5oqn1s+5TuAbdn8nX1urQxUglqQbiBnm+jJaPIjdOdQ6fMECtLIeg4e0nrI
         rWgSxMfq/+mB7Tn4hfiEA4Yghy5q0R6zoGgY6YggT1d4NaHqPTmNBzuPui8JvAcpERMA
         aETbfiYZjrKwf6bMcWMBpexiD8dr+uxUrt9hor4lhXx0+Z4b/hLDtgIzzTI1JlzxAfOe
         IWFqL2yv6xZTCivSYoEQlCpFhe8fJ4Ns++CD1A0lcBeoU4cxGqg1UXQ/xwNUC60RKsPK
         dPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HtrrLrw+1OknCOOx+zNJupqTwVX9f2e2DEw49FV2XWo=;
        b=ibQrE4ev5VsMWYx/BdBMlxeLwuPxRtAab5GlC4LUb1wxkTyVv+lhgoLM+PdKUMQYWj
         WKtML9PLGDuXpzdNlEYyfBI07UfVLs5B/0J4KJtOv8JwWjmk/1hX/GNhadSN0po3bo5D
         eKsRupxxXP8HcQthI4kzap1S/k7hgehnyKW9fTyBjS3z4E8fNHFJfPhEcu8VdxwVFZmj
         Yg4dYxwt7HBfi6MJAve6RR7G9s87+e6bmdfXMeQvZV1J3musaBgDeVhKRtOImXZtMNDR
         9xoLaqA2d66DUvb2dR0ECKhJTV1qz57XlhSaw4azZRWb5TAsLzzefiZci2Yr10mVMblh
         4jqw==
X-Gm-Message-State: AOAM533UvruUZ0+C3YXPQ+mH9cw01HdYtWe70y8jDvYV2pYj+m8A+199
        0PN9ArGquORLVl+KAZTA0TgIcXbe1wCCbA==
X-Google-Smtp-Source: ABdhPJxTZ7zTELKAp5a6wGc2dgaNAC770wnQpbZjiIzhw5UqAbkeWRzotv6pYTg3Vi1RCYf60o2oYw==
X-Received: by 2002:a17:90b:2394:: with SMTP id mr20mr53229482pjb.167.1621030024971;
        Fri, 14 May 2021 15:07:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:be08:fb62:598a:3497])
        by smtp.gmail.com with ESMTPSA id n20sm1440692pjv.42.2021.05.14.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 15:07:04 -0700 (PDT)
Date:   Fri, 14 May 2021 15:06:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
Message-ID: <YJ70g0Nd1W1f6BIx@google.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com>
 <87im3qu4gy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im3qu4gy.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 02:29:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, May 06 2021, Emily Shaffer wrote:
> 
> > It can be useful to tell who invoked Git - was it invoked manually by a
> > user via CLI or script? By an IDE? Knowing where the Git invocation came
> > from can help with debugging to isolate where the problem came from.
> 
> Aside from the portability concerns others have raised, I don't really
> see why you'd need this.
> 
> We already have the nest-level as part of the SID, so isn't it
> sufficient (and portable) at the top-level to log what isatty says + set
> the initial SID "root" in the IDE (which presumably knows about git).

If you already know all the IDEs and scripts which invoke Git, sure, you
could set the SID root - we do this with 'repo' tool today. But actually
we want this because we aren't sure exactly who at Google is invoking
Git in their tooling, how, why, etc. - this logline was supposed to help
with that. Chicken, egg, etc.

Or else I'm misunderstanding your suggestion; to me it sounded like "go
fix your VSCode plugin so that it sets an additional envvar" and I
responded accordingly. If you mean something else I didn't see,
implemented in Git land, then I'm curious to hear more.

> 
> Wouldn't this log passwords in cases of e.g.:
> 
>     some-script --git-password secret # invokes "git"

I have nothing but nasty things to say about scripts which would do
that, but your point is valid enough to make me think this logline
should be gated behind a config and posted much later (when config is
available - I think it's not yet, with the patch as-is).

> 
> In older versions of linux reading e.g. smaps from /proc/self would
> stall the kernel while the read was happening, I haven't checked whether
> cmdline is such a thing (probably not), but it's a subtle thing to have
> in mind for this / follow-ups if it's made portable (is that an issue on
> other OS's?).

That's an interesting point and I wonder how I can validate if it
does/doesn't stall in this way - I guess I can go manpage diving?

 - Emily
