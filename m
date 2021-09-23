Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDDDC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BD160F6F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbhIWCFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhIWCFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:05:01 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472BC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:03:30 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m4so4940984ilj.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KYLSFmRku+Z4psaZDmg9Op3RirlISwWSSbyh0QVPMro=;
        b=FWXqSzFM98jcFpiOokN0KK5bOJYNMhkbuTSMAGIaM52iXwytd4IzODFwepYeWS0m3s
         MFQQblGOGcWJ5SlK3mkcXxzqFwVB0LSMlQMdYgKhRGGlfgeIxBhRa7YRvNj/SBMXCBYK
         tvbS7stcsuynldVr7hrh7jtIyWr/8uszl8fhcyv2mlUmfBQjFdwN3wzq60zVCWCjJTjK
         T7avWD0zHfG+3AOaH9pfwoSje1+osD9QzzCUOOTxciAKyiLXd5eJT30LO69yqFKYaeDt
         FKm0nUmiv8sC/2KT+vTQUwHzREyT0jJEbVCn1vEvqH3KO+N3KaxsqeIbw7kRe/vA50h0
         Y4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KYLSFmRku+Z4psaZDmg9Op3RirlISwWSSbyh0QVPMro=;
        b=Qoh93oppVKv/GYipsfqHSj9zTy6kCXCF2CBgoI7j59wGSZMWut3TX5k7I++PA3SAyu
         fFKJtdXRGpyyDavaL5q9cql9eQfYgtXetUevMcJs6KvV4SbUXIuVcmTdsRRj1VIOKs0I
         HS7R+lQK2HioYiK3tnGSE2Veqf6J1pA13AF5vcTHTRSYDlc5khTs6p61TPRMkMre2nhh
         boDfUkxQFpifCRZISrFAjEjxpkE3YrNdHJohcYvPGQBZRExh3Pj1+5AaSNVyLGZy2t1z
         qdjye9a4WzEbDvo2PJ4kjwQZ0l+uylkmTDB6jMj/5SM8VvZWn8PcnaGdgP/Jq38uL1fq
         /LNg==
X-Gm-Message-State: AOAM531oz2mgoJhF2ehi7i84cEUstCkuwzZH0a8/nexsiE+nkB7IWvyF
        V1tYrTZ2CSBiAQ18AHC+5Nq2wg==
X-Google-Smtp-Source: ABdhPJzdxDtV2k2c+osCN4n3sJVFxWC1DfhzVlrrq8bkpRLhB9Z7A91eIgbwmWa4Sw57Z7Sar36pmQ==
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr1639711ilv.221.1632362609839;
        Wed, 22 Sep 2021 19:03:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 12sm1769583ilq.23.2021.09.22.19.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:03:29 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:03:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/8] builtin/multi-pack-index.c: support
 `--stdin-packs` mode
Message-ID: <YUvgbxRmUwZF87b1@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
 <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
 <YUuuYW3RktlDzskH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUuuYW3RktlDzskH@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 03:29:53PM -0700, Josh Steadmon wrote:
> Thanks for the series! I have a couple of questions:
>
>
> On 2021.09.15 14:24, Taylor Blau wrote:
> > To power a new `--write-midx` mode, `git repack` will want to write a
> > multi-pack index containing a certain set of packs in the repository.
> >
> > This new option will be used by `git repack` to write a MIDX which
> > contains only the packs which will survive after the repack (that is, it
> > will exclude any packs which are about to be deleted).
> >
> > This patch effectively exposes the function implemented in the previous
> > commit via the `git multi-pack-index` builtin. An alternative approach
> > would have been to call that function from the `git repack` builtin
> > directly, but this introduces awkward problems around closing and
> > reopening the object store, so the MIDX will be written out-of-process.
>
> Could you elaborate a bit on the "awkward problems" here? I'm afraid I'm
> missing the context here.

A variety of things can go wrong when the object store is closed and
re-opened in the same process. Many of the symptoms are described
beginning at this message:

  https://lore.kernel.org/git/YPf1m01mcdJ3HNBt@coredump.intra.peff.net/

and further down in the sub-thread. Many of those problems have been
resolved, but I'm not convinced that there aren't others lurking.

> > +static void read_packs_from_stdin(struct string_list *to)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	while (strbuf_getline(&buf, stdin) != EOF)
> > +		string_list_append(to, buf.buf);
> > +	string_list_sort(to);
> > +
> > +	strbuf_release(&buf);
> > +}
> > +
>
> I'm presuming that the packfile list is going to be generated
> automatically, but what happens if that becomes corrupt somehow, and we
> skip a packfile that should have been included? Will that cause
> incorrect behavior, or will we just miss out on some of the bitmap
> performance benefits?

A multi-pack bitmap can only refer to objects that are in a pack which
the repository's MIDX includes. So if we left off a pack from this list,
we'd be unable to cover that pack's objects in the resulting bitmap.
We'd also be unable to cover any objects which are reachable from the
missing pack's objects, since the set of objects in a bitmap must be
closed under reachability.

If, on the other hand, we read a line which does not correspond to any
pack, we'll simply ignore it. That's because we loop over the results of
get_all_packs() and try to find a match in this list instead of the
other way around.

We could mark the packs we found by abusing the string_list_item's util
pointer, but it's probably not worth it since this is mostly an internal
interface.

Thanks,
Taylor
