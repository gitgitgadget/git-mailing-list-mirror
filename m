Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C28C7114E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E02465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RchrojSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBSWHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:07:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40865 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgBSWHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 17:07:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so795726pgk.7
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 14:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/iCpG/K9BmhIzGsXoxZR2Q0/5y+JqJQYmOG7x+uxKoA=;
        b=RchrojSDI1gkgay0Iv5OAFPOUh7lrLy7Xah+AH9ZnzGA/GN4TMkZRFm1a5v8z3fmmZ
         QLV+n+/0RCD1TgCuLIEGFXcxMKhnjkkINhjX9P7YId9EWQ1mWRnMPfRKkz4WSxsAePPa
         pgiLO+VzJKa7O8Elp4mKv2vo9oTxj5H5AOmC4rKU99l7jlxq7agZJIA6vx5FLRqkpgVz
         TCHaD+kKhhtZ5RlrEof98wKEf6fW2CLBM9mvvgDiJkj+3Y74+n7GFNppI+taqDEWSN4z
         EWFqDqHj/vDutLcfw84uutIDNIfJXZC04bUrcoe2w5zKNFf6cbHVDCNZUFtwVv/thnto
         Io5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iCpG/K9BmhIzGsXoxZR2Q0/5y+JqJQYmOG7x+uxKoA=;
        b=rdfgO1oVo1iMn01rcRMRmKUfA8MYi+UxR07p17ydptI+C+pXp/V3l2oYFKQfZs7N+A
         ojJJfTTwVTmxe9GF5x8rzSvAkY9DBzr8tByHzZYNd0znBATwGFoEdEU88T3SuBDvYKjy
         zrkO2gcdRnSVTyaTYc2kJZvaZM28QvtrD+3JXEiGm2w9mfa0pTho89gb3ufc7cszKvF+
         9iQFXmqvCTMluYOdeRgk2BrB1az8MhfDVWG6sdVShzzmOzIRLGLCRi2xYs6YUhmckbZs
         l2RuzmrkI3h3oCT6C4NTkzdT6q2Bvv5qkGHiZPVN5bRCcForO2vkQogxLSrtxOViX3e7
         qyPQ==
X-Gm-Message-State: APjAAAUOMarGdzPJ8aCAqoWuqyBBqkK5XiihtxpXUnf4QZ2WIFTzgV/5
        2fxj1+uFcbAOjO/QE4+MChNRU9ucu1Iiww==
X-Google-Smtp-Source: APXvYqxzgsO8AkDBTxy+iqPavtLPlelflblPAOxY+38TQ8a+RIunjV4AU0glxgiUetBcZWhyXLc0kw==
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr31794296pgm.112.1582150040161;
        Wed, 19 Feb 2020 14:07:20 -0800 (PST)
Received: from localhost ([205.175.106.52])
        by smtp.gmail.com with ESMTPSA id r26sm674214pga.55.2020.02.19.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:07:19 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:07:18 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
Message-ID: <20200219220718.GD5101@syl.local>
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
 <20200219195822.GA5101@syl.local>
 <xmqqy2syckju.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2syckju.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 01:51:49PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Feb 17, 2020 at 02:08:38PM -0800, Junio C Hamano wrote:
> >
> >> * tb/commit-graph-split-merge (2020-02-12) 3 commits
> >>  - builtin/commit-graph.c: support '--input=none'
> >>  - builtin/commit-graph.c: introduce '--input=<source>'
> >>  - builtin/commit-graph.c: support '--split[=<strategy>]'
> >>
> >>  The code to write out the commit-graph has been taught a few
> >>  options to control if the resulting graph chains should be merged
> >>  or a single new incremental graph is created.
> >>
> >>  Waiting for the discussion to settle.
> >>  cf. <20200212205028.GE4364@syl.local>
> >
> > I think that this discussion is still "settling", although the thread
> > hasn't had any activity for a few days now.
> >
> > I wanted to get feedback from my response to Eric Sunshine before saying
> > that we have consensus, but otherwise I think this is moving along.
>
> Did you mean Szeder?

I did, whoops. Thanks for noticing (and sorry to Eric, who I see has
responded just above :-)).

> https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/

Thanks,
Taylor
