Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DDC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB242087F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1AqZEQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgB1AD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:03:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43612 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgB1AD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 19:03:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so510743pgb.10
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+FAN66pUleVyoVpKtS8WJciZqKGXFZTCS1u7QHQF5M=;
        b=E1AqZEQXAsY1ly0eJ+L6RO/vGGis/wlhVL5iFfCbt/o5/AB3Rd90wokcNvl5bVmFPJ
         iRwNAQTf7w0i4fD+exrZAURXbNHxwcaoGMs1KfO5mg9kqBJqlb6MTh4VgtLBCV1qUsI1
         iwoD6BXw85XV0z7V/FDnEwHZt+6iXWn9IVZ1MkDj4Lb67ls57PbMVKXJhOuwkyTsyv6n
         qW/6BdVlMos3UvFcUXg6oZT+8hYmY5eCgkIzjZSN7hr94/JGKgmyRcLp+okMi0EgJje6
         Hyuiy8P7X1L4ajAn7q1EB3Naxk6iqZSEVs5eeV3/P1DuCvuEXRMhm2DK0a9zr4KkxeS2
         LKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=V+FAN66pUleVyoVpKtS8WJciZqKGXFZTCS1u7QHQF5M=;
        b=ivnypmHEKqSUBhOyDAx6P2yynfhufIH+cggnK8QwJ/j4DrDIEZqnySvFho+6dLByV6
         EUs6t/bwE36BaO9l8/zBqQBFFYJY2+ejwkHhEvpRCcPHpUvuWJZFIzllDT0Ob/qawJu2
         dyiVnA6C2wloFdizsa32sx3bhle503O3PU5zuFjqb2B+bXxY3Qtn3kzQ/OUIE2Za8MBh
         XqCfjQ0triIEOQ+zaEqhYUgYx7DR/q8SoKBergU4uapTUq6P7gxaUIIUd6xi8I/GWGta
         Id7nitwP39G9ZhdwliWyMzYXuhl3MBQNIxq8zQxahUDl+EYYVZHelOnfMs2VwUupWb6a
         ZvUw==
X-Gm-Message-State: APjAAAX60ARShyYuvyS8GkT3+qlUYseYOY+gxLodHXkqAG9i3HzvAmBR
        MKTokPTpfeIX0cgmsjp7LRfXVw==
X-Google-Smtp-Source: APXvYqwqeadqf+xEJBH/GSTC41GfIHIFi0fTEpNz8ijK/uwOZXo+lk/rPrvyfQYW2oGDwjET31Nv2Q==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr1743118pgt.432.1582848236503;
        Thu, 27 Feb 2020 16:03:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id y1sm4629755pgs.74.2020.02.27.16.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:03:55 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:03:50 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 0/7] Better threaded delta resolution in index-pack
Message-ID: <20200228000350.GB12115@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com, peff@peff.net
References: <cover.1570663470.git.jonathantanmy@google.com>
 <cover.1571343096.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.17 13:17, Jonathan Tan wrote:
> Thanks, Stolee and Peff, for taking a look at it. Here is a v2. It is
> mostly unchanged, except for expanded commit messages and code comments.
> 
> I've also added a documentation clarification that
> core.deltaBaseCacheLimit is per-thread, appearing as the first patch in
> this patch series.
> 
> From patch 3 (now patch 4):
> 
> > > +	int i;
> > 
> > Technically this probably ought to be a size_t as well, but I'm much
> > more concerned about the allocation ones, where we might accidentally
> > overflow and underallocate a buffer. Overflowing "i" would probably just
> > lead to an error or bad result.
> 
> I believe this needs to be signed, since we're iterating in reverse
> order, so I made it a ssize_t instead (note the extra "s" in front).
> 
> From patch 4 (now patch 5):
> 
> > > Whenever we make a struct base_data, immediately calculate its delta
> > > children. This eliminates confusion as to when the
> > > {ref,ofs}_{first,last} fields are initialized.
> > 
> > That _seems_ like a good idea, but I'm a little worried just because I
> > don't entirely understand why it was being done lazily before. If you've
> > puzzled all that out, it would be nice to make the argument in the
> > commit message.
> 
> I've added an explanation in the commit message.
> 
> Jonathan Tan (7):
>   Documentation: deltaBaseCacheLimit is per-thread
>   index-pack: unify threaded and unthreaded code
>   index-pack: remove redundant parameter
>   index-pack: remove redundant child field
>   index-pack: calculate {ref,ofs}_{first,last} early
>   index-pack: make resolve_delta() assume base data
>   index-pack: make quantum of work smaller
> 
>  Documentation/config/core.txt |   2 +-
>  builtin/index-pack.c          | 446 ++++++++++++++++++----------------
>  2 files changed, 242 insertions(+), 206 deletions(-)

This series mostly looks good to me. There were a few parts I had
trouble following or convincing myself were safe, so there could be some
improvements with comments or more explicit commit messages, but no
problems apart from that.
