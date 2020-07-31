Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D28C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8453221744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jrVAfA4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGaUDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgGaUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:03:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36EC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:03:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so29980458qka.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5S67V2oMZMLm6H8wg8Dn/tD4XP+CRl2U9AuLtBj+zBw=;
        b=jrVAfA4JZz6Tq/LEUaMZq3x0nBW223DzZDsM9OYj6hLtOyUiMFvpde7Hg5IVdZWCJa
         +UvQ//mn77/QCyNPBhguRlxSkSZje2nFtMvJcnCKNYc6LUA+/gw9/cII9DCsbSwnnsG3
         cAy3MDtL+zWBcK2OjhiFGzFj2Ql5Su5gshmk3+TFvi9hRkMuxS0Mjg3SNid0rnYv50ZD
         8J/gZwheMN27kekX4j2Vjt6YORG12tmFTlxIf2JS7RSGryO7v9SmVPGSmfrYn4kFaKt5
         nsm7w3Kgeqpg4x5uycoJFhbzrZDn+KXEFRmzOcNv8YzB/2GxWXvPBVa5cypbt5ZZ6Tb8
         cjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5S67V2oMZMLm6H8wg8Dn/tD4XP+CRl2U9AuLtBj+zBw=;
        b=ET3/dH4pAPw8RRq2juS499a6qSDQR+ynxt5mT4onp/I/DEyzDXnXe2rEBV1tSv34Db
         TtsNLuP1tcmmZAV/GAJ2TCM0eTGtKgOFBZrhpunk1WjtQC5VjyOzXwFq2r5YGBIDUC5D
         io39hJ3M74NdQzOJFdWvcFAO27mpxwNTQSxvLXYv9T7cqaN/OiPE62LHTBR5SIqW9a6L
         xIugZsm21S3Jvfeahipj3I7Ng/98ijeBDf592xgUudn4kKIMNXAbdT9IeHvuY5zQFRgA
         9t0iMFhSTs/jB1Ar1zDDp0RoX5CcmOfBYNtuTy4DKXa8ZJDEeKizrS2Wr+IqMBKoVlL0
         VLcg==
X-Gm-Message-State: AOAM533IyQUN2MgdOsQSaV7dbK2Qwarfntgszr+deFtV8AeLzSdbnLjW
        L4ozPZpoPn2uMnZiqh+J7pcppiwEen4ULw==
X-Google-Smtp-Source: ABdhPJxVse51Ham9W847lttTTRo1Uximf6dswBudwX16Xg0i478AlIlJcB1gLa6dEBdZ60SbCGPovA==
X-Received: by 2002:a05:620a:2236:: with SMTP id n22mr5439421qkh.127.1596225788974;
        Fri, 31 Jul 2020 13:03:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id 8sm9976771qkh.77.2020.07.31.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:03:08 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:03:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into
 <branch>"
Message-ID: <20200731200306.GB3409@syl.lan>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
 <20200731004202.GA240563@coredump.intra.peff.net>
 <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
 <20200731022217.GA825094@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731022217.GA825094@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 10:22:17PM -0400, Jeff King wrote:
> On Thu, Jul 30, 2020 at 07:04:15PM -0700, Junio C Hamano wrote:
>
> > You'd rather want to "lie" about the destination branch while
> > redoing these merges, perhaps with
> >
> > 	$ git merge --pretend-dest=jch topic-name
> >
> > with your HEAD detached, and tell fmt-merge-msg to pretend that the
> > merge is being made into jch branch.  And that is outside the scope
> > of this patch, though it might be a good #leftoverbits candidate.
>
> Since nobody really asked for it, it may make sense to wait for such a
> feature. After all, this is the just the starting text we put into the
> merge message. You are always free to add the pretend branch yourself in
> the editor.
>
> > >   - should "master" be in the list even if you configure a value? That
> > >     would do the wrong thing if you have a non-integration master, but
> > >     that seems unlikely. And it would do the right thing if somebody
> > >     later puts "main" in merge.suppressDest, but still occasionally
> > >     works with "master" repos (where "right" is defined as "what they
> > >     probably wanted", but it is perhaps a bit magical).
> >
> > If you configure, you can configure it fully without manually
> > clearing first.  If you do not configure, you get a backward
> > compatible default.  I think that is the only sensible semantics.
> >
> > Besides, I thought we were aiming to make 'master' less special.
> > When a user already has a concrete list of things to use shorter
> > merge title for, why should 'master' be magically added to the list
> > and force the user to explicitly clear it?  I do not think that
> > makes much sense.
>
> It's magic-ness would be purely for backwards compatibility. IMHO
> maintaining exact behavior with respect to this particular case was not
> a big deal, but clearly Linus disagrees. But the "do the right thing
> above" I mentioned above is "do the right thing even if the user _did_
> switch their config to a new name, but forgot that they sometimes are
> working with old repos". So it is perhaps an even weaker reason.

I think that you could do this without treating 'master' as specially by
making 'merge.suppressDest' contain the value of 'init.defaultBranch'
(unless set otherwise).

This gets tricky when the fall-back value for 'init.defaultBranch'
changes, though. If it were to go from 'master' -> 'main', you'd want to
have both of those defaults in your 'merge.suppressDest' list, to avoid
breaking clients who still use 'master' (and expect 'into master' not to
show up in their merges).

So, I guess the rule would be: 'merge.suppressDest' contains the value
of 'init.defaultBranch' (or its default value) along with any previous
default values for 'init.defaultBranch', unless specified otherwise.

Apologies if this has already been suggested elsewhere and I glossed
past it.

> To be clear, I'm OK with the behavior in your patch. I just wanted to
> make sure we thought through all of the implications.

I am too.

> > >   - what's the plan if we do switch init.defaultBranch to "main"? Would
> > >     we add default_branch() to the list of defaults alongside "master",
> > >     or just add "main", or just leave it and let people configure
> > >     independently? It doesn't need to be decided now, but maybe worth
> > >     thinking about.
> > [...quite reasonable analysis that I agree with...]
> >
> > In any case, I do not think I want to see more reliance of the
> > notion that there always is one and only one single special branch
> > in the repository, so if we can get away without it, that would be
> > more preferrable.
>
> Yeah, if the plan is to stop here then I'm OK with that. That makes
> "master" special for historical reasons, but "main" or whatever never
> got this special treatment by default. People have the ability to
> configure if they choose, or they may not care either way.
>
> We might get a feature request later that says "gee, I wish we did this
> for 'main' by default without me having to configure it", but we can
> cross that bridge when we come to it.
>
> -Peff

Thanks,
Taylor
