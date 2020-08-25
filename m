Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83CC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BC22075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tdURAV6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHYOpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 10:45:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F7C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:45:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so5577231qvl.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/N7wmai0wFsPQd8sx47tQcLMS3W0nCrzS0Lkv+BFdzI=;
        b=tdURAV6UuyGL0JmW6LRgSynmX3VmkcwoI6TH+2HZinWkeSBpPKFntmc/hF3FBwBtsu
         az/nQCsCFJ+qbkvLwFR+Ih9EIK44QRpnQm1GM9u94G3zJcgQIVsJ2TgCDkFGjyAJvf3h
         lIwWlLvE0AzPdGLDsMJu1qBrlkqUAkV0XW9+C/bPBJMLV7VuUo2+7NKBVcTjHGSQffch
         Tj6npcjBzFKMTDtWmDSKPOj48gP5a/+RSMNQB68TgzRT4SK4CinF8fRGa+0d2+gCbbi8
         MepYScL9t3feFnAKvByuIyXc8fTAeIJtVMf6O82BhApiF2GjAK5yD5/ZabM7SBRI2bnh
         hirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/N7wmai0wFsPQd8sx47tQcLMS3W0nCrzS0Lkv+BFdzI=;
        b=nVS/+oNfaeKwAO9IdOyRn+lvOmP0dVpRtGeAWWHqU3CyG8VYNhsCTQByOHcPkm4Y2k
         c0LP/YRSqMRQf43Ik14+6cFidK1tDd9YeWTytee59bV7a6iTkgMky9T1RBm62z9Rqzyc
         FPXigBssWzIFm7xMeXcO0fZYU6d4tHqM9Ws/XW9v6cZHor2ePaG/JIFK6BnSvujPd5bz
         EGT4GVUtYCVPyeQ0BaacseX9FzUh9AiTWK0w23TJ9ENwQBqvZA/2zsAcn+M+V0XbV7DK
         nJf7ckOsvcf/JRhYmgzTdYs5KBG77Tg6MYFBOqQuKlAYRwPz8NrxI4MtsazjFnh7k2Cg
         6wBA==
X-Gm-Message-State: AOAM532aGsrj9ds1cGX5KHydu1OT4pqdIDrBPJFRVEjQkkhNxgQhocxQ
        11XrruZkoB46bk/LdLWZdMrxiw==
X-Google-Smtp-Source: ABdhPJyYq6VZDCmNY9S/gfvXmKIVP47nNdFrlBAZbMlrEwA6YnuBOQxbo75SGhEa5men1TWAvSd6cQ==
X-Received: by 2002:ad4:4992:: with SMTP id t18mr9185040qvx.193.1598366718443;
        Tue, 25 Aug 2020 07:45:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id i75sm11933730qke.70.2020.08.25.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:45:17 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:45:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825144515.GB7671@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 09:55:22AM +0200, Son Luong Ngoc wrote:
> Hi Taylor,
>
> Thanks for working on this.
>
> > On Aug 25, 2020, at 04:01, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> > learned to remove a multi-pack-index file if it added or removed a pack
> > from the object store.
> >
> > This mechanism is a little over-eager, since it is only necessary to
> > drop a MIDX if 'git repack' removes a pack that the MIDX references.
> > Adding a pack outside of the MIDX does not require invalidating the
> > MIDX, and likewise for removing a pack the MIDX does not know about.
>
> I wonder if its worth to trigger write_midx_file() to update the midx instead of
> just removing MIDX?

There's no reason that we couldn't do this, but I don't think that it's
a very good idea, especially if the new 'git maintenance' command will
be able to do something like this by itself.

I'm hesitant to add yet another option to 'git repack', which I have
always thought as a plumbing tool. That's important because callers
(like 'git maintenance' or user scripts) can 'git multi-pack-index write
...' after their 'git repack' to generate a new MIDX if they want one.

This becomes even trickier if 'git multi-pack-index write' were to gain
new options, at which point 'git repack' would *also* have to learn
those options to plumb them through.

Maybe there's a legitimate case that I'm overlooking, but I don't think
so. If there is, I'd be happy to come back to this, but this patch is
really just focused on fixing a bug.

> That is already the direction we are taking in the 'maintenance' patch series
> whenever the multi-pack-index file was deemed invalid.
>
> Or perhaps, we can check for 'core.multiPackIndex' value (which recently is
> 'true' by default) and determine whether we should remove the MIDX or rewrite
> it?
>
> >
> > Teach 'git repack' to check for this by loading the MIDX, and checking
> > whether the to-be-removed pack is known to the MIDX. This requires a
> > slightly odd alternation to a test in t5319, which is explained with a
> > comment.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>

Thanks for your feedback.

> Cheers,
> Son Luong.

Thanks,
Taylor
