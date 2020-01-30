Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80374C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753D20CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqpY3RlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgA3PAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:00:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34312 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3PAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:00:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so3791241oig.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KT+y/7098mJ03TS/PLpXRu1cn8gu9dfFbHPveC70UL4=;
        b=fqpY3RlXsQ/LBaOe2LC8gPE8kG/59la85cxwZBwCJx0zWU/X4A5jfV2PPSn9z+g97m
         iMTkro3Jr6Q6El1aqsSXg3QlXKwD5HsoAPMos1kwlRs5PyJUHQ9Yc/qPTUePmNx40Dh4
         Sul5FNnA3WY/+GgBvHwa6rhS/yPiDkU/hAyPU0s+Fa0Zkb3T+RK0QYSbCfnIrAtvONoZ
         gsAaWfArvHogUS61/aOqLlmoH5EUpkD7oHc3c9nzSubY/25I17tkae2jBhsrvvJjQOIl
         Ar74Z+h5CP6CUsQ/T8Mm+ky4+kbBbUeQvUq2NN7qKBEG4GbWt67RdEFDUbLy8NsjkS2C
         yRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT+y/7098mJ03TS/PLpXRu1cn8gu9dfFbHPveC70UL4=;
        b=R04QBhW/nPV7Vrf04ffRHsUEhV4ZRMrGLZesQxP1vbytxCtfo+yN/1cg34Yns5Lew1
         D0K2aXKbqE65stWfLKr0nmUY/KyrLGde7gxQrShhwY/41MISI5mU5MCjm/g7aQG86RNX
         SEYfoifsMlA4E5uCwoVVj9GE4mW1MOFuoWuvvQ24u8Usnne+FEkCJ+AfgYNFTBQnqWCr
         We1GKT81CpWEWORL1tUXoLwkO5UtEVe8Qvs6C6mk0Y5HgBdJLISkVjaIj3me2vlP28Ro
         8BusXT2sjdUTIOwxzQqdiVisj18ZzcDvtJwomjYCr2ODfDFepd3Gb9nqtS6dZ2OpxTWZ
         qfkg==
X-Gm-Message-State: APjAAAWqtqJvrXL9Oru8SB6aIAyLZUz1L8RbNg5EGaAUZ0LJBuXEdZTt
        h74EClhBVig6t5hSWQgUs34/KZ/F/ch57uzUAW9U8g==
X-Google-Smtp-Source: APXvYqySOqgO36Yi0VMrXDNGZUlbXSznDJ4XoTYDQGNmsVMJo6KzSeECcVc6L7SyOsuU8IOFnT5vcRAZ5sfFAemKaqw=
X-Received: by 2002:aca:b483:: with SMTP id d125mr3209765oif.167.1580396409952;
 Thu, 30 Jan 2020 07:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20200130095155.GA839988@coredump.intra.peff.net>
In-Reply-To: <20200130095155.GA839988@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 06:59:59 -0800
Message-ID: <CABPp-BHmj6g_M=XjuQY5cd+G2EneerFPktDLnPbbUALksA-Gfw@mail.gmail.com>
Subject: Re: [PATCH 0/3] some minor memory allocation cleanups
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 1:53 AM Jeff King <peff@peff.net> wrote:
>
> These are a result of me poking at the results of:
>
>   git grep 'x[mc]alloc.*[+*] '
>
> looking for any buffer allocation computations that could overflow (and
> hence under-allocate).
>
> There are a few hits left after this in the commit-graph code. Those
> will be dealt with in a separate series (coming soon!) since they have
> other problems, as discussed in:
>
>   https://lore.kernel.org/git/20191027042116.GA5801@sigill.intra.peff.net/
>
> (those have to do with normalize_path_copy(), hence the only
> semi-related documentation patch here).
>
>   [1/3]: normalize_path_copy(): document "dst" size expectations
>   [2/3]: walker_fetch(): avoid raw array length computation
>   [3/3]: traverse_trees(): use stack array for name entries
>
>  path.c      |  2 ++
>  tree-walk.c | 13 ++++++++-----
>  walker.c    |  4 +++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> -Peff

Other than introducing (or extending?) a cyclic dependency between
tree-walk and unpack-trees that I'd prefer to remove, this series
looks good to me.
