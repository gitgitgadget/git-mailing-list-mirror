Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE0DC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B020848
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ/EzXQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgJNKPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgJNKO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 06:14:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA1C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 03:14:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p88so1839801qtd.12
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oQV3I711qTzI1x7czia20RFYnxStlFzqRWH1egSLNHw=;
        b=jQ/EzXQoVRksJRJAb2PYj1pjCE023FIvfjtdVfnVWkxJ3vg4mE/gLA6dA/G2hcRP/Z
         0YR7FfFADFpes28Ez8ihGeOVNGWxjx39BE/jrvP74LEPDUCr1DmrGnu16qO8WYjloKQe
         moRt7DbpqwBvg1c+ScOGiBHumOJaggI/fLNEbXPLdhNwQRG/NH6fufHFFszXIxrDV3Bd
         ghizoi9No2GKZ2pY2cYExjzdUb43qt2LL3MEd7b86t/KCRjBkleMd3/L64c6SDmqEc1T
         lWojks2N8cmNk+AGaAwK06GRnUkHhlSe8xoqk0nAfWRCJX30hbZbb8oJm0CvAWdW+dzf
         Vlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oQV3I711qTzI1x7czia20RFYnxStlFzqRWH1egSLNHw=;
        b=prxxKzORN7xAEzCr1/OCLVWSMt99B+AdbkrUrDgDLzeTgw7Bl85p20bxIwMOXJ1/UW
         jPjCw4I6/lju3EfCSVjuhExAg0/V7SNUckXtUPrnpfv/getrCx++DGkHBuIpTw9iGVe6
         AOLeKAa1paN6mlNSjebNlXWoW5rpKFIanckyxl9/QCUsN6JS2WUaLBYhUeEXtKmIi2QU
         OnPMk+LSsw+g/LOn+72EUPKqUz/wZr2+9XhxruHXWV9WZxozL5lAkHcxDVOLVFyHx1eV
         D8CsAVOk3ENReluDZgTBqbGahfaqrcgvt8zdIU/bWCxhRGG5L/0QeHg/sEZH3f2LPUGu
         GmIw==
X-Gm-Message-State: AOAM532DlPfbiFv+82XJUURVJqUcbN4js5BxgX5FzbhZbo3geRX9TBdZ
        oVNmlSYZZ2YnyFkCy8RPDZKgiYOFQr5taYWbZxa76PH4gVsTOw==
X-Google-Smtp-Source: ABdhPJxFZfC0rRdFbY/eBsrxDJBQpwRzcFZB2K3ktDsXkkZbqMJHE/oMsnq62m0fOkZI9uqrxcOORej9tCOOIClB+hQ=
X-Received: by 2002:ac8:1af2:: with SMTP id h47mr4054650qtk.346.1602670465247;
 Wed, 14 Oct 2020 03:14:25 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Sune <marcdevel@gmail.com>
Date:   Wed, 14 Oct 2020 12:14:14 +0200
Message-ID: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com>
Subject: git diff --submodule=diff and --stat/--dirstat/--name-only
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

First, thank you to the community for the great work. Worth saying it
from time to time, I think.

I am dealing with a couple of big repositories that use git
submodules. They have nested submodules, and some of them are pretty
huge. I came across:

git diff --submodule=diff

Which is very handy for creating some tooling, but it's obviously slow
- in the order of tens of minutes in my case - for big diffs. I was
only interested in the list files that changed, in this particular
case, but:

git diff --stat --submodule=diff

doesn't seem to honour `--submodule=diff` and it doesn't go into the
submodule(s) nor recurses, of course. Other options like `--dirstat`
or `--name-only` seem to behave the same way.

I've tried this v2.20.1 and the HEAD of master (d4a392452e) with the
same results. Is this a missing feature, a bug or is it just the
intended behaviour?

Regards
marc
