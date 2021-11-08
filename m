Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E344C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553F1610C8
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhKHXZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbhKHXZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:25:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C1C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:22:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r5so17451148pls.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kkm2VJy0SCjoyD+QhqVysLROJx2xUkzwXH4UuON65m4=;
        b=afccyVDeKvrqqYLu8b+mQytcZ8w9Avr7jDqFB1XHONWsiDM8QjW1EPTCVTDuLIOceu
         VwUCMfYkYo7KKrCXERyilMhfozkXbQss1dQKRqXYeHLMAojJyPyFzb0PU5NWgWU86nzp
         w9w05kNhGHt3kHPl6IdnW+XuS6EoooHKDf4/X4Gh5+oBtCtBOo2fqX2Umd19JPMgdqcL
         GNsq56rdn5WeSIQ5ijzpNuB8/sJwAPpvA0KDEhg5bPl9+Lcd2iDYDw10z9hmac82NJSK
         2my6fxRVtNJ26N8NArhb4L3DRprNkVIztR8LySEtXMQg82xjCFzzO5q77b64Xzqr0heq
         eFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kkm2VJy0SCjoyD+QhqVysLROJx2xUkzwXH4UuON65m4=;
        b=eNwT36P87A2seIUatfHdSnNQVNaeqp0uqeXYY6tN1saQdPHhBareNvNJ0hkbcQngby
         ey48OZZ5dW1Bkdj5LV/39O/gqOSco0BQ5NejHhXovTmjDV79MUxcbdthxsALfObCNadJ
         c5tFCRc1j+VXefU8ujUhK+OwwgpvjeVOErYiv1GcgX98JBFw1q3PgJKHFLGZv5+LjHIk
         V6Fyzd7sFAV+XedN3FHRljqyPrh2WevHant2p8jGRaZPT/QLj6ja4MeXoyuRo42peJ/e
         +OY4SkmaCGhaVjpRMVYWNlKuwu/+mkEnTT0/pVuYP/l9yGyo8iM24XccHLbGE5PoTofp
         3/Qg==
X-Gm-Message-State: AOAM533tc147uFJWmil5pD4Knwo409vvyolKB4/TpwqQY4FZS2l6Ajbd
        CtjSb43pUtYhLftOL5vMA03d9L8vPtFUeA==
X-Google-Smtp-Source: ABdhPJzvVhUoXrF3leORO7Tkgor00wEl0yTLnJ9dV6R6ABeKlDP9He2qX5aw4LeGP1qh3MkZG0QEbA==
X-Received: by 2002:a17:902:8f93:b0:142:8731:1a5d with SMTP id z19-20020a1709028f9300b0014287311a5dmr2672880plo.60.1636413775135;
        Mon, 08 Nov 2021 15:22:55 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f405:d461:2b86:9d34])
        by smtp.gmail.com with ESMTPSA id q32sm371147pja.4.2021.11.08.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:22:54 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:22:50 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Message-ID: <YYmxSptSDRPWJJ3t@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <211105.86wnlngebr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211105.86wnlngebr.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 09:51:12AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Nov 04 2021, Emily Shaffer wrote:
> 
> > A recorded hint path to the superproject's gitdir might be added during
> > 'git submodule add', but in some cases - like submodules which were
> > created before 'git submodule add' learned to record that info - it might
> > be useful to update the hint. Let's do it during 'git submodule
> > update', when we already have a handle to the superproject while calling
> > operations on the submodules.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  git-submodule.sh            | 14 ++++++++++++++
> >  t/t7406-submodule-update.sh | 12 ++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 652861aa66..873d64eb99 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -449,6 +449,20 @@ cmd_update()
> >  			;;
> >  		esac
> >  
> > +		# Cache a pointer to the superproject's common dir. This may have
> > +		# changed, unless it's a fresh clone. Writes it to worktree
> > +		# if applicable, otherwise to local.
> > +		if test -z "$just_cloned"
> > +		then
> > +			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
> > +			relative_gitdir="$(git rev-parse --path-format=relative \
> > +							 --prefix "${sm_gitdir}" \
> > +							 --git-common-dir)"
> > +
> > +			git -C "$sm_path" config --worktree \
> > +				submodule.superprojectgitdir "$relative_gitdir"
> > +		fi
> > +
> 
> Aside from the "is this really needed anymore?" comment on this caching
> strategy in general I had in [1] does this really need to be adding new
> shell code to git-submodule.sh given that we're actively trying to get
> rid of it entirely and move it over to C.
> 
> I.e. here we've just called "git submodule--helper
> run-update-procedure", and we pass it "$sm_path" (but not "$recursive",
> but could easily do so).
> 
> It needs to clone this new submodule, so presumably it already has a
> "$sm_gitdir" equivalent, and we can turn that into the same relative
> path, no?
> 
> Can't we call this with a git_config_set*() somewhere in that code?
> 
> *investigates a bit*
> 
> Okey, so I see that [2] is part of a series that Atharva Raykar had a
> version of (including this new git-submodule.sh code above) [3] rebased
> on top of an older version of this topic. I.e. this bit is that part of that patch:
> 
> +       git_config_set_in_file(config_path, "submodule.superprojectGitdir",
> +                              relative_path(get_git_dir(),
> +                                            update_data->sm_path, &sb));
> 
> I also vaguely recall that Junio ejected his topic to make room for this
> topic first.
> 
> Maybe I've missed some update on this but is his [2][3] broken in
> combination with your topic here? And re[1] is whatever "caching" is
> being done here still beneficial once this is all moved to C?
> 
> In your [4] there seems to be an agreement to do it the other way
> around, but as noted in the mail linked from [1] maybe the caching isn't
> needed anymore then?

I answered vs. your other mail; yes, it's still needed, and last I
checked Atharva's series had been kicked out to make room for this one.

> 
> 1. https://lore.kernel.org/git/211105.861r3vhtot.gmgdl@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/20211013051805.45662-8-raykar.ath@gmail.com/
> 3. https://lore.kernel.org/git/20211013051805.45662-1-raykar.ath@gmail.com/
> 4. https://lore.kernel.org/git/YWiXL+plA7GHfuVv@google.com/
