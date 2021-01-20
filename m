Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BDC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12E5233CE
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbhATSyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392224AbhATSvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:51:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF83C06179E
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:49:37 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h19so16983452qtq.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmDBht7K1zuPMkGfhC9SgNYdqtq0QVfgiIaqOu9MQWs=;
        b=d8k+06gw339NC6vFk7d0iKaEy2uNu03CuDDHW0vQfkyUSIbb5R3+bTEn0Rr3Q11bp+
         NMvvmLxaOW+Zjg9U9anPEuw/Impd9O9taf9jl9NplCkCJmkj9tUTWx+rRiNX38JdSLxN
         Lou/MnnH5LN8aIPttF5vtFc7m+gjPcnYKaozw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmDBht7K1zuPMkGfhC9SgNYdqtq0QVfgiIaqOu9MQWs=;
        b=rNXCVOpUWO6e1qkrshXjXMVt6Efykum8nYlztW4rUP2Z/lBcyPaNjffsDK13wNsrA3
         f6CTHdXUbMwlTV8x7WVQOaigonp+RuBljgd70qzxIvvl96vO3v81dUQMtDEKD2lQiY7j
         fp0gKTZHC+uizlLgFZv+lA+g9+OuwCAMN0d7zetYzRF+Xnn1NTJacsM/2gzr4OfipZbA
         IvLLN24MTMgp089zN2TbRvoBPCvIfvyxp/2DtLXMpq+sYJht3x2ED+9Wg/l49nE+y8bu
         nRLbIPOdxcT1UjPGjDJfsuGvg17nM1XUlz2noMgxYiY0sOipEGENiVZeXorKiDcaaxyo
         SlLg==
X-Gm-Message-State: AOAM531HwtNzIA63yuBCZIL4j9haNSrTZ0224XX5AXecgd0KxLX9owO+
        K4uAziwABzJMBRAaPOTfGN5IrLkxhC0w1H4w9yvUAA==
X-Google-Smtp-Source: ABdhPJzQbPxjCEMIli+jK1Pi5+TpoAHQnqnagDkWZO8OcU+1yz9v72ONnHerXF41k7FKvEna4RNltpQRZgUq2TpOLoQ=
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr1150526qti.246.1611168577223;
 Wed, 20 Jan 2021 10:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20210120124514.49737-1-jacob@gitlab.com> <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local> <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net> <YAhYHUcdynbWyhwo@nand.local>
In-Reply-To: <YAhYHUcdynbWyhwo@nand.local>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 19:49:26 +0100
Message-ID: <CADMWQoPwNQafPcr2NvRcGzcWDwku1VYoGsKaKiBWSCRCvqY4Tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also spent time being confused about what is going on, and wondering
if that other ref iteration ever worked. I went as far as inspecting
git-verify-pack -v output to look at object order. :)

On the other hand, through working on this I learned that include-tag
has pretty effective test coverage so if peel_ref didn't work or
stopped working, we'd find out.

If there is a better way to write "for each tag + peel ref" I am happy
to change the patch, just let me know what it should look like.

Best regards,

Jacob Vosmaer
GitLab, Inc.

On Wed, Jan 20, 2021 at 5:19 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Jan 20, 2021 at 11:18:11AM -0500, Jeff King wrote:
> > So I think both the existing and the new calls using for_each_tag_ref()
> > are OK here.
>
> Indeed, I followed the same trail of calls as you did and reached the
> same conclusion, but didn't write any of it down here since I thought it
> wasn't worthwhile.
>
> But, yes, I agree that both are safe.
>
> Thanks,
> Taylor
