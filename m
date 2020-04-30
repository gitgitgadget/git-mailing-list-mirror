Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEEC4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8622072A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="skshlgoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgD3TWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgD3TWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:22:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A7C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:22:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so328708pfx.7
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xiJoO9JJWXepBi53jbbSfQ+YpgkKx0sA0ExdMAeCa/g=;
        b=skshlgoG3lNDEudXMVbtCHa395GgWUxqkx3BrpiXY1Re3hiCmBEIqt4f15ctvRrdje
         7aSO/6usdufLYdImjyYnywPUK3AycGKhL4+eidtFg6csmifTRjGWVq5hCZtVCEBKmH6k
         M2Cmrs6KIh1BZ2eAg5HFbFs7LulgAoHcM3b2zdOZzHoBEqjucp3BzXYP6BDsxAvBw484
         PeWRS0PKZZHf/hVlwayLl+5PcBUIg2bwnKORZyayd1lDnvw6QUDwaX5RuCtrMIAbkcO5
         WjGLNEXYrNeRH+arRN7bDORJoA54QvEs3nIUwqQ7kBYEGD0Y57XGnczKyZR61s+Efa0W
         RH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiJoO9JJWXepBi53jbbSfQ+YpgkKx0sA0ExdMAeCa/g=;
        b=cf9pLUGy0mHOnYAsWEmE19oWAtwoNK/EJW+VD51HskGpIccB+NZtPy7t+TgyOmzWGy
         wpdQ1HjktR2R4oyU2hEtisFyOxNkK6wDi0NK5J8V4L/JtFODHY1n72wIQC3ufsb4kAiQ
         DQN4D+hMbWDUEKAHOXxQqyvO3dKXvSOoi28fTjXKyuuz/VFhvVHSkGmTJcpU5hw29p7u
         4jGLwQE+GyEZHWNlQpoC1NjB0I8WvCJMIoh7YIuP9sKSM6wk1wTE5L0FjOmgtXSZ8kLx
         0jm5Q7j3WCje8qwPY39Gya6hjYPMcIc8wxZvQBL2pYU7VDcl1lbQXKr+ttjjdqsYOSZq
         CJDw==
X-Gm-Message-State: AGi0PuZ3UA3bLWl9OWVEE8YS6r/ya6VAaXADAlcghs0R241iwku5r1yX
        YkMKFdQoo3sZzsp+tsKhudd8l0Ts0uFh/A==
X-Google-Smtp-Source: APiQypLygcmSEnfkQHmMpbl52NZA1SWi4RynEpWw+uJ6sZU2Fjypj+ZC1SwLQ+xtitY3GiyDFq0XJg==
X-Received: by 2002:aa7:9ac9:: with SMTP id x9mr264257pfp.304.1588274574183;
        Thu, 30 Apr 2020 12:22:54 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 207sm452392pgh.34.2020.04.30.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:22:53 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:22:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 1/5] commit: make 'commit_graft_pos' non-static
Message-ID: <20200430192251.GA6280@syl.local>
References: <cover.1588199705.git.me@ttaylorr.com>
 <8ac4c63735f2e48dc83e9f31c9fbbbfb47d7e79d.1588199705.git.me@ttaylorr.com>
 <20200430032611.GF115238@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430032611.GF115238@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 08:26:11PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
>
>
> >            [...] by making 'commit_graft_pos' non-static so that it can
> > be called from both 'commit.c' and 'shallow.c'.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  commit.c | 2 +-
> >  commit.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/commit.h b/commit.h
> > index ab91d21131..eb42e8b6d2 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -236,6 +236,7 @@ struct commit_graft {
> >  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
> >
> >  struct commit_graft *read_graft_line(struct strbuf *line);
> > +int commit_graft_pos(struct repository *r, const unsigned char *sha1);
>
> Now that this function isn't file-local, its name becomes more
> significant.  What array does this represent a position in?  What does
> it return if the graft isn't found?  From a call site it's not
> necessarily obvious.
>
> Ideas:
>
> - could include a comment saying that it's an index into
>   r->parsed_objects->grafts

This and the below are both good ideas to me. I prefer this one, since
we'd have to duplicate yet another static function
('commit_graft_sha1_access()' directly above) that is called by this
one.

> - I'm usually loathe to suggest unnecessary duplication of code, but
>   it might make sense to duplicate the function into shallow.c.  Or
>   even to inline it there (in the single call site, that ends up
>   being pretty readable).

I am not at all offended by duplication of code where it makes sense to
do so, but having to duplicate two functions seems like we'd be better
off simply documenting the function in commit.h.

> Thoughts?
>
> Thanks,
> Jonathan

Thanks,
Taylor
