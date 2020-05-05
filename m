Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B897C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CAB206EB
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QG9vuOQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEEAQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgEEAQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:16:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3319CC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:16:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so39504pfa.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z+qOAE9EwrPCikK/jrZtyVBy4uv5mMxIzDEdrekjVsg=;
        b=QG9vuOQv2R1Unf+ujoruubNGBrqCIYr3i3fyg9HfCDwExn+BcGeZjGWCYg9fas3zsM
         1J66f75OaOmZxNgG9p6D6/cmLxtFzWuld67WAt+oMlmTMhTAgCB4gE+X8G2iCtF4v71V
         sIplqzMh2PhEIJUCLzVcTP+Xvdrl2XcqlooyVX0jTPtlQvhh/JQkTVT1GEjx7436jGb6
         DtrzeOgvXaXqUUric9OZ+hC2fffGuO9sL8Aokba+wm96qUSOy0vS4dkJK+PPr5Mgnxxk
         1BizQO5Od7CUw/I6xI722YpnuLzmc+QpkZOk1emHG+Jl8vxx7fsAmTrzAtC/23A5N8Pm
         qshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+qOAE9EwrPCikK/jrZtyVBy4uv5mMxIzDEdrekjVsg=;
        b=gFIs6nskDiEGpDi0DLpBAdhzezKxr40y+jx1vamXUn4k4k86N6bUxHcldOqxnT7EUb
         jV/TnyHyYnFNXfDNrW5Q/kMP1eZSWGlJLic5VtdAJaf5Ar52jjy7jDRf0S72v0kixU46
         5VcDjSa5HeUUQB9cvk0WynwFGvD/LP23R9SR39NnujXK17B7eLQ/PawImpe111yV5D3M
         Yekfohq0hpDb12EXQXcXpk8OSnoO1Zp6p7vsn1SniWWX+da1agxISO7fBJyz6xCQ77yW
         JFd3U2xFz4YZezkTq6Joqu3j3BnKeeyae01QfmmCIFt9O+cu6ziaQee7vqjZ8rfeDCc4
         27AA==
X-Gm-Message-State: AGi0Pubjk7HaA27sUQqVN36tY7eti26BeNfb3W18zoK3+FfYz5ati18q
        VkNU7TP5/bM3KCkirpr0QqeEwQ==
X-Google-Smtp-Source: APiQypLyo7ze/phvuZjEN9bHxFtQ2SiATdVKfzPu/uB1QGP0LnaWjGc3yExurOqERIU0UFxGLq1i9w==
X-Received: by 2002:a63:43c3:: with SMTP id q186mr700034pga.411.1588637800424;
        Mon, 04 May 2020 17:16:40 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a99sm125717pje.35.2020.05.04.17.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:16:39 -0700 (PDT)
Date:   Mon, 4 May 2020 18:16:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #04; Thu, 30)
Message-ID: <20200505001638.GB64230@syl.local>
References: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
 <20200501202411.GA41612@syl.local>
 <20200501224004.GA45288@syl.local>
 <xmqq4ksvitcd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ksvitcd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 08:59:46AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Fri, May 01, 2020 at 02:24:11PM -0600, Taylor Blau wrote:
> >> One thing that may have been passed over is my series to teach the
> >> bitmap machinery how to quickly interpret '--filter=tree:0' by
> >> discarding non-named trees from the result set. That is here:
> >>
> >>   https://lore.kernel.org/git/cover.1587597151.git.me@ttaylorr.com/
> >>
> >> This didn't get much review outside of from Peff, who wrote some of the
> >> patches, so I'd be happy to re-send it or wait longer for others to have
> >> a look, too. For what it's worth, these changes are fairly
> >> straightforward and we have been running them at GitHub (and allowing
> >> partial clones with `--filter=tree:0`!) for some time now.
> >
> > At the risk of nagging, would you like this one to be re-sent, or are
> > you feeling OK about picking it up?
>
> Ah, I completely missed this message.  I have no strong opinions on
> the topic itself myself and I do not remember seeing anything
> objectionable in the implementation, but a resend may give it the
> last chance for exposure.

No worries; thanks for clarifying. I resent it without changes as [1].

> Thanks.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1588633810.git.me@ttaylorr.com/
