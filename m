Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2B5C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 07:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419B9206E9
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 07:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLHjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 03:39:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32966 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDLHjq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 03:39:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id v8so7871491wma.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 00:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK6mLCwVYRvRKNlLO+n3XlH+HHwnqPHY72htxiDNbGs=;
        b=Tvzp/AL0eNP6kEYnEUueluluMfQwAWaORNjKnQE+qgo2gF7NuMLMPtN+MYFeIDHADJ
         t95w3Twk7aiwVP32dRDBaoAbBrSlCNdsUPfd9W5vp00jBp7nhlIKeKOtI2TrzfuGXAqi
         X5Vk/QYlTMLx2cC4YIL5ocfdmFDKoiwBZ/eLfuONHhnogHDmp9Zicjt0ptNHY1FiUwRS
         ULhuqgO47nebaqm6I9ei0Lg/oTXNbVQugBMMZuoEwgvKyI6jJvYDebDhnjHpfHkEB1pv
         U5IwAb34kAZxvHfwxt0fGxf4fpGtzPyfC4q/iJ65RUJzU0p4p2G6nTULDQn/n087D2UV
         Qa/g==
X-Gm-Message-State: AGi0PubL8g067Nqgdu8/8EkDwwEQgV0Ginx3ivHmToQff0msTNUuunzv
        pxYkkSVRawamB0kD+gvErxV7vzqIw8IZDvqpl+Y=
X-Google-Smtp-Source: APiQypIkVOfKgeolSZbLFZrMik7v1ayE8N9MSympl70s43xlW007e9557NrMUF69tA27BDO26DS7KdVvk/05UGWAd1w=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr12789383wmi.53.1586677184260;
 Sun, 12 Apr 2020 00:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <431fde6803140398eec0744c866616a0a78f9433.1586566981.git.gitgitgadget@gmail.com>
 <xmqq5ze5he8o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5ze5he8o.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Apr 2020 03:39:33 -0400
Message-ID: <CAPig+cRm515C05SD_ivZmdPEUW=Tw3j2r4_p9_oSmRjs++BLZw@mail.gmail.com>
Subject: Re: [PATCH 3/3] blame: use changed-path Bloom filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jakub Narebski <jnareb@gmail.com>, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 11, 2020 at 6:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > The lack of improvement for the MAINTAINERS file and the relatively
> > modest improvement for the other examples can be easily explained.
> > The blame machinery needs to compute line-level diffs to determine
> > which lines were changed by each commit. That makes up a large
> > proportion of the computation time, and this change does not
> > attempt to improve on that section of the algorithm. The
> > MAINTAINERS file is large and changed often, so it takes time to
> > determine which lines were updated by which commit. In contrast,
> > the code files are much smaller, and it takes longer to comute
> > the line-by-line diff for a single patch on the Linux mailing
> > lists.

s/comute/compute/

(Sorry for replying to Junio's reply -- the original is no longer in
my mailbox.)
