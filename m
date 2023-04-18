Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7486C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjDRRI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjDRRIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:08:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04B2693
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:08:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a11so7437406ybm.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681837719; x=1684429719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv+Nw266l/w4aF4fCfsImktivhHRLSEDi0WMgAVZZtQ=;
        b=q/02leVIJjeA4wHcODBNEjFqceD4J1JIJuHJ9PI1se8K2Y+HygJ7QhAwHCZHOOiLFY
         Tw3GfyQ+IYu0CSc1axbHEC8JytoLov03Y5NFamMBrLApCtXjYZl7cMoeZ9hwFH8IB1Wx
         vztOG/T5KJ/O/Osr0WZid+45jvsQwf6Vuqr3/uqJXsRCyYxIoPFwYqs+BeK4dodGqW9u
         +mzqOE2wyY/+XWFcpWLfJkDRZYwwVGzgASQD07k1BVsYJV3EWPLv7Tn85nMnZjlLqRdm
         wHrY9sRGJxdok3hxWwWJp3hL9mbMXYY5D1yryi+PN24CTqo/ExrboNS4U9y4Z0n+ScD/
         X6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837719; x=1684429719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv+Nw266l/w4aF4fCfsImktivhHRLSEDi0WMgAVZZtQ=;
        b=i8X4UO6KpTdSH4bwF7q1xDIgd1ka6PsXMUBeRX6IYfQzsP4tw51/JAcsUdYjt5Sf94
         yhBPdC//tdE3RjhbWQuIEUlOO/O8qQAyoVpcvLmSrX+quadId03uTp67u4sgTedhlhLG
         CGdMniedEMBHX38Edzug3Fo6h5iouMvowcLCCGOqcxDTC0nKDo79ixN8jvRaEoM7S/P+
         GFia6wd0WIXr60pq8jvgukkxa8fYBgQVN13X5PYmUW5Mb1RmWXQzUdhj7WsOSJVHJgqJ
         qveQ3UEwcsKnacOVrOdWKodUAJ8WAhL440CYQzf+WRYakd/lVOl+K/823sdz6GNkx5pK
         OgKg==
X-Gm-Message-State: AAQBX9eCjRYysZSDm3xF5OdO/y+k3SvTEB4vRkHyrzQ+SWOPpgBScVOa
        flynmxR5jEtunsewDaZh7JVYtw==
X-Google-Smtp-Source: AKy350ZNDKwHWYYtMitgcOjM6roGTpuQRPOq5CKcw+Ss+zMeGZ88Oy7/xbhhgqFwBkH8VuvKBpAlGA==
X-Received: by 2002:a25:655:0:b0:b95:6ccc:56a7 with SMTP id 82-20020a250655000000b00b956ccc56a7mr2799007ybg.46.1681837719308;
        Tue, 18 Apr 2023 10:08:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f188-20020a256ac5000000b00b923f7a98a9sm1898643ybc.7.2023.04.18.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:08:38 -0700 (PDT)
Date:   Tue, 18 Apr 2023 13:08:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <ZD7OlWjApwvE8Aih@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <dda218c8c1fdc0ca2e4352b820f3432565a74a23.1681428696.git.me@ttaylorr.com>
 <20230418101058.GA508219@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418101058.GA508219@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 06:10:58AM -0400, Jeff King wrote:
> On Thu, Apr 13, 2023 at 07:31:43PM -0400, Taylor Blau wrote:
>
> > Instead of using `strchr(2)` to locate the first occurrence of the given
> > delimiter character, `string_list_split_in_place_multi()` uses
> > `strpbrk(2)` to find the first occurrence of *any* character in the given
> > delimiter string.
> >
> > Since the `_multi` variant is a generalization of the original
> > implementation, reimplement `string_list_split_in_place()` in terms of
> > the more general function by providing a single-character string for the
> > list of accepted delimiters.
>
> I'd imagine that strpbrk() is potentially a lot slower than strchr().
> But I kind of doubt that splitting is such a hot path that it will
> matter. If we want to care, I think we could do something like:
>
>   end = delim[1] ? strpbrk(p, delim) : strchr(p, delim[0]);
>
> It's entirely possible that a half-decent strpbrk() implementation does
> this already.

I did a little research here, and it looks like both glibc[1] and
musl[2] already do this. Those links are for their implementations of
strcspn(), but which both implement[^1] strpbrk() as "p += strcspn(p,
d)".

> So I mention it mostly in case we need to revisit this later. I think
> it's OK to ignore for now.

In addition to being OK from a performance standpoint I think solving
the semantics concern you noted lower down in the thread[3] is fairly
straightforward.

When in "_multi" mode, I think this boils down to moving past any number
of characters in `delim` before each iteration of the loop. And that's
doable with "p += strspn(p, delim)".

That avoids any behavior change, and more closely matches what strtok()
does, so I think it's a better path.

Thanks,
Taylor

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/strcspn.c;hb=glibc-2.37#l35
[2]: https://git.musl-libc.org/cgit/musl/tree/src/string/strcspn.c?h=v1.2.3#n11
[3]: https://lore.kernel.org/git/20230418102320.GB508219@coredump.intra.peff.net/

[^1]: Not entirely. If strcspn() takes you to the end of the string,
  strpbrk() will return NULL, instead of a pointer to the end of the
  string.
