Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE092C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB55D2076D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="s0XZ+HVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD3UUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:20:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E07C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 13:20:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so1334430pjh.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e5KfB4YXBFg2sDlydEd8ldLIzxfC7sN3sHYcr8UeZDw=;
        b=s0XZ+HVcSIenqluJolX14I0PQoT+7jZzX8yOgw3/t30q56XST7SS/Vl0CZhJjdcRVP
         ikJKyv8moHxw2QRBp/5qJMd7eqCSP1IULoFskWVthokrEPPl3BQhXwY0qM8sXhKKFQXs
         NzTcz3g/o1dhzUVDE8/vKg/Tz+Lv2akI/gyRYSaevzoSyJKWma9gc42PU9M9VakVfPzH
         EsdrHkFiRaGjjEE77ubSHbb22QMPC3kL+B1zlkaqNqFuBKwMPfRjauPyJluHDDJuWsYM
         WyfxOEdAp8f1AikNn2mdtPe73bP91pqt9UPkJ0EK5fXBrGJ0vp6Arhv5BHWJ1Rdz7LkW
         ieAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5KfB4YXBFg2sDlydEd8ldLIzxfC7sN3sHYcr8UeZDw=;
        b=PXA+8bPNrc2XSKNz6m7B0KNmBitKWUl38PKMipNzTur50IopHT5y7SlO2n1SNmDrDG
         D4AF8mY2bZMTF6iUcsOTabbnIy1NJ/UjjMm0XP9RbNTbNsZXhTNWM/m+n8EMz0Ux1jra
         1gB/ZwgWn/eru0YaBT0VmZaF3tDvlVlb3IVf0N5l4n7czuutd3Yvu+Kl92THJAV4hWsk
         wde3rgrYHRuKlwreBBmLdJTjXc/YeDT4Qm8ORONbKab1UtsXdg/l0CElxNH/gZdSJpKk
         RXXFwKRnHEHMt33TOqRlHTGVe1gTEwWXCvmcgLTDYuFEKpsHt8/xZOrXWrVwst3NrrRR
         hBsA==
X-Gm-Message-State: AGi0PubCbZeGJ8mlDUY97st4YpukZxRYjfr7n9kHIgoC4PZHz6WeBmdQ
        NUQYB+/30G+fhXH3NuVEXJo4oQ==
X-Google-Smtp-Source: APiQypIsMPVML/DTtgU2ul6VHk6zXAcaIugsoy4kC6baVjqyhBYQia2iEXOlVeyTCvDGw/Z0/OeTiQ==
X-Received: by 2002:a17:902:c113:: with SMTP id 19mr725274pli.95.1588278016906;
        Thu, 30 Apr 2020 13:20:16 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r28sm532128pfg.186.2020.04.30.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:20:16 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:20:14 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Seg Fault on git fetch with fetch.negotiationAlgorithm=skipping
Message-ID: <20200430202014.GB2014@syl.local>
References: <450D5CC7-113A-40D8-9CD4-53786198526D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <450D5CC7-113A-40D8-9CD4-53786198526D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Son,

On Thu, Apr 30, 2020 at 04:55:07PM +0200, Son Luong Ngoc wrote:
> Hi folks,
>
> We recently encountered a segfault during a git fetch
> strace output could be found https://gist.github.com/sluongng/e48327cc911c617ed2ef8578acc2ea34
>
> The root cause was due to having `fetch.negotiationAlgorithm=skipping`
> The repo is about linux.git size with a few NULL commit that we have been using `fsck.skipList`
> on both server and client side to skip.

Are you able to share a core file? If not, it would be very helpful for
you to 'git fast-export --anonymize ...' and see if you can reproduce
the problem on an anonymized copy of your repository.

I can speculate about the cause of the crash from your strace above, but
a core file would be more helpful.

> Is this and edge case for the new algorithm?
>
> Cheers,
> Son Luong.

Thanks,
Taylor
