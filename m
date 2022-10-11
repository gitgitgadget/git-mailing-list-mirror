Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6859C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKBCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJKBCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:02:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D57A519
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:02:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z197so4809320iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiJFxYNdewP/scN3SxxrMp3DnRv6vOFUHY+ITgHPU0o=;
        b=v3ywYoJXOtr/D5yplCkzV6WDT0fpTh/6R6TtziIMkEn2N6Cn5CsxF9ItyamthpbPzz
         EaWCG4MzWolvPz7bh+S0/tzomGVl5K+wGdpheBwRUpK+vaEhji/oIyCCmY1+de+Y9gkG
         P146MrAVy8UqsRDeHtx3hZk1iZtsZGBVQwhFmKBUlZbqlWd8wP9gfA7ZhP07FC5Wundk
         5UYwSo/UbBrFRzzNfEigb1Wqn62xMkBpxf4ua+ZNCkkqzsSPzfWd4E3u9bExA2uJp6vI
         RNIFKGXxlMuBfZY5uWuRaq9bCFt2dRCX6DVWn03So8P2amtDYAWIghpDhGBuXnqM+U//
         TrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJFxYNdewP/scN3SxxrMp3DnRv6vOFUHY+ITgHPU0o=;
        b=IgPrhWOazZTLElecM3qqI7GXj7oB1RrAU/pBCfuk8Ule2GmhqbsPdWLxUNruzSE0/a
         Wrqhn1wU7abwEFQGC8eE3fm3j9BfwjIyNbiqrW1SeWTaxQutFZH6tZmkE/XU5kUX8c2x
         bPjjrZtmEV0FBL9F/y2JrBxF4tdAynZFOhM0QF1HnlNjP1YNAUVPQIZuMzZS4FGQo948
         2bgHAsyvTIxBEzpbgXuqFmx/QQ5MXmVgAuWDAeMr2l8YDcVQk+t8st8r1Gy8oYC1Yurc
         5xb+YJCB7quRtcbYylU2DXBc05/BWzQrE3esFpqP/TJLEICgxXkHyYxnUEj1C3PwLlw2
         xG2Q==
X-Gm-Message-State: ACrzQf0D5FAr4kjjUzYfCSUziGUB3+0QxGhJdzXbe/OhpdCMYsMI9YF8
        ErPCo/ZPXaE4KrsdUVXais0GiQv2opOcPRrj
X-Google-Smtp-Source: AMsMyM5Dp9Oh1X4XDVxRqOVBdWT0qPoVLLQTAFtWOlNJuW/uhVuDhNU3+pO9J7HSP2NSyJBU+n2zxw==
X-Received: by 2002:a05:6638:16d2:b0:363:c860:a58e with SMTP id g18-20020a05663816d200b00363c860a58emr1981431jat.60.1665450159566;
        Mon, 10 Oct 2022 18:02:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a056638050700b003572ae30370sm4602692jar.145.2022.10.10.18.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:02:39 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:02:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 1/7] Documentation: extract date-options.txt
Message-ID: <Y0TArbwMho1zHNPj@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <eaec59daa178c205a59b779c63e411316d8180ed.1665448437.git.me@ttaylorr.com>
 <Y0S+s04LrQWSeIC+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0S+s04LrQWSeIC+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:54:11PM -0400, Jeff King wrote:
> On Mon, Oct 10, 2022 at 08:34:02PM -0400, Taylor Blau wrote:
>
> > A future commit will want to include `--date`-related options in the
> > documentation for `git-shortlog(1)`, but without some of the additional
> > baggage in the usual rev-list-options.txt.
> >
> > Extract those options to a separate file in Documentation and include it
> > from its original source in rev-list-options.txt.
> >
> > This patch does not modify the contents of the `--date`-options section
> > of Documentation/rev-list-options.txt.
>
> I think git-shortlog.txt already includes rev-list-options, but the date
> parts are omitted because there's an ifndef::git-shortlog[] around the
> whole "commit formatting" section.
>
> Should we just be loosening the ifndef here?

That would do the trick. When I originally wrote it, I thought that
chopping the section up would be trickier than it actually was, which is
really just limited to the following:

--- 8< ---

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1cb91dfb9c..d5fbde6c80 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1033,8 +1033,12 @@ endif::git-rev-list[]

 include::pretty-options.txt[]

+endif::git-shortlog[]
+
 include::date-options.txt[]

+ifndef::git-shortlog[]
+
 ifdef::git-rev-list[]
 --header::
 	Print the contents of the commit in raw-format; each record is

--- >8 ---

(Obviously reverting this patch to replace the include of
date-options.txt with the old contents that was there before this
patch).

> I think we _could_ include more of the "formatting" section overall, but
> it looks like we have a custom mention of "--format" in
> git-shortlog.txt, which I think is a better solution anyway. Maybe we
> should just do the same with `--date`?

That works for me, too. Let's do that ;-).

Thanks,
Taylor
