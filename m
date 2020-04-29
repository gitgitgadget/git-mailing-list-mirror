Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A6C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE120BED
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nZ/2kSmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgD2Xvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD2Xvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:51:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2EC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 16:51:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c21so1522291plz.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vJwoKAnrTHOGP9mhhBzh2g+2bZjMMaaH/iGwMEl3muA=;
        b=nZ/2kSmFgOCBt1AU0oUiXdLW5b9bWHL3iz0XqquU8hkoV1DZnfZwfi/P7mii8lNI3+
         Us1u9Tc55lGMN7/cVqZ/58qroJtgJi3JpII5YLIBHJWADE530K1vQQn5GdYYCpStUuvz
         g1ExJJXKHsyFoV6SPBypem+xdU7dWDmvqJ0/OhUVsWaVQobGFm3XoJJ4Oj7f75gM5Scp
         U0Aj/QVKOKY0Z+41yM/a/Ffb4J9/W8MKpUemgXs3qLhA2HXpwXT8Y1fXXOi5AlYs2Fa+
         iR76QWEMrT8AnvmNlIL6DnX0J4ii7KcVeOgmKwDQTnPL7WaS3ZdfaChY0lc8Fla1JetZ
         VKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJwoKAnrTHOGP9mhhBzh2g+2bZjMMaaH/iGwMEl3muA=;
        b=NT3GqCLAyHa80FNOjwFLPC41/OoKxgPNC3KkZUehfwoWYQOcMfyHArxW40JQkKzW2d
         EcyfTwOSzWzB/J45N5bjAU19hV6XAboPAtoFzxVeM6mH3InjSEui/w6Qc7kfK69TXEFi
         Yu4gnxpA1UWxdE67Bd3ZlV0Nj7IY2DBFMIy3aI8QZ5FEiHahva9X9BLYntDOOQkYcgO4
         TPfL0XBk5i6OO5jBu98fIun4Rr/2ObCae6kyedIKQIRRzhx+NI1qeAuPk5SiQ22hPz90
         /UW43FqBmTQ1JsE/fdZcrcJXif98H09vopEr1Tw/d5JIQcHHzA+v+Rqyi8ssZjKlt/Pz
         oc0A==
X-Gm-Message-State: AGi0PuYIbQAydFtnNrgzc4r+ZV2DhaCKJPQYMpVTrrAsyBWgL+Co2Jyt
        A/JpyfVPMCrtnB4nnLHDM6QTYA==
X-Google-Smtp-Source: APiQypKSpxVghzjnUQjfuiia9XdgtSi4XHUG/ANXRFszMkp0aQT6uyyZ468dV7iFbsTbANKNBs7rsg==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr930325plo.48.1588204308564;
        Wed, 29 Apr 2020 16:51:48 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m18sm310196pjl.14.2020.04.29.16.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:51:47 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:51:46 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional
 safety
Message-ID: <20200429235146.GA20588@syl.local>
References: <cover.1588199705.git.me@ttaylorr.com>
 <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
 <CAPig+cTvX1wT8kAha22uUQ5PDQ0mjeoDGQdA6VtMzfnAELpTaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTvX1wT8kAha22uUQ5PDQ0mjeoDGQdA6VtMzfnAELpTaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 07:03:48PM -0400, Eric Sunshine wrote:
> On Wed, Apr 29, 2020 at 6:39 PM Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > This patch introduces that type as a thin wrapper around 'struct
> > lockfile', and updates the two aforementioned functions and their
> > callers to use it.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/shallow.h b/shallow.h
> > @@ -10,12 +10,22 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
> > +/*
> > + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> > + * which locks can be used with '{commit,rollback}_shallow_file()'.
> > + */
> > +struct shallow_lock {
> > +       struct lock_file lk;
> > +};
>
> The documentation comment for 'shallow_lock' may help newcomers to C
> but probably doesn't add much value for seasoned programmers. If this
> is the sort of idiom we want to introduce (or exists already in this
> codebase) -- declaring a specific C type to avoid accidental use of an
> unrelated lock -- then it's probably better documented in
> CodingGuidelines rather than repeating it at each point in the code
> which employs the idiom.

Fair enough; I definitely weighed the usefulness of this comment a
little bit when I was writing it. I figured that I didn't want to
commit to updating CodingGuidelines in this series, but that I didn't
want to leave the explanation only in the commit message.

I figure that it's probably fine to document it in the commit message,
and leave it at that for now.

Thanks for this suggestion (and the earlier ones, too). I have applied
them locally, and I'll sit on them for a day or two before sending out
v2. Thanks again.


Thanks,
Taylor
