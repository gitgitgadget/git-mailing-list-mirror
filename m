Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9846C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 08:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiGGIs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiGGIsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 04:48:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAD326D1
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 01:48:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x184so4663648pfx.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRMJKk+h3JYba3kXtN6lSlvepamRyT2yQWWhTajuBKw=;
        b=eR37OBdEsA36s9WeAmJJ6YJ5tiEi/cznJLXpsaaYMJOoLLmgRsMvTlnQmgLaLaPqsl
         5MbcN4G7S6v1YOuBP7hR3a0uwEY+fUAWA3YkLG2i+uV7+XUWO/UG7oYGUy955XG36BjU
         /dbAmigwW7lN3/w5GhWdjroqO5WNE4ZH8WJRlgdyCDYfI+eAgnuI58HIblAB6wbMVoVM
         Vxa74MIEApuz5e0rP+bCGWj7SELLjWhkIix92i8XSrEW/T4xl17IEhmn4wRYdtc+kOXe
         H8WcyniSxSJ3kAqFkIPZ+i1L2l/u403kp9/gHAnUGrsbp+8po7vul98Nk0Lo4Lf1TqEv
         p9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRMJKk+h3JYba3kXtN6lSlvepamRyT2yQWWhTajuBKw=;
        b=sM0BYiCaQxndWLGfjdNSS5UXPSkeuD83vDoP4LWQWIaLtyZWxzODtyb0R0vGEPpIjG
         QttWLuy4e+afgTZezLlVmnNitigYnhVJqgE2EXlx1qexYNIa0X/1LyboWZSBRgOz8Bxe
         aDKPDT+bVCUbrYC7GU4LuAq9JiyVlJ/7k/6PrZ4o9S90iJdWABu7mL4YcxSyH2vrtncI
         mSKgXAMqRUMr/me3F395m18xoB3i051BhPnjPMbwjz5x19eOcnn+J7hlJuz8p3cP5K2R
         m/E0wb5ZqVbuPJpTC/y18yYwncMSjWG2ZdsP4FbJNH3FSzQRZA3kuxVpJR87emVXAj+I
         Radg==
X-Gm-Message-State: AJIora/otdborU84ETnwWwP6qHe0MRBEWND2Hei3JcaGnu9xYO9b8LXh
        OG6nQIO/iuFGKEcS0EQs0oM=
X-Google-Smtp-Source: AGRyM1vyINR1vIjED+2tkrLID9uWGbQ48Nq1e5sSnLfT4icdmZUbC130msZKSW71h6dUAX6Bhp0NlQ==
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id q9-20020a056a00088900b0051091e66463mr51403537pfj.58.1657183725251;
        Thu, 07 Jul 2022 01:48:45 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.34])
        by smtp.gmail.com with ESMTPSA id l37-20020a635725000000b00411acdb1625sm13153880pgb.92.2022.07.07.01.48.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Jul 2022 01:48:44 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Date:   Thu,  7 Jul 2022 14:18:18 +0530
Message-Id: <20220707084818.79881-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqiloagi80.fsf@gitster.g>
References: <xmqqiloagi80.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> > This is the second version which addressed all (I think) the reviews. Please
> > notify me if some reviews are not addressed :)
>
> Is this the second version that is labeled as "v3" ;-)?

Hi junio,

No, it is actually the third version. I forgot to update the cover
letter :P.

I am using Github's gitgitgadget to submit PRs and it
uses PR description as the cover letter.

So before submitting a new version of patchset, PR description
must be updated which I missed this time.

I wrote a reply comment[1] where you can find a summary of all the
new changes.

[1] https://lore.kernel.org/git/20220704163506.76162-1-chakrabortyabhradeep79@gmail.com/

> >  Documentation/technical/bitmap-format.txt |  39 ++
>
> I haven't tried merging it yet, but doesn't [1/6] overlap with and
> semantically depend on your other series that touch the formatting
> of this file?

Correct, [1/6] indeed depends on my previous patch series[2] and it
is assuming that that series has already been merged. As far as it seems,
it will not create any merge conflicts while merging but I am not sure.
This would be interesting to see.

[2] https://lore.kernel.org/git/pull.1246.v4.git.1655355834.gitgitgadget@gmail.com/

Thanks :)
