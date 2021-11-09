Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC14FC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E2A61107
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKIA2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhKIA2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:28:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B20C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 16:25:39 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z19-20020aa79593000000b0049472f5e52dso7972107pfj.13
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 16:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jeOzQG7gxR7iSjdJ4Rxr8LEAr5KMGsexFfBG6e2bbeo=;
        b=mvHj094G/05mYS6mC5vTlbnqvRR+5XUUGLTO39Ah2hQGL2weF+RtVVgU/utWbfMH+V
         TNCUDJDQbu4AlCr/3z71cjHm3t960qPgAymBO47DynuSb8tQx5OaOFsxNMO+U261v2Wh
         WYHMbtS5IlIY9A2D/+TzA7JHa5TpK4JpO9PkAs70Hr9lEuxJaj2R4EKXPf3S3+SLgf3D
         MDdvIhj3u+J2B2/Nw2Aop2capGF+yTMqA6fcPly5VHBAOZ/NMOysB3BFgBnPL0yvemWn
         WcnZHB/Ju+jeWJihikD525ZW0w1M7b11uGv9MoXalTkQ0OnqVhrvDrerRyM2wCFbYd3n
         O8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jeOzQG7gxR7iSjdJ4Rxr8LEAr5KMGsexFfBG6e2bbeo=;
        b=J+iPm58Hymvl/2Hb9haSqNGChkklPZrrZWQkcuOXUnaTdm0NDUqnaFWunkehDd88yk
         bqjZIPo0e1xSXQXNF3Qte8oJTWVKPtZ8e7qzEDOMDF0oPywrTt7fpL++cslZDKgYwMBM
         H5hsaUtX8y6vvs7vE4IfARi11KwJBxHibB5DaVsgKhQjh15v+qT+SVPSvr7MZ26yT0RY
         rshzw06QgH91RHiSIAsYbQhtuSc+juCxEye+JcznPbX8tQd9oM+WcGzjOAzZNsaef0MY
         NZZM6X7sXkDEFYVEqV3/yFXjiVFZoC7XK82NZqNjDnXKbAqwPELBIZAEno8pmGdMJ+gA
         e49g==
X-Gm-Message-State: AOAM533kCEJ5A/mSnhPDTrYV+g2PqTKqrx2kLH+9AR5anOzNg1M3kaSr
        eUg9/TXEug+iq6v8ZAAnTwUJVFMN9lToyHDj6kYZ
X-Google-Smtp-Source: ABdhPJzdskcxTVa2EMf4xpanWJTuGvZgAkG3CjXhRg0QbftCTYRAXPZNWUfAl9TkqsH2uc9caWOwIPQkCOqj1dQKBnAC
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ca81:: with SMTP id
 y1mr2483791pjt.231.1636417538814; Mon, 08 Nov 2021 16:25:38 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:25:36 -0800
In-Reply-To: <211106.8635o9hogz.gmgdl@evledraar.gmail.com>
Message-Id: <20211109002536.1111372-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <211106.8635o9hogz.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: Re: [WIP v2 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     emilyshaffer@google.com, jonathantanmy@google.com,
        git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > What's the easiest way to "try it and see", to add tooling and find out
> > whether the config files would be reopened during the second parse?
> > Because I suspect that we won't actually reopen those files, due to the
> > config cache.
> 
> strace -f?

Thanks - this might work.

> > So couldn't we do something like....
> >
> > pass #1:
> >  if (include)
> >    if (not hasRemoteUrl)
> >      open up path & parse
> >  put config into in-memory cache normally
> > pass #2: (and this pass would need to be added to repo_config() probably)
> >  if (include)
> >    if (hasRemoteUrl)
> >      open up path & parse
> >      insert in-order into in-memory cache
> >  don't touch existing configs otherwise
> >
> > I think it's in practice similar to the approach you're using (getting
> > around the weird ordering with a cache in memory), but we could reuse
> > the existing config cache rather than creating a new and different one.
> 
> I don't know enough to say if this two-step approach is better (although
> I'm slightly biased in that direction, since it seems simpler), but this
> just seems like premature optimization.
> 
> I.e. let's just read the files twice, they'll be in the OS's FS cache,
> which is unlikely to be a bottleneck for the amount of files involved.

OK - let me try this.

> That being said we do have exactly this cache already. See [1] and
> 3c8687a73ee (add `config_set` API for caching config-like files,
> 2014-07-28).
> 
> But I think that was added due to *very* frequent re-parsing of the
> entire config every time someone needed a config variable, not due to
> the I/O overhead (but I may be wrong).
> 
> So if we've got 100 config variables we need and 10 config files then
> 10*100 is probably starting to hurt, but if for whatever reason we
> needed 2*10 here that's probably no big deal, and in any case would only
> happen if this new include mechanism was in play.
> 
> 1. https://lore.kernel.org/git/1404631162-18556-1-git-send-email-tanayabh@gmail.com/ 

This might not work for the reasons I described in my reply to Emily
[1]. I'll try the read-twice version first.

[1] https://lore.kernel.org/git/20211109002255.1110653-1-jonathantanmy@google.com/
