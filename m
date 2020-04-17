Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7EFC2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EA222209
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OjBRZdAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgDQRkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728421AbgDQRkf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 13:40:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E91C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 10:40:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so1433312pgs.9
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRiMvU0pVbRwxP5ZLvH4VoQ5+cEI6YvRTokjXaxn8nY=;
        b=OjBRZdAl+EgXH0O7OdOHjMvmebJK8cJvLxGMZ8Gc6BnHe2orErUPWF8Tp6bkZBWDyO
         NcKi77hEUoCmLYW7qABmp5MdISxFYMkyuhtmqtMpP/AgTd8qidsUr2z6I2nGuIgKQcZ2
         ImmA079CeAHEmI2D9OQtkVlBMMM/XErGl1FgPy19KFOY98uwQC+9ptUxReql/4aZO6RV
         gD8+xmR33Us8RGQ2ONl5q9pnj9gbSzq0HkVSbee7Y3upcIEywjQcs303yAtuE3hhumzt
         AQ39XleliABacpKvdEpM5gxou6wj1eRd5WFQ7rYaQuAWip0nq3DXIe33U48+jRDZNMbp
         dWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRiMvU0pVbRwxP5ZLvH4VoQ5+cEI6YvRTokjXaxn8nY=;
        b=BIYTKIcdBAEIp+k6RjTne32bhSDgkTj85ajdopgP7dl4/hRTHL2+0lXtDiGLFvUGNv
         7mVVL0835MthcVPdIxHSsyXyZzSU444XVODoAVaqHn/kCIA6KRVDUKHMW56SI/5yLI9K
         hhIQEKBUfp16Un8KZRUn8Y7MCAN4+vPINzLcno4cRL2lwgIf9ocJhQoPIkW3UXIWSjHz
         +Nbn6o+BqWyKwSY5lrPPdXwCsAsv2QzBefVmtZsxpPpDOID1Fzfb/KGbD+IJmZo1UOOv
         HnPHzTfsjsRAGkF1X07Es9OzGFMsHfUyqqvBqjy1MOhxI6P/j/b0dpQGNkiCB3P6P1sm
         bztA==
X-Gm-Message-State: AGi0PubyOpgO72KBnjbbfBdEJ3mrE1PZNq2uwY3teYrRgx5FR2p0AdzH
        x2Px7/yY0Ex/VTh3HQrfuIalWQ==
X-Google-Smtp-Source: APiQypJCFpJuw2JmXrweJRYzqE+MZTVBN+pes+//MBqAxHCP130R/X1NbbU6+GmvItiGU4SJC7tYOA==
X-Received: by 2002:aa7:8593:: with SMTP id w19mr4245700pfn.97.1587145233141;
        Fri, 17 Apr 2020 10:40:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s63sm6781979pfb.44.2020.04.17.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 10:40:32 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:40:30 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200417174030.GB2103@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 11:41:48AM +0200, Christian Couder wrote:
> Hi Taylor and Peff,
>
> On Wed, Mar 18, 2020 at 11:18 AM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Mar 17, 2020 at 02:39:05PM -0600, Taylor Blau wrote:
> >
> > > Of course, I would be happy to send along our patches. They are included
> > > in the series below, and correspond roughly to what we are running at
> > > GitHub. (For us, there have been a few more clean-ups and additional
> > > patches, but I squashed them into 2/2 below).
>
> Thanks for the patches, and sorry for the delay in responding!

No need to apologize. Clearly these had slipped my mind, too :).

> > > The approach is roughly that we have:
> > >
> > >   - 'uploadpack.filter.allow' -> specifying the default for unspecified
> > >     filter choices, itself defaulting to true in order to maintain
> > >     backwards compatibility, and
> > >
> > >   - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
> > >     filter kind is allowed or not. (Originally this was given as 'git
> > >     config uploadpack.filter=blob:none.allow true', but this '=' is
> > >     ambiguous to configuration given over '-c', which itself uses an '='
> > >     to separate keys from values.)
> >
> > One thing that's a little ugly here is the embedded dot in the
> > subsection (i.e., "filter.<filter>"). It makes it look like a four-level
> > key, but really there is no such thing in Git.  But everything else we
> > tried was even uglier.
> >
> > I think we want to declare a real subsection for each filter and not
> > just "uploadpack.filter.<filter>". That gives us room to expand to other
> > config options besides "allow" later on if we need to.
> >
> > We don't want to claim "uploadpack.allow" and "uploadpack.<filter>.allow";
> > that's too generic.
> >
> > Likewise "filter.allow" is too generic.
> >
> > We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
> > but that's both ugly _and_ separates these options from the rest of
> > uploadpack.*.
>
> What do you think about something like:
>
> [promisorFilter "noBlobs"]
>         type = blob:none
>         uploadpack = true # maybe "allow" could also mean "true" here
>         ...
> ?

I'm not sure about introducing a layer of indirection here with
"noBlobs". It's nice that it could perhaps be enabled/disabled for
different builtins (e.g., by adding 'revList = false', say), but I'm not
convinced that this is improving all of those cases, either.

For example, what happens if I have something like:

  [uploadpack "filter.tree"]
    maxDepth = 1
    allow = true

but I want to use a different value of maxDepth for, say, rev-list? I'd
rather have two sections (each for the 'tree' filter, but scoped to
'upload-pack' and 'rev-list' separately) than write something like:

  [promisorFilter "treeDepth"]
          type = tree
          uploadpack = true
          uploadpackMaxDepth = 1
          revList = true
          revListMaxDepth = 0
          ...

So, yeah, the current system is not great because it has the '.' in the
second component. I am definitely eager to hear other suggestions about
naming it differently, but I think that the general structure is on
track.

One thing that I can think of (other than replacing the '.' with another
delimiting character other than '=') is renaming the key from
'uploadPack' to 'uploadPackFilter'. I believe that this was suggested by
Juino (?) earlier in the thread. I think that it's a fine resolution to
this, but I'm also not opposed to what is currently written in too above patches.

> > > I noted in the second patch that there is the unfortunate possibility of
> > > encountering a SIGPIPE when trying to write the ERR sideband back to a
> > > client who requested a non-supported filter. Peff and I have had some
> > > discussion off-list about resurrecting SZEDZER's work which makes room
> > > in the buffer by reading one packet back from the client when the server
> > > encounters a SIGPIPE. It is for this reason that I am marking the series
> > > as 'RFC'.
> >
> > For reference, the patch I was thinking of was this:
> >
> >   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
>
> Are you using the patches in this series with or without something
> like the above patch? I am ok to resend this patch series including
> the above patch (crediting Szeder) if you use something like it.

We're not using them, but without them we suffer from a problem that if
we can get a SIGPIPE when writing the "sorry, I don't support that
filter" message back to the client, then they won't receive it.

Szeder's patches help address that issue by catching the SIGPIPE and
popping off enough from the client buffer so that we can write the
message out before dying.

I appreciate your offer to resubmit the series on my behalf, but I was
already planning on doing this myself and wouldn't want to burden you
with another to-do. I'll be happy to take it on myself, probably within
a week or so.

> Thanks,
> Christian.

Thanks,
Taylor
