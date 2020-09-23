Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3EC47423
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F70E21BE5
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB/TFN7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIWKW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIWKWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 06:22:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86AC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:22:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q63so22208434qkf.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLoe9aHykVulDYLlKOCMmM3O9OjENMSxNKtKrf6tFWs=;
        b=CB/TFN7+xTVTmq53uQFpKK0A/awhpGZ6w4GEONIeNVIE5bWFZTvPXez1YLLC6+gY1f
         NzQY0n6TDra73uYKH/4iuC9SrbZqz26MsJhQCVWlOUGPrOhx2hLleui0wQ4m4ewKs1ld
         ihbAvx1p5rHLr6rPy4gP/aIoDCXdpssuOSx+uIsDjkr24ITXWpwbVMfLPasvZKmOAcT2
         wW6Ack38vpAuvktEZky6kIeyP5//aCS2BnQO8kphkC0+h3AZE89rE3ZV6TGxeE+f0Lgq
         QUcBcF8bvzQfYJ4dU9n8WEDY2HzQInh46tlfWTvbn2sr0Vim9ZsaVw9SSAwaxmW4PaR7
         vemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLoe9aHykVulDYLlKOCMmM3O9OjENMSxNKtKrf6tFWs=;
        b=Ze1t2JU/9SIkLbKdDuZcnqndBOvK99S3Ormje/1VcQWI59sIqpoht8BXeAf3J9qprW
         EV5qTesJaU1rq42jo9i7MxGw40qp1tUimI1vos3s/jOss+4RGPf0KB1pRJGJNMBkvCcI
         eCMYok2wK4SbTVZ/+pEyuRiyyCSI2eXchJyM7os1/JxFDbmC41b4I7fiT53qE4PyFTnC
         Funn7GDAkAldppe6zdYR0r2ix7WRLOAubuHgirogFKQZkXQ/5DzvHtTbuKxikBvo5N0l
         /B3R1D9F/4oFD5aMhtA3nYo9ZuRe7+h+AjQPaHkWtSHFE/Y4e6mkxr0BL+lmTqziIMYJ
         CZIQ==
X-Gm-Message-State: AOAM530cf6Oi2tzPAMUTUMc/I8gNxm8ynUeezLIWhYWA2TBZ1fonp9Mk
        7E7Ae/Fa/xv4yMxha3UyD+g=
X-Google-Smtp-Source: ABdhPJxNk5XAcjygyjuSfgDysEIn0YNi8xHVlAcQmJ4VImXC1xIo+s3Go/4QwJbCZOGDKVb41aMX4w==
X-Received: by 2002:a05:620a:39a:: with SMTP id q26mr2818512qkm.305.1600856542243;
        Wed, 23 Sep 2020 03:22:22 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id g14sm13369947qkk.38.2020.09.23.03.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:22:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 15:52:15 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20200923102215.GA70669@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
 <xmqqft7djzz0.fsf@gitster.c.googlers.com>
 <20200921084231.GA64896@mail.clickyotomy.dev>
 <xmqqimc7ezk2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimc7ezk2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/21/2020 11:48, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> >> If we were talking about older parts of the history, optional
> >> generation numbers could change the equation somewhat, but the
> >> common case for the workflow this series is trying to help is that
> >> these local commits ane the remote tip are relatively new and it is
> >> not unlikely that the generation numbers have not been computed for
> >> them, which is why I suspect that in_merges_many may be a win.
> >
> > Nice! We can definitely try batching commits from the reflog and
> > pass it along to "in_merge_bases_many()". As for being faster than
> > calling "in_merge_bases()" for each commit entry in the reflog --
> > I am not familiar with how the former works. Do we still keep the
> > "reflog_entry_exists()" part? It might still be faster to go through
> > the entries once to check with "oideq()" in the first run.
> 
> That is what I meant.  You go through local reflog entries until you
> find one that is older than the timestamp of the reflog entry of the
> remote-tracking branch, check with oideq() to see if the tip was ever
> directly checked out.  Then, using these same local reflog entries,
> you can make in_merge_bases_many() tranversal to see if any of them
> reach the tip.  I suspect that the number of local reflog entries you
> need to examine would not be too many, so if you can put them all in
> a single array of "struct commit *" pointers in the first "oideq()"
> phase, you may be able to do just a single in_merge_bases_many() batch
> to check for the reachability.

Gotcha.

> > Also, I was wondering if it is worth considering this:
> >   - check if the reflog of the HEAD has the remote ref
> 
> It would help the workflow I had in mind, but it would raise the
> risk of false positives according to Dscho and I tend to agree, so
> I do not know if it is overall a good idea.

Oh, right. This doesn't work when a "git pull --rebase" is run on
a different branch (and a few other cases, as mentioned by Johannes).

> >   - check if the reflog of the local branch has the remote ref
> 
> Isn't that the oideq() test?

Yes.

> >   - check if the remote ref is reachable from any of the local ref's
> >     "reflog" entries using "in_merge_bases_many()" in batches as
> >     suggested here.
> 
> I think it amounts to the same as "does any reflog entry of HEAD
> reach it?" and shares the same issues with false positives as the
> first one.

Hmm, isn't this the same as what was mentioned by you earlier (without
the timestamp:

> [...] Then, using these same local reflog entries,
> you can make in_merge_bases_many() tranversal to see if any of them
> reach the tip.

In v5 (the new patch) [1], the check does this:
  - go through the local reflog until it hits an entry with a timestamp
    older than the remote commit, and doing an "oideq()" check and
    collecting commits into a list along the way.

  - if an exact entry was found, the test passes; otherwise use
    the commit list and make a call to "in_merge_bases_many()" to
    check for reachability, and report it.

> >> > +		deletion:1,
> >> > +		if_includes:1, /* If "--force-with-includes" was specified. */
> >> 
> >> The description needs to be tightened.
> >> 
> >> > +		unreachable:1; /* For "if_includes"; unreachable in reflog. */
> >
> > OK, you're right. Perhaps, we could rename it to something like
> > "if_includes_for_tracking" and update the comment description
> > with saying something along the lines of:
> 
> That is overlong.  Let me try:
> 
> 		/* need to check if local reflog reaches the remote tip */
> 		check_reachable:1,
> 
> 		/* local reflog does not reach the remote tip */
> 		unreachable:1;
> 

I have updated the description in v5 [1]; thanks!

[1]: https://public-inbox.org/git/20200923073022.61293-1-shrinidhi.kaushik@gmail.com/

Thanks.
-- 
Srinidhi Kaushik
