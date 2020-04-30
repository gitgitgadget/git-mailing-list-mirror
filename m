Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AFFC47253
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A47A208D6
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="q/UFr95L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD3Tch (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgD3Tcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:32:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466FC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:32:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so334084pfc.12
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wqXkydfrBrgJO6vP+XRRfLKOt/qwp4mgd7He61SxlNQ=;
        b=q/UFr95LB35/VP/8HJOfCY6ERt2OoXDxiO+dK4A1dVXK+FRnZORDJ11n92ZMo7BmDj
         Sx9oL0ZSRznAbJCSZjyw2kVRkr9ph8JuNleFz0ojVS37Nw2tZdmpL4YANbrnypuaL+7M
         p26TW3LqhM0p/Q6IeAYL6RiuH0hUfE2P2qYRvv6gzfFMvQxke6CAkZ6sXYjj6GViexo+
         K3hLAE5dh4c5Wq3Eag5ApDog/RLrRPIET4OgfMc9pxvSd8HQTKcaxv5JeR93OnV734oX
         oo9nhW5K9CacQ/e32nOlFUrNp0YYmqpAH0nu/x3dQBUE42f14zE4rWoWQqR/OEpvJL0q
         Wbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqXkydfrBrgJO6vP+XRRfLKOt/qwp4mgd7He61SxlNQ=;
        b=q/exRAUcYFJbBRnwfOH5wg5iEa+4QK0WeHvrwpYMMRGF2B3eWAkvhNHUv852JQO6mY
         FWcRysEmCTZ2yND00D9yt42qHuaeB1qH7AQGhBB6JoMafPUH13x+urCvB7/8hOVnfEfa
         qR4fNEt7GH3KIHzQ5JGmkXvulug3Zyh3Sre8wnD/noc8xgccuw9gxSfxOvxFvcUba+Mv
         zseinLF67wOLA+y7cq6fTXBvjv747Fw6O7dikCxd+R8Br22Q2Uuz9O8Sjbphoe1USpJC
         fdCONnTO1/IjiCr0W0PZ7NXlAMa7erN6JgBK45kBzEh6f1MEsDWbZxbmu1WJ40JPum3V
         LvpA==
X-Gm-Message-State: AGi0PuakmXFYML4ny2YocJuCUPx1ofWeNZN+LWPFFy7l8ST01Bd/tgzF
        xvDsM1Q2/KAdgIbgUIHkmN2YHmIJaRlEhw==
X-Google-Smtp-Source: APiQypL0hkP2XvOUDsDytIZEbIt5LdzRBngjwBeJDbighIkU66PmEvtOzoQjGIZAZgtkSTGDcixMGg==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr336530pfh.150.1588275154850;
        Thu, 30 Apr 2020 12:32:34 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 140sm491257pfw.96.2020.04.30.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:32:33 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:32:33 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional
 safety
Message-ID: <20200430193233.GC6280@syl.local>
References: <cover.1588199705.git.me@ttaylorr.com>
 <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
 <20200430031138.GC115238@google.com>
 <CAPig+cQOMJJQBi2KMqzzZQs-S1KVwzAxdfzEaUvSNskMtYkCrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQOMJJQBi2KMqzzZQs-S1KVwzAxdfzEaUvSNskMtYkCrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 01:32:34AM -0400, Eric Sunshine wrote:
> On Wed, Apr 29, 2020 at 11:11 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Taylor Blau wrote:
> > > +/*
> > > + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> > > + * which locks can be used with '{commit,rollback}_shallow_file()'.
> > > + */
> >
> > I think I disagree with Eric here: it's useful to have a comment here
> > to describe the purpose of the struct (i.e., the "why" as opposed to
> > the "what").
>
> I'm not, in general, opposed to the structure being documented; it's
> just that the comment, as presented, doesn't seem to add value.
>
> > I wonder if we can go further, though --- when using a shallow_lock,
> > how should I think of it as a caller? In some sense, the use of
> > 'struct lock_file' is an implementation detail, so we could say:
> >
> >     /*
> >     * Lock for updating the $GIT_DIR/shallow file.
> >     *
> >     * Use `commit_shallow_file()` to commit an update, or
> >     * `rollback_shallow_file()` to roll it back. In either case,
> >     * any in-memory cached information about which commits are
> >     * shallow will be appropriately invalidated so that future
> >     * operations reflect the new state.
> >     */
> >
> > What do you think?
>
> This comment makes more sense and wouldn't have led to me questioning
> its usefulness. Thanks.

Me either, thanks for the suggestion.

Thanks,
Taylor
