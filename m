Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C662C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEDB20809
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392299AbgFSQAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:00:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392302AbgFSQAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:00:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id o11so2479919wrv.9
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nY6GBXnu+gYhqaA8wZDakTQaEJTKsLzJ9uVtXwKdPY=;
        b=N5vNNS5r1jlKyxoNm7gHVHYdv4GcELW6Z5K4Pcxv6aOs0mjl/6AcICkzCmvK1jKIqG
         UZHMPVtVCJQGcwIId5ugXls7EAfVR9vT0Dpzfa4xCmjxyhPegM4FYhMvZEcnRGPst97P
         W0TA0zR2ZwbaON9ygiK+BgcbNXzkIDl7H9PFyXQe70gRB4Juevv7tRCQThkTLQuAHFuK
         ER2ZX4sw0XwfqZmL77zSwN900U8y5W+/UCzlvzeHuosn0D8O6YkDdBIwb+630LnGkVMw
         zZv5ewrt6j3X03kTvU2J1hXCORzzsUX6cdwl1XEtvR/bl21grZNSL4iVWV4rtLKEd1XG
         kk3g==
X-Gm-Message-State: AOAM531VU9mEo71b8L2nXdG4vlvvHD3X+ISG6EI2FaocBV8RblYXGK8H
        nq71sqaZDo4muGtFRE4D6zmV2Xg/h3S6kQbsZLA=
X-Google-Smtp-Source: ABdhPJyyqq4xb1fHZuE3BhvIfJfHI2DdIUNNwoI6kJ0SumtSlAMnjisUjH92xUuiBgqIcUYw2HXYr0fjD/5bJJRBTOc=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr4429327wrd.277.1592582451708;
 Fri, 19 Jun 2020 09:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200619132304.GA2540657@coredump.intra.peff.net> <20200619132923.GA2540897@coredump.intra.peff.net>
In-Reply-To: <20200619132923.GA2540897@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jun 2020 12:00:40 -0400
Message-ID: <CAPig+cSkmGABkfK6MaSTYsX-okrrkk_SpGgztMvzBCT0bLjGmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fast-export: allow dumping the path mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 9:29 AM Jeff King <peff@peff.net> wrote:
> [...]
> We recently taught fast-export to dump the refname mapping. Let's do the
> same thing for paths, which can reuse most of the same infrastructure.
> Note that the output format isn't unambiguous here (because paths could
> contain spaces). That's OK because this is meant to be examined by a
> human.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> @@ -1244,6 +1254,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>         if (anonymized_refnames_file)
>                 anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");
> +       if (anonymized_paths_file)
> +               anonymized_paths_handle = xfopen(anonymized_paths_file, "w");

Same question as in my patch 1/1 review: Do you want to close this
file at some point?
