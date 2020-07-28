Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EF5C433EC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06354206D4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Wc6Beasf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgG1Paq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgG1Pap (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:30:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64907C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:30:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so19047248qkb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1x4mZYk6crWkcuoMBk4cYRor/Hsty0XNXJzgAuhwky4=;
        b=Wc6BeasfVH3sPXqfAu6V5s8zzYTQ3aND1x7tx67GC4W02me27nv01JQnIQrBo6PhK4
         oXRH4sEBwtxYAdKm8GeRRyGO5T0HdsvmlQ8vmCQ7T2b/CJlksKh4DiA7BbDMCoVEik5G
         FrnwSzk1q8nLHcFFu6Z9T0rNrGNLjjsnOHvtj0gnk0smtN9bLNW/mMeOAYwBXqHLxXqb
         9RJSsFBbMIdQgSL6NBrSI64hxaWXIEIQo9T5uBjW/GpV31K9X1nSsoT/EEi4WkG5MoxQ
         FZYjJNE6EVAw0HifLD6UF6FDjLt09qfSvsSUI3ClCqutwUt2t4WOUH3d4IK5CnwvZ5kC
         xgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1x4mZYk6crWkcuoMBk4cYRor/Hsty0XNXJzgAuhwky4=;
        b=Tq8rLHLFxW1BB8uxxpIQ1iLcgwVOeN53TrUemsJbXhj79PkqKm7JIfTh5T1HXh3sqN
         M8pBOXzpmDI60cnIb3TucMGVR2Npp/CN0q+VEfHeRLsS5tETJXWjmf2hrDQEB00mBFNh
         tPxQewUKPgmaPlW8Uqrk5kRPdLUPSb12+p5Jjr01n+tkY4UNUsuzFPbwQxnkXQs8uHZu
         eQtIw+ddlBWdlioXcS5eqplPd2hWsK6qC+T3cTgOrKdrrWO4DHhxJwqRfp7te/d9M5EQ
         DF3qd6KRW3nHGjQwFyzVUgVVpqh9XYXjIcb7jwD0JGcG9ye6kp1eRX1+OHronmxmM7Hx
         ZU8A==
X-Gm-Message-State: AOAM5329vHgmRrGdrKW7aHmV6/zvChxOuBvOR1Q0iG011/EoEl9WqYgw
        vV5BRotMkI9IzSsJDr1pphXpAA==
X-Google-Smtp-Source: ABdhPJzZvir0RhC5rH5wRapQHiZoPsb6C6uypYu0BJcNn1Jq5FjF+HC/j0Z9auQ5yZzTgyUZHYjZEw==
X-Received: by 2002:ae9:f008:: with SMTP id l8mr27492599qkg.342.1595950244485;
        Tue, 28 Jul 2020 08:30:44 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id m3sm17579434qka.31.2020.07.28.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:30:43 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:30:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 2/6] revision: parse parent in indegree_walk_step()
Message-ID: <20200728153042.GC87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
 <b997b649-cfeb-4b55-9c83-1c0ee2a5677c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b997b649-cfeb-4b55-9c83-1c0ee2a5677c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:00:51AM -0400, Derrick Stolee wrote:
> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > In indegree_walk_step(), we add unvisited parents to the indegree queue.
> > However, parents are not guaranteed to be parsed. As the indegree queue
> > sorts by generation number, let's parse parents before inserting them to
> > ensure the correct priority order.
>
> You mentioned this in your blog post. I'm sorry that such a small
> issue caused you pain. Perhaps you could summarize a little bit of
> how that investigation led you to find this issue?

Indeed ;-). I feel like forgetting to call 'parse_commit_gently()' is a
rite of passage for this part of the code in some sense.

> Question: is this something that is only necessary when we change
> the generation number, or is it something that is only _exposed_
> by the test suite when we change the generation number? It seems that
> it is likely to be an existing bug, but it might be hard to expose
> in a test case.

I tend to agree that this bug probably existed before Abhishek's
changes, but that it's probably more trouble than it's worth to tickle
with a test case. So, I'd be fine with this fix as it is (provided that
the style nit is addressed below, too).

> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  revision.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/revision.c b/revision.c
> > index 6aa7f4f567..23287d26c3 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -3343,6 +3343,9 @@ static void indegree_walk_step(struct rev_info *revs)
> >  		struct commit *parent = p->item;
> >  		int *pi = indegree_slab_at(&info->indegree, parent);
> >
> > +		if (parse_commit_gently(parent, 1) < 0)
> > +			return ;
>
> Drop the extra space.
>
> Thanks,
> -Stolee

Thanks,
Taylor
