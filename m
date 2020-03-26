Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A5C2D0ED
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE8E206E6
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OX7DqlFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCZTvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:51:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39478 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 15:51:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so3312168pfn.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdXyNbW5a3wDYCXr8ICW9SlW9dpFgVSIQV9C2D/Sqck=;
        b=OX7DqlFLkgSjTYuXEyEdsgoJokZSpsYBJpgCQBfzODj76zv+I8VtY3aEF6U3fHyphT
         M6+Z9f4Fa556zcfzz8CSrT6cQCSmUF/qQ52mkfJ+rzlVqR88O+EeLl+iHTvZ6PlSO/uZ
         Iyj99Fv9QZ1BAah6u6P8I4qCIXAQhbxMoWSNS5I6mFaPQnFExI2mXkCPxGHDsbblcMoq
         4Yz4vrktoqbePtQYf7EQ2wmE4Er26FfkdQu6L6p9Bct6Po0f1vmKm4aqBidtxViw6aqJ
         iUCRtZbcSpfkLQNWD6nyFcA2yZfdElXTMA8CxvymO3fxu5vXM5PHaRZYAe/LpMuhpC5P
         mdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdXyNbW5a3wDYCXr8ICW9SlW9dpFgVSIQV9C2D/Sqck=;
        b=SeeH175ahD9iyJaYErMU50fwu96MWq7jv0vXPJ824nsa0hbNjnlTHmSXGS0+qusgsJ
         oCJxh/P06EbP+y2s1+cHioKsn5TUZMjskA9PW63TbgKh3oiKEF3Fi77r02PKDVBLgdWf
         0AF1dTrjHmvcRO7bzFyiUG0+obQCnq0S2/e3Zks9eNgfSm+JYcll2LlXnT0pyMnenOzT
         UY/wQYrwQ4NzVzSm51wa47fVhZUTq2XUjer2pL8qyTRAppFfZI4C0KketmCxUK0m6mWL
         QbSRwwQP9+NgW//2tU6vRvXZkBVoRy9Sv6SOig2tmI3pA4WMU/70hTBl+yyUocHNYJ5E
         Fhxg==
X-Gm-Message-State: ANhLgQ2hvt9LmTrzzAohRQTfeOk2Sd+fHVidHUDA7Zueu3ho4WBncD+Y
        LiWn/YPRrxJ6aOv9pQ/laAEgDYYrNDk=
X-Google-Smtp-Source: ADFU+vuBrOaI/d1PacqoMuo3rrGlew4NBWE/y2BjGAQxaJDllnLy73mwWdQlixRVw53bmcyjUm5Mhg==
X-Received: by 2002:a63:60d:: with SMTP id 13mr10019480pgg.151.1585252261008;
        Thu, 26 Mar 2020 12:51:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i2sm2049416pfr.203.2020.03.26.12.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:51:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:50:58 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: lazy fetch using tree:0
Message-ID: <20200326195058.GA8613@syl.local>
References: <20200319174439.230969-1-jonathantanmy@google.com>
 <20200320061214.GA511478@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320061214.GA511478@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Mar 20, 2020 at 02:12:14AM -0400, Jeff King wrote:
> On Thu, Mar 19, 2020 at 10:44:39AM -0700, Jonathan Tan wrote:
> >  - Some hosts like GitHub support some partial clone filters, but not
> >    "tree:0".
>
> Yes, this is going to fail against GitHub servers, just like it would
> for older servers. One way to prevent that would be to use a "blob"
> filter if that's what we originally partial-cloned with. I don't know if
> that information always reliably makes it into this code path, though.
> I think I'd prefer a capability-based fix in the long run.
>
> We may support "tree:0" eventually at GitHub. It's quick to compute with
> bitmaps, just like "blob:none" is. But "tree:1" isn't.

I'm rolling this out shortly :).

> One side note (for Taylor, cc'd): our patches elsewhere to limit the
> allowed filters don't make it possible to express the difference between
> "tree:0" and "tree:1". It may be worth thinking about that, especially
> if it influences the config schema (since we'll have to support it
> forever once it makes it into a release).

They do now, mostly thanks to Peff's original thinking about separating
out each filter choice into its own subsection, so that we can write not
just:

  [uploadpack "filter.tree:depth"]
    allow = true

but also:

  [uploadpack "filter.tree:depth"]
    allow = true
    maxDepth = <n>

I have some patches that I'm rolling out to GitHub in the next day or so
that do just that. I think that we will likely just support the no-trees
version of this filter (i.e., '--filter=tree:0'), since that is the only
case that is helped by having up-to-date bitmaps enabled. I assume that
other administrators will do the same.

I'm going to send these patches upstream in the not-too-distant future,
because I want to address the original issues that I talked about in my
RFC about adding these filter subsections to 'upload-pack's
configuration in the first place in [1].

My hope is that I can do that while these patches are being vetted in
the wild before I send them to the list.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1584477196.git.me@ttaylorr.com/
