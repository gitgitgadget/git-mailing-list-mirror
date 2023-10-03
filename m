Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419CAE8FDBA
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbjJCVwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJCVwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:52:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268CA1
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:52:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77574dec71bso101809885a.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696369951; x=1696974751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6aWmgIiCGP+Yi7WOtpfNCWIrdD9oMyosYdSW3Neivc=;
        b=Re/fEqwKANeRx5TnFlUu51IOeW0+FdMJeDx/MYbK2Q7TfRaauL7Gb+TXb+tFc0PjT1
         SHmXurWoHsjmd5I7xTfHUS+628vldBAQ2kGyCwpgnMVrnt3m9C4vuWZuwVT/ZwcE9BUR
         c7hvPSjCq8B/Ii2kSl2M5nLCV+s5Vk6QvEupNpFbP7yiyRNKRNSjQaAf53JkSp/MmKD0
         LRSCbRJ1R4xFtIcdP9/vsLFbGEb183fvFmgCEqau0Bcxr5bi9dr5emZPrVNDwPgrW6i9
         NZvey0v6slHbRi+vg8Wpyy6NHJtJKM4UzviM+8hKXrgF32dz+evKBFUg0n5m5DaFkrP/
         wZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369951; x=1696974751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6aWmgIiCGP+Yi7WOtpfNCWIrdD9oMyosYdSW3Neivc=;
        b=nJL6xcbifJ/vOYB0i2IBXlcQfe9/YhfUE04LvEeOz8pcNwR1Bqj/Kjaa6M88j232Im
         MWCDL8QjotnF03f3oUUNTyjekyXmLSpw+HuL3pVSi5pFyEVda8I4gJEJp7YJL3v0/PNK
         udKSiCHisaw1KlhKrlbkz5Z8r6ybAdkmQ+8PQ9/hdLcEeVUS/K1bCuOldnAteD8jG9Fu
         BamIZW8ygGtgx49O8SqkZS+9DRzDkUR8XteFysq8fc0+ugxidpcJ9LT2aJVdPbBGsshf
         0MbLxUpPYvadaOjO/4p1Lk7Laqv3J4jGLkCZbAlXyBE8eKBK1zRo2Zf8e/dWrQmyYUqT
         Kqsg==
X-Gm-Message-State: AOJu0YyNpmJDElhYHs47spuECqd6ScXXRezmotOXSpkp5dDZa3pxP8IY
        8dZqJTe+MQWRZABnspgewk1NGg==
X-Google-Smtp-Source: AGHT+IFr2gqwGB87/Ab5Ui2+4zqUG3uZLlaShKlPIXAuKev5HVnhpv6hu859vu4RM886QQduYlqUcw==
X-Received: by 2002:a05:620a:44c5:b0:76c:c636:4772 with SMTP id y5-20020a05620a44c500b0076cc6364772mr979564qkp.65.1696369950712;
        Tue, 03 Oct 2023 14:52:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id op52-20020a05620a537400b0076d9e298928sm792427qkn.66.2023.10.03.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:52:30 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:52:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <ZRyNHRf+tQwV+T6P@nand.local>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
 <20231003201617.GE1562@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003201617.GE1562@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:16:17PM -0400, Jeff King wrote:
> On Tue, Oct 03, 2023 at 12:27:51PM -0400, Taylor Blau wrote:
>
> > Note that this behavior is usually just a performance regression. But
> > it's possible it could be a correctness issue.
> >
> > Suppose an object was duplicated among the cruft and non-cruft pack. The
> > MIDX will pick the one from the pack with the lowest mtime, which will
> > always be the cruft one. But if the non-cruft pack happens to sort
> > earlier in lexical order, we'll treat that one as preferred, but not all
> > duplicates will be resolved in favor of that pack.
> >
> > So if we happened to have an object which appears in both packs
> > (e.g., due to a cruft object being freshened, causing it to appear
> > loose, and then repacking it via the `--geometric` repack) it's possible
> > the duplicate would be picked from the non-preferred pack.
>
> I'm not sure I understand how that is a correctness issue. The contents
> of the object are the same in either pack. Or do you mean that the
> pack-reuse code in pack-objects.c may get confused and try to use the
> wrong pack/offset when sending the object out? I would think it would
> always be coming from the preferred pack for that code (so the outcome
> is just that we fail to do the pack-reuse optimization very well, but we
> don't generate a wrong answer).

Admittedly I'm not 100% sure of my interpretation here either, since I
wrote most of this patch's log message nearly two years ago ;-).

I think the issue was as follows:

  - you have an object duplicated among some cruft and non-cruft pack
  - the cruft pack happens to have an older mtime than the non-cruft one
  - the repack reused no non-cruft packs, which (before this patch)
    would let the MIDX avoid picking a preferred pack
  - if the non-cruft pack happens to sort ahead of the cruft one in
    lexical order, it'll appear in the first few bits of the bitmap's
    ordering, causing us to treat it as if it were the preferred pack
  - ...but the MIDX will resolve duplicate objects in favor of the
    oldest pack when neither are preferred, causing us to pick a
    duplicate from the non-"preferred" pack.

(The last point is what causes the pack-bitmap reading code to get
confused, since it expects and makes assumption based on resolving ties
in favor of the preferred pack.)

That feels right to me, but admittedly my memory is pretty hazy on those
bitmap bugs. However, I don't think that this is an issue anymore, since
this patch was written before we had 177c0d6e63 (midx: infer preferred
pack when not given one, 2021-08-31) in GitHub's private fork, and the
patch message here incorrectly refers to statements about GitHub's fork,
not git.git.

But since we have 177c0d6e63 in git.git, this paragraph can and should
be dropped as finding ourselves in that situation is impossible, since
we would infer a preferred pack when not given one, and resolve
duplicates in favor of it.

That makes this purely a performance issue.

> Other than that, the explanation and patch make perfect sense to me, and
> the patch looks good.

Thanks!

> -Peff

Thanks,
Taylor
