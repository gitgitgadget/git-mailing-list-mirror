Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCDC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiEXViy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbiEXViw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:38:52 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A77E1E1
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:38:48 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id x28-20020a4a621c000000b0040e85d338f2so1397881ooc.5
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qNkzxjFI0eCl/VopHjcabXZeRag9J2LbokQg2EHsnjE=;
        b=Ho/RxrThnfweVTvnBbd0CvICAUf+hBLb2dCU62BIcsfmSNRAwKEibs6DrSJz1M0Mhy
         OLaDqbSwv3dzDiIxJSlzEJ44oZLmOaZLZKTNmzgDla0ShHtnw8P7zBivFyxDw9tpMFbT
         47Y1rYZp/0zVwBx5FIA78FtiU6vttY++m6h7YnuUqWxpR5vvg0I5axbilZmBdQma9WbC
         1W+o88vhwX4PVMfsfZI+IFrVhFmD/+s7e1jK4qofyCWR3TQ4pmHQYh0iPNRfbQNt6yfL
         bw0bKq8mjx2j5F38T4ISwo28J+CQc34f8vN4I+WvMPXhXwDjPlsShTR2Ab8g/65qnTfk
         E8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qNkzxjFI0eCl/VopHjcabXZeRag9J2LbokQg2EHsnjE=;
        b=nHnMjUjtN7sXiZDhaHk3A5WHwT6x4ALO6cVK68Ykj5W/UIowAYLpwqJ3OO1jPff3qr
         3tuGAML8mQ046qWpR5Yp+rZ5NazCFu3h1GyxEEnD8ps+EEwcoWyqL/N87b8WQEwaIZ5v
         GgY0Yvo3oVXHjvbWNDAz2yaUTz0hJiQDIzLOk2Jt5eeoZqCmuFw6yDd6sTNcpAySTNQ8
         HWaD39gWjjNERszt0LR7s71AVtFUARyVUbStVeJp2LlbiMqggjhjhRplzNx+aeEydup0
         s2RYFKpp2/8HEOEM3wz4ByPU5bQKFQs1udjMA9OApkC+kwuX5IY1c7ak3SKvyajPUxCT
         nWMg==
X-Gm-Message-State: AOAM530kmRKudBcgOEA/cJKebVsx6TIxkI7LesfeHC4wwB/f4sT0zryL
        EeWNzN2JpOeZduj+yJlNs0jbLg==
X-Google-Smtp-Source: ABdhPJxKozpYa5pz8HifHJHwE/aKJ10bYuQPdi9XshWBbAiEgNVE3ltlGNVNEIzhKqNBBjl8BKor2A==
X-Received: by 2002:a4a:7c46:0:b0:40e:5ff1:f1a3 with SMTP id v67-20020a4a7c46000000b0040e5ff1f1a3mr9115621ooc.27.1653428328163;
        Tue, 24 May 2022 14:38:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c199-20020a4a4fd0000000b0035f068e16aasm5857911oob.5.2022.05.24.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:38:47 -0700 (PDT)
Date:   Tue, 24 May 2022 17:38:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/4] pack-bitmap.c: check preferred pack validity when
 opening MIDX bitmap
Message-ID: <Yo1QZe5CyYWGGtYR@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <618e8a6166473d238e62ce6243d9a0b2b72ee2f0.1653418457.git.me@ttaylorr.com>
 <220524.864k1ewwh4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220524.864k1ewwh4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 09:36:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, May 24 2022, Taylor Blau wrote:
>
> Just nits on the error reporting:
>
> > @@ -353,6 +355,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  		warning(_("multi-pack bitmap is missing required reverse index"));
> >  		goto cleanup;
> >  	}
> > +
> > +	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> > +		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> > +			die(_("could not open pack %s"),
> > +			    bitmap_git->midx->pack_names[i]);
>
> Some existing API users of this & their error handling suggest that this
> message is wrong. I.e. it's not that we couldn't open it, but that we
> could open it and there's something wrong with it. Or perhaps their
> messages are misleading?

I tried to reuse some similar message based on "git grep 'if
(.*prepare_midx_pack'", so this was inspired by:

  - the caller in midx.c::write_midx_internal(), whose error is "could
    not load pack", and
  - the caller in midx.c::verify_midx_file(), whose error is "failed to
    load pack"

Are you suggesting we should s/open/load here and use the above error
message? My feeling at the time was that "load" was basically synonymous
with "open" given the context, but if you think they're different
enough, or have a different suggestion LMK.

Thanks,
Taylor
