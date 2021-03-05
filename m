Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4576EC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FE8650A0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCET1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCET1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:27:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBFC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 11:27:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t4so3167696qkp.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mUP5Jte/WeQ0XZB4+ANPZxhsOVLCwnJ/LtRLcURJGr0=;
        b=FRl47ikl9zlKGLkwBGzHIHFfHtpTn63NrkmsMNwCKY72hRFaEjXOalt8q2yvJntfn3
         y7ZC5M+NWHWFXhf7EBd0QnasMtm6SPkwnasbzCAMME4FE56ribkbRJR3eXTltO7T+M1H
         0w+aUJaOQg8t8jFBiOfN9sDXVeQFdXrmSWqGJ2tEquLw6VdiYjZ6aXWsaghldgEmUvye
         d05+L4iBXHvj13XokGU3hteKpln2+w/MbgOjWQNpI6ZLp/P8a3kh6VC7hcwOanKAKo1a
         BKJIytGcdK5Ic4ZLvap4LHJqeWPfawLtCEUEBupXSZb2Mp4tN8HaL32yAlr70b6ZkmMG
         BwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUP5Jte/WeQ0XZB4+ANPZxhsOVLCwnJ/LtRLcURJGr0=;
        b=fOB3p3pdv1+ZboAb2OG3FcSDzpabUR/CBCftntgJ9mYQAuC9vxZ/TzasMXsOQT7/mR
         /rdoByjkVhO1PwHGCHkbXXLjskjVJOc6BjS/z5KuXkaqSqmIHHqGWlux7gg+Ji/VbSX3
         AAzYnA1I6pilzzNS9BJU1JFioXGhFUM9lRF96bFLgHe+xtWxYLQVobVVO7XLs6ZZxKdc
         9lxBIcKzdKcl1x6oB3YkYa/Fr5SuZlQI1mJzn1uoeKB+mN7F6Tb/32sTiBjUzeusImag
         JRUY7ZifoVZzu7cfOe5RivOXJjjQVYmRY1f//nukBR4B4kMmcxTnGzDLcw+gPHC9on6P
         X6Dg==
X-Gm-Message-State: AOAM5315UtgHkN73zj3L2P4kSpaf9dXKlWMb+0qpqGRvnJq3Xi0J7rGR
        teMbo8ZbMR4e7S3dq1Zl1i9Byw==
X-Google-Smtp-Source: ABdhPJyOfMuBjHzWh5yw8ZFHTcLt1WcXYeRi1oK/DWIZoLlIvkxwAxEBhXr1O+dljmZZDOjrh3hJxA==
X-Received: by 2002:a37:c16:: with SMTP id 22mr10737060qkm.84.1614972464748;
        Fri, 05 Mar 2021 11:27:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id 4sm866909qth.74.2021.03.05.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:27:44 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:27:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/5] builtin/repack.c: do not repack single packs with
 --geometric
Message-ID: <YEKGLfUM1DSHk74B@nand.local>
References: <cover.1614957681.git.me@ttaylorr.com>
 <80bc7fa8397491d015b80a39168813d2019e262d.1614957681.git.me@ttaylorr.com>
 <xmqqv9a59ztd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9a59ztd.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 11:15:58AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Loosen the guard to only stop when there aren't any packs, and let the
> > rest of the code do the right thing. Add a test to ensure that this is
> > the case.
> >
> > Noticed-by: Junio C Hamano <gitster@pobox.com>
>
> I do not think I "noticed" anything, though.

Well, I clearly didn't notice it, so I'm happy to pass the buck to you.

> > -	if (geometry->pack_nr <= 1) {
> > +	if (!geometry->pack_nr) {
> >  		geometry->split = geometry->pack_nr;
> >  		return;
> >  	}
>
> When pack_nr is 0, split is set to 0.  Otherwise we compute the
> split the usual way in the new code.  Let's see the post-context of
> the above code and figure out what happens when pack_nr is 1.
>
> [snip]
>
> I however wonder if it expresses the intent more clearly if you did
> this upfront, instead of forcing the readers to go through the code.
>
> 	if (geometry->pack_nr <= 1) {
> -		geometry->split = geometry->pack_nr;
> +		geometry->split = 0;
>  		return;
>  	}
>
> That is, "when there is no existing packs, or just one pack, we
> split at 0"

Hmm. I originally wrote the patch as:

    if (geometry->pack_nr <= 1) {
      geometry->split = 0;
      return;
    }

instead of only when geometry->pack_nr == 0. But I was pretty sure that
the code below was doing the right thing even for geometry->pack_nr ==
1, and so I decided to avoid making this non-special case "special" by
returning early.

I could see arguments in both directions. But I may be biased as the
author, so I'd rather defer to your judgement instead.

> The code that gets affected by the setting of "split" is this piece
> in the caller, cmd_repack():
>
> 	if (geometry) {
> 		FILE *in = xfdopen(cmd.in, "w");
> 		for (i = 0; i < geometry->split; i++)
> 			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
> 		for (i = geometry->split; i < geometry->pack_nr; i++)
> 			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
> 		fclose(in);
> 	}
>
> When split == 0, we end up feeding no positive packs and all
> negative packs, which results in nothing to pack.  I wonder if we
> can optimize out the spawning of the pack-object process, but that
> is probalby optimizing for a wrong case.

Yeah, I think the earlier optimization (avoiding repacking the contents
of a single pack) is more important than not opening pack objects here.

But the next patch demonstrates why we can't do this: we care about
loose objects, which we may still pick up even if split == 0.

Thanks,
Taylor
